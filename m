Return-Path: <linux-tip-commits+bounces-5402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21BAADAFA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489A29A1A45
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B592459D6;
	Wed,  7 May 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nf6b5NIl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJr5OUqI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17A241662;
	Wed,  7 May 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608865; cv=none; b=QGR8dBspCudqN5skk7d2WDQGi66KTk0P7hkyV35jZQF6ZQ818DoZIr1h6NDL06KDc6UlcC2zucRo1JZG+7xSF3LpR8XiDTZvmgYPXHh4Srqk3DvcCbtylR8JN8n+j9+P3zzBQ/f+ZJKYLBlLYFv5gNZMLnAoQ0W3guuSha0pwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608865; c=relaxed/simple;
	bh=wDW3b7+uPQP6X/ZFcPu8oB5WwP364/Jv+YZXA8Ebv7g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IdXg2m5R7QKbSdDcz7VgtxcOBbYsRR5yw3eNWM5FL0ym5DIUGAmCXYXFyUNosyqphF+XT6Fpf6GzxlrTU7EfXCzh6WHD+hcLzefGvyOGouNakgaToi5yGauum+rBZvkGG1VljoEIAU7S1bDKdbYo73JSobVqsfWckpJlPxf5CWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nf6b5NIl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJr5OUqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhogB+sCf6V1R4LkyUq5kvYbqzcOFIC+Lp4BzSf/Trc=;
	b=Nf6b5NIlpTQRoWORV/C/RSgu+d18MKHIG8VavATWJi/Xm2s1GBF5zBAqdN7rb2WkJ75HT8
	8J5MuihWGXSN2HZ0kSwQlDRxiCWukmbhV2cGtbueXl+l3VJIFI2k4xLY95R6N3cMT0+zX7
	3IMhOTNS96N6uomw3UGtq+upOmM1vf8WaLWJjKLzsMUi1HcD4Mao/3iXCHWHutPirORrKK
	DooOaxo52nXrLRRFn0NoPiW077ul1UM3YE4EEqS6cZrADz/32oKRwd37Ujvs1mAPsMkSRg
	NhsTxapvZWnQIftfogzoOSHShIw+zl8Zzz5zqWTH4CO7f7yVAcUSUBcDoblNcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhogB+sCf6V1R4LkyUq5kvYbqzcOFIC+Lp4BzSf/Trc=;
	b=dJr5OUqI+UPge4UaBg9uU2J7Z3TJwxRF7YRHDLfxOxpRUmAW9PxHbnmiXxoc9LekIRzqBw
	lJ3tfx1foYgiDcCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_nested_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.744042890@linutronix.de>
References: <20250429065420.744042890@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886094.406.13095864381763287785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2ef2e13094c7510c40833951c2ec36cf8574331a
Gitweb:        https://git.kernel.org/tip/2ef2e13094c7510c40833951c2ec36cf8574331a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/chip: Rework handle_nested_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.744042890@linutronix.de


---
 kernel/irq/chip.c | 78 +++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 4b4ce38..87add4b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -450,48 +450,6 @@ void unmask_threaded_irq(struct irq_desc *desc)
 	unmask_irq(desc);
 }
 
-/*
- *	handle_nested_irq - Handle a nested irq from a irq thread
- *	@irq:	the interrupt number
- *
- *	Handle interrupts which are nested into a threaded interrupt
- *	handler. The handler function is called inside the calling
- *	threads context.
- */
-void handle_nested_irq(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	might_sleep();
-
-	raw_spin_lock_irq(&desc->lock);
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	action = desc->action;
-	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		raw_spin_unlock_irq(&desc->lock);
-		return;
-	}
-
-	kstat_incr_irqs_this_cpu(desc);
-	atomic_inc(&desc->threads_active);
-	raw_spin_unlock_irq(&desc->lock);
-
-	action_ret = IRQ_NONE;
-	for_each_action_of_desc(desc, action)
-		action_ret |= action->thread_fn(action->irq, action->dev_id);
-
-	if (!irq_settings_no_debug(desc))
-		note_interrupt(desc, action_ret);
-
-	wake_threads_waitq(desc);
-}
-EXPORT_SYMBOL_GPL(handle_nested_irq);
-
 static bool irq_check_poll(struct irq_desc *desc)
 {
 	if (!(desc->istate & IRQS_POLL_INPROGRESS))
@@ -544,6 +502,42 @@ static inline bool irq_can_handle(struct irq_desc *desc)
 }
 
 /**
+ * handle_nested_irq - Handle a nested irq from a irq thread
+ * @irq:	the interrupt number
+ *
+ * Handle interrupts which are nested into a threaded interrupt
+ * handler. The handler function is called inside the calling threads
+ * context.
+ */
+void handle_nested_irq(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action;
+	irqreturn_t action_ret;
+
+	might_sleep();
+
+	scoped_guard(raw_spinlock_irq, &desc->lock) {
+		if (irq_can_handle_actions(desc))
+			return;
+
+		action = desc->action;
+		kstat_incr_irqs_this_cpu(desc);
+		atomic_inc(&desc->threads_active);
+	}
+
+	action_ret = IRQ_NONE;
+	for_each_action_of_desc(desc, action)
+		action_ret |= action->thread_fn(action->irq, action->dev_id);
+
+	if (!irq_settings_no_debug(desc))
+		note_interrupt(desc, action_ret);
+
+	wake_threads_waitq(desc);
+}
+EXPORT_SYMBOL_GPL(handle_nested_irq);
+
+/**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@desc:	the interrupt description structure for this irq
  *

