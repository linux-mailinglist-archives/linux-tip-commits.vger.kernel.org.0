Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B16288292
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgJIGiG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbgJIGfa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:30 -0400
Date:   Fri, 09 Oct 2020 06:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JRmUZZ0zf12ZnnL2ziFqlOKGKubM3x7gxBhK/JkAb5Q=;
        b=wyqBip/XUxhsm0V3gn51NZcB7IOGUuzDFjun344/IMtVMs3UEEgVjmXWKQKsiv+/qibEN6
        vZn1CNUW/ykjtK+rc+Hgy0jx8eXg0hsdM0UV6N6xwX6TGYaMgpGdx7+J4SgQL4lLnlleno
        pJf32QRjeUpyUhr+eE8CpxVSm22v9xgLSBVwGE6sUYKKGFp/mdAIKcB0eVJ9JTXEUXb/Qn
        V4JUZQyAfmXmgnNotSQoW0fKcM1hk6kRyt+7rUUw9pN9yOvLC3U/aqN9eutbFdqk5C1XZw
        3Jk/ozpjczH8UQlkWO1b1FPjnQlWGZdIwp4o9SjtJYheQuJHEKDs3peip1TDOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JRmUZZ0zf12ZnnL2ziFqlOKGKubM3x7gxBhK/JkAb5Q=;
        b=LA6PGKbC2u0XYTZA5fMEgXYdPRzpPU5ANrDz7NSN8yEV6NQ6Ak5FpGji5yVv6LX71vjn3E
        gHyTK0L2Y6AlXDAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Flag errors in torture-compatible manner
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532811.7002.8682460645631428163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dbf83b655a7853bc430af10e9a3e7eb1f4c90f86
Gitweb:        https://git.kernel.org/tip/dbf83b655a7853bc430af10e9a3e7eb1f4c90f86
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Jul 2020 16:06:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:35 -07:00

scftorture: Flag errors in torture-compatible manner

This commit prints error counts on the statistics line and also adds a
"!!!" if any of the counters are non-zero.  Allocation failures are
(somewhat) forgiven, but all other errors result in a "FAILURE" print
at the end of the test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 8ab72e5..880c2ce 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -132,6 +132,7 @@ static atomic_t n_mb_in_errs;
 static atomic_t n_mb_out_errs;
 static atomic_t n_alloc_errs;
 static bool scfdone;
+static char *bangstr = "";
 
 DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
@@ -156,12 +157,17 @@ static void scf_torture_stats_print(void)
 		scfs.n_all += scf_stats_p[i].n_all;
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
-	pr_alert("%s scf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
-		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count,
+	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
+	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+		bangstr = "!!! ";
+	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
-	pr_cont("\n");
+	pr_cont("ste: %d stnmie: %d stnmoe: %d staf: %d\n", atomic_read(&n_errs),
+		atomic_read(&n_mb_in_errs), atomic_read(&n_mb_out_errs),
+		atomic_read(&n_alloc_errs));
 }
 
 // Periodically prints torture statistics, if periodic statistics printing
@@ -431,7 +437,7 @@ static void scf_torture_cleanup(void)
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
 	scf_stats_p = NULL;
 
-	if (atomic_read(&n_errs))
+	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) || atomic_read(&n_mb_out_errs))
 		scftorture_print_module_parms("End of test: FAILURE");
 	else if (torture_onoff_failures())
 		scftorture_print_module_parms("End of test: LOCK_HOTPLUG");
