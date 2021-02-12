Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF1319EB2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhBLMkO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhBLMig (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:36 -0500
Date:   Fri, 12 Feb 2021 12:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RcFhGNHVbcnbYWFT3c7A/Lq+k+y/Iu8p0DTbbp8W/6g=;
        b=397uslylQCBlQ84bx+TdsIyhuCuKzYdc5UOHydjFqM1k0Yn/XRHAGRXs+bEXqGexbmn3pG
        qmtDZLQptlXU7omO2ASaJDwxQ29eA9ttMYmFDb9GHOmqiv1NlmiQde9CgjQUbctglLt7wB
        giT7FGFEnGWGgHpeVZ0py1+3+tPKd2OqTQEAvpjbiH00lynQMrByQNJtp9BPYNdvew/gCU
        wABdCXycv//VkMFWnasVS8VHu9eG3rSrdM114QFBP1eUUvLNPj2nL7qk4sxnHKAqyuSqJH
        L/+ix9UoUeu8JHo+Y3oxoLrKLtwH+yrBXoliJj+Bv7/Z9zVvMtDM9gT9r4EhkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RcFhGNHVbcnbYWFT3c7A/Lq+k+y/Iu8p0DTbbp8W/6g=;
        b=65lMdKpRsRQCw9CXSYxG4IEsPbpFwe2fnVGVWpP8GwAqZSD00IkpIhS2aUzh/1XGSb5Vfn
        mRcO/Z8E/R6NSfBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove use of "eval" in torture.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343451.23325.11949803870701900596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     197220d4a3347aa2c21389235db4a4457e7dc0a7
Gitweb:        https://git.kernel.org/tip/197220d4a3347aa2c21389235db4a4457e7dc0a7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 23 Nov 2020 07:27:32 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:40 -08:00

torture: Remove use of "eval" in torture.sh

The bash "eval" command enables Bobby Tables attacks, which might not
be a concern in torture testing by themselves, but one could imagine
these combined with a cut-and-paste attack.  This commit therefore gets
rid of them.  This comes at a price in terms of bash quoting not working
nicely, so the "--bootargs" argument lists are now passed to torture_one
via a bash-variable side channel.  This might be a bit ugly, but it will
also allow torture.sh to grow its own --bootargs parameter.

While in the area, add proper header comments for the bash functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 55 +++++++++++---
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 1657404..0bd8e84 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -178,11 +178,26 @@ ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
 startdate="`date`"
 starttime="`get_starttime`"
 
-# tortureme flavor command
+# torture_one - Does a single kvm.sh run.
+#
+# Usage:
+#	torture_bootargs="[ kernel boot arguments ]"
+#	torture_one flavor [ kvm.sh arguments ]
+#
 # Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+# Note that quoting is problematic.  So on the command line, pass multiple
+# values with multiple kvm.sh argument instances.
 function torture_one {
+	local cur_bootargs=
+	local boottag=
+
 	echo " --- $curflavor:" Start `date` | tee -a $T/log
-	eval $* --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
+	if test -n "$torture_bootargs"
+	then
+		boottag="--bootargs"
+		cur_bootargs="$torture_bootargs"
+	fi
+	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
 	if test -n "$resdir"
@@ -201,36 +216,48 @@ function torture_one {
 	fi
 }
 
+# torture_set - Does a set of tortures with and without KASAN and KCSAN.
+#
+# Usage:
+#	torture_bootargs="[ kernel boot arguments ]"
+#	torture_set flavor [ kvm.sh arguments ]
+#
+# Note that "flavor" is an arbitrary string.  Supply --torture if needed.
+# Note that quoting is problematic.  So on the command line, pass multiple
+# values with multiple kvm.sh argument instances.
 function torture_set {
 	local flavor=$1
 	shift
 	curflavor=$flavor
-	torture_one $*
+	torture_one "$@"
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
-		torture_one $* --kasan
+		torture_one "$@" --kasan
 	fi
 	if test "$do_kcsan" = "yes"
 	then
 		curflavor=${flavor}-kcsan
-		torture_one $* --kconfig '"CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"' --kmake-arg "CC=clang" --kcsan
+		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --kmake-arg "CC=clang" --kcsan
 	fi
 }
 
 if test "$do_rcutorture" = "yes"
 then
-	torture_set "rcutorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration '"$duration_rcutorture"' --configs "TREE10 4*CFLIST" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000" --trust-make'
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE10 4*CFLIST" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
 then
-	torture_set "locktorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration '"$duration_locktorture"' --configs "14*CFLIST" --bootargs "torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="torture.disable_onoff_at_boot"
+	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "14*CFLIST" --trust-make
 fi
 
 if test "$do_scftorture" = "yes"
 then
-	torture_set "scftorture" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration '"$duration_scftorture"' --kconfig "CONFIG_NR_CPUS=224" --bootargs "scftorture.nthreads=224 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="scftorture.nthreads=224 torture.disable_onoff_at_boot"
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=224" --trust-make
 fi
 
 if test "$do_refscale" = yes
@@ -241,7 +268,8 @@ else
 fi
 for prim in $primlist
 do
-	torture_set "refscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "refscale.scale_type='"$prim"' refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 done
 
 if test "$do_rcuscale" = yes
@@ -252,12 +280,14 @@ else
 fi
 for prim in $primlist
 do
-	torture_set "rcuscale-$prim" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.scale_type='"$prim"' rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 done
 
 if test "$do_kvfree" = "yes"
 then
-	torture_set "rcuscale-kvfree" 'tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make'
+	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --trust-make
 fi
 
 echo " --- " $scriptname $args
@@ -293,3 +323,6 @@ exit $ret
 # Need a way for the invoker to specify clang.
 # Work out --configs based on number of available CPUs?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
+# --kconfig as with --bootargs (Both have overrides.)
+# Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
+# Ensure that build failures count as failures
