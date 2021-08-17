Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40E23EF341
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhHQUOs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbhHQUOl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:41 -0400
Date:   Tue, 17 Aug 2021 20:14:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4XuWfwq3aY2+PcfQFqhC06y7qE13a/4Jpv2OR8Z8ac=;
        b=MUhwg+KDyyx42QZ2PlJkI8FixkXtaiUqXYFYu3G0cup4HfBCe+vXCoGqKC7/cnh2WMFCPe
        Q7Zqw0uj2DDQ8cz83DbxqyQ/rbl81Zti1GzFpjTMTK0muiLCPTHcpfkfueqVte1KBJ4GoD
        dAkTNbsThGbs4zoaG8itsxmQ2k9fDa3nxLwsAjcjYl6rzTiptZ2xFITJEadqQSWm4PIa13
        J75UCWk+B4osppa0ne47MrKrmuYE6qTD6FOR/Srms7jlX9Hd6BtfBvWarWmzm38MhcPq/Q
        Cz5VsDVPPtTrPWtXlTaF9qrJun2UPo/3ntC6T+Do8+lUca0ZOF21lLeeY7yt2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4XuWfwq3aY2+PcfQFqhC06y7qE13a/4Jpv2OR8Z8ac=;
        b=YvtgHraerniJZN/6w6AT4zVV1zRB2EoRCEWQiycP8bjU6WC9X/yVvFkj49gRqrNcv+5HVj
        ySAG3NhQAKcvvDDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Implement rtmutex based
 ww_mutex API functions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.024057938@linutronix.de>
References: <20210815211305.024057938@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124680.25758.1330980792522542380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f8635d509d807c0a9deb273e19bc5a8a19c52895
Gitweb:        https://git.kernel.org/tip/f8635d509d807c0a9deb273e19bc5a8a19c52895
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:29:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:26 +02:00

locking/ww_mutex: Implement rtmutex based ww_mutex API functions

Add the actual ww_mutex API functions which replace the mutex based variant
on RT enabled kernels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.024057938@linutronix.de
---
 kernel/locking/Makefile      |  2 +-
 kernel/locking/ww_rt_mutex.c | 76 +++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 kernel/locking/ww_rt_mutex.c

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 683f0b7..d51cabf 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
-obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o
+obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o ww_rt_mutex.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
new file mode 100644
index 0000000..3f1fff7
--- /dev/null
+++ b/kernel/locking/ww_rt_mutex.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtmutex API
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_MUTEX
+#define WW_RT
+#include "rtmutex.c"
+
+static int __sched
+__ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
+		   unsigned int state, unsigned long ip)
+{
+	struct lockdep_map __maybe_unused *nest_lock = NULL;
+	struct rt_mutex *rtm = &lock->base;
+	int ret;
+
+	might_sleep();
+
+	if (ww_ctx) {
+		if (unlikely(ww_ctx == READ_ONCE(lock->ctx)))
+			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a kill. No other process can
+		 * race and wound us here, since they can't have a valid owner
+		 * pointer if we don't have any locks held.
+		 */
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
+	}
+	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
+
+	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+		if (ww_ctx)
+			ww_mutex_set_context_fastpath(lock, ww_ctx);
+		return 0;
+	}
+
+	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
+
+	if (ret)
+		mutex_release(&rtm->dep_map, ip);
+	return ret;
+}
+
+int __sched
+ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock);
+
+int __sched
+ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_INTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock_interruptible);
+
+void __sched ww_mutex_unlock(struct ww_mutex *lock)
+{
+	struct rt_mutex *rtm = &lock->base;
+
+	__ww_mutex_unlock(lock);
+
+	mutex_release(&rtm->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&rtm->rtmutex);
+}
+EXPORT_SYMBOL(ww_mutex_unlock);
