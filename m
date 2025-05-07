Return-Path: <linux-tip-commits+bounces-5400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A9AADAF4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A32C3B856D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9D24394B;
	Wed,  7 May 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dM5HfqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1opaDFsv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334024169B;
	Wed,  7 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608864; cv=none; b=rFf6h7Yl6PMB7XHODW0dfItIa7ea386qMPtbghla2m9GAsStS+boCprIBRbyAeAZuU6T1o3FyJXpyYszL3MvgrSgjJJllznOxt2+sWnJ3F6KHPiy/+Tlju5Ynw288MW4Uy9DK+wCC6kwKegOcHGbKHr1/vJ0t77q5ss6S+9wMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608864; c=relaxed/simple;
	bh=XQWh+jVZULOdMfhlE1Fxsr/ZR6UMP0IWsm4Fi/f6X58=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RnVl3hQ1PEJUz+sBVETHAEeC3Rn5d66jGmAn5UQnmvBJH9DNtP6KI3q6qufCU6hy/4Rhd7kUBp5b/5m2R5SFWyYKpgLdhlZiOKANkAMovdA8zEPowJ2LLu5FnRxbrAODeqlejcWEzG3chtHQ288I65cdv0Mgt+0zmYTrk7RVTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dM5HfqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1opaDFsv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aluRo1PWSMdbVBv6dHGQtY66c73otNdPsb7DtaWlsA=;
	b=2dM5HfqU5X7nqpKaNuhkFQ3sWUqQrFfbqVfOpBOX1KU8eq0Zw2WjodF9iqKW9W/5GlvB/n
	TThrYSmin1/93j8N0I1cFl2BJTJW0lcWYt9aThGP2nOAy1OVVDat0ZoKPDMzRijadmoNGL
	+6Rlvcr5Xdd/bO5AcLR7Z47Yu4UkMzAxdMV2MsI3UoKA4HQnQMFA1xo3YlT6wypkSvpZOQ
	WXaPNQQFbN95IC4B30ePkX07gPsZlyDP5xMT+JP0zeoMeTp8v3szrbso+Iy36wnahRqGQX
	MzS3hYweKXEUwQjmx1rFcS+4MKziFgbtruNVqOKbgPFpk+d/Z3ItUfmwxKu9Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aluRo1PWSMdbVBv6dHGQtY66c73otNdPsb7DtaWlsA=;
	b=1opaDFsvCOxQzqCj23p43vftrLODEJD84jrP5RS2l0LdtIpgMmvag6TXiYlZJaVpCyNqVu
	gESePysk2C8HxQCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_untracked_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.865212916@linutronix.de>
References: <20250429065420.865212916@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885952.406.18043749720605271818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a155777175bb3d0e93f8605d4d93ae6abf3484ab
Gitweb:        https://git.kernel.org/tip/a155777175bb3d0e93f8605d4d93ae6abf3484ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/chip: Rework handle_untracked_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.865212916@linutronix.de


---
 kernel/irq/chip.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8a1e54e..48f62fc 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -561,43 +561,32 @@ void handle_simple_irq(struct irq_desc *desc)
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 /**
- *	handle_untracked_irq - Simple and software-decoded IRQs.
- *	@desc:	the interrupt description structure for this irq
+ * handle_untracked_irq - Simple and software-decoded IRQs.
+ * @desc:	the interrupt description structure for this irq
  *
- *	Untracked interrupts are sent from a demultiplexing interrupt
- *	handler when the demultiplexer does not know which device it its
- *	multiplexed irq domain generated the interrupt. IRQ's handled
- *	through here are not subjected to stats tracking, randomness, or
- *	spurious interrupt detection.
+ * Untracked interrupts are sent from a demultiplexing interrupt handler
+ * when the demultiplexer does not know which device it its multiplexed irq
+ * domain generated the interrupt. IRQ's handled through here are not
+ * subjected to stats tracking, randomness, or spurious interrupt
+ * detection.
  *
- *	Note: Like handle_simple_irq, the caller is expected to handle
- *	the ack, clear, mask and unmask issues if necessary.
+ * Note: Like handle_simple_irq, the caller is expected to handle the ack,
+ * clear, mask and unmask issues if necessary.
  */
 void handle_untracked_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
-
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+	scoped_guard(raw_spinlock, &desc->lock) {
+		if (!irq_can_handle(desc))
+			return;
 
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
+		desc->istate &= ~IRQS_PENDING;
+		irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	}
 
-	desc->istate &= ~IRQS_PENDING;
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-	raw_spin_unlock(&desc->lock);
-
 	__handle_irq_event_percpu(desc);
 
-	raw_spin_lock(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
+	scoped_guard(raw_spinlock, &desc->lock)
+		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 }
 EXPORT_SYMBOL_GPL(handle_untracked_irq);
 

