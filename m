Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D831BB83
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBOO4b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBOO4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:24 -0500
Date:   Mon, 15 Feb 2021 14:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AEdFZ0ti8Ph8B9svluMFci38S8I1VvETZ02fAH9spRc=;
        b=L7QsO0c0y0zqmjnnak0eaOm6C+8H8Mj9u5Uvz9g1gkfZ8lSqjENZ29NkwGApitRYxzrNdL
        ka4GZOJEkwe6569J7fvEbdT4Z5JcofEH+Q36Y9z6OpixRBvgp4pgPKv/Ve4DMgKP/lUCtE
        Cqm0ugWVlQ2VjYbWJpJPkSXfrBA58PkXL3IuuoBzcFeKStR+oP7PmxrTfmsIVf1L1x3Tvm
        L4qq3M3WFHuqOpwW7Cxg1CPfVQWdvwgmb4xcdLN6eaeN+DfYGMzyEdANvXwTYG7gYog5jy
        9f/4HHpaEoBHxv++KMy0pCcfy6dQ12FBsDSbJQMkAT9PGIxeutTphPFIlDFf5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AEdFZ0ti8Ph8B9svluMFci38S8I1VvETZ02fAH9spRc=;
        b=CoUttwNOItlJYmGHAs2ZQjc9zGM3cZomeVDIV9le/ViJIxtncHBMurCsyD6MmJ7zeDqOrU
        QMF01Ou3RI0PWoAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: For RCU grace-period kthread starvation, dump
 last CPU it ran on
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094205.20312.18111886240559745511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     243027a3c80564bf96e40437ffac46efb9f5f2b5
Gitweb:        https://git.kernel.org/tip/243027a3c80564bf96e40437ffac46efb9f5f2b5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Nov 2020 16:08:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:59:41 -08:00

rcu: For RCU grace-period kthread starvation, dump last CPU it ran on

When the RCU CPU stall-warning code detects that the RCU grace-period
kthread is being starved, it dumps that kthread's stack.  This can
sometimes be useful, but it is also useful to know what is running on the
CPU that this kthread is attempting to run on.  This commit therefore
adds a stack trace of this CPU in order to help track down whatever it
is that might be preventing RCU's grace-period kthread from running.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c5..35c1355 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -449,20 +449,27 @@ static void print_cpu_stall_info(int cpu)
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
+	int cpu;
 	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
 
 	if (rcu_is_gp_kthread_starving(&j)) {
+		cpu = gpk ? task_cpu(gpk) : -1;
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		       gpk ? gpk->state : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
+			if (cpu >= 0) {
+				pr_err("Stack dump where RCU grace-period kthread last ran:\n");
+				if (!trigger_single_cpu_backtrace(cpu))
+					dump_cpu_task(cpu);
+			}
 			wake_up_process(gpk);
 		}
 	}
