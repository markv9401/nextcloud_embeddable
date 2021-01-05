#!/bin/sh

sed -i -Ez "s/(\s+)protected [$]allowedFrameAncestors = \[\n((\s+)(\S+\n)+)\s\];/\1protected \$allowedFrameAncestors = \[\n\3'\\\'self\\\'',\n\3'$FRAME_ANCESTOR',\1\];/" /var/www/html/lib/public/AppFramework/Http/ContentSecurityPolicy.php && which apache2 > /dev/null && apache2-foreground || php-fpm
