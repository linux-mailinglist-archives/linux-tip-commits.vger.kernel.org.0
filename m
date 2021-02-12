Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4F319EB4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBLMkQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBLMii (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:38 -0500
Date:   Fri, 12 Feb 2021 12:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AVRkqSJY4djqyrUBAMLf5jScvAnlMNA4WlnuEcIhvHU=;
        b=fbleV6MEIRH39/PjSt8nw+ac0SZsjWHtxi/bilTxDK2zNX5OU0r8CVkFNAfnQB98ZTTaLt
        qQ5DGk7OygBxyDbXaNZ6Pm3YHpXMmoTdgbJVYsE+/AowQYSKs3dldzAHMwCOkzxY8hR9pi
        4pAFJ4/3LTB3MivG/SKKtPZgMCPXxDiYGi7yYmRTuUwBRKQxYEm1++7LosDTAHyEWShEOB
        e5zMnFU9fK7tNOEeKSltRt/yb1aJbaimQ15v9azcrwGZqo9sYs0r2nvWstiAbaJ9Gt1B4d
        Tcdu9gAxVOETqyv4b2HR2a8zdC1nk1pLRO3EwJb6Rl84HuV6XJy+eUxDw24/qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AVRkqSJY4djqyrUBAMLf5jScvAnlMNA4WlnuEcIhvHU=;
        b=swSqpdGk7bko8B7QAoKkVMzF+gmdtiESpZDkpSw/V+54ZLr3UhrhNgE8MjdfCYHjlJvjdd
        WYu70KO6ipfnLFAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add torture.sh torture-everything script
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343509.23325.7927591256949589675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bfc19c13d24c70e4fb1dafd76900731bcee97683
Gitweb:        https://git.kernel.org/tip/bfc19c13d24c70e4fb1dafd76900731bcee97683
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 21 Nov 2020 14:09:48 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:59:47 -08:00

torture: Add torture.sh torture-everything script

Although tailoring a specific set of kvm.sh runs has served rcutorture
testing well over many years, it requires a relatively distraction-free
environment, which is not always available.  This commit therefore
adds a prototype torture.sh script that by default tortures pretty much
everything the rcutorture scripting is designed to torture, and which
can be given command-line arguments to take a more focused approach.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 301 +++++++++++++-
 1 file changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/bin/torture.sh

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
new file mode 100644
index 0000000..7f21aab
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -0,0 +1,301 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a series of torture tests, intended for overnight or
+# longer timeframes, and also for large systems.
+#
+# Usage: torture.sh [ options ]
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+# Default duration and apportionment.
+duration_base=10
+duration_rcutorture_frac=7
+duration_locktorture_frac=1
+duration_scftorture_frac=2
+
+# "yes" or "no" parameters
+do_rcutorture=yes
+do_locktorture=yes
+do_scftorture=yes
+do_rcuscale=yes
+do_refscale=yes
+do_kvfree=yes
+do_kasan=yes
+do_kcsan=no
+
+usage () {
+	echo "Usage: $scriptname optional arguments:"
+	echo "       --doall"
+	echo "       --do-kasan / --do-no-kasan"
+	echo "       --do-kcsan / --do-no-kcsan"
+	echo "       --do-kvfree / --do-no-kvfree"
+	echo "       --do-locktorture / --do-no-locktorture"
+	echo "       --do-none"
+	echo "       --do-rcuscale / --do-no-rcuscale"
+	echo "       --do-rcutorture / --do-no-rcutorture"
+	echo "       --do-refscale / --do-no-refscale"
+	echo "       --do-scftorture / --do-no-scftorture"
+	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
+	exit 1
+}
+
+while test $# -gt 0
+do
+	case "$1" in
+	--doall)
+		do_rcutorture=yes
+		do_locktorture=yes
+		do_scftorture=yes
+		do_rcuscale=yes
+		do_refscale=yes
+		do_kvfree=yes
+		do_kasan=yes
+		do_kcsan=yes
+		;;
+	--do-kasan|--do-no-kasan)
+		if test "$1" = --do-kasan
+		then
+			do_kasan=yes
+		else
+			do_kasan=no
+		fi
+		;;
+	--do-kcsan|--do-no-kcsan)
+		if test "$1" = --do-kcsan
+		then
+			do_kcsan=yes
+		else
+			do_kcsan=no
+		fi
+		;;
+	--do-kvfree|--do-no-kvfree)
+		if test "$1" = --do-kvfree
+		then
+			do_kvfree=yes
+		else
+			do_kvfree=no
+		fi
+		;;
+	--do-locktorture|--do-no-locktorture)
+		if test "$1" = --do-locktorture
+		then
+			do_locktorture=yes
+		else
+			do_locktorture=no
+		fi
+		;;
+	--do-none)
+		do_rcutorture=no
+		do_locktorture=no
+		do_scftorture=no
+		do_rcuscale=no
+		do_refscale=no
+		do_kvfree=no
+		do_kasan=no
+		do_kcsan=no
+		;;
+	--do-rcuscale|--do-no-rcuscale)
+		if test "$1" = --do-rcuscale
+		then
+			do_rcuscale=yes
+		else
+			do_rcuscale=no
+		fi
+		;;
+	--do-rcutorture|--do-no-rcutorture)
+		if test "$1" = --do-rcutorture
+		then
+			do_rcutorture=yes
+		else
+			do_rcutorture=no
+		fi
+		;;
+	--do-refscale|--do-no-refscale)
+		if test "$1" = --do-refscale
+		then
+			do_refscale=yes
+		else
+			do_refscale=no
+		fi
+		;;
+	--do-scftorture|--do-no-scftorture)
+		if test "$1" = --do-scftorture
+		then
+			do_scftorture=yes
+		else
+			do_scftorture=no
+		fi
+		;;
+	--duration)
+		# checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		duration_base=$(($ts*mult))
+		shift
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+
+duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
+# Need to sum remaining weights, and if duration weights to zero,
+# set do_no_rcutorture. @@@
+duration_locktorture=$((duration_base*duration_locktorture_frac/10))
+duration_scftorture=$((duration_base*duration_scftorture_frac/10))
+
+T=/tmp/torture.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
+
+touch $T/failures
+touch $T/successes
+
+ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
+startdate="`date`"
+starttime="`awk 'BEGIN { print systime() }' < /dev/null`"
+
+# tortureme flavor command
+# Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+function torture_one {
+	echo " --- $curflavor:" Start `date` | tee -a $T/log
+	eval $* --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	retcode=$?
+	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
+	if test -n "$resdir"
+	then
+		cp $T/$curflavor.out $resdir/log.long
+		echo retcode=$retcode >> $resdir/log.long
+	else
+		cat $T/$curflavor.out | tee -a $T/log
+		echo retcode=$retcode | tee -a $T/log
+	fi
+	if test "$retcode" == 0
+	then
+		echo "$curflavor($retcode)" $resdir >> $T/successes
+	else
+		echo "$curflavor($retcode)" $resdir >> $T/failures
+	fi
+}
+
+function torture_set {
+	local flavor=$1
+	shift
+	curflavor=$flavor
+	torture_one $*
+	if test "$do_kasan" = "yes"
+	then
+		curflavor=${flavor}-kasan
+		torture_one $* --kasan
+	fi
+	if test "$do_kcsan" = "yes"
+	then
+		curflavor=${flavor}-kcsan
+		torture_one $* --kconfig '"CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"' --kmake-arg "CC=clang" --kcsan
+	fi
+}
+
+if test "$do_rcutorture" = "yes"
+then
+	torture_set "rcutorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration '"$duration_rcutorture"' --configs "TREE10 4*CFLIST" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000" --trust-make'
+fi
+
+if test "$do_locktorture" = "yes"
+then
+	torture_set "locktorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration '"$duration_locktorture"' --configs "14*CFLIST" --bootargs "torture.disable_onoff_at_boot" --trust-make'
+fi
+
+if test "$do_scftorture" = "yes"
+then
+	torture_set "scftorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration '"$duration_scftorture"' --kconfig "CONFIG_NR_CPUS=224" --bootargs "scftorture.nthreads=224 torture.disable_onoff_at_boot" --trust-make'
+fi
+
+if test "$do_refscale" = yes
+then
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+else
+	primlist=
+fi
+for prim in $primlist
+do
+	torture_set "refscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "refscale.scale_type='"$prim"' refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+done
+
+if test "$do_rcuscale" = yes
+then
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+else
+	primlist=
+fi
+for prim in $primlist
+do
+	torture_set "rcuscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.scale_type='"$prim"' rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+done
+
+if test "$do_kvfree" = "yes"
+then
+	torture_set "rcuscale-kvfree" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make'
+fi
+
+echo " --- " $scriptname $args
+echo " --- " Done `date` | tee -a $T/log
+ret=0
+nsuccesses=0
+echo SUCCESSES: | tee -a $T/log
+if test -s "$T/successes"
+then
+	cat "$T/successes" | tee -a $T/log
+	nsuccesses="`wc -l "$T/successes" | awk '{ print $1 }'`"
+fi
+nfailures=0
+echo FAILURES: | tee -a $T/log
+if test -s "$T/failures"
+then
+	cat "$T/failures" | tee -a $T/log
+	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
+	ret=2
+fi
+duration="`awk -v starttime=$starttime '
+BEGIN {
+	s = systime() - starttime;
+	h = s / 3600;
+	d = h /24;
+	if (d < 1)
+		print h " hours";
+	else
+		print d " days (" h " hours)";
+}' < /dev/null`"
+echo Started at $startdate, ended at `date`, duration $duration. | tee -a $T/log
+echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
+tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+if test -n "$tdir"
+then
+	cp $T/log $tdir
+fi
+exit $ret
+
+# RCU CPU stall warnings?
+# scftorture warnings?
+# Need a way for the invoker to specify clang.
+# Work out --configs based on number of available CPUs?
+# Need a way to specify --configs.  --configs--rcutorture?
+# Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
