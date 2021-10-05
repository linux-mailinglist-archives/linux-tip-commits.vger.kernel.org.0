Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C0422A55
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhJEON5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhJEONv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A88C06174E;
        Tue,  5 Oct 2021 07:12:00 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:11:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=891z1eCuGEXUzGBNPwzwCbvULzKlX5+unll3bgS9yWk=;
        b=VY6VdNPuPA4lubz8t3nHpNVZ4/GFziEGA5a3m4SOSx9wUqHzuHstyPCyS99/ixMDo1UJmF
        OwgKZUkaER8gM4UGZjByLmBA+HbV3AhfKj4g5eMXb/kk2FpBybl4+YyBZdiKXmkZmfiL/1
        ZAmlPNnEIRvJAkuJqZK9oMSqtW9crzNzwz5eHE8qtMIy0ITnTEywr0bSazSodI6VMksM9O
        ES1OfDe0qUcw9ZIMJ/ZgyI6wpX9ImFYhs6ltcxyeYzWvpHF+1yUtH6feEZz9CPoOeWzH57
        Uz1AP4nGOdygfZrDIHbrQqD5jreIxj8l27YWFrrPs8V2hB+POCR5mJs16u0YCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=891z1eCuGEXUzGBNPwzwCbvULzKlX5+unll3bgS9yWk=;
        b=MbCVWqUmqR0R8IHxEAx7IWNQtJQd9jn+Hugs29rWuEI7O8Gjwg1hWjBIJrF7pTSiVtc2cL
        nicqoYXgzNJp78DA==
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
Message-ID: <163344311880.25758.8139446036865843187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8d491de6edc27138806cae6e8eca455beb325b62
Gitweb:        https://git.kernel.org/tip/8d491de6edc27138806cae6e8eca455beb325b62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:09 +02:00

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
index 7f8ee09..e9672de 100644
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
@@ -572,6 +573,9 @@ struct mm_struct {
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
index 5561486..aca874d 100644
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
index 95f4e16..9eaeba6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4836,7 +4836,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		mmdrop_sched(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
