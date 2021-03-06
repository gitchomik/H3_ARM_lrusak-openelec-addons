################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="repository.lrusak.openelec.addons"
PKG_VERSION="7.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://addons.freestylephenoms.com"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="lrusak's OpenELEC.tv Add-on Repository"
PKG_LONGDESC="lrusak's OpenELEC.tv Add-on Repository"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.addon.repository"
PKG_ADDON_PROVIDES=""

PKG_AUTORECONF="no"

PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

make_target() {
  $SED -e "s|@PROJECT@|$PROJECT|g" \
     -e "s|@ARCH@|$TARGET_ARCH|g" \
     -e "s|@PKG_VERSION@|$PKG_VERSION|g" \
     -e "s|@PKG_REV@|$PKG_REV|g"\
  -i addon.xml
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -R $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
