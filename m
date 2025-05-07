Return-Path: <linux-tip-commits+bounces-5397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EFAADAF2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A668E177BF5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A3242935;
	Wed,  7 May 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWQ8K9Gt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6QjxRuNt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8923FC49;
	Wed,  7 May 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608862; cv=none; b=ugggK/JGXBDwhDrY1jqFu/FkSj0NgPa2+1lG2efy8yUHs5Rw46a10ETuMJ8qWsiLEftC10Jcn6lhpWdtaPezoTMx7EJXcrIDqhg4XAsmaJtd0WToiuBvsroGMV+x/jP+j7klTKfjQbxUuHuXeLg1NO6J+O3szdg6mRCBf642k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608862; c=relaxed/simple;
	bh=o75ufmf0TWqyAR+oHz+W249rNfErzaCi7RPi53cJb3M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wl8yKzrjao1n2YU8WzRkEa/mDHiTD0lKVseBzaZ/42fuuP4ozSIR1JtyLWpqBH2T18pFZPlheNf1hzCPkrS+l7RIb8sbCyvjMnwJawyXR57lpH/wZRHhtlCdsQhdz8rveWQos91pnKdRGYDS0IvyFVVIzRRsMrRx2LWqieu+3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWQ8K9Gt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6QjxRuNt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daN7dOX0n4STULUkAF7z4LattsJsrAaAzqcX26Ucx9Q=;
	b=VWQ8K9GtOX91ARl2lGQltbnMsdlNXpQIPjas2t6qb1mS0rxPt6cpTuUKsD2UEkqxBVD810
	FLURl6aBSpq9iESIol7h2DvW8JjU9jrGQtR9RwIbvSI/X4JqrKe47wNR5wFUR6XFf/YpXS
	a6oZ4yXdeeoxZ3/0YfDsCs80QW/45N4rsBOWFOojfz44fFIUC/dcldjAJi6FxtbBMGAGUQ
	ngdbo7ZNshZoBNBZ18tXJtJwZHDySRQre0sUC4eLMbDQPi7qYICtezhpvZ7NKMp9a1OpnI
	BxWI9iLscBwTUhvVtYIyTk/Yk9+UoeXCyR9OxCb0CRE1F7aga/Y1kx8Rq/8JCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daN7dOX0n4STULUkAF7z4LattsJsrAaAzqcX26Ucx9Q=;
	b=6QjxRuNtBxcUiCBRDD89y4s5KvEqLc09WKjMwBRAS0aiPr0QIYbBqmrm3jECrAydwZedqN
	v6Lf0pw8c0Y8ecAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_edge_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.045492336@linutronix.de>
References: <20250429065421.045492336@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885753.406.2496233723524372324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2d46aea52c02612d1b49aa562162eee58fa1968d
Gitweb:        https://git.kernel.org/tip/2d46aea52c02612d1b49aa562162eee58fa1968d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework handle_edge_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.045492336@linutronix.de


---
 kernel/irq/chip.c | 49 +++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 1ca9b50..6c33679 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -742,40 +742,27 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
 
 /**
- *	handle_edge_irq - edge type IRQ handler
- *	@desc:	the interrupt description structure for this irq
+ * handle_edge_irq - edge type IRQ handler
+ * @desc:	the interrupt description structure for this irq
  *
- *	Interrupt occurs on the falling and/or rising edge of a hardware
- *	signal. The occurrence is latched into the irq controller hardware
- *	and must be acked in order to be reenabled. After the ack another
- *	interrupt can happen on the same source even before the first one
- *	is handled by the associated event handler. If this happens it
- *	might be necessary to disable (mask) the interrupt depending on the
- *	controller hardware. This requires to reenable the interrupt inside
- *	of the loop which handles the interrupts which have arrived while
- *	the handler was running. If all pending interrupts are handled, the
- *	loop is left.
+ * Interrupt occurs on the falling and/or rising edge of a hardware
+ * signal. The occurrence is latched into the irq controller hardware and
+ * must be acked in order to be reenabled. After the ack another interrupt
+ * can happen on the same source even before the first one is handled by
+ * the associated event handler. If this happens it might be necessary to
+ * disable (mask) the interrupt depending on the controller hardware. This
+ * requires to reenable the interrupt inside of the loop which handles the
+ * interrupts which have arrived while the handler was running. If all
+ * pending interrupts are handled, the loop is left.
  */
 void handle_edge_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (!irq_can_handle_pm(desc)) {
-		desc->istate |= IRQS_PENDING;
-		mask_ack_irq(desc);
-		goto out_unlock;
-	}
+	guard(raw_spinlock)(&desc->lock);
 
-	/*
-	 * If its disabled or no action available then mask it and get
-	 * out of here.
-	 */
-	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
+	if (!irq_can_handle(desc)) {
 		desc->istate |= IRQS_PENDING;
 		mask_ack_irq(desc);
-		goto out_unlock;
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
@@ -786,7 +773,7 @@ void handle_edge_irq(struct irq_desc *desc)
 	do {
 		if (unlikely(!desc->action)) {
 			mask_irq(desc);
-			goto out_unlock;
+			return;
 		}
 
 		/*
@@ -802,11 +789,7 @@ void handle_edge_irq(struct irq_desc *desc)
 
 		handle_irq_event(desc);
 
-	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
+	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 }
 EXPORT_SYMBOL(handle_edge_irq);
 

