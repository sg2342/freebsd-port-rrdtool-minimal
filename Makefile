# New ports collection makefile for:	rrdtool-minimal
# Date created:				
# Whom:					
#
# based on $FreeBSD: ports/databases/rrdtool/Makefile,v 1.105 2012/06/01 05:16:54 dinoex Exp $
#

PORTNAME=	rrdtool
PKGNAMESUFFIX=  -minimal
PORTVERSION=	1.4.7
PORTREVISION=	2
CATEGORIES=	databases graphics
MASTER_SITES=	http://oss.oetiker.ch/rrdtool/pub/

MAINTAINER=	_not_maintained_
COMMENT=	Round Robin Database Tools

LICENSE=	GPLv2

BUILD_DEPENDS= xml2:${PORTSDIR}/textproc/libxml2 \
               ${LOCALBASE}/include/glib-2.0/glib.h:${PORTSDIR}/devel/glib20	

CONFLICTS=	rrdtool-1.0* rrdtool-1.2* rrdtool*

USE_AUTOTOOLS=	libtool
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
USE_GMAKE=	yes

CONFIGURE_ARGS=	--disable-lua --disable-tcl --disable-python --disable-nls \
               --disable-perl --disable-libwrap --disable-libdbi \
               --enable-static-programs --disable-rrdcgi \
               --disable-rrd_graph

PLIST_FILES=    bin/rrdtool bin/rrdcached bin/rrdupdate

post-extract:
	@${REINPLACE_CMD} -e 's/^POD3/#POD3/' ${WRKSRC}/doc/Makefile.in
	@${REINPLACE_CMD} -e 's/[[:space:]]install-idocDATA//g' \
		-e 's/[[:space:]]install-ihtmlDATA//g' \
		-e 's/^[[:space:]].*cd .* rrdtool.html index.html/      #/' \
		${WRKSRC}/doc/Makefile.in
	${REINPLACE_CMD} -e '/^SUBDIRS = /s| examples | |' \
		${WRKSRC}/Makefile.in


CPPFLAGS+=	-I${LOCALBASE}/include 
##LDFLAGS+=	-L${LOCALBASE}/lib
CFLAGS:=	${CFLAGS:N-ffast-math}

.include <bsd.port.mk>
