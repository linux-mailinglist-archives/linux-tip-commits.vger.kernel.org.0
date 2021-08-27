Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF593FA1E7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhH0XmE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 19:42:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhH0XmD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 19:42:03 -0400
Date:   Fri, 27 Aug 2021 23:41:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630107673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJtYy3+Ewjzd6KiUleN02lT/h8y1My8Bkx4g8HNxCt0=;
        b=jAGJv+QUqKknVrjTfBTClN5pQ61UfSivTREsgKJ6Y0qzU5h/pix8f1SipRTbVdLQp8xxuB
        CjTx1SZZ+wC8Mr12CfvYQbhMDAnA4yZfXer1dK2dCEVDkZTG3Q4esr4VAkEhcR/jqee/j3
        75E7EpYwv/X5cFoQm1JXMhr7xA7l20Qb8jGtH9vbSevttQY//X3a7Y4ZE1pJfHw/88ZPK+
        cv3EF4NWS3iZQOpxiP8yhuphOSiLV/wTR/iEIluzVYQUspV01oA8Jwv15Rrbn92FA5H0O7
        lS4fD/BqMx9GPBBQyAa36MNNrcuBEOJ0i9J+Z9RBP62uxhoL+7wqcEdI6vxKNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630107673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJtYy3+Ewjzd6KiUleN02lT/h8y1My8Bkx4g8HNxCt0=;
        b=R6H2THrrvIMOQd8GXiXXTzmmySzHmJm8v0usKEyNtxQZnUwwON42T5aTC+qgSHfzXOJO2J
        RaU4DsToCu115ECA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] eventfd: Make signal recursion protection a task bit
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87wnp9idso.ffs@tglx>
References: <87wnp9idso.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163010767256.25758.8600942642007356589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b542e383d8c005f06a131e2b40d5889b812f19c6
Gitweb:        https://git.kernel.org/tip/b542e383d8c005f06a131e2b40d5889b812f19c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 13:01:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Aug 2021 01:33:02 +02:00

eventfd: Make signal recursion protection a task bit

The recursion protection for eventfd_signal() is based on a per CPU
variable and relies on the !RT semantics of spin_lock_irqsave() for
protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
disables preemption nor interrupts which allows the spin lock held section
to be preempted. If the preempting task invokes eventfd_signal() as well,
then the recursion warning triggers.

Paolo suggested to protect the per CPU variable with a local lock, but
that's heavyweight and actually not necessary. The goal of this protection
is to prevent the task stack from overflowing, which can be achieved with a
per task recursion protection as well.

Replace the per CPU variable with a per task bit similar to other recursion
protection bits like task_struct::in_page_owner. This works on both !RT and
RT kernels and removes as a side effect the extra per CPU storage.

No functional change for !RT kernels.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/87wnp9idso.ffs@tglx

---
 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   |  4 ++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76ce0cc..51b08ab 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6d..3627dd7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,8 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -67,21 +65,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * Deadlock or stack overflow issues can happen if we recurse here
 	 * through waitqueue wakeup handlers. If the caller users potentially
 	 * nested waitqueues with custom wakeup handlers, then it should
-	 * check eventfd_signal_count() before calling this function. If
-	 * it returns true, the eventfd_signal() call should be deferred to a
+	 * check eventfd_signal_allowed() before calling this function. If
+	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(current->in_eventfd_signal))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524..305d5f1 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -43,11 +44,9 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
 
 #else /* CONFIG_EVENTFD */
@@ -78,9 +77,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
 
 static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3bb9fec..6421a9a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -864,6 +864,10 @@ struct task_struct {
 	/* Used by page_owner=on to detect recursion in page tracking. */
 	unsigned			in_page_owner:1;
 #endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
