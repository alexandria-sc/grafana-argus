# grafana-argus

The Grafana that [Alexandria](https://alexandria.sc) runs as part of **Argus**, its
monitoring service, and the complete source of how it differs from upstream
Grafana.

Grafana is © Grafana Labs and licensed under the
[GNU Affero General Public License v3.0](LICENSE). Under that licence, people who
use a modified Grafana over a network are entitled to its source. This repository
is that source: Argus' Grafana is the upstream release named on the `FROM` line of
the [Dockerfile](Dockerfile), with only the changes below. Grafana's own source is
at [github.com/grafana/grafana](https://github.com/grafana/grafana).

## What is changed

Branding only. No behaviour, security or data handling changes:

| What | Upstream | Here |
| --- | --- | --- |
| Name next to the logo, browser tab title | Grafana | Argus |
| Home page greeting | Welcome to Grafana. | Welcome to Argus. |
| Logo, favicon, home-screen icon | Grafana's | [Argus' mark](branding/) |

The [Dockerfile](Dockerfile) applies these to the official `grafana/grafana` image.
Its build fails if a string it replaces is no longer found, so a new Grafana
release never ships half-branded.

## Build

```sh
docker build -t grafana-argus .
```

## Licences

- **Grafana** is © Grafana Labs, licensed under the [AGPL-3.0](LICENSE).
- **The [Dockerfile](Dockerfile)**, Alexandria's change to it, is licensed under the
  AGPL-3.0 as well. Under the licence's section 7(e), it grants no rights to the
  Argus name or mark.
- **The Argus name and mark ([`branding/`](branding/))** are not open source. They are
  included so this build can be examined and reproduced exactly, and may be used for
  nothing else. See [branding/LICENSE](branding/LICENSE). If you build your own
  variant, replace them with your own icons and name.

"Grafana" is a trademark of Grafana Labs. This build is not affiliated with or
endorsed by Grafana Labs.
