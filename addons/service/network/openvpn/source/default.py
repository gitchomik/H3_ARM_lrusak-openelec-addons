################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

import ast
import os
import subprocess
import sys
import time
import xbmc
import xbmcaddon
import xbmcgui

sys.path.append('/storage/.kodi/addons/service.openelec.settings')
sys.path.append('/usr/share/kodi/addons/service.openelec.settings')

import oe

__author__     = 'lrusak'
__url__        = 'https://github.com/lrusak/lrusak-openelec-addons'
__addon__      = xbmcaddon.Addon()

class Main(object):

    def __init__(self, *args, **kwargs):

        Openvpn().autostart()

        monitor = OpenvpnMonitor(self)

        while not monitor.abortRequested():
            if monitor.waitForAbort():
                Openvpn().stop()
                os.remove('/var/log/openvpn.log')
                break

class Openvpn(object):

    def ipinfo(self):
        ipinfo = ast.literal_eval(oe.execute('curl ipinfo.io 2> /dev/null', get_result=1).replace('\n',''))
        dialog = xbmcgui.Dialog()
        dialog.ok('OpenVPN', "IP : " + ipinfo['ip'],
                             'Country : ' + ipinfo['country'],
                             'City : ' + ipinfo['city'])

    def start(self):
        oe.notify('OpenVPN', 'Establishing Connection', icon='eth')
        oe.execute('/storage/.kodi/addons/service.network.openvpn/bin/openvpn --daemon --writepid /var/run/openvpn.pid --log /var/log/openvpn.log --config ' + self.get_config_file() + ' ' + self.get_custom_options())
        time.sleep(3)
        if self.status():
            oe.notify('OpenVPN', 'Connection Established', icon='eth')

    def stop(self):
        oe.notify('OpenVPN', 'Stopping Connection', icon='eth')
        oe.execute('pkill openvpn')
        time.sleep(3)
        if not self.status():
            oe.notify('OpenVPN', 'Connection Stopped', icon='eth')

    def autostart(self):
        if __addon__.getSetting('autostart_openvpn') == 'true':
            self.start()

    def status(self):
        status = oe.execute('pgrep openvpn', get_result=1)
        if status is not '':
            return 1
        else:
            return 0

    def get_config_file(self):
        config_file = __addon__.getSetting('config_file')
        if config_file == '':
            oe.notify('OpenVPN', 'No Configuration File Selected', icon='eth')
            oe.set_busy(0)
            exit(1)
        else:
            return config_file

    def get_custom_options(self):
        return __addon__.getSetting('custom_options')

    def main(self):
        oe.set_busy(1)
        if self.status():
            self.stop()
            self.start()
        oe.set_busy(0)

class OpenvpnMonitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)

    def onSettingsChanged(self):
        Openvpn().main()

if ( __name__ == "__main__" ):

    openvpn = Openvpn()

    if len(sys.argv) > 1:
        if sys.argv[1] == 'toggle':
            if openvpn.status():
                openvpn.stop()
            else:
                openvpn.start()
        elif sys.argv[1] == 'start':
            if not openvpn.status():
                openvpn.start()
        elif sys.argv[1] == 'stop':
            if openvpn.status():
                openvpn.stop()
        elif sys.argv[1] == 'ipinfo':
            openvpn.ipinfo()
    else:
        Main()

    del OpenvpnMonitor
