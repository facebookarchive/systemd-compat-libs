/***
  This file is part of systemd-compat-libs, but is heavily based on
  glibc's libc-symbols.h.

  Copyright (C) 1995-1998,2000-2006,2008,2009 Free Software Foundation, Inc

  This source code is licensed under the license found in the
  LICENSE file in the root directory of this source tree.
***/

#pragma once

#define __make_section_unallocated(section_string)      \
  asm (".section " section_string "\n\t.previous");

#define __sec_comment "\n#APP\n\t#"

#define link_warning(symbol, msg) \
  __make_section_unallocated (".gnu.warning." #symbol)  \
  static const char __evoke_link_warning_##symbol[]     \
    __attribute__ ((used, section (".gnu.warning." #symbol __sec_comment))) \
    = msg

#define obsolete_lib(name, lib)                         \
  link_warning(name, #name " was moved to libsystemd. Do not use " #lib ".")
