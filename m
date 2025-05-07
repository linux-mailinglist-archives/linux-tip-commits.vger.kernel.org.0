Return-Path: <linux-tip-commits+bounces-5398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60658AADAF1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE313B6804
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DDF242D87;
	Wed,  7 May 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pqf7YBCv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CLJ4CK8M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD0241663;
	Wed,  7 May 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608863; cv=none; b=JqjoXEYJo6sd93qgftL1sG6RkJ0VaBswS4apEi6pCv6ctsigLXBoMyJeCt77Sy6r8nrAThCkBWKQiOtvBu2fGXpi1yOZQ2BSDzcPWZ0AOIkN6goJNT+6AbgRUn2ISHG+K/iC8PsvBMx/JPd/KW/WYn5xgKtzhM3bSmN6TxvkWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608863; c=relaxed/simple;
	bh=Cuw2D5eNQQW/eA8BUCMbsppaTpHqfdzfgfX2rLTU/dM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqK+nKS2a9wNJ7HqVMdcjoegD/k5WJ66uV/jjIRaezbC5QtnfdjzXCM3OO1AEySSgZW57bBerC8kCA/YnP0E/hk9SLKW5DTj8l3iXVFYHmNTysBW9Ch+kTnRY8tT+G4KeJn5/gTJhu3bNlIdSFeyTvVE9Vr7dNlMuNcU/6Ut5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pqf7YBCv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CLJ4CK8M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyiB0OhW8XH7K8PA7BzBORSysaybLZikDjZ6YdcXaeA=;
	b=pqf7YBCvGbE0J7LSKp331iXa3KoF8Ne+xp7vsEB8y0RGVucBXV1C4RD/U2bs7Sur/bb/Ct
	4ZTaSIMAOxpCTdt1oPTLWY5fho1jS5F665LpaHQNI7q+AQ0wYTCAOrHED1BlwNod6dis0I
	psK3yj4j7fm7fNV57ISBTBUE/ytWbmcW7/mdWx0jhVc74bTZmldFiPS1gZUaoinhLGwGZa
	C4t4vbvDDBD8pj6UOWtvN+i7B62GNVHxqcEv2/2/17B+zn1PmMNketXZkQcJRAeLYi5bIO
	rUvJZMLLzhHVSVQtWW7uAKTDa6UoL/St5NGJaGHTndF4/YE6FyaY4lyvAuL7Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyiB0OhW8XH7K8PA7BzBORSysaybLZikDjZ6YdcXaeA=;
	b=CLJ4CK8MLD4FsxVybA9UVF+Ba5C0D6NglSquVbD6M/3YU5j+FHmUx5WTrxcXDehmORQIje
	BW9EytQnFvFgW0BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_eoi_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.986002418@linutronix.de>
References: <20250429065420.986002418@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885818.406.11814716534240691806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15d772e2eebd297e3714abad8bf1d424d3d700fc
Gitweb:        https://git.kernel.org/tip/15d772e2eebd297e3714abad8bf1d424d3d700fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework handle_eoi_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.986002418@linutronix.de


---
 kernel/irq/chip.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eddf0c6..1ca9b50 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -653,20 +653,26 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 	}
 }
 
+static inline void cond_eoi_irq(struct irq_chip *chip, struct irq_data *data)
+{
+	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
+		chip->irq_eoi(data);
+}
+
 /**
- *	handle_fasteoi_irq - irq handler for transparent controllers
- *	@desc:	the interrupt description structure for this irq
+ * handle_fasteoi_irq - irq handler for transparent controllers
+ * @desc:	the interrupt description structure for this irq
  *
- *	Only a single callback will be issued to the chip: an ->eoi()
- *	call when the interrupt has been serviced. This enables support
- *	for modern forms of interrupt handlers, which handle the flow
- *	details in hardware, transparently.
+ * Only a single callback will be issued to the chip: an ->eoi() call when
+ * the interrupt has been serviced. This enables support for modern forms
+ * of interrupt handlers, which handle the flow details in hardware,
+ * transparently.
  */
 void handle_fasteoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
 	/*
 	 * When an affinity change races with IRQ handling, the next interrupt
@@ -676,19 +682,14 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	if (!irq_can_handle_pm(desc)) {
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
+	if (!irq_can_handle_actions(desc)) {
 		mask_irq(desc);
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
@@ -704,13 +705,6 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	 */
 	if (unlikely(desc->istate & IRQS_PENDING))
 		check_irq_resend(desc, false);
-
-	raw_spin_unlock(&desc->lock);
-	return;
-out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 

