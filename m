Return-Path: <linux-tip-commits+bounces-5401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC3AADAF9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF77F7B87A4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623A245003;
	Wed,  7 May 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpgnleSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNzLNFG4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C0230BE5;
	Wed,  7 May 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608864; cv=none; b=PlnkSoqlOahr/AR5QeT6ClhArPyA4urDVPQ49aikRsf49jutRCGaAPd1J6YlBWGJjrzcvg5/fBuvkNrKLJjm18TCp39mHJQ351mMiy7h7erGfNNVm4eozwmIfvTpSFPtdTFILwys6EqJMW1EfYj7UO3zgM45Np80YuRg7DJPAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608864; c=relaxed/simple;
	bh=1yfhNzdwc9thmp9t4sfxww0HFaaFNjsGda/0RQQwT18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hhcdRU8e6YcT1e+5XTLNKLvdvCK89ItAtJyZAL93rVvv5j0O7FI7xiuJe44Fivp0BI1zGezipJ+zgy//eo3YIcukfI3EqVPx9cpMIg4G6rQG+Wm7onPwuEF3EY9IFOl1+9l9PMC4VmT2yHqBjkoK1kWQ9PPcK31sS7sVzBpxPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpgnleSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNzLNFG4; arc=none smtp.client-ip=193.142.43.55
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
	bh=oas6CN+k0bpAi4TIOe6vTAHLG0veqKP8YvBKwhcp8E0=;
	b=gpgnleSnwu3qTI9iRT9TASKL/5ou6u+eRtqZsdndERBND1BcNMOxOqDCjdGafgMs81qg7S
	MzHrUfelGTIhgOeZW+fx/OvVmHtCQEQnAJodNqfl0O739QUYiJ2pxLlpkp8c2dNyAXM2/f
	plgAzwhSiRDevpSuhDGrKSW5R8VwAfG2EciFBsr7/3uXJ9M1cOLcu+c7uPiuh2dgO1i0Gj
	8n5p1UqPYnXm+lP1mrDJkxr8bnVja9DcuMMsQVvK42QpDainyEbcizHgkSmgEvdmgPVXoi
	NLQ+VTJmnUvCkTFV18fxXFVC49bkujCi8s6NYJziMv1QH9Rx7zo5lckk7prW0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oas6CN+k0bpAi4TIOe6vTAHLG0veqKP8YvBKwhcp8E0=;
	b=YNzLNFG4jgvrr9i3Oa0a/er2fH/5ZMiFTzpElHKUJb7tWmibqJhZndTj5TJVYcbOmvEazv
	ySJKoOAUNtY+isCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_simple_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.804683349@linutronix.de>
References: <20250429065420.804683349@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886028.406.1073630794372205595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1a3678675f6945f97945dc453352c9c1fa26c470
Gitweb:        https://git.kernel.org/tip/1a3678675f6945f97945dc453352c9c1fa26c470
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/chip: Rework handle_simple_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.804683349@linutronix.de


---
 kernel/irq/chip.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 87add4b..8a1e54e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -538,35 +538,25 @@ void handle_nested_irq(unsigned int irq)
 EXPORT_SYMBOL_GPL(handle_nested_irq);
 
 /**
- *	handle_simple_irq - Simple and software-decoded IRQs.
- *	@desc:	the interrupt description structure for this irq
+ * handle_simple_irq - Simple and software-decoded IRQs.
+ * @desc:	the interrupt description structure for this irq
  *
- *	Simple interrupts are either sent from a demultiplexing interrupt
- *	handler or come from hardware, where no interrupt hardware control
- *	is necessary.
+ * Simple interrupts are either sent from a demultiplexing interrupt
+ * handler or come from hardware, where no interrupt hardware control is
+ * necessary.
  *
- *	Note: The caller is expected to handle the ack, clear, mask and
- *	unmask issues if necessary.
+ * Note: The caller is expected to handle the ack, clear, mask and unmask
+ * issues if necessary.
  */
 void handle_simple_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
-
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+	guard(raw_spinlock)(&desc->lock);
 
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
-	}
+	if (!irq_can_handle(desc))
+		return;
 
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 

