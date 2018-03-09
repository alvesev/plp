#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  Copyright 2013-2017 Alex Vesev <alex.vesev@gmail.com>
#
#  This file is part of Packages List Processor - PLP.
#
#  PLP is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  PLP is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with PLP.  If not, see <http://www.gnu.org/licenses/>.
#
##


import sys
sys.dont_write_bytecode = True


import os
import logging
from logging.handlers import RotatingFileHandler


file_log = os.path.join(os.path.expanduser("~"), ".logs", "plp.log")
size_log = 1*1024*1024


if not os.path.isdir(os.path.dirname(file_log)):
    os.mkdir(os.path.dirname(file_log))

log_str_frmt = "%(asctime)s [%(levelname)-5.5s" \
                            + ":%(filename)s" \
                            + ":%(lineno)s"\
                            + ":pid-%(process)d" \
                            + ":%(threadName)-12.12s]" \
                            + " %(message)s"

level = logging.INFO
logging.basicConfig(format=log_str_frmt, level="INFO")
lform = logging.Formatter(log_str_frmt)
flh = RotatingFileHandler(file_log, maxBytes=size_log, backupCount=2)
l = logging.getLogger('root')

flh.setFormatter(lform)
flh.setLevel(level)
l.addHandler(flh)
l.setLevel(level)

l.info("Log file is '{}'.".format(file_log))
