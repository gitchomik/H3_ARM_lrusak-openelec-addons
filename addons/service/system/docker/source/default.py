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

__author__      = 'lrusak'
__url__         = 'https://github.com/lrusak/lrusak-openelec-addons'
__addon__       = xbmcaddon.Addon()
__path__        = __addon__.getAddonInfo('path')
__service__     = __path__ + '/systemd/' + __addon__.getAddonInfo('id') + '.service'
__servicename__ = __addon__.getAddonInfo('id') + '.service'
__socket__      = __path__ + '/systemd/' + __addon__.getAddonInfo('id') + '.socket'
__socketname__  = __addon__.getAddonInfo('id') + '.socket'

class Main(object):

    def __init__(self, *args, **kwargs):

        monitor = DockerMonitor(self)

        if not Docker().is_enabled():
            Docker().enable()
            Docker().start()

        while not monitor.abortRequested():
            if monitor.waitForAbort():
                Docker().stop()
                Docker().disable()

class Docker(object):

    def enable(self):
        self.execute('systemctl enable ' + __service__)
        self.execute('systemctl enable ' + __socket__)

    def disable(self):
        self.execute('systemctl disable ' + __servicename__)
        self.execute('systemctl disable ' + __socketname__)

    def is_enabled(self):
        if self.execute('systemctl is-enabled ' + __servicename__, get_result=1).strip('\n') == 'enabled':
            return True
        else:
            return False

    def start(self):
        self.execute('systemctl start ' + __servicename__)

    def stop(self):
        self.execute('systemctl stop ' + __servicename__)

    def is_active(self):
        if self.execute('systemctl is-active ' + __servicename__, get_result=1).strip('\n') == 'active':
            return True
        else:
            return False

    def execute(self, command_line, get_result=0):
        result = oe.execute(command_line, get_result=get_result)
        if get_result:
            return result

    def restart(self):
        if self.is_active():
            self.stop()
            self.start()

class DockerMonitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)

    def onSettingsChanged(self):
        Docker().restart()

if ( __name__ == "__main__" ):
    Main()

    del DockerMonitor
