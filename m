Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5373B83EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhF3NvX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhF3Nud (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222DC061756;
        Wed, 30 Jun 2021 06:47:48 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9ZeyovyJ5IfmrY63bL6R4dx1hE1Qutd+yU2wKH9p7F4=;
        b=Vu4Rnx59WDNoyjgImCiElUeRaPYM7OtF3GAkd2LmKnerashCqAnfImh8EXKWrP1SY6mnRE
        qAiq9w54eTlMVXtU/EbTS8ysgaEhGsOLp2n6YRPQTZDf0/plRVe25u9bxLqKtdldGH4X8X
        yU4+qOd0RfRTt7oR06hMGf7O1tbV4yYJpPLJZpVX47sOC8ll62wz2sEKevou8UJ1HG0wFa
        pcUdEn+S1F+mAL+c6+92HjH45y1IuwA48ykScBsNspgVUomaP+tTKO1ZGx/XGuwUX2LKpw
        TFJQJ3kc+ttNAm9++MAeYTMSXOHfkKtiCQYTYvOcYMdeBLUfCGuzR7IvvVq6fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9ZeyovyJ5IfmrY63bL6R4dx1hE1Qutd+yU2wKH9p7F4=;
        b=wVJH0/8O1pioB/YhFB9YLm0sHGeMnfFfigH54a/q08zO8p+CVkLT3cNtifQ82u1ldhFFAy
        BTFiWHEF1QnkOeDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Abstract end-of-run summary
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086614.395.15358870409611049988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ee8fef9137e9e75a36342077a2414dbd86c703bf
Gitweb:        https://git.kernel.org/tip/ee8fef9137e9e75a36342077a2414dbd86c703bf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Mar 2021 12:26:04 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture: Abstract end-of-run summary

This commit abstractst the end-of-run summary from kvm-again.sh, and,
while in the area, brings its format into line with that of kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh         | 11 +--
 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh | 40 +++++++-
 2 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b74bb43..d8c8483 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -143,6 +143,8 @@ then
 	usage
 fi
 rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+touch "$rundir/log"
+echo $scriptname $args | tee -a "$rundir/log"
 echo $oldrun > "$rundir/re-run"
 if ! test -d "$rundir/../../bin"
 then
@@ -178,12 +180,5 @@ then
 	echo ---- Dryrun complete, directory: $rundir | tee -a "$rundir/log"
 else
 	( cd "$rundir"; sh $T/runbatches.sh )
-	kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
-	echo | tee -a "$rundir/log"
-	echo ---- Results directory: $rundir | tee -a "$rundir/log"
-	kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
-	ret=$?
-	cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
-	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
-	exit $ret
+	kvm-end-run-stats.sh "$rundir" "$starttime"
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
new file mode 100755
index 0000000..e4a0077
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Check the status of the specified run.
+#
+# Usage: kvm-end-run-stats.sh /path/to/run starttime
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+# scriptname=$0
+# args="$*"
+rundir="$1"
+if ! test -d "$rundir"
+then
+	echo kvm-end-run-stats.sh: Specified run directory does not exist: $rundir
+	exit 1
+fi
+
+T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+default_starttime="`get_starttime`"
+starttime="${2-default_starttime}"
+
+echo | tee -a "$rundir/log"
+echo | tee -a "$rundir/log"
+echo " --- `date` Test summary:" | tee -a "$rundir/log"
+echo Results directory: $rundir | tee -a "$rundir/log"
+kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
+kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
+ret=$?
+cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
+echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
+exit $ret
