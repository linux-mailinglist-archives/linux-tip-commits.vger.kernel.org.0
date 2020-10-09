Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E342882C4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgJIGfO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJIGfM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:12 -0400
Date:   Fri, 09 Oct 2020 06:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OYZmGUpJPDLWKBfhpmsZPsdfNKm6eX5E1E9ch4BbjE4=;
        b=3Pg6pUt8+sy9jlvPwYmTWGbMUVpwA+dwGzmBjPrPNFj1hNvinPX7ng2nPfUj/J06Gb7ABi
        FRQebJdFUeOrnxXmZ4pFTqDZSCNlA7EFuT6oG5ugo9grhKj2uk6NmvT3NRQx0Vuhf/KsCL
        1aIINFys/TnEuL4ibqf0CAAp+2AJ/4efo6aUuS93RdcI5dGSElmmvx/WEc4oekpRUL/7im
        gGB+Yi23nXBTnRdx322fGd6xL5mQFhJTz8ekEA54U/UnhhJTP1kGFdaa1HR2BTU6dL6bYb
        yRlFWfKdn1t9E8uXdQWl8HZk2CTrBcBcIDv+3l+1JqAmauazPcX3LcPCdJbQtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OYZmGUpJPDLWKBfhpmsZPsdfNKm6eX5E1E9ch4BbjE4=;
        b=sbV7bjFrGhV9Tm7SOMzvhgv1PWtqXdsgEemYhwmU4Ec6hQCr5FbWWtq9u06hn1Y+GpDsmD
        MgluTjp3XGGm4XAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] smp: Add source and destination CPUs to __call_single_data
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222530879.7002.13788054790141860731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e48c15b796d412ede883bb2ef7779b2a142f7962
Gitweb:        https://git.kernel.org/tip/e48c15b796d412ede883bb2ef7779b2a142f7962
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 29 Jun 2020 17:21:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 04 Sep 2020 11:50:50 -07:00

smp: Add source and destination CPUs to __call_single_data

This commit adds a destination CPU to __call_single_data, and is inspired
by an earlier commit by Peter Zijlstra.  This version adds #ifdef to
permit use by 32-bit systems and supplying the destination CPU for all
smp_call_function*() requests, not just smp_call_function_single().

If need be, 32-bit systems could be accommodated by shrinking the flags
field to 16 bits (the atomic_t variant is currently unused) and by
providing only eight bits for CPU on such systems.

It is not clear that the addition of the fields to __call_single_node
are really needed.

[ paulmck: Apply Boqun Feng feedback on 32-bit builds. ]
Link: https://lore.kernel.org/lkml/20200615164048.GC2531@hirez.programming.kicks-ass.net/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/smp.h       | 3 +++
 include/linux/smp_types.h | 3 +++
 kernel/smp.c              | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 80d557e..9f13966 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -26,6 +26,9 @@ struct __call_single_data {
 		struct {
 			struct llist_node llist;
 			unsigned int flags;
+#ifdef CONFIG_64BIT
+			u16 src, dst;
+#endif
 		};
 	};
 	smp_call_func_t func;
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
index 364b3ae..2e8461a 100644
--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -61,6 +61,9 @@ struct __call_single_node {
 		unsigned int	u_flags;
 		atomic_t	a_flags;
 	};
+#ifdef CONFIG_64BIT
+	u16 src, dst;
+#endif
 };
 
 #endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index d0ae8eb..865a876 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -375,6 +375,9 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+#ifdef CONFIG_64BIT
+	csd->dst = cpu;
+#endif
 
 	err = generic_exec_single(cpu, csd);
 
@@ -540,6 +543,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+#ifdef CONFIG_64BIT
+		csd->dst = cpu;
+#endif
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
