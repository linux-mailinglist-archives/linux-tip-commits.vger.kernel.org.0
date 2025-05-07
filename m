Return-Path: <linux-tip-commits+bounces-5395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DFAADAEE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D901C04DE1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606DA24168D;
	Wed,  7 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/Hirsr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeqZEmdC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4423E338;
	Wed,  7 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608861; cv=none; b=Oov/NmBYMsbM2rTxnuJnOMfNDECm2E/lHL3I1pkyIY/gZEkj384EJiOvsXolubBGlSQc4zksXqLythzCaiicHUP/bXDZDqnCWHSB5iD1AWMmTn0wcabw6rUojP4CG8RMWobdYO2kph978R+z36tZn6GSCqhfrY3JUhEfcYkHB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608861; c=relaxed/simple;
	bh=GuWufa8eoe3EiIBaAIGQtrwL7ybZK/GBm3yXaCue0MI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RR/JtebkRP98klAEZ3B5eNaxYpnjVJ70sqVEG/Z8MIk318faUUypnYBN3q2FtyI4yd4/gnx11WP+7gsu0Hv4nr2gEVBwAzX3gv+tGNMtZBxsPxk4SZ5S5OsQRh1uwwqsnDKhHFKED7TIqbBFgtdQUtoX5jhmej0eZTP3rMEjZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/Hirsr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeqZEmdC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8orLinLvBWR0eHLN9+46wRuiBJVew98Ux4qnN5k/pE=;
	b=h/Hirsr+9wTF2yhrnLM0CpI6y+cmtzAfoQ7p3a++k/4MYa9gl4CEwcfsGAEb6DQhaNAcuc
	tmyu6mW8pAz8tu+yy9maxNZ7lcOmeoRll/D1Kg9MDd+VPNXjmK6a1h9RLFsM71lUEL1a1I
	uo5XxrLD5xlIGgPNOl68WTrywtl/gC7xhozbQtDAEoJNs9RWNIju6YkG/+2kW9w+Tgvh79
	Mu4+ibglE2qyu6rHgNINfNVQdOrgeOlB05txLSSlTTaLOS6/9ssjHB0KpYlwz5nLmx14vV
	X2uX0M0/WJ9+aVOFhoTOoUfBGIiY26L7efV6qxDrCUXg5QURzhSBmWs45lUuCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8orLinLvBWR0eHLN9+46wRuiBJVew98Ux4qnN5k/pE=;
	b=EeqZEmdCZqwBAZ+JD/8pqJL7evrdXrUEDZWV56tjmahPmV4rVKsm1/Bu4kJB+H8qmeZ/p8
	UF3IdrYunRa3O7Bw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_fasteoi_mask_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.175652864@linutronix.de>
References: <20250429065421.175652864@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885615.406.12494830909030901700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f71d7c45edadfa98edac74bfdf820cce5482673a
Gitweb:        https://git.kernel.org/tip/f71d7c45edadfa98edac74bfdf820cce5482673a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework handle_fasteoi_mask_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Note: The mask_irq() operation in the second condition was redundant as the
interrupt is already masked right at the beginning of the function.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.175652864@linutronix.de


---
 kernel/irq/chip.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2b60542..2b23630 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1144,51 +1144,31 @@ void handle_fasteoi_ack_irq(struct irq_desc *desc)
 EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
 
 /**
- *	handle_fasteoi_mask_irq - irq handler for level hierarchy
- *	stacked on transparent controllers
+ * handle_fasteoi_mask_irq - irq handler for level hierarchy stacked on
+ *			     transparent controllers
  *
- *	@desc:	the interrupt description structure for this irq
+ * @desc:	the interrupt description structure for this irq
  *
- *	Like handle_fasteoi_irq(), but for use with hierarchy where
- *	the irq_chip also needs to have its ->irq_mask_ack() function
- *	called.
+ * Like handle_fasteoi_irq(), but for use with hierarchy where the irq_chip
+ * also needs to have its ->irq_mask_ack() function called.
  */
 void handle_fasteoi_mask_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_can_handle_pm(desc))
-		goto out;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		mask_irq(desc);
-		goto out;
+	if (!irq_can_handle(desc)) {
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	if (desc->istate & IRQS_ONESHOT)
-		mask_irq(desc);
 
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
-
-	raw_spin_unlock(&desc->lock);
-	return;
-out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
 

