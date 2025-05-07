Return-Path: <linux-tip-commits+bounces-5379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001FAADACB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D29A9A17D6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB5236454;
	Wed,  7 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6cEhxpt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uj6oFfiG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D7234994;
	Wed,  7 May 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608849; cv=none; b=LhfudA7gQcAJdZb56/4iq8O9ttkkmpHbktv1V25Nv7YNZXmLktNN9ittbzpYPGHldWohKOwRbveaWBUcJe3P+xIODKVTfuiXGVWZYA7UfE8K+I8C+t9Lp8ws4Bg5UGP6RKEpeTeF2Wu2CoGA0fLIPcUCGVd/IpwxGDGyt1aKdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608849; c=relaxed/simple;
	bh=JgFpwWqMW8Rj3CKlxArskOtYT/mPGM+a9bCVlPjjVtE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gM7BySVwyw7U81cigDTTUgcy/Td0MH7IfZ1VR0zBH+BnlI5mD0XKJeiuLHLT2IvZpfsj77WgBGSFbvwk7Cn3nA8W9gsYsa4wUbst/Dcmp4VJMKKBhYjxISfa0uhg63MFYkVu0G7FNhFEas6GCwP0Ub4n0NkiRDoum07qZIWmJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6cEhxpt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uj6oFfiG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwsr1yHoMGpd5/o48iyEk8pzPB7bSVEvb+aCF1OE+XE=;
	b=q6cEhxptSeJ7ExKJyYZ36KJwgtVqQDPENIXbaQZmqLnRR9r+xrm07GgVPZCRRsNtkjDjbh
	EWD9nR7XFpAQvpFXTO/bv5lXNcRUgzExW1weeYvwfd/6zCRDiCWyxF1p/cEv1yMC9xnYhY
	2FOH3yu1SmAhdqGiapIjKnQOZu6axFf04CNK6bHKIR5N5Lf8uLIq6IrME3EktEwrXvNM3+
	bdtXHX5c/S7svHAPjDsd5i40rvU2EHWfjpv86qyS4MbItmBlGoqfg/iH/sJM5kUbH/f15+
	ebLb87hQmd0575LEXgEX3K8JiZnifv9L99OPPcJnAUeX5DUlKSTZOMpeE2Lx5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwsr1yHoMGpd5/o48iyEk8pzPB7bSVEvb+aCF1OE+XE=;
	b=uj6oFfiGEGdc8s1Q2G1qpwBvKxIwDhUHP0BDjKEzNz17K+cmqUP/HUrc5cRDDtga1CpBds
	6LrJWbE4d/0SQlAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_set_irq_wake()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ldrhq0hc.ffs@tglx>
References: <87ldrhq0hc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884536.406.3810331641973669788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8589e325ba4f3effe0d47924d38a5c6aef7a5512
Gitweb:        https://git.kernel.org/tip/8589e325ba4f3effe0d47924d38a5c6aef7a5512
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 30 Apr 2025 14:48:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework irq_set_irq_wake()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/87ldrhq0hc.ffs@tglx

---
 kernel/irq/manage.c | 65 ++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b8f5985..d1ff1e8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -846,45 +846,40 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-	int ret = 0;
-
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
+		int ret = 0;
 
-	/* Don't use NMIs as wake up interrupts please */
-	if (irq_is_nmi(desc)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+		/* Don't use NMIs as wake up interrupts please */
+		if (irq_is_nmi(desc))
+			return -EINVAL;
 
-	/* wakeup-capable irqs can be shared between drivers that
-	 * don't need to have the same sleep mode behaviors.
-	 */
-	if (on) {
-		if (desc->wake_depth++ == 0) {
-			ret = set_irq_wake_real(irq, on);
-			if (ret)
-				desc->wake_depth = 0;
-			else
-				irqd_set(&desc->irq_data, IRQD_WAKEUP_STATE);
-		}
-	} else {
-		if (desc->wake_depth == 0) {
-			WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
-		} else if (--desc->wake_depth == 0) {
-			ret = set_irq_wake_real(irq, on);
-			if (ret)
-				desc->wake_depth = 1;
-			else
-				irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
+		/*
+		 * wakeup-capable irqs can be shared between drivers that
+		 * don't need to have the same sleep mode behaviors.
+		 */
+		if (on) {
+			if (desc->wake_depth++ == 0) {
+				ret = set_irq_wake_real(irq, on);
+				if (ret)
+					desc->wake_depth = 0;
+				else
+					irqd_set(&desc->irq_data, IRQD_WAKEUP_STATE);
+			}
+		} else {
+			if (desc->wake_depth == 0) {
+				WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
+			} else if (--desc->wake_depth == 0) {
+				ret = set_irq_wake_real(irq, on);
+				if (ret)
+					desc->wake_depth = 1;
+				else
+					irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
+			}
 		}
+		return ret;
 	}
-
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
-	return ret;
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_irq_wake);
 

