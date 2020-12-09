Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1C2D3DCA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgLIInb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgLIInb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 03:43:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ABCC06179C;
        Wed,  9 Dec 2020 00:42:50 -0800 (PST)
Date:   Wed, 09 Dec 2020 08:42:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607503368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozSKBR9xOUgHCHoqksylYgx0bqtxO/ha2qx7fwm1OlY=;
        b=mozi1QkBHBKQC3ZY8SsLTd0djwLJCukzhXLrcBq1r8+lyQn0y9v6eYquHo7rliHdXkgEKZ
        OTgswTcpuGyqEPwZ2jhCTj32GUo/p/MMCIHoiJeDZDwUQBPs6QfoLi8/ri4fQDMr8LHWDr
        /zr3vM9f/wh/uIFY8d0Ib2Uaa31XuoRF7BZ7oitU5lEnY2shU0o1JhkE8IHBjxLI6hjU5p
        Op/dN1lcv3bJOPDVsrdkYlvWQgYp87fx9WR+QDJgEgeau8Ihe9MPHc4mYTwMFi+3VsOjZI
        urjp+FKMGCvv7WZH8A5jc/84Ee/BFb3w2NRG2CASmahZ9wI3w9+F4rQfa9CxTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607503368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozSKBR9xOUgHCHoqksylYgx0bqtxO/ha2qx7fwm1OlY=;
        b=tKEgRO42UUFqH4tixMXMMwsBNqFZ4pRTQ507mPdmMKJ6sOHrbGQ5NP/H7jTHmbz1xfupGs
        R5sLKi6OhkOkt2Aw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] membarrier: Execute SYNC_CORE on the calling thread
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <250ded637696d490c69bef1877148db86066881c.1607058304.git.luto@kernel.org>
References: <250ded637696d490c69bef1877148db86066881c.1607058304.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <160750336732.3364.15581613421921893916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e45cdc71d1fa5ac3a57b23acc31eb959e4f60135
Gitweb:        https://git.kernel.org/tip/e45cdc71d1fa5ac3a57b23acc31eb959e4f60135
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 03 Dec 2020 21:07:06 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Dec 2020 09:37:43 +01:00

membarrier: Execute SYNC_CORE on the calling thread

membarrier()'s MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is documented as
syncing the core on all sibling threads but not necessarily the calling
thread.  This behavior is fundamentally buggy and cannot be used safely.

Suppose a user program has two threads.  Thread A is on CPU 0 and thread B
is on CPU 1.  Thread A modifies some text and calls
membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).

Then thread B executes the modified code.  If, at any point after
membarrier() decides which CPUs to target, thread A could be preempted and
replaced by thread B on CPU 0.  This could even happen on exit from the
membarrier() syscall.  If this happens, thread B will end up running on CPU
0 without having synced.

In principle, this could be fixed by arranging for the scheduler to issue
sync_core_before_usermode() whenever switching between two threads in the
same mm if there is any possibility of a concurrent membarrier() call, but
this would have considerable overhead.  Instead, make membarrier() sync the
calling CPU as well.

As an optimization, this avoids an extra smp_mb() in the default
barrier-only mode and an extra rseq preempt on the caller.

Fixes: 70216e18e519 ("membarrier: Provide core serializing command, *_SYNC_CORE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/250ded637696d490c69bef1877148db86066881c.1607058304.git.luto@kernel.org

---
 kernel/sched/membarrier.c | 51 ++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 1c278df..9d8df34 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -194,7 +194,8 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			return -EPERM;
 	}
 
-	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1)
+	if (flags != MEMBARRIER_FLAG_SYNC_CORE &&
+	    (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1))
 		return 0;
 
 	/*
@@ -213,8 +214,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 
 		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
 			goto out;
-		if (cpu_id == raw_smp_processor_id())
-			goto out;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
 		if (!p || p->mm != mm) {
@@ -229,16 +228,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		for_each_online_cpu(cpu) {
 			struct task_struct *p;
 
-			/*
-			 * Skipping the current CPU is OK even through we can be
-			 * migrated at any point. The current CPU, at the point
-			 * where we read raw_smp_processor_id(), is ensured to
-			 * be in program order with respect to the caller
-			 * thread. Therefore, we can skip this CPU from the
-			 * iteration.
-			 */
-			if (cpu == raw_smp_processor_id())
-				continue;
 			p = rcu_dereference(cpu_rq(cpu)->curr);
 			if (p && p->mm == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
@@ -246,12 +235,38 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		rcu_read_unlock();
 	}
 
-	preempt_disable();
-	if (cpu_id >= 0)
+	if (cpu_id >= 0) {
+		/*
+		 * smp_call_function_single() will call ipi_func() if cpu_id
+		 * is the calling CPU.
+		 */
 		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
-	else
-		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
-	preempt_enable();
+	} else {
+		/*
+		 * For regular membarrier, we can save a few cycles by
+		 * skipping the current cpu -- we're about to do smp_mb()
+		 * below, and if we migrate to a different cpu, this cpu
+		 * and the new cpu will execute a full barrier in the
+		 * scheduler.
+		 *
+		 * For SYNC_CORE, we do need a barrier on the current cpu --
+		 * otherwise, if we are migrated and replaced by a different
+		 * task in the same mm just before, during, or after
+		 * membarrier, we will end up with some thread in the mm
+		 * running without a core sync.
+		 *
+		 * For RSEQ, don't rseq_preempt() the caller.  User code
+		 * is not supposed to issue syscalls at all from inside an
+		 * rseq critical section.
+		 */
+		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
+			preempt_disable();
+			smp_call_function_many(tmpmask, ipi_func, NULL, true);
+			preempt_enable();
+		} else {
+			on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+		}
+	}
 
 out:
 	if (cpu_id < 0)
