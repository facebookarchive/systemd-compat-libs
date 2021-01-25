# systemd compatibility libraries

NOTE: this project is no longer under active development

This is a standalone build of the compatibility libraries for systemd, which
map library calls for systemd < 209 onto the new `libsystemd.so` provided by
later versions. These libraries
[used to be shipped](https://lists.freedesktop.org/archives/systemd-devel/2014-February/017146.html)
with systemd, but were
[removed upstream](https://github.com/systemd/systemd/commit/4de282cf9324ab13d17ac334244d0d7cae2df37d)
in v230. This project allows one to easily backport recent versions of systemd
on distributions that originally shipped with versions < 230, such as CentOS 7.

# License
This codebase is a derivative work of the systemd project
(https://github.com/systemd/systemd) and is thus covered by the same license
(LGPLv2.1+, see LICENSE.LGPL2.1 for the full text).
