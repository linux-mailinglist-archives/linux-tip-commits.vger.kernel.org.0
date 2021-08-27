Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BD3F9900
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Aug 2021 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhH0McR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245079AbhH0McQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 08:32:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC744C0613CF;
        Fri, 27 Aug 2021 05:31:26 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630067483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37paN2TEJ2LrDTxJnP8R+26sGa5kq0sS/mr6xEQdRXI=;
        b=OQxFv7JXzjeT2tuliXb2ySC+5O8DqDV09rYJg4MyK21KMYpTG7szr3l4lyiuLmaM+CSti/
        AkqIw6H4F/nd7MzsAWQ1vugr++pTBgo8V9kUCpwXrUsEBUss7udXxGZ5Y/8svmFg0nMxP7
        mk//+LoqcNmvrMTspIPDmRzMoNdsjaY1Yl863pMZMoDWmRo45/AOut1yM0Eqprc0VWmjH4
        O4glJOXbdFQdmNxz7FnpMD7g2wogSj0ICcWa5t0e/UneFZN+4KYXL8CPeMd+N9jXOOTj4p
        u21E9V5SdVZ1+DCwUxJXl0PphcS+IZ35AgPTc11xVYGfozJP48Q3ra+5KYoqKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630067483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37paN2TEJ2LrDTxJnP8R+26sGa5kq0sS/mr6xEQdRXI=;
        b=TtHJR3gQFG52ZO3YdPy5950N3VczYHjOKXPCyYUC1jsQodzpbPe9IF1OmDUHYdGfAxPuEX
        DuLN7hxFEm3UHGAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Prevent spurious EDEADLK return
 caused by ww_mutexes
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
References: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163006748269.25758.13180531445179577224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6467822b8cc96e5feda98c7bf5c6329c6a896c91
Gitweb:        https://git.kernel.org/tip/6467822b8cc96e5feda98c7bf5c6329c6a896c91
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Aug 2021 09:36:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Aug 2021 14:28:49 +02:00

locking/rtmutex: Prevent spurious EDEADLK return caused by ww_mutexes

rtmutex based ww_mutexes can legitimately create a cycle in the lock graph
which can be observed by a blocker which didn't cause the problem:

   P1: A, ww_A, ww_B
   P2: ww_B, ww_A
   P3: A

P3 might therefore be trapped in the ww_mutex induced cycle and run into
the lock depth limitation of rt_mutex_adjust_prio_chain() which returns
-EDEADLK to the caller.

Disable the deadlock detection walk when the chain walk observes a
ww_mutex to prevent this looping.

[ tglx: Split it apart and added changelog ]

Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Fixes: add461325ec5 ("locking/rtmutex: Extend the rtmutex core to support ww_mutex")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net
---
 kernel/locking/rtmutex.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c8fe74e..3c1ba7b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -657,6 +657,31 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		goto out_unlock_pi;
 
 	/*
+	 * There could be 'spurious' loops in the lock graph due to ww_mutex,
+	 * consider:
+	 *
+	 *   P1: A, ww_A, ww_B
+	 *   P2: ww_B, ww_A
+	 *   P3: A
+	 *
+	 * P3 should not return -EDEADLK because it gets trapped in the cycle
+	 * created by P1 and P2 (which will resolve -- and runs into
+	 * max_lock_depth above). Therefore disable detect_deadlock such that
+	 * the below termination condition can trigger once all relevant tasks
+	 * are boosted.
+	 *
+	 * Even when we start with ww_mutex we can disable deadlock detection,
+	 * since we would supress a ww_mutex induced deadlock at [6] anyway.
+	 * Supressing it here however is not sufficient since we might still
+	 * hit [6] due to adjustment driven iteration.
+	 *
+	 * NOTE: if someone were to create a deadlock between 2 ww_classes we'd
+	 * utterly fail to report it; lockdep should.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && waiter->ww_ctx && detect_deadlock)
+		detect_deadlock = false;
+
+	/*
 	 * Drop out, when the task has no waiters. Note,
 	 * top_waiter can be NULL, when we are in the deboosting
 	 * mode!
