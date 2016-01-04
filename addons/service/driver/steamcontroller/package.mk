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

PKG_NAME="steamcontroller"
PKG_VERSION="a8c0b8a"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ynsta/steamcontroller"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host libusb1 enum34"
PKG_NEED_UNPACK="linux"
PKG_PRIORITY="optional"
PKG_SECTION="service/driver"
PKG_SHORTDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_LONGDESC="A standalone userland driver for the steam controller to be used where steam client can't be installed."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REPOVERSION="7.0"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
}

make_target() {
  python setup.py build
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -a $PKG_BUILD/build/scripts-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

  mkdir	-p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -a $PKG_BUILD/build/lib.linux-*-2.7/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir libusb1)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -a $(get_build_dir enum34)/build/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/include/linux
    if [ -f "$(get_build_dir linux)/usr/include/linux/input-event-codes.h" ]; then
      cp $(get_build_dir linux)/usr/include/linux/input-event-codes.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/
    fi
    cp $(get_build_dir linux)/usr/include/linux/input.h $ADDON_BUILD/$PKG_ADDON_ID/include/linux/

  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $ADDON_BUILD/$PKG_ADDON_ID/lib/ -f
  find $ADDON_BUILD/$PKG_ADDON_ID/lib/ -name '*.py' -exec rm {} \;
}
