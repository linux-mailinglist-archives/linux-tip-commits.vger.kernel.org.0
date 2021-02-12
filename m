Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300BD319EAA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBLMkB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhBLMic (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:32 -0500
Date:   Fri, 12 Feb 2021 12:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ATgyoHM6vB6+RdVHSpIePHEI1ckinPBTrgFDhO27FzI=;
        b=pOmxbFqKG49kftE53QNoH0foBXTXye420jHxSzxy2ks0ptenCpxpWcRi0cpdT38So3zN8H
        Q9PtW0tfhxjISh5a6n13jURlcYWuXs7tk9IA4BVBIJKd4exln8pP0UilPs6QAFv8tQJPJT
        NwiH7XXRJDULIudvPRcqoNDyQK1Umhpzw6IqpCr7UBkvQngUDPzseRsHZw83E5Z/Ss+PA4
        coj5F1uUeFs0MfYFeeYxRYv4rHHjBCgncxs/L/GQrZCoaPvn/k3nI61KtJzLowl2mIpMHd
        pKyu7vH5XKURpo3DQiwwKb5X9A9LtWrBtN3sAYItTzZsNzpaCzG9KrE1UygUcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ATgyoHM6vB6+RdVHSpIePHEI1ckinPBTrgFDhO27FzI=;
        b=vDmfl2MIbWvkMIjQF50NQtoDhIPCXhYNYpxIVeHQtWflWuWxnSEAOnAFXFO1A2zfSyWfDz
        m1XRvRMKeQ0vrJBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add "make allmodconfig" to torture.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343427.23325.15950775230003397476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a115a775a8d51c51c8c0b89649646a0e15a4978e
Gitweb:        https://git.kernel.org/tip/a115a775a8d51c51c8c0b89649646a0e15a4978e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 11:33:05 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:41 -08:00

torture: Add "make allmodconfig" to torture.sh

This commit adds the ability to do "make allmodconfig" to torture.sh,
given that normal rcutorture runs do not normally catch missing exports.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 37 +++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0bd8e84..57f2f31 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -17,6 +17,9 @@ KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
 
+TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
+MAKE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS*2))
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -24,6 +27,7 @@ duration_locktorture_frac=1
 duration_scftorture_frac=2
 
 # "yes" or "no" parameters
+do_allmodconfig=yes
 do_rcutorture=yes
 do_locktorture=yes
 do_scftorture=yes
@@ -36,6 +40,7 @@ do_kcsan=no
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --doall"
+	echo "       --doallmodconfig / --do-no-allmodconfig"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"
 	echo "       --do-kvfree / --do-no-kvfree"
@@ -53,6 +58,7 @@ while test $# -gt 0
 do
 	case "$1" in
 	--doall)
+		do_allmodconfig=yes
 		do_rcutorture=yes
 		do_locktorture=yes
 		do_scftorture=yes
@@ -62,6 +68,14 @@ do
 		do_kasan=yes
 		do_kcsan=yes
 		;;
+	--do-allmodconfig|--do-no-allmodconfig)
+		if test "$1" = --do-allmodconfig
+		then
+			do_allmodconfig=yes
+		else
+			do_allmodconfig=no
+		fi
+		;;
 	--do-kasan|--do-no-kasan)
 		if test "$1" = --do-kasan
 		then
@@ -95,6 +109,7 @@ do
 		fi
 		;;
 	--do-none)
+		do_allmodconfig=no
 		do_rcutorture=no
 		do_locktorture=no
 		do_scftorture=no
@@ -242,6 +257,26 @@ function torture_set {
 	fi
 }
 
+# make allmodconfig
+if test "$do_allmodconfig" = "yes"
+then
+	echo " --- allmodconfig:" Start `date` | tee -a $T/log
+	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
+	mkdir -p "$amcdir"
+	make -j$MAKE_ALLOTED_CPUS clean > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS allmodconfig > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS > "$amcdir/Make.out" 2>&1
+	retcode="$?"
+	echo $retcode > "$amcdir/Make.exitcode"
+	if test "$retcode" == 0
+	then
+		echo "allmodconfig($retcode)" $amcdir >> $T/successes
+	else
+		echo "allmodconfig($retcode)" $amcdir >> $T/failures
+	fi
+fi
+
+# --torture rcu
 if test "$do_rcutorture" = "yes"
 then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
@@ -320,7 +355,7 @@ exit $ret
 # @@@
 # RCU CPU stall warnings?
 # scftorture warnings?
-# Need a way for the invoker to specify clang.
+# Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
 # Work out --configs based on number of available CPUs?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
 # --kconfig as with --bootargs (Both have overrides.)
