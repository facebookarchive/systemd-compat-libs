#
# Copyright (C) 2017 Facebook
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

project('systemd-compat-libs', 'c',
        version : '237',
        license : 'LGPLv2+',
        default_options: [
                'c_std=gnu99',
                'prefix=/usr',
                'sysconfdir=/etc',
                'localstatedir=/var',
        ],
        meson_version : '>= 0.44',
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
libbasic_gcrypt = systemd_sp.get_variable('libbasic_gcrypt')
librt = systemd_sp.get_variable('librt')
libgcrypt = systemd_sp.get_variable('libgcrypt')
threads = systemd_sp.get_variable('threads')
libxz = systemd_sp.get_variable('libxz')
liblz4 = systemd_sp.get_variable('liblz4')
libsystemd_static = systemd_sp.get_variable('libsystemd_static')
libsystemd = systemd_sp.get_variable('libsystemd')
libjournal_client = systemd_sp.get_variable('libjournal_client')

sd_daemon_c = systemd_sp.get_variable('sd_daemon_c')
sd_login_c = systemd_sp.get_variable('sd_login_c')
sd_event_c = systemd_sp.get_variable('sd_event_c')

systemd_base = 'subprojects/systemd-' + meson.project_version()
systemd_src = join_paths([systemd_base, 'src'])

includes = include_directories(
  join_paths([systemd_src, 'basic']),
  join_paths([systemd_src, 'shared']),
  join_paths([systemd_src, 'systemd']),
)

id128_sources = systemd_sp.get_variable('id128_sources')

cargs = [
  '-imacros../src/compat-libs/linkwarning.h',
  '-include', join_paths([systemd_base, 'config.h']),
]

libsystemd_daemon = shared_library(
        'systemd-daemon',
        sd_daemon_c,
        libsystemd_daemon_src,
        version : '0.0.12',
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
        version : '0.0.28',
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
        sd_login_c,
        libsystemd_login_src,
        version : '0.9.3',
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
        libsystemd_journal_src,
        version : '0.11.5',
        include_directories : includes,
        c_args : cargs,
        link_args : ['-shared',
                     '-Wl,--version-script=' + '../src/compat-libs/libsystemd-journal.sym'],
        link_with : [libbasic, libbasic_gcrypt],
        link_whole: [libsystemd_static, libjournal_client],
        link_depends : 'src/compat-libs/libsystemd-journal.sym',
        dependencies : [libgcrypt, librt, threads, libxz, liblz4],
        install : true,
        install_dir : rootlibdir,
)

meson.add_install_script(meson.source_root() + '/tools/meson-cleanup-install.sh')
