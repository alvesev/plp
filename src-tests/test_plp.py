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
sys.path.append("../src")


import unittest
# import xmlrunner
import tempfile
import os
import shutil
import stat
from journal import l


def _del_recurs(dir_name):
    l.info("Removing '{}'".format(dir_name))
    def force_del(action, path_x, exc):
        l.info("Force removal of '{}'".format(path_x))
        os.chmod(path_x, stat.S_IWRITE)
        os.unlink(path_x)
    if os.path.exists(dir_name):
        shutil.rmtree(dir_name, ignore_errors=False, onerror=force_del)

class TestPLP(unittest.TestCase):

    class CliArgs(object):
        pass

    def test_basic(self):
        assert True

    @classmethod
    def setUpClass(self):
        self.dir_tmp = tempfile.mkdtemp()
        self.cli_args = self.CliArgs()
        l.info("Testing in '{}'".format(self.dir_tmp))

    @classmethod
    def tearDownClass(self):
        _del_recurs(self.dir_tmp)


if __name__ == '__main__':
    l.setLevel("DEBUG")
    #unittest.main(testRunner=xmlrunner.XMLTestRunner(output=os.path.dirname(__file__)))
    unittest.main()
