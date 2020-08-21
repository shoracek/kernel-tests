#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      
#                                                                           
#   runtest.sh of /packages/xdp-tools/xdp-tools-testsuite/runtest.sh
#   Description: Wrapper around upstream xdp-tools testsuite.
#   Author: Stepan Horacek <shoracek@redhat.com>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Copyright (c) 2020 Red Hat, Inc. All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


. ../../../cki_lib/libcki.sh || exit 1
. /usr/share/beakerlib/beakerlib.sh || exit 1

check_version()
{
        local required_version="$2"
        local current_version
        local lowest_version

        command -v $1 &> /dev/null
        if [[ $? -ne 0 ]]; then
                rlLog "Aborting test because: Installed version is too old, required at least ${required_version}."
                rstrnt-abort --server $RSTRNT_RECIPE_URL/tasks/$RSTRNT_TASKID/status
        fi

        current_version=$($1 2> /dev/null | grep "[0-9]\+\.[0-9]\+\.[0-9]\+" -o)
        lowest_version=$(printf "${current_version}\n${required_version}" \
                         | sort -V | head -n 1)

        if [[ "$lowest_version" != "$required_version" ]]; then
                rlLog "Aborting test because: Installed version is too old, required at least ${required_version}, installed ${current_version}."
                rstrnt-abort --server $RSTRNT_RECIPE_URL/tasks/$RSTRNT_TASKID/status
        fi
}

rlJournalStart
        rlPhaseStartSetup
                check_version "xdpdump --version" "1.0.1"
                check_version "xdp-filter status --version" "1.0.1"
                check_version "xdp-loader status --version" "1.0.1"

                rlRun "git clone https://github.com/xdp-project/xdp-tools"
                if [ $? -ne 0 ]; then
                        rlLog "Aborting test because: Unable to clone testsuite repository."
                        rstrnt-abort --server $RSTRNT_RECIPE_URL/tasks/$RSTRNT_TASKID/status

                fi

                rlRun "EMACS= make -C xdp-tools"

                rlRun "pip3 install xdp_test_harness"

                TEST_RUNNER="./xdp-tools/lib/testing/test_runner.sh"

                export XDPDUMP=xdpdump
                export XDP_LOADER=xdp-loader
                export XDP_FILTER=xdp-filter
        rlPhaseEnd

        rlPhaseStartTest "xdp-filter"
                rlRun "${TEST_RUNNER} xdp-tools/xdp-filter/tests/test-xdp-filter.sh"
        rlPhaseEnd
        rlPhaseStartTest "xdp-loader"
                rlRun "${TEST_RUNNER} xdp-tools/xdp-loader/tests/test-xdp-loader.sh"
        rlPhaseEnd
        rlPhaseStartTest "xdp-dump"
                rlRun "${TEST_RUNNER} xdp-tools/xdp-dump/tests/test-xdpdump.sh"
        rlPhaseEnd

        rlPhaseStartCleanup
                rlRun "rm -rf xdp-tools"
        rlPhaseEnd

        rlJournalPrintText
rlJournalEnd
