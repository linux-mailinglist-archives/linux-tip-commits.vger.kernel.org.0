Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75223B83E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhF3NvO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhF3Nub (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE5C0619FE;
        Wed, 30 Jun 2021 06:47:47 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FjIgi9pBI2cyYl0hd1lMANmllaLE2SKJzFadm061VcE=;
        b=diFT1/kUFL02nmdNgTsH1RrNBqRWlGT1SKPiGe91qguLSoaOml3DlpOeJxq5PmRoiEetvW
        rk+PjsDhmc7vfoxGb9xwoTdVyDvhuKvNOcR8KyFWSTEycPUtvmMCGXn48phgOW02NYT+ED
        shHDSFScR0A582aVundEiYPfGiwBfRw62y7cJpvO2KqVNlVAwPB8scUt6pDwSiJ9iZreFm
        XdljAgyG0ZnSt/347jgs6J2vRkUbAooi0TRcM7qA8jezUQ0xO6IMsWUwDXm6KoV1yPvamM
        forhexv2izGONFLFLiu1agfJ+l1ypjuEEu6PD4ZRYvI1ez9FwPPLin31Rvt0TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FjIgi9pBI2cyYl0hd1lMANmllaLE2SKJzFadm061VcE=;
        b=fIcIZI2V+fndmyy4mxeVayfBYzeQfsRDCIZymq+paJpxr2ouVfhCyDNmE4MdSupYdSKfd3
        X9ulLckl5INycvCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh use abstracted kvm-end-run-stats.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086559.395.11125773611062083881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f254a0b52787d108879cc8761ee4f6ce33698029
Gitweb:        https://git.kernel.org/tip/f254a0b52787d108879cc8761ee4f6ce33698029
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Mar 2021 13:21:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture: Make kvm.sh use abstracted kvm-end-run-stats.sh

This commit reduces duplicate code by making kvm.sh use the new
kvm-end-run-stats.sh script rather than taking its historical approach
of open-coding it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3bd523a..fab3bd9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -550,20 +550,7 @@ END {
 	if (ncpus != 0)
 		dump(first, i, batchnum);
 }' >> $T/script
-
-cat << '___EOF___' >> $T/script
-echo | tee -a $TORTURE_RESDIR/log
-echo | tee -a $TORTURE_RESDIR/log
-echo " --- `date` Test summary:" | tee -a $TORTURE_RESDIR/log
-___EOF___
-cat << ___EOF___ >> $T/script
-echo Results directory: $resdir/$ds | tee -a $resdir/$ds/log
-kcsan-collapse.sh $resdir/$ds | tee -a $resdir/$ds/log
-kvm-recheck.sh $resdir/$ds > $T/kvm-recheck.sh.out 2>&1
-___EOF___
-echo 'ret=$?' >> $T/script
-echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
-echo 'exit $ret' >> $T/script
+echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
 egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
@@ -627,7 +614,6 @@ else
 	cp $T/batches $resdir/$ds/batches
 	cp $T/scenarios $resdir/$ds/scenarios
 	echo '#' cpus=$cpus >> $resdir/$ds/batches
-	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
 
