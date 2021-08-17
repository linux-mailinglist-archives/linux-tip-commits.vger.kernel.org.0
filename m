Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3A3EF39F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhHQUQT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhHQUPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C738C0611DD;
        Tue, 17 Aug 2021 13:14:28 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kw21syDqpU5AKlwYR6qoVGrxCf94wnxtOLUbInyjq/A=;
        b=qfV2v0MUg1BPKJwvWtDOxvCxqPfcHfUYXCMQslusYCTrO9R7uh4zl1NQMlXS3gi3REcldN
        XrD3D5kLAKumoICAz/0iNfzVf4owZKYSigxiV09PVxWaAPw50ZZRrd45h7hcGR+4Buc2SH
        /bQFqEzKsVF+aSvMbWVp22CLTF/qICWmcBeyrPprQjGkP++mPUUi6hByYEyOWDnJgAvLkt
        e5akxGUTsszbyd+ym5eH8U/877QBh8qT/MZ/BizYTV7cAO10PaD66D8vW4aApCbcOrlkw+
        UUMSX8S0jqlybUXOw7MyMutQuAYWU4O3PqJ3yVtpb8tf3+45/j11F1Hofn5V0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kw21syDqpU5AKlwYR6qoVGrxCf94wnxtOLUbInyjq/A=;
        b=n9KdIkGP1bht+9RetUF+S2noMovJAdd1VCiBlGrGlH0FSAErB+fi2AEG+OlkkWnTsqFHy5
        gZc1bcSRyG33RFCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Provide rt_wake_q_head and helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.139337655@linutronix.de>
References: <20210815211303.139337655@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126636.25758.14472505296436534481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b576e640ce5e22673e12949cf14ae3cb18d9b859
Gitweb:        https://git.kernel.org/tip/b576e640ce5e22673e12949cf14ae3cb18d9b859
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:18:15 +02:00

locking/rtmutex: Provide rt_wake_q_head and helpers

To handle the difference between wakeups for regular sleeping locks (mutex,
rtmutex, rw_semaphore) and the wakeups for 'sleeping' spin/rwlocks on
PREEMPT_RT enabled kernels correctly, it is required to provide a
wake_q_head construct which allows to keep them separate.

Provide a wrapper around wake_q_head and the required helpers, which will be
extended with the state handling later.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.139337655@linutronix.de
---
 kernel/locking/rtmutex.c        | 15 +++++++++++++++
 kernel/locking/rtmutex_common.h | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c13b9b8..35f7685 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,6 +347,21 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 	rt_mutex_setprio(p, pi_task);
 }
 
+/* RT mutex specific wake_q wrappers */
+static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	wake_q_add(&wqh->head, w->task);
+}
+
+static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
+{
+	wake_up_q(&wqh->head);
+
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
+	preempt_enable();
+}
+
 /*
  * Deadlock detection is conditional:
  *
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index fcc55de..9e2f1db 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -39,6 +39,20 @@ struct rt_mutex_waiter {
 	u64			deadline;
 };
 
+/**
+ * rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *		    "sleeping" spinlocks on RT
+ * @head:	The regular wake_q_head for sleeping lock variants
+ */
+struct rt_wake_q_head {
+	struct wake_q_head	head;
+};
+
+#define DEFINE_RT_WAKE_Q(name)						\
+	struct rt_wake_q_head name = {					\
+		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+	}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
