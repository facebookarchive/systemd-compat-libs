#!/bin/sh
#
# Copyright (C) 2017 Facebook
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

sed -n -r "s/^ +(sd_.*);/obsolete_lib(\1,$1);/p" $2
