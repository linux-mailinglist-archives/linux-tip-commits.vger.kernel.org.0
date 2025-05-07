Return-Path: <linux-tip-commits+bounces-5410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AAAADB0A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F7B9A1B8A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D282522A8;
	Wed,  7 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PM05slSt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWba5SMq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5A231C91;
	Wed,  7 May 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608870; cv=none; b=boHlVmRKKJg1GOa6+2ZNSO5HY80a8olNkgQREFIkXtaiNuEG9m0lFq8N1Z0d1KqMlA/M53S2/LIc1HiY/glVJAxstNMvAIbYWGqe8RQ1VYu0iq90p5Z5ua2fcasrCFcNdlXEPJQKzJp8SmufB10bzQq4MA6n4hqiVwmcJvXxrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608870; c=relaxed/simple;
	bh=cOJwyN6CY9qOytdVJQB4MQxfk/L5s1blYdtRbcFl5ic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oZcxX7JhUum+4GSBoStcCvvGsMkkCNS2mCC5tiugE0BBEuUXzpnBg7ZVGuSqS5HqmNwv4z+m87ju2elnsc1B3vmQeEEqMgX0uCEyGpSbR0EPDtPSWepzGSDjOHE27BIMNfQpzb+xAoXDWdSXrqozAGZP/UI+G+gVmNQG+DlsK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PM05slSt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWba5SMq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+22fnk4G6DcHII25HjysqkpBrWaOsNu5lO/O9k1dmA=;
	b=PM05slStJH3WAQGCW6tRlFPZyaCEVa+77d6QQ3jV3FXL4VKSyCiJ+MypBvchng6cU4z9SX
	llLOPL8+hLy5uNdNdAxAdQJFHmZVOrEwgBJQ7ZL1Pjt6Vy0PLDrFHNYflGItyh6ofkm+l8
	ZivcwAQ1Hm+9ccvqAI0QRp18hU+T/359+AbetxYFDfsBgMj+ZdmmiUTfSaL/dNJ02jmxtR
	hfrWlUyzBOaMhw9efH/m5aGlEYT2XvRYuVM1nJlUhwTjAvaMUHE/dQody1e5HDcPIYs96t
	KHoNyFfagk+Vl8eMdUCBK6gnfUd/Jfo1EQdjE2Gj5moQf/3PQEc3p5D0y9xJ6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+22fnk4G6DcHII25HjysqkpBrWaOsNu5lO/O9k1dmA=;
	b=DWba5SMqxyEuDGoy7n/k85TZ/cTTGRuplXN1BNoI44tVR7DxIwj7ueBWRWRazcWwBx5cU3
	soGCzVFBSPq8kCBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/pm: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.251299112@linutronix.de>
References: <20250429065420.251299112@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886640.406.12794172100477264760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     19b4b14428338775d8c0d0e725ecfb14e10121c3
Gitweb:        https://git.kernel.org/tip/19b4b14428338775d8c0d0e725ecfb14e10121c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq/pm: Switch to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.251299112@linutronix.de


---
 kernel/irq/pm.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index c556bc4..445912d 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -46,8 +46,7 @@ void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action)
 		desc->cond_suspend_depth++;
 
 	WARN_ON_ONCE(desc->no_suspend_depth &&
-		     (desc->no_suspend_depth +
-			desc->cond_suspend_depth) != desc->nr_actions);
+		     (desc->no_suspend_depth + desc->cond_suspend_depth) != desc->nr_actions);
 }
 
 /*
@@ -134,14 +133,12 @@ void suspend_device_irqs(void)
 	int irq;
 
 	for_each_irq_desc(irq, desc) {
-		unsigned long flags;
 		bool sync;
 
 		if (irq_settings_is_nested_thread(desc))
 			continue;
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		sync = suspend_device_irq(desc);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		scoped_guard(raw_spinlock_irqsave, &desc->lock)
+			sync = suspend_device_irq(desc);
 
 		if (sync)
 			synchronize_irq(irq);
@@ -186,18 +183,15 @@ static void resume_irqs(bool want_early)
 	int irq;
 
 	for_each_irq_desc(irq, desc) {
-		unsigned long flags;
-		bool is_early = desc->action &&
-			desc->action->flags & IRQF_EARLY_RESUME;
+		bool is_early = desc->action &&	desc->action->flags & IRQF_EARLY_RESUME;
 
 		if (!is_early && want_early)
 			continue;
 		if (irq_settings_is_nested_thread(desc))
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		resume_irq(desc);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
@@ -207,22 +201,16 @@ static void resume_irqs(bool want_early)
  */
 void rearm_wake_irq(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return;
-
-	if (!(desc->istate & IRQS_SUSPENDED) ||
-	    !irqd_is_wakeup_set(&desc->irq_data))
-		goto unlock;
-
-	desc->istate &= ~IRQS_SUSPENDED;
-	irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
-	__enable_irq(desc);
+		if (!(desc->istate & IRQS_SUSPENDED) || !irqd_is_wakeup_set(&desc->irq_data))
+			return;
 
-unlock:
-	irq_put_desc_busunlock(desc, flags);
+		desc->istate &= ~IRQS_SUSPENDED;
+		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+		__enable_irq(desc);
+	}
 }
 
 /**

