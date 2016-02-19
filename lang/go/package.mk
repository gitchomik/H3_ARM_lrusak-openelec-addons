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

PKG_NAME="go"
PKG_VERSION="1.6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://golang.org"
PKG_URL="https://github.com/golang/go/archive/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}-${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_HOST="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="Go is an open source programming language that makes it easy to build simple, reliable, and efficient software."
PKG_LONGDESC="Go is an open source programming language that makes it easy to build simple, reliable, and efficient software."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

configure_host() {
  export GOOS=linux
  export GOROOT_FINAL=$ROOT/$TOOLCHAIN/lib/golang
  export GOROOT_BOOTSTRAP=$HOME/go
  export GOARCH=amd64
}

make_host() {
  cd $ROOT/$PKG_BUILD/src
  bash make.bash --no-banner
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/lib/golang
  cp -av $ROOT/$PKG_BUILD/* $ROOT/$TOOLCHAIN/lib/golang/
}
