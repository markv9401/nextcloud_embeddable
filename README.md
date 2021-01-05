# nextcloud_embeddable
A little addition to make your Nextcloud Docker deployment (html) embeddable without rebuilding a custom image

### TL;DR How to
Just download `alternative.sh` to `./nextcloud/alternative.sh` (relative to `docker-compose.yml`) and add the following to your Nextcloud deployment's `docker-compose.yml`:
```
...
volumes:
  - ./nextcloud/alternative.sh:/alternative.sh
command: /bin/sh /alternative.sh
environment:
  - FRAME_ANCESTOR=example.org
...
```

### Which versions / tags of the official Nextcloud images does it support?
All. The script looks for the `apache2` binary and launches it if it's found. Otherwise falls back to `php-fpm`. Should you be using any unofficial image (like linuxhomeserver) it'll still work just make sure you fix the commandlet in `alternative.sh` to use the appropriate launch sequence

### How does it work?
It appends your chosen domains to the `allowedFrameAncestors` list of the `/var/www/html/lib/public/AppFramework/Http/ContentSecurityPolicy.php` file. Simple `sed` + regexp, check the code in `alternative.sh`

### Been done before, can be done manually, so why?
Because you'd most likely have to do that manually after every update

### So why not maintain a self built Docker image?
Answer is in the question. Because you'd have to maintain it. Rebuild every time a new Nextcloud image is released, etc. Why bother?

### Isn't this also modifying the official Nextcloud Docker image?
Yes and no. You're bind-mounting a single `.sh` script file to a previously absent path which simply uses `sh` and `sed` to parse and append your domain to the allowed list. It requires to extra installations, no layers no extra maintenance whatsoever. New Nextcloud image pushes? You just pull, re-up, and good to go.
