# firefox-support-common
Common information for Firefox support in corporation use

License: MPL 2.0

## How to build PDF version of the migration report

You need to install required tools and fonts to create PDF version of the migration report.

On Ubuntu 22.04:

```console
$ sudo apt install pandoc texlive-full fonts-noto-cjk fonts-noto-cjk-extra
```

Then you can build PDF as:

```console
$ make migration-report
```
