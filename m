Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810DD41F075
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354997AbhJAPIJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354827AbhJAPHr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF8C0613EF;
        Fri,  1 Oct 2021 08:05:54 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMiFaOrHFdAHVk6/KSvbWti0t/N9hGP9astLlEVf6TE=;
        b=187XaQLqpumAVNOIol4C/L3A2R/XYibjz+fvoUDoE90H/oA26vNx2CKqZFFFFcME4/koyr
        gOx6vSvzMOiH8DYQVNnt/ibn7ia2Yi9sLIRmdvA/xgekFOG+2dFOwWnWTmjkp7+SobZKoe
        r9/pTwOYVFFSZ1zrdM/+vXgu/4UTzXzvtEOEBMuyyC45GJeds8rE/GsL8DJ9PR4aaFk3/s
        gzgdvU5fHmdVAM9H57gpIZkCqbPgIb93UgeWcTenuCwOKygfvkvhTqMbUzQ89cE5vEE2bD
        EyDG2R2gVbTNU3b7iKO+7Aq1V/TXzeKmBijEsHs7dSettaqCK4DUnFGlK4vW0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMiFaOrHFdAHVk6/KSvbWti0t/N9hGP9astLlEVf6TE=;
        b=IHFY8WxnKibpJIogE/ahlRZ1SVFIWDf0yJnj7JziHOb8ft8n6yKcb4a4PGvmI+sp/ZYgXB
        Sw8mVqe0CnGOUVAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move mmdrop to RCU on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928122411.648582026@linutronix.de>
References: <20210928122411.648582026@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310075215.25758.14922478291631583561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     df89544263cd98ffcef1318b3bf18509b9420c8a
Gitweb:        https://git.kernel.org/tip/df89544263cd98ffcef1318b3bf18509b9420c8a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:06 +02:00

sched: Move mmdrop to RCU on RT

mmdrop() is invoked from finish_task_switch() by the incoming task to drop
the mm which was handed over by the previous task. mmdrop() can be quite
expensive which prevents an incoming real-time task from getting useful
work done.

Provide mmdrop_sched() which maps to mmdrop() on !RT kernels. On RT kernels
it delagates the eventually required invocation of __mmdrop() to RCU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928122411.648582026@linutronix.de
---
 include/linux/mm_types.h |  4 ++++
 include/linux/sched/mm.h | 29 +++++++++++++++++++++++++++++
 kernel/sched/core.c      |  2 +-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8f0fb62..09a2885 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
+#include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
@@ -567,6 +568,9 @@ struct mm_struct {
 		bool tlb_flush_batched;
 #endif
 		struct uprobes_state uprobes_state;
+#ifdef CONFIG_PREEMPT_RT
+		struct rcu_head delayed_drop;
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe..0d81060 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,35 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
+ * by far the least expensive way to do that.
+ */
+static inline void __mmdrop_delayed(struct rcu_head *rhp)
+{
+	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
+
+	__mmdrop(mm);
+}
+
+/*
+ * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
+ * kernels via RCU.
+ */
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	/* Provides a full memory barrier. See mmdrop() */
+	if (atomic_dec_and_test(&mm->mm_count))
+		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
+}
+#else
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+#endif
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b36b5d7..bb70a07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4773,7 +4773,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		mmdrop_sched(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
