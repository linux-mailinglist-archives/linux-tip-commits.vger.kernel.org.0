Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14FB3B8412
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhF3NwM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhF3NvA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00CC061146;
        Wed, 30 Jun 2021 06:47:52 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lpr2lWeND1+hbD9J8b7icYQ4aFYGQ3kwyfmbbIB81AU=;
        b=PVQWTRML6ooHGp9XtzZenOQfOzY5ze0fvMSZsa66M5tyPQ4K9OQ8P1fmT6Lce+T09aObgs
        vKWnDeMZnF9Z+fQVrgaF1BaHH0YfLOA8htpOEBRGKOc72Xb9daOIv8hdB/CEnKQe3SsF/+
        H8pttgXDkbfUrm1QZaURZvXP/gyF2KTABTYdpDPU9XyfceZ3uFLyRwDptN8DN/OJDj+xHE
        aUDRpi9y0HiTBCC74Hx4lwtxcnAOkwmX4zR0uscY8y3QHZwpaoMHSJt+jsu66/uyE7Fuwx
        BmPoumPbMyJ2RDCocOxhxZba5TtGLdRAfAA2ypw8ZyQpRSCRVkdlHZ8sny3UJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lpr2lWeND1+hbD9J8b7icYQ4aFYGQ3kwyfmbbIB81AU=;
        b=uO0zfJQCaLDMW5LLiP0wg87ZHDgex7a8B2YU8Rqq4OkLofZ6q66SxnFTV7U+T56atrHZp6
        SvVaXKoy7V8l7BDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add "scenarios" option to kvm.sh --dryrun parameter
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087022.395.11725260654168880390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d2cc4fec861a825ecd7d9ce2797df4e5f0f5517
Gitweb:        https://git.kernel.org/tip/3d2cc4fec861a825ecd7d9ce2797df4e5f0f5517
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 17:21:17 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

torture: Add "scenarios" option to kvm.sh --dryrun parameter

This commit adds "--dryrun scenarios" to kvm.sh, which prints something
like this:

1.  TREE03
2.  TREE07
3.  SRCU-P SRCU-N
4.  TREE01 TRACE01
5.  TREE02 TRACE02
6.  TREE04 RUDE01 TASKS01
7.  TREE05 TASKS03 SRCU-T SRCU-U
8.  TASKS02 TINY01 TINY02 TREE09

This format is more convenient for scripts that run batches of scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 28 ++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6bf00a0..3bd523a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -64,7 +64,7 @@ usage () {
 	echo "       --cpus N"
 	echo "       --datestamp string"
 	echo "       --defconfig string"
-	echo "       --dryrun batches|sched|script"
+	echo "       --dryrun batches|scenarios|sched|script"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
@@ -130,7 +130,7 @@ do
 		shift
 		;;
 	--dryrun)
-		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|sched\|script' '^--'
+		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|scenarios\|sched\|script' '^--'
 		dryrun=$2
 		shift
 		;;
@@ -577,6 +577,25 @@ egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		print batchno, $1, $2
 	}' > $T/batches
 
+# As above, but one line per batch.
+grep -v '^#' $T/batches | awk '
+BEGIN {
+	oldbatch = 1;
+}
+
+{
+	if (oldbatch != $1) {
+		print ++n ". " curbatch;
+		curbatch = "";
+		oldbatch = $1;
+	}
+	curbatch = curbatch " " $2;
+}
+
+END {
+	print ++n ". " curbatch;
+}' > $T/scenarios
+
 if test "$dryrun" = script
 then
 	cat $T/script
@@ -597,11 +616,16 @@ elif test "$dryrun" = batches
 then
 	cat $T/batches
 	exit 0
+elif test "$dryrun" = scenarios
+then
+	cat $T/scenarios
+	exit 0
 else
 	# Not a dryrun.  Record the batches and the number of CPUs, then run the script.
 	bash $T/script
 	ret=$?
 	cp $T/batches $resdir/$ds/batches
+	cp $T/scenarios $resdir/$ds/scenarios
 	echo '#' cpus=$cpus >> $resdir/$ds/batches
 	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
