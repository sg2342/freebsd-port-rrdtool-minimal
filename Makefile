# New ports collection makefile for:	rrdtool-minimal
# Date created:				19th December 2011
# Whom:					Stefan Grundmann
#
# $FreeBSD$
#

PORTNAME=	rrdtool-minimal
SVN_REV=	002247
PORTVERSION=	1.4.6.${SVN_REV}
CATEGORIES=	databases
MASTER_SITES=

LICENSE=	GPLv2

CONFLICTS=	rrdtool-1.0* rrdtool-1.2* rrdtool*

MAINTAINER=	not_maintened
COMMENT=	minimal rrdtool

USE_AUTOTOOLS= libtoolize autoconf libtool automake
GNU_CONFIGURE=	yes

BUILD_DEPENDS=	${LOCALBASE}/include/glib-2.0/glib.h:${PORTSDIR}/devel/glib20 \
		xmlcatalog:${PORTSDIR}/textproc/libxml2

CONFIGURE_ARGS=--disable-lua --disable-tcl --disable-python --disable-nls \
	       --disable-perl --disable-libwrap --disable-libdbi \
	       --enable-static-programs --disable-rrdcgi \
	       --disable-rrd_graph 

EXTRACT_DEPENDS+=	svn:${PORTSDIR}/devel/subversion

PLIST_FILES=	bin/rrdtool

pre-configure:
	@cd ${WRKSRC} && ${LIBTOOLIZE} && ${AUTORECONF} --force --install --verbose -I m4

do-fetch:
	@${DO_NADA}

do-extract:
	${MKDIR} ${WRKDIR}
	svn export -r ${SVN_REV} \
	    svn://svn.oetiker.ch/rrdtool/branches/1.4/program ${WRKSRC}

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/src/rrdtool ${PREFIX}/bin

.include <bsd.port.mk>
