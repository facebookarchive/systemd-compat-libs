#
# Copyright (C) 2017 Facebook
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

project('systemd-compat-libs', 'c',
        version : '234',
        license : 'LGPLv2+',
        default_options: [
                'c_std=gnu99',
                'prefix=/usr',
                'sysconfdir=/etc',
                'localstatedir=/var',
        ],
        meson_version : '>= 0.40',
       )

rootprefixdir = get_option('rootprefix')

prefixdir = get_option('prefix')
if not prefixdir.startswith('/')
        error('Prefix is not absolute: "@0@"'.format(prefixdir))
endif

bindir = join_paths(prefixdir, get_option('bindir'))
libdir = join_paths(prefixdir, get_option('libdir'))
sysconfdir = join_paths(prefixdir, get_option('sysconfdir'))
includedir = join_paths(prefixdir, get_option('includedir'))
datadir = join_paths(prefixdir, get_option('datadir'))
localstatedir = join_paths('/', get_option('localstatedir'))

rootbindir = join_paths(rootprefixdir, 'bin')
rootlibexecdir = join_paths(rootprefixdir, 'lib/systemd')

rootlibdir = get_option('rootlibdir')
if rootlibdir == ''
        rootlibdir = join_paths(rootprefixdir, libdir.split('/')[-1])
endif
pkgconfigdatadir = join_paths(datadir, 'pkgconfig')
pkgconfiglibdir = join_paths(libdir, 'pkgconfig')

systemd_sp = subproject('systemd')

meson_compat_lib_sh = find_program('tools/meson-compat-lib.sh')

subdir('src/compat-libs')

libbasic = systemd_sp.get_variable('libbasic')
librt = systemd_sp.get_variable('librt')
libgcrypt = systemd_sp.get_variable('libgcrypt')
threads = systemd_sp.get_variable('threads')
libxz = systemd_sp.get_variable('libxz')
liblz4 = systemd_sp.get_variable('liblz4')
libsystemd_internal = systemd_sp.get_variable('libsystemd_internal')
libsystemd = systemd_sp.get_variable('libsystemd')
journal_internal_sources = systemd_sp.get_variable('journal_internal_sources')

systemd_base = 'subprojects/systemd-234'
systemd_src = join_paths([systemd_base, 'src'])

includes = include_directories(
  join_paths([systemd_src, 'basic']),
  join_paths([systemd_src, 'shared']),
  join_paths([systemd_src, 'systemd']),
)

id128_sources = [
  join_paths([systemd_src, 'libsystemd/sd-id128/id128-util.h']),
  join_paths([systemd_src, 'libsystemd/sd-id128/id128-util.c']),
  join_paths([systemd_src, 'libsystemd/sd-id128/sd-id128.c']),
]

cargs = [
  '-imacros../src/compat-libs/linkwarning.h',
  '-include', join_paths([systemd_base, 'config.h']),
]

libsystemd_daemon = shared_library(
        'systemd-daemon',
        join_paths([systemd_src, 'libsystemd/sd-daemon/sd-daemon.c']),
        libsystemd_daemon_src,
        version : '0.12.0',
        include_directories : includes,
        c_args : cargs,
        link_args : [
                '-shared',
                '-Wl,--version-script=' + '../src/compat-libs/libsystemd-daemon.sym'],
        link_with : [libbasic],
        link_depends : 'src/compat-libs/libsystemd-daemon.sym',
        dependencies : [librt],
        install : true,
        install_dir : rootlibdir,
)

libsystemd_id128 = shared_library(
        'systemd-id128',
        id128_sources,
        libsystemd_id128_src,
        version : '0.28.0',
        include_directories : includes,
        c_args : cargs,
        link_args : ['-shared',
                     '-Wl,--version-script=' + '../src/compat-libs/libsystemd-id128.sym'],
        link_with : [libbasic],
        link_depends : 'src/compat-libs/libsystemd-id128.sym',
        install : true,
        install_dir : rootlibdir,
)

libsystemd_login = shared_library(
        'systemd-login',
        join_paths([systemd_src, 'libsystemd/sd-login/sd-login.c']),
        libsystemd_login_src,
        version : '9.3.9',
        include_directories : includes,
        c_args : cargs,
        link_args : ['-shared',
                     '-Wl,--version-script=' + '../src/compat-libs/libsystemd-journal.sym'],
        link_with : [libbasic],
        link_depends : 'src/compat-libs/libsystemd-login.sym',
        install : true,
        install_dir : rootlibdir,
)

libsystemd_journal = shared_library(
        'systemd-journal',
        journal_internal_sources,
        id128_sources,
        join_paths([systemd_src, 'libsystemd/sd-event/sd-event.c']),
        join_paths([systemd_src, 'libsystemd/sd-daemon/sd-daemon.c']),
        [libsystemd_journal_src],
        version : '11.5.11',
        include_directories : includes,
        c_args : cargs,
        link_args : ['-shared',
                     '-Wl,--version-script=' + '../src/compat-libs/libsystemd-journal.sym'],
        link_with : [libbasic],
        link_depends : 'src/compat-libs/libsystemd-journal.sym',
        dependencies : [libgcrypt, librt, threads, libxz, liblz4],
        install : true,
        install_dir : rootlibdir,
)

meson.add_install_script(meson.source_root() + '/tools/meson-cleanup-install.sh')
