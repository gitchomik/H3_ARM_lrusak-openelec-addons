################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="wetek-cec"
PKG_VERSION="1.0"
PKG_REV="2"
PKG_ARCH="arm"
PKG_ADDON_PROJECTS="WeTek_Play"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="service.system"
PKG_SHORTDESC="A simple add-on to enable HDMI CEC on the Wetek Play"
PKG_LONGDESC="A simple add-on to enable HDMI CEC on the Wetek Play"
PKG_AUTORECONF="no"
PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROVIDES=""
PKG_ADDON_NAME="Wetek HDMI CEC Enabler"
PKG_ADDON_REPOVERSION="6.0"

PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  : # nothing to do here
}
