--- src/rrd_open.c.orig	2011-12-19 21:58:11.011598703 +0000
+++ src/rrd_open.c	2011-12-19 21:58:37.029640082 +0000
@@ -589,9 +589,6 @@
     int       ret;
 
 #ifdef HAVE_MMAP
-    ret = msync(rrd_simple_file->file_start, rrd_file->file_len, MS_ASYNC);
-    if (ret != 0)
-        rrd_set_error("msync rrd_file: %s", rrd_strerror(errno));
     ret = munmap(rrd_simple_file->file_start, rrd_file->file_len);
     if (ret != 0)
         rrd_set_error("munmap rrd_file: %s", rrd_strerror(errno));
