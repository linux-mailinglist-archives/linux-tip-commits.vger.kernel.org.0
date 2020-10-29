Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECDC29E98C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgJ2Kvz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgJ2Kvy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:54 -0400
Date:   Thu, 29 Oct 2020 10:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnz1Smfi8Lt84DmNmzJfVdck9i5ltRDNZOy/7pXfNks=;
        b=GNTSNH9D+2diaeHnq4VubfLF4fz5qc/Hq7/vAU/vhLyjXgu3MPT6v/qopeejDQCaaiwOg9
        tC9HIodCDz1qK9im3C1nWou+g2nDYKn+KXKv/QX/6xkF4hzczA8+RS1nJZEMVW6txnpYMj
        tRqJV5pC/RnVwCx3mQVaRSfS6gt8yIran8NA/ye8hCtMQC0bEfvnfqRJnH/MSELq3tB3CJ
        +GThqUTOlLh2bXDb6m8LSCbqIopLcQhsgdLXgJMBayklpJeu7bnGFHM0P9TfQ+SFS+v5sy
        J2rF12QMpTel+yD2Nbuja5+ORJyh9qydGC/3TQ6TsS3Sp/XYtAepOjy8XtYhpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnz1Smfi8Lt84DmNmzJfVdck9i5ltRDNZOy/7pXfNks=;
        b=JdF5e5oHNI8smpkO+nfV708Jc5xRsN2QggUfiOsmj0D/D7znFPt8T88lYziLOOL+NLwW58
        DzJFl0MuYSD+J8Dg==
From:   "tip-bot2 for Peng Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix sched_dl_global_validate()
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <db6bbda316048cda7a1bbc9571defde193a8d67e.1602171061.git.iwtbavbm@gmail.com>
References: <db6bbda316048cda7a1bbc9571defde193a8d67e.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Message-ID: <160396871126.397.6829344906733895755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a57415f5d1e43c3a5c5d412cd85e2792d7ed9b11
Gitweb:        https://git.kernel.org/tip/a57415f5d1e43c3a5c5d412cd85e2792d7ed9b11
Author:        Peng Liu <iwtbavbm@gmail.com>
AuthorDate:    Thu, 08 Oct 2020 23:49:42 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:29 +01:00

sched/deadline: Fix sched_dl_global_validate()

When change sched_rt_{runtime, period}_us, we validate that the new
settings should at least accommodate the currently allocated -dl
bandwidth:

  sched_rt_handler()
    -->	sched_dl_bandwidth_validate()
	{
		new_bw = global_rt_runtime()/global_rt_period();

		for_each_possible_cpu(cpu) {
			dl_b = dl_bw_of(cpu);
			if (new_bw < dl_b->total_bw)    <-------
				ret = -EBUSY;
		}
	}

But under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
dl_b->total_bw is the allocated bandwidth of the whole root domain.
Instead, we should compare dl_b->total_bw against "cpus*new_bw",
where 'cpus' is the number of CPUs of the root domain.

Also, below annotation(in kernel/sched/sched.h) implied implementation
only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
evolving till got merged(v9), but the annotation remains unchanged,
meaningless and misleading, update it.

* With respect to SMP, the bandwidth is given on a per-CPU basis,
* meaning that:
*  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
*  - dl_total_bw array contains, in the i-eth element, the currently
*    allocated bandwidth on the i-eth CPU.

[1]: https://lore.kernel.org/lkml/1267385230.13676.101.camel@Palantir/

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/db6bbda316048cda7a1bbc9571defde193a8d67e.1602171061.git.iwtbavbm@gmail.com
---
 kernel/sched/deadline.c |  5 +++--
 kernel/sched/sched.h    | 42 +++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 98d96d4..0f75e95 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2561,7 +2561,7 @@ int sched_dl_global_validate(void)
 	u64 new_bw = to_ratio(period, runtime);
 	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	unsigned long flags;
 
 	/*
@@ -2576,9 +2576,10 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 49a2dae..965b296 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -257,30 +257,6 @@ struct rt_bandwidth {
 
 void __dl_clear_params(struct task_struct *p);
 
-/*
- * To keep the bandwidth of -deadline tasks and groups under control
- * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
- *  - cache the fraction of that bandwidth that is currently allocated.
- *
- * This is all done in the data structure below. It is similar to the
- * one used for RT-throttling (rt_bandwidth), with the main difference
- * that, since here we are only interested in admission control, we
- * do not decrease any runtime while the group "executes", neither we
- * need a timer to replenish it.
- *
- * With respect to SMP, the bandwidth is given on a per-CPU basis,
- * meaning that:
- *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
- *  - dl_total_bw array contains, in the i-eth element, the currently
- *    allocated bandwidth on the i-eth CPU.
- * Moreover, groups consume bandwidth on each CPU, while tasks only
- * consume bandwidth on the CPU they're running on.
- * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
- * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
- * control.
- */
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
 	u64			dl_runtime;
@@ -292,6 +268,24 @@ static inline int dl_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
+/*
+ * To keep the bandwidth of -deadline tasks under control
+ * we need some place where:
+ *  - store the maximum -deadline bandwidth of each cpu;
+ *  - cache the fraction of bandwidth that is currently allocated in
+ *    each root domain;
+ *
+ * This is all done in the data structure below. It is similar to the
+ * one used for RT-throttling (rt_bandwidth), with the main difference
+ * that, since here we are only interested in admission control, we
+ * do not decrease any runtime while the group "executes", neither we
+ * need a timer to replenish it.
+ *
+ * With respect to SMP, bandwidth is given on a per root domain basis,
+ * meaning that:
+ *  - bw (< 100%) is the deadline bandwidth of each CPU;
+ *  - total_bw is the currently allocated bandwidth in each root domain;
+ */
 struct dl_bw {
 	raw_spinlock_t		lock;
 	u64			bw;
