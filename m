Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E22B3A68
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgKOWvO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgKOWvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F01C0613CF;
        Sun, 15 Nov 2020 14:51:09 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAbwv5pO+FdE7FetcQeB791mwyK29Xn4hTU9E4SYKpU=;
        b=4tsaFaZwBABA8wVFdhlQ/VLoYJiGlVDZjzLHYy5loJ0n3eZRL5RVTVZuUV1XPGPDBhgmEu
        uKupmMmFiT5gIRnini4MbFjNwVn2Q2pHXpra/kxBFr8xkjzANbZZFuv5xcVxauPRiBxOil
        cBoGNhKdEGnY8RZik8dnHHkiWqn+ToHnKyQ/diM0aGDVjnn4o0kwgvk8y0xUREiXUntmqm
        eiWpV46CRiRXiSirEi+zrmYNZjZjvcTH+X+qGpBP/CCqnCRjO9wM5HP/gNMntKo3i4Ldu0
        MWjLy/ADLF4ZKKZHtYHdYfF9KfrIW99BMjprCGyfja9w7X41msjZczi0crqM/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAbwv5pO+FdE7FetcQeB791mwyK29Xn4hTU9E4SYKpU=;
        b=EH5xDXD3ZRMlhK9O6YE3mbNGm+f4ddZDWErEnviMMFM7DUBBLcEzFCCCeRTcjHzQuYSsY6
        Yc19EN5dfx4M9wCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Don't block on ->expiry_lock for
 TIMER_IRQSAFE timers
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201103190937.hga67rqhvknki3tp@linutronix.de>
References: <20201103190937.hga67rqhvknki3tp@linutronix.de>
MIME-Version: 1.0
Message-ID: <160548066747.11244.15660821900299207801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c725dafc95f1b37027840aaeaa8b7e4e9cd20516
Gitweb:        https://git.kernel.org/tip/c725dafc95f1b37027840aaeaa8b7e4e9cd20516
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 20:09:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 20:59:26 +01:00

timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a livelock in
the case that the task waiting for the callback completion preempted the
callback.

This cannot be done for timers flagged with TIMER_IRQSAFE. These timers can
be canceled from an interrupt disabled context even on RT kernels.

The expiry callback of such timers is invoked with interrupts disabled so
there is no need to use the expiry lock mechanism because obviously the
callback cannot be preempted even on RT kernels.

Do not use the timer_base::expiry_lock mechanism when waiting for a running
callback to complete if the timer is flagged with TIMER_IRQSAFE.

Also add a lockdep assertion for RT kernels to validate that the expiry
lock mechanism is always invoked in preemptible context.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.de

---
 kernel/time/timer.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index de37e33..af9ddfb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1288,7 +1288,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1372,6 +1372,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
