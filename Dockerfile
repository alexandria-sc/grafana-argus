# Grafana, branded as Argus: the official image with its brand strings and icons
# replaced. Grafana OSS has no branding settings (that is Enterprise), and this is
# much less to keep up with than a fork: bump the tag, rebuild. The build fails if
# a pattern is no longer found, so an upgrade cannot quietly lose the branding.
#
# Grafana is AGPL-3.0: this file and branding/ are the complete set of changes
# to the upstream release named on the FROM line. This file is licensed under the
# AGPL-3.0 (see LICENSE), with this additional term under its section 7(e): no
# rights are granted to the Argus name or mark (branding/, see branding/LICENSE).
FROM grafana/grafana:13.2.3

USER root
COPY branding/ /tmp/branding/
RUN set -eu; cd /usr/share/grafana/public; \
    replace() { \
      files=$(grep -rlF "$1" build locales dashboards); \
      [ -n "$files" ] || { echo "pattern not found, update this Dockerfile: $1" >&2; exit 1; }; \
      for f in $files; do sed -i "s|$1|$2|g" "$f"; done; \
    }; \
    # The name next to the logo, and the browser tab title.
    replace 'this.AppTitle="Grafana"' 'this.AppTitle="Argus"'; \
    # The home page greeting: code, every language's translations, the default home dashboard.
    replace 'Welcome to Grafana' 'Welcome to Argus'; \
    # The home page's "Welcome to {{edition}}": the edition's name, in the code (the
    # default every language falls back to) and in the English translation.
    replace 'home.home-page.edition.open-source","Grafana"' 'home.home-page.edition.open-source","Argus"'; \
    replace '"open-source": "Grafana"' '"open-source": "Argus"'; \
    # The tab title before the app has loaded.
    grep -qF '[[.AppTitle]]' views/index.html; sed -i 's|<title>\[\[\.AppTitle\]\]</title>|<title>Argus</title>|' views/index.html; \
    # Logo, Safari pinned-tab icon, favicon, home-screen icon. Build paths are
    # fingerprinted per version, hence the globs.
    logo=$(ls build/static/img/grafana_icon.*.svg); [ -n "$logo" ]; \
    for f in $logo img/grafana_icon.svg img/grafana_mask_icon.svg; do cp /tmp/branding/argus.svg "$f"; done; \
    for d in build/img img; do cp /tmp/branding/fav32.png /tmp/branding/apple-touch-icon.png "$d/"; done; \
    rm -rf /tmp/branding

USER 472
