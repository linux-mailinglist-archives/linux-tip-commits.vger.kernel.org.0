Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA63EF333
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhHQUOi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhHQUOg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:36 -0400
Date:   Tue, 17 Aug 2021 20:14:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XA43O9toVvYtitZu3LqWeulK8MV18aT4ASHogFvYRzs=;
        b=m94iBgUiScbEvq1wZKBC1nuEkgM+oK/jEtEcuga1CHyeCv0odoYN0REm/7s42lkocHeeOV
        AzVW/CZgvaPffrV5iDdMa9TCTghadNa6MsLYGp9z7VHroHXxewxepxprq/4gfnEqC3RbSp
        rS2AFOiZbKqCDhEwyThgH9nNiVCd2m6ZBNAiPQaGxateSWmJ3J8SovX7BLlc7dVBpeuz2h
        XCEa3JsHKt78tKHkGRUlSqgkS3ethM5mWVb+BCsiw7H8EoITlGrqIIOprZvGgydG6HIM9I
        jxf4RF9CxunGMbY8NaOy3QyDriIhnV252NOHprBjpb2KnBaPbxeybeKDR+oXgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XA43O9toVvYtitZu3LqWeulK8MV18aT4ASHogFvYRzs=;
        b=z8VjUgtb9u+N++HbgQNOXeCgNDavHYtfLWBJZj4Y2xT/EMISFNGaR7bvZPDCV4+N4Ojq9J
        c+M7+TqqZBRLQ/BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Clarify comment in futex_requeue()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.524990421@linutronix.de>
References: <20210815211305.524990421@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124169.25758.1969214332883331976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c18eaa3aca43688a3aee199d85ce4227686a29b6
Gitweb:        https://git.kernel.org/tip/c18eaa3aca43688a3aee199d85ce4227686a29b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:51 +02:00

futex: Clarify comment in futex_requeue()

The comment about the restriction of the number of waiters to wake for the
REQUEUE_PI case is confusing at best. Rewrite it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.524990421@linutronix.de
---
 kernel/futex.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 6cb6b5d..8d8bad5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1939,15 +1939,27 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 */
 		if (refill_pi_state_cache())
 			return -ENOMEM;
+
 		/*
-		 * requeue_pi must wake as many tasks as it can, up to nr_wake
-		 * + nr_requeue, since it acquires the rt_mutex prior to
-		 * returning to userspace, so as to not leave the rt_mutex with
-		 * waiters and no owner.  However, second and third wake-ups
-		 * cannot be predicted as they involve race conditions with the
-		 * first wake and a fault while looking up the pi_state.  Both
-		 * pthread_cond_signal() and pthread_cond_broadcast() should
-		 * use nr_wake=1.
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI, waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex, because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one, and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=1.
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;
