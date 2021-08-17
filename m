Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8969F3EF364
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhHQUP0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhHQUPA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:00 -0400
Date:   Tue, 17 Aug 2021 20:14:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NUuif5RgWM0Fq2SDGRAIQgAXDJ55RQkwKxFHNCBK2A=;
        b=luqKZxZbSQ1HTahdrpQRLr4Xfcj9ygc9VExKPchRGdF5vd0/JhJFgjtvOEMi3+7eUkzimC
        MAlhhzjZQ+3wExuj6TaCpyymOwAowHEzHAFDXFKGErN+MubyOR4iq/D0Fmm8ZSLA4pLQ/b
        y2wm9el9iPsXArz2NoKwhhEP3u1vXYGSu43RGadYgbfUAvEMlzueTjwZa8U+4faHWMZ+dk
        cWG3L4M/Fds4dWPL7UwJLmOSDf+j5PSLMVY/zxizmC2REXJaSk1F9yh3cADufn7jlVhcAF
        As8aYbVCaxwHiANiVLduD+uWA19oDlT7TJchD7vqRpbIi0HwVn/LNTlX5cizVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NUuif5RgWM0Fq2SDGRAIQgAXDJ55RQkwKxFHNCBK2A=;
        b=0JpXJ3iGdOCYACXGLSpdQspnLon05Sf7xNeHzrqQ90J4+oFpc/1zVqvXfBuiVRzQjKplUq
        H5wxiTuxen3jk3Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.253614678@linutronix.de>
References: <20210815211303.253614678@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126522.25758.9579870247472636074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     456cfbc65cd072f4f53936ee5a37eb1447a7d3ba
Gitweb:        https://git.kernel.org/tip/456cfbc65cd072f4f53936ee5a37eb1447a7d3ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:21:09 +02:00

locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks

Add an rtlock_task pointer to rt_mutex_wake_q, which allows to handle the RT
specific wakeup for spin/rwlock waiters. The pointer is just consuming 4/8
bytes on the stack so it is provided unconditionaly to avoid #ifdeffery all
over the place.

This cannot use a regular wake_q, because a task can have concurrent wakeups which
would make it miss either lock or the regular wakeups, depending on what gets
queued first, unless task struct gains a separate wake_q_node for this, which
would be overkill, because there can only be a single task which gets woken
up in the spin/rw_lock unlock path.

No functional change for non-RT enabled kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.253614678@linutronix.de
---
 kernel/locking/rtmutex.c        | 18 ++++++++++++++++--
 kernel/locking/rtmutex_common.h |  5 ++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5f0d072..8b0d38d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -351,12 +351,26 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	wake_q_add(&wqh->head, w->task);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(w->task);
+		wqh->rtlock_task = w->task;
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
 }
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
-	wake_up_q(&wqh->head);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
+		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
+		put_task_struct(wqh->rtlock_task);
+		wqh->rtlock_task = NULL;
+	}
+
+	if (!wake_q_empty(&wqh->head))
+		wake_up_q(&wqh->head);
 
 	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ff36316..424ee0f 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -42,15 +42,18 @@ struct rt_mutex_waiter {
 /**
  * rt_wake_q_head - Wrapper around regular wake_q_head to support
  *		    "sleeping" spinlocks on RT
- * @head:	The regular wake_q_head for sleeping lock variants
+ * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
 struct rt_wake_q_head {
 	struct wake_q_head	head;
+	struct task_struct	*rtlock_task;
 };
 
 #define DEFINE_RT_WAKE_Q(name)						\
 	struct rt_wake_q_head name = {					\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rtlock_task	= NULL,					\
 	}
 
 /*
