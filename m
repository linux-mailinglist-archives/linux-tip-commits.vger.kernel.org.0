Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349172AEB27
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKKIYp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKKIXU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:20 -0500
Date:   Wed, 11 Nov 2020 08:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXfHuhOYCb5jwzA4T+Zc+yOpZlJQDvjJsKRA/hObf38=;
        b=0DMwmd9Sdicv/sa4kjqPfIfdEsHdGVKi6hj4XXzRH7VDJBaMORolKOF2HH+xr+ri3hfgRG
        8DoGRn5yL6W+YE46HoSB25gkjDFMCg5uJXXoWHghjs0h5q1X8nSACDjqK2AX14fHRgohcf
        T3Wl+rdk3g15AMlOwb9dMAgGuSw1aGzW0my1uKsaPYZtj2RHVUueubIxgQ2TlJTWkLy9ie
        tUqx7fqwDlEkZKOffMdU6yx4rD9BVLQgdfoHFKi5V6OtvF5MRwSEhh394LnCyX6a2xTo1k
        mJupt/GICpuewrYCb0FO7DEpCSTDTWEp728bLMclmfBrK190NX8BdvZ1KV49vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXfHuhOYCb5jwzA4T+Zc+yOpZlJQDvjJsKRA/hObf38=;
        b=nXiDgtdCqPJ3mGMgGvpDTYdCuHxEyAMV/hvpL1nRs5dANwP5M64tX9MpZ2qdy8etLih6Cu
        yMDVkd+uxwaYINBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,rt: Use cpumask_any*_distribute()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.190759694@infradead.org>
References: <20201023102347.190759694@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299809.11244.7912844893337510708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     14e292f8d45380c519a83d9b0f37089a17eedcdf
Gitweb:        https://git.kernel.org/tip/14e292f8d45380c519a83d9b0f37089a17eedcdf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Oct 2020 15:54:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:00 +01:00

sched,rt: Use cpumask_any*_distribute()

Replace a bunch of cpumask_any*() instances with
cpumask_any*_distribute(), by injecting this little bit of random in
cpu selection, we reduce the chance two competing balance operations
working off the same lowest_mask pick the same CPU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.190759694@infradead.org
---
 include/linux/cpumask.h |  6 ++++++
 kernel/sched/deadline.c |  6 +++---
 kernel/sched/rt.c       |  6 +++---
 lib/cpumask.c           | 18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d..383684e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -199,6 +199,11 @@ static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
+int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e97c7c2..206a070 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2002,8 +2002,8 @@ static int find_later_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(later_mask,
+							      sched_domain_span(sd));
 			/*
 			 * Last chance: if a CPU being in both later_mask
 			 * and current sd span is valid, that becomes our
@@ -2025,7 +2025,7 @@ static int find_later_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 40a4663..2525a1b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
@@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(lowest_mask);
+	cpu = cpumask_any_distribute(lowest_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 85da6ab..3592402 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
+
+int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_distribute);
