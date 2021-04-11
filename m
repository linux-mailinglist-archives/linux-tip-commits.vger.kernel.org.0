Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABB35B4C1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhDKNoH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZl94lNk4y7Hz5RjqnywK2D8+zkqu7WVWfJCAHu1oMA=;
        b=F1FnSOg6KIA3znky5eluaFvO1zupE2iDeVRg4bv+mi/9ft1RitY9W78WSz8IHb3IHSR2U1
        O8+9AK8nWTMhwaN1uWgnj6Nipio0m4p5UB4RfV2002+GorkXFSEURjgrjtwCzdzZLqd/l4
        g3GtDpOt8mYxrSMJKC54N757mgJV3y81UeQWWSEM1J7uxtfIZ1jnPs9rW/R+F+AL2kemWe
        +Slr8v2Pm+KFv1ONzUB793IEmDoHSqMGsKpIUQ4xwmZ4AsU647RLCM2VATchpUHA1QQlOB
        mTqNU45E+VirfRdFWgz78NbULiT22CgF29AOB4YTsZyogDxoapLwmiOYlH3isg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZl94lNk4y7Hz5RjqnywK2D8+zkqu7WVWfJCAHu1oMA=;
        b=oGAzChe6kBfFcEgq6+G3SLs/Qw0enZ53GrLoKEiHK37UvpMNdBpf/oXYBKn74oL45YnOC5
        DWDuqHZ3N7AtrgAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add kvm-again.sh to rerun a previous torture-test
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860109.29796.6667551101891823637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7cf86c0b6279d9d12bb697e58c7e8b2184a8f3db
Gitweb:        https://git.kernel.org/tip/7cf86c0b6279d9d12bb697e58c7e8b2184a8f3db
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 19 Feb 2021 17:49:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:19 -07:00

torture: Add kvm-again.sh to rerun a previous torture-test

This commit adds a kvm-again.sh script that, given the results directory
of a torture-test run, re-runs that test.  This means that the kernels
need not be rebuilt, but it also is a step towards running torture tests
on remote systems.

This commit also adds a kvm-test-1-run-batch.sh script that runs one
batch out of the torture test.  The idea is to copy a results directory
tree to remote systems, then use kvm-test-1-run-batch.sh to run batches
on these systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh            | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh |  67 +++++++++++++++++++++++++++-
 2 files changed, 238 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-again.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
new file mode 100755
index 0000000..4137440
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Rerun a series of tests under KVM.
+#
+# Usage: kvm-again.sh /path/to/old/run [ options ]
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+T=${TMPDIR-/tmp}/kvm-again.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+if ! test -d tools/testing/selftests/rcutorture/bin
+then
+	echo $scriptname must be run from top-level directory of kernel source tree.
+	exit 1
+fi
+
+oldrun=$1
+shift
+if ! test -d "$oldrun"
+then
+	echo "Usage: $scriptname /path/to/old/run [ options ]"
+	exit 1
+fi
+if ! cp "$oldrun/batches" $T/batches.oldrun
+then
+	# Later on, can reconstitute this from console.log files.
+	echo Prior run batches file does not exist: $oldrun/batches
+	exit 1
+fi
+
+if test -f "$oldrun/torture_suite"
+then
+	torture_suite="`cat $oldrun/torture_suite`"
+elif test -f "$oldrun/TORTURE_SUITE"
+then
+	torture_suite="`cat $oldrun/TORTURE_SUITE`"
+else
+	echo "Prior run torture_suite file does not exist: $oldrun/{torture_suite,TORTURE_SUITE}"
+	exit 1
+fi
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
+dryrun=
+default_link="cp -R"
+rundir="`pwd`/tools/testing/selftests/rcutorture/res/`date +%Y.%m.%d-%H.%M.%S-again`"
+
+startdate="`date`"
+starttime="`get_starttime`"
+
+usage () {
+	echo "Usage: $scriptname $oldrun [ arguments ]:"
+	echo "       --dryrun"
+	echo "       --link hard|soft|copy"
+	echo "       --remote"
+	echo "       --rundir /new/res/path"
+	exit 1
+}
+
+while test $# -gt 0
+do
+	case "$1" in
+	--dryrun)
+		dryrun=1
+		;;
+	--link)
+		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
+		case "$2" in
+		copy)
+			arg_link="cp -R"
+			;;
+		hard)
+			arg_link="cp -Rl"
+			;;
+		soft)
+			arg_link="cp -Rs"
+			;;
+		esac
+		shift
+		;;
+	--remote)
+		arg_remote=1
+		default_link="cp -as"
+		;;
+	--rundir)
+		checkarg --rundir "(absolute pathname)" "$#" "$2" '^/' '^error'
+		rundir=$2
+		if test -e "$rundir"
+		then
+			echo "--rundir $2: Already exists."
+			usage
+		fi
+		shift
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+if test -z "$arg_link"
+then
+	arg_link="$default_link"
+fi
+
+echo ---- Re-run results directory: $rundir
+
+# Copy old run directory tree over and adjust.
+mkdir -p "`dirname "$rundir"`"
+if ! $arg_link "$oldrun" "$rundir"
+then
+	echo "Cannot copy from $oldrun to $rundir."
+	usage
+fi
+rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+echo $oldrun > "$rundir/re-run"
+if ! test -d "$rundir/../../bin"
+then
+	$arg_link "$oldrun/../../bin" "$rundir/../.."
+fi
+for i in $rundir/*/qemu-cmd
+do
+	cp "$i" $T
+	qemu_cmd_dir="`dirname "$i"`"
+	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
+	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log < $T/qemu-cmd > $i
+	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+done
+grep -v '^#' $T/batches.oldrun | awk '
+BEGIN {
+	oldbatch = 1;
+}
+
+{
+	if (oldbatch != $1) {
+		print "kvm-test-1-run-batch.sh" curbatch;
+		curbatch = "";
+		oldbatch = $1;
+	}
+	curbatch = curbatch " " $2;
+}
+
+END {
+	print "kvm-test-1-run-batch.sh" curbatch
+}' > $T/runbatches.sh
+
+if test -n "$dryrun"
+then
+	echo ---- Dryrun complete, directory: $rundir | tee -a "$rundir/log"
+else
+	( cd "$rundir"; sh $T/runbatches.sh )
+	kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
+	echo | tee -a "$rundir/log"
+	echo ---- Results directory: $rundir | tee -a "$rundir/log"
+	kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
+	ret=$?
+	cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
+	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
+	exit $ret
+fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
new file mode 100755
index 0000000..7ea0809
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Carry out a kvm-based run for the specified batch of scenarios, which
+# might have been built by --build-only kvm.sh run.
+#
+# Usage: kvm-test-1-run-batch.sh SCENARIO [ SCENARIO ... ]
+#
+# Each SCENARIO is the name of a directory in the current directory
+#	containing a ready-to-run qemu-cmd file.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+T=${TMPDIR-/tmp}/kvm-test-1-run-batch.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+echo ---- Running batch $*
+# Check arguments
+runfiles=
+for i in "$@"
+do
+	if ! echo $i | grep -q '^[^/.a-z]\+\(\.[0-9]\+\)\?$'
+	then
+		echo Bad scenario name: \"$i\" 1>&2
+		exit 1
+	fi
+	if ! test -d "$i"
+	then
+		echo Scenario name not a directory: \"$i\" 1>&2
+		exit 2
+	fi
+	if ! test -f "$i/qemu-cmd"
+	then
+		echo Scenario lacks a command file: \"$i/qemu-cmd\" 1>&2
+		exit 3
+	fi
+	rm -f $i/build.*
+	touch $i/build.run
+	runfiles="$runfiles $i/build.run"
+done
+
+# Extract settings from the qemu-cmd file.
+grep '^#' $1/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
+. $T/qemu-cmd-settings
+
+# Start up jitter, start each scenario, wait, end jitter.
+echo ---- System running test: `uname -a`
+echo ---- Starting kernels. `date` | tee -a log
+$TORTURE_JITTER_START
+for i in "$@"
+do
+	echo ---- System running test: `uname -a` > $i/kvm-test-1-run-qemu.sh.out
+	echo > $i/kvm-test-1-run-qemu.sh.out
+	kvm-test-1-run-qemu.sh $i >> $i/kvm-test-1-run-qemu.sh.out 2>&1 &
+done
+for i in $runfiles
+do
+	while ls $i > /dev/null 2>&1
+	do
+		:
+	done
+done
+echo ---- All kernel runs complete. `date` | tee -a log
+$TORTURE_JITTER_STOP
