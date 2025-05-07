Return-Path: <linux-tip-commits+bounces-5406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA5AADB05
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB48116E3D2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD224DFFD;
	Wed,  7 May 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLv7fVJW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ap0ZFFUi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7682459F9;
	Wed,  7 May 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608868; cv=none; b=uWYKXMRITOsgyg0jeAmHky8ZT2rmz13NgkJMutF93Ib3LDU+Ap4ixmDAdurIMeHtJ+NOmUH3UvgqDBQ3y94prmWflDZIDXN7ynKFisIkZmd4Qd9w2nimEukK3PmBzOQC/ugDDklsgrLVNK/QVUt9sJGA16FPy3T/D3wcIzHHFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608868; c=relaxed/simple;
	bh=bsm4GI86bpQMsHymuXJIho6gVHcq9N+Zx0rHXWT6OSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FEkk4kK+mbY2dhsKw5nefVpb83BBDZsIdek9vWWebxagKAUWmGgkq7G44ztd7iKOwmUrUNqpVZWivfNGkXQY5lWDPsOdDAY/EzlQFY0pBNPauvFrTA+G2dL25doHx/kur0rLvBFO0NPkengnylpLXVGOa3jWgypen3CX/FXHcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLv7fVJW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ap0ZFFUi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEoqK7gsm+yEx8+qy1TFYsDrWz5/hZYHE0awsVR/NZw=;
	b=NLv7fVJWTRtgZyxbzNF3Zoj5nuxQZbGiW5np877NTPNpYocJLIhxvP0p+h0zD1mI68qs0T
	gmVCxvKUM/fCiTjZCSbZyu9GXxsMVwp98dXhS/3d4PT6pSRitTpO4TggGlOO5Dw1dDdYxm
	iHf7no9z9lUMZn6uPYf+8/4ve1u5kzjdROxq+Tg8jlIex1psZBFpJFEU0zU+FrtOcgfKuo
	zGsFTO5eWvrmwmMKAH5J7iPb7ypsRAHCy/dopg6Ft8hG5I/H25KUdcn0/JeLIaNI168cbY
	paiqdET/XmHJ3oHLulFxTKWpl1yRaFqiEEgblToSgMSXglW4BlNRnBt9BVOKtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEoqK7gsm+yEx8+qy1TFYsDrWz5/hZYHE0awsVR/NZw=;
	b=Ap0ZFFUi2ISHVYWmhaHOMdsyvm4LaxoFcd6C52USeGWDlvzSrsiwtHDBQ5+NPP2u1kE1pZ
	hibMyy6wOXcyPUDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/spurious: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.497714413@linutronix.de>
References: <20250429065420.497714413@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886372.406.1218960819930774070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     113332a865530c8ab89d8292e59293b6c9301f96
Gitweb:        https://git.kernel.org/tip/113332a865530c8ab89d8292e59293b6c9301f96
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/spurious: Switch to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.497714413@linutronix.de


---
 kernel/irq/spurious.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 296cb48..8f26982 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -60,37 +60,35 @@ bool irq_wait_for_poll(struct irq_desc *desc)
 /*
  * Recovery handler for misrouted interrupts.
  */
-static int try_one_irq(struct irq_desc *desc, bool force)
+static bool try_one_irq(struct irq_desc *desc, bool force)
 {
-	irqreturn_t ret = IRQ_NONE;
 	struct irqaction *action;
+	bool ret = false;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
 	/*
 	 * PER_CPU, nested thread interrupts and interrupts explicitly
 	 * marked polled are excluded from polling.
 	 */
-	if (irq_settings_is_per_cpu(desc) ||
-	    irq_settings_is_nested_thread(desc) ||
+	if (irq_settings_is_per_cpu(desc) || irq_settings_is_nested_thread(desc) ||
 	    irq_settings_is_polled(desc))
-		goto out;
+		return false;
 
 	/*
 	 * Do not poll disabled interrupts unless the spurious
 	 * disabled poller asks explicitly.
 	 */
 	if (irqd_irq_disabled(&desc->irq_data) && !force)
-		goto out;
+		return false;
 
 	/*
 	 * All handlers must agree on IRQF_SHARED, so we test just the
 	 * first.
 	 */
 	action = desc->action;
-	if (!action || !(action->flags & IRQF_SHARED) ||
-	    (action->flags & __IRQF_TIMER))
-		goto out;
+	if (!action || !(action->flags & IRQF_SHARED) || (action->flags & __IRQF_TIMER))
+		return false;
 
 	/* Already running on another processor */
 	if (irqd_irq_inprogress(&desc->irq_data)) {
@@ -99,21 +97,19 @@ static int try_one_irq(struct irq_desc *desc, bool force)
 		 * CPU to go looking for our mystery interrupt too
 		 */
 		desc->istate |= IRQS_PENDING;
-		goto out;
+		return false;
 	}
 
 	/* Mark it poll in progress */
 	desc->istate |= IRQS_POLL_INPROGRESS;
 	do {
 		if (handle_irq_event(desc) == IRQ_HANDLED)
-			ret = IRQ_HANDLED;
+			ret = true;
 		/* Make sure that there is still a valid action */
 		action = desc->action;
 	} while ((desc->istate & IRQS_PENDING) && action);
 	desc->istate &= ~IRQS_POLL_INPROGRESS;
-out:
-	raw_spin_unlock(&desc->lock);
-	return ret == IRQ_HANDLED;
+	return ret;
 }
 
 static int misrouted_irq(int irq)
@@ -192,7 +188,6 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct irqaction *action;
-	unsigned long flags;
 
 	if (bad_action_ret(action_ret))
 		pr_err("irq event %d: bogus return value %x\n", irq, action_ret);
@@ -207,14 +202,13 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 	 * with something else removing an action. It's ok to take
 	 * desc->lock here. See synchronize_irq().
 	 */
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irqsave)(&desc->lock);
 	for_each_action_of_desc(desc, action) {
 		pr_err("[<%p>] %ps", action->handler, action->handler);
 		if (action->thread_fn)
 			pr_cont(" threaded [<%p>] %ps", action->thread_fn, action->thread_fn);
 		pr_cont("\n");
 	}
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
 static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)

