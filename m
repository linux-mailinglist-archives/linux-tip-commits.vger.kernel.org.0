Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B98319EFA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBLMoz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhBLMnB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9FC06178A;
        Fri, 12 Feb 2021 04:42:20 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/UQbR5wKZ7F2RZkoX05vb1e6KQJqygSfy5blQG7wkkM=;
        b=kcfwSZrVQFt5/2M5pBZTAHxMVndXe6Xof2iDysEaycboQlO91FqQNgm2J029OV8ilH3vgf
        Xo2JUEc/Ws7YxlqSqn97T1PD4GH+V1kWJ6Y91jOt+9ADgwushWo8EGV51CvLWkKukD3jY8
        7Ln69VYBv+zgSwEcW0Jl9Qm00eqjZK0mfi/vRRFgfYxxEbd1Drnhlq8PenumRpc08ZLvbh
        4cR4X0TqGEHR0t7KSh1MbSBLHilDJHvQH9YXzhptJImW2G1RipJkWnSnStxbBiIdhj3Gom
        Vk7LYcEJvDrWHe3Z21r7gnncEcdJZ6eqFCe6iIvxLPgkDyqSOos2l4FyQwonAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/UQbR5wKZ7F2RZkoX05vb1e6KQJqygSfy5blQG7wkkM=;
        b=+6cHpdSkXijy2O7Satpf1s1Dxw3uv1SIhWf2NCpTnOLtBLPubCn6As8BKt16Beq/YKLDC1
        G/Y+QS/v7Z8T6xDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add kvm.sh test summary to end of log file
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344615.23325.7252334519905593095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0beb394878a46bad6358f81dde2ef4aa0ef68af5
Gitweb:        https://git.kernel.org/tip/0beb394878a46bad6358f81dde2ef4aa0ef68af5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 26 Nov 2020 15:27:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:22 -08:00

torture: Add kvm.sh test summary to end of log file

This commit adds the test summary to the end of the log in the top-level
directory containing the kvm.sh test artifacts.  While in the area, it adds
the kvm.sh exit code to this test summary.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 19 ++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 472929c..667896f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -527,15 +527,18 @@ END {
 }' >> $T/script
 
 cat << '___EOF___' >> $T/script
-echo
-echo
-echo " --- `date` Test summary:"
+echo | tee -a $TORTURE_RESDIR/log
+echo | tee -a $TORTURE_RESDIR/log
+echo " --- `date` Test summary:" | tee -a $TORTURE_RESDIR/log
 ___EOF___
 cat << ___EOF___ >> $T/script
-echo Results directory: $resdir/$ds
-kcsan-collapse.sh $resdir/$ds
-kvm-recheck.sh $resdir/$ds
+echo Results directory: $resdir/$ds | tee -a $resdir/$ds/log
+kcsan-collapse.sh $resdir/$ds | tee -a $resdir/$ds/log
+kvm-recheck.sh $resdir/$ds > $T/kvm-recheck.sh.out 2>&1
 ___EOF___
+echo 'ret=$?' >> $T/script
+echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
+echo 'exit $ret' >> $T/script
 
 if test "$dryrun" = script
 then
@@ -556,9 +559,9 @@ then
 	exit 0
 else
 	# Not a dryrun, so run the script.
-	sh $T/script
+	bash $T/script
 	ret=$?
-	echo " --- Done at `date` (`get_starttime_duration $starttime`)"
+	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
 
