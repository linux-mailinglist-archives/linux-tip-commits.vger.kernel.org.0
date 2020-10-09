Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8437E288286
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgJIGhi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbgJIGfd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41781C0613D6;
        Thu,  8 Oct 2020 23:35:33 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A+4ctZtLuQOlEI+pA+FucARFF/uSBELG4pHJXVZdXl4=;
        b=O5+7bZ1b4ZlYkXzADuW9luxxTxTKh+z/JDymPyxts6SDHpwQe+SYxr9ULJCBk7Rai5SBZB
        wEX1HKXTzpmj61SCAsL6A2kSs3mmIi1gH2Ws7r/kpftzuxOGkvHgcF1TtPagINRN8UMPK1
        ShbAYO+vuCpSTwvBXTpz/M69fta5x68n3WVESupyM/rowWpmEoi1/m5BqVUHIQQ7Lmb6zv
        dV+H6Si2hEYM8z5/1aDq+WPkUOoDQUyyz1MDmg7fiVoVRh2ec/Fjz0jPigGxgym2Il/3dq
        IMtGc5GrcXPGXwYlfqU9kTxG8/EuGJHUNlP+Je6GsTyO8F/IeZ035wjV2tm83Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A+4ctZtLuQOlEI+pA+FucARFF/uSBELG4pHJXVZdXl4=;
        b=kax36MGFaZoIeRgieI9tgOi9yb3K4+9nt2sJLcfLV3/U96hq5dihg9KOJZvD8ywHBdc2du
        xCtLNlBl5vIEIODw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Summarize per-thread statistics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533102.7002.11230901526584142414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dba3142b37f343734bf61dbce2914acb76e69fb6
Gitweb:        https://git.kernel.org/tip/dba3142b37f343734bf61dbce2914acb76e69fb6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Jun 2020 16:13:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:33 -07:00

scftorture: Summarize per-thread statistics

This commit summarizes the per-thread statistics, providing counts of
the number of single, many, and all calls, both no-wait and wait, and,
for the single case, the number where the target CPU was offline.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5f19845..09a6242 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -128,13 +128,27 @@ DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 static void scf_torture_stats_print(void)
 {
 	int cpu;
+	int i;
 	long long invoked_count = 0;
 	bool isdone = READ_ONCE(scfdone);
+	struct scf_statistics scfs = {};
 
 	for_each_possible_cpu(cpu)
 		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
-	pr_alert("%s scf_invoked_count %s: %lld ",
-		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count);
+	for (i = 0; i < nthreads; i++) {
+		scfs.n_single += scf_stats_p[i].n_single;
+		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
+		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
+		scfs.n_single_wait_ofl += scf_stats_p[i].n_single_wait_ofl;
+		scfs.n_many += scf_stats_p[i].n_many;
+		scfs.n_many_wait += scf_stats_p[i].n_many_wait;
+		scfs.n_all += scf_stats_p[i].n_all;
+		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
+	}
+	pr_alert("%s scf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count,
+		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
+		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
 	pr_cont("\n");
 }
@@ -357,11 +371,11 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	kfree(scf_stats_p);
-	scf_stats_p = NULL;
 	smp_call_function(scf_cleanup_handler, NULL, 0);
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
+	kfree(scf_stats_p);  // -After- the last stats print has completed!
+	scf_stats_p = NULL;
 
 	if (atomic_read(&n_errs))
 		scftorture_print_module_parms("End of test: FAILURE");
