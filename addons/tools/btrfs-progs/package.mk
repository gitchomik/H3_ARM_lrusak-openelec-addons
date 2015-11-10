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

PKG_NAME="btrfs-progs"
PKG_VERSION="4.3"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://btrfs.wiki.kernel.org/index.php/Main_Page"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-linux zlib lzo"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="tools for the btrfs filesystem"
PKG_LONGDESC="tools for the btrfs filesystem"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REPOVERSION="6.0"

PKG_SECTION="tools"
PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

PKG_CONFIGURE_OPTS_TARGET="--exec-prefix=/ \
                           --bindir=/sbin \
                           --disable-backtrace \
                           --disable-documentation \
                           --disable-convert"

pre_configure_target() {
  ./autogen.sh
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -a $ROOT/$PKG_BUILD/.install_pkg/sbin/* $ADDON_BUILD/$PKG_ADDON_ID/bin/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -a $ROOT/$PKG_BUILD/.install_pkg/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
}
