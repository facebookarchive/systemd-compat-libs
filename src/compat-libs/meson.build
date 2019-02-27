#
# Copyright (C) 2017 Facebook
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

substs = configuration_data()
substs.set('PACKAGE_URL', 'https://www.freedesktop.org/wiki/Software/systemd')
substs.set('PACKAGE_VERSION', meson.project_version())
substs.set('prefix', prefixdir)
substs.set('exec_prefix', prefixdir)
substs.set('libdir', libdir)
substs.set('includedir', includedir)

libsystemd_daemon_src = custom_target(
        'libsystemd-daemon.c',
        output : 'libsystemd-daemon.c',
        input : 'libsystemd-daemon.sym',
        command : [meson_compat_lib_sh, 'libsystemd-daemon', '@INPUT@'],
        capture : true)

libsystemd_daemon_pc = configure_file(
        input : 'libsystemd-daemon.pc.in',
        output : 'libsystemd-daemon.pc',
        configuration : substs)

install_data(libsystemd_daemon_pc,
             install_dir : pkgconfiglibdir)

libsystemd_id128_src = custom_target(
        'libsystemd-id128.c',
        output : 'libsystemd-id128.c',
        input : 'libsystemd-id128.sym',
        command : [meson_compat_lib_sh, 'libsystemd-id128', '@INPUT@'],
        capture : true)

libsystemd_id128_pc = configure_file(
        input : 'libsystemd-id128.pc.in',
        output : 'libsystemd-id128.pc',
        configuration : substs)

install_data(libsystemd_id128_pc,
             install_dir : pkgconfiglibdir)

libsystemd_login_src = custom_target(
        'libsystemd-login.c',
        output : 'libsystemd-login.c',
        input : 'libsystemd-login.sym',
        command : [meson_compat_lib_sh, 'libsystemd-login', '@INPUT@'],
        capture : true)

libsystemd_login_pc = configure_file(
        input : 'libsystemd-login.pc.in',
        output : 'libsystemd-login.pc',
        configuration : substs)

install_data(libsystemd_login_pc,
             install_dir : pkgconfiglibdir)

libsystemd_journal_src = custom_target(
        'libsystemd-journal.c',
        output : 'libsystemd-journal.c',
        input : 'libsystemd-journal.sym',
        command : [meson_compat_lib_sh, 'libsystemd-journal', '@INPUT@'],
        capture : true)

libsystemd_journal_pc = configure_file(
        input : 'libsystemd-journal.pc.in',
        output : 'libsystemd-journal.pc',
        configuration : substs)

install_data(libsystemd_journal_pc,
             install_dir : pkgconfiglibdir)
