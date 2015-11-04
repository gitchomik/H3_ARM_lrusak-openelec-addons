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

import xbmc
import xbmcaddon
import subprocess

__scriptname__ = 'wetek-cec'
__author__     = 'lrusak'
__url__        = 'http://www.openelec.tv'
__addon__      = xbmcaddon.Addon()

cec_modes = {
             '0': '0x0f',
             '1': '0x0b'
}
rev_cec_modes = {v: k for k, v in cec_modes.items()}

class Main(object):

    def __init__(self, *args, **kwargs):

        self.main()
        monitor = WetekMonitor(self)

        while not monitor.abortRequested():
            if monitor.waitForAbort():
                self.disable_cec()
                break

    def enable_cec(self, cec_mode):
        subprocess.Popen('echo ' + cec_mode + ' > /sys/class/amhdmitx/amhdmitx0/cec_config', shell=True)

    def disable_cec(self):
        subprocess.Popen('echo 0x00 > /sys/class/amhdmitx/amhdmitx0/cec_config', shell=True)

    def cec_enabled(self):
        if __addon__.getSetting('enable_cec') == 'true':
            return 1
        else:
            return 0

    def get_cec_mode(self):
        return cec_modes.get(__addon__.getSetting('cec_mode'))

    def main(self):
        if self.cec_enabled():
            self.enable_cec(self.get_cec_mode())
        else:
            self.disable_cec()

class WetekMonitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)

    def onSettingsChanged(self):
        Main().main()

if ( __name__ == "__main__" ):
    Main()

    del WetekMonitor
