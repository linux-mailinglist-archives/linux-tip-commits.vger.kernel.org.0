Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7D3F4772
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhHWJ1L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhHWJ1J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:09 -0400
Date:   Mon, 23 Aug 2021 09:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+4lxUsAuteV08ZJ0b4ldjv7PpetS37XL4TkF+yKsw0=;
        b=YLHJSQY+ynXEQuy/ZYodOlXfUD8mMdI/XAA/DX9sQqw010XFUCE6TFG793Qty8MoL45mum
        a1aDB4rgylQlVhX46sOlKI/+eFg38XK4WKbpeRqKhfmDA1ga/7bjcvawJ+dYdADfZMEzzk
        C7hg3Cyi0M4ke+uD1rwJawldja1Zlp3eKVjmNWAJMRA8OJ8kkM4BJTahNjPbqB+mvdWc/Q
        exWXzi8ISp1cDefNBsdsEk7zLYNYkXofrVCOHXhvUcqZCwPXlNeWkMCfql7EAYajz+on4b
        ecsC/Hktj0XoJ9gMKXpylY/Q1J/vIWdN9MIc6WHkXOy96EGx8lB/RnlSdCX2Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+4lxUsAuteV08ZJ0b4ldjv7PpetS37XL4TkF+yKsw0=;
        b=MUims1xPhl/dXTW8ziEz3Mdyod0clP5wJzjUlGDFpyUJpRWGs4y4ASMcRttoXVd+tAs+dy
        OjxmXkf4uPb6HIAg==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce task_cpu_possible_mask() to limit
 fallback rq selection
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Quentin Perret <qperret@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-2-will@kernel.org>
References: <20210730112443.23245-2-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078589.25758.8977089326499284001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ae606bc74dd0e58d4de894e3c5cbb9d45599267
Gitweb:        https://git.kernel.org/tip/9ae606bc74dd0e58d4de894e3c5cbb9d45599267
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:58 +02:00

sched: Introduce task_cpu_possible_mask() to limit fallback rq selection

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

On such a system, we must take care not to migrate a task to an
unsupported CPU when forcefully moving tasks in select_fallback_rq()
in response to a CPU hot-unplug operation.

Introduce a task_cpu_possible_mask() hook which, given a task argument,
allows an architecture to return a cpumask of CPUs that are capable of
executing that task. The default implementation returns the
cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
limitations that affect scheduling. The new mask is used when selecting
the fallback runqueue as a last resort before forcing a migration to the
first active CPU.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lore.kernel.org/r/20210730112443.23245-2-will@kernel.org
---
 include/linux/mmu_context.h | 14 ++++++++++++++
 kernel/sched/core.c         |  9 +++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 03dee12..b9b970f 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -14,4 +14,18 @@
 static inline void leave_mm(int cpu) { }
 #endif
 
+/*
+ * CPUs that are capable of running user task @p. Must contain at least one
+ * active CPU. It is assumed that the kernel can run on all CPUs, so calling
+ * this for a kernel thread is pointless.
+ *
+ * By default, we assume a sane, homogeneous system.
+ */
+#ifndef task_cpu_possible_mask
+# define task_cpu_possible_mask(p)	cpu_possible_mask
+# define task_cpu_possible(cpu, p)	true
+#else
+# define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7fa6ce7..6f31267 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2173,7 +2173,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu);
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -3124,9 +3124,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 
 		/* Look for allowed, online CPU in same node. */
 		for_each_cpu(dest_cpu, nodemask) {
-			if (!cpu_active(dest_cpu))
-				continue;
-			if (cpumask_test_cpu(dest_cpu, p->cpus_ptr))
+			if (is_cpu_allowed(p, dest_cpu))
 				return dest_cpu;
 		}
 	}
@@ -3156,10 +3154,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			 *
 			 * More yuck to audit.
 			 */
-			do_set_cpus_allowed(p, cpu_possible_mask);
+			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
 			state = fail;
 			break;
-
 		case fail:
 			BUG();
 			break;
