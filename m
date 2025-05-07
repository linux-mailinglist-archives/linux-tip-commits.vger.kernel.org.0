Return-Path: <linux-tip-commits+bounces-5399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38510AADAF3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6383BBC30
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7512441AA;
	Wed,  7 May 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FmCDbGib";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EbcZxEl3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDD2417F0;
	Wed,  7 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608864; cv=none; b=c3xX0Z2kdcDSa+gCxFHJoZhV/EA1cXnP2ll5JPrZkaBrj++X/2GPftfiI/xEWyuiteeHliXVkkEfZ9HfXHVUMwAdGcC+UBtwEgUKHBLyvTfzlUA64U8NjIrcsDk84jbMELK5iEqCnwDPsM/x/lE3q6lF0fneAyqUv0Q9K79L3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608864; c=relaxed/simple;
	bh=1qXpLQn0N3oUo4SDJQFsMlSCTQluPauNVLiuVGmHa38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qmEX30Qac8sK9NGm4uzg7FAYoWlQeK5dBmrbZ9SvvbeJhtJTzlgpKb2EZWF5nnbbOH8raJTf997rPc2uLM2ghRihMB3nYK6v2WnGIKCUDsLA4UWg8kMMraq+jPnWzrtGdf3KLrpl5YEL+NtsGKso5PAjFeasN8K2A+IJwR6kpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FmCDbGib; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EbcZxEl3; arc=none smtp.client-ip=193.142.43.55
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
	bh=/xTiK9LK0HMtxXWDcML84j/PNUhnA1JLM/g8Qd0ANQ4=;
	b=FmCDbGib72Sg2WlAUTxSGocZRoVLUyZdFXS4UDXllo8LgS8rHmawpBiK0e0GeUsYDfkyWx
	mZUkmn81iTVgmZg1UgXh1L1iC8ZmzrvV6mdohLJ4OrjNgQQ7BgzP7K6cNaTC/zS8mLh3tN
	8p+k2ZHGxeZMDs34d1q7l1s82VPZURyowfeu3hz13B9pC+gii8fdu8om3eSPo6bBzm0hxW
	x+UEoHRKUC9AfOTrQqun8Lb0+re72h6t6GU6ZW0k6lYI4Px04SFRM7NMaQELz4ypoi/I+n
	WB/1BGe4CtIDMzxSZmNVrIorT4IS+/izd24AwIlu7mLstAJxDt1PzYbeJUilYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xTiK9LK0HMtxXWDcML84j/PNUhnA1JLM/g8Qd0ANQ4=;
	b=EbcZxEl3DHN24DF0YR0AO/XRPDNTmRrspj5pqvH12W3jdU7PN9p/ZZ8yn1agl2esxErlqR
	NhQiL7Y0dvD06DBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_level_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.926362488@linutronix.de>
References: <20250429065420.926362488@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885885.406.17847204461521972074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2334c45521033772fd808e54814f5844ac35c9d0
Gitweb:        https://git.kernel.org/tip/2334c45521033772fd808e54814f5844ac35c9d0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework handle_level_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.926362488@linutronix.de


---
 kernel/irq/chip.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 48f62fc..eddf0c6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -609,40 +609,26 @@ static void cond_unmask_irq(struct irq_desc *desc)
 }
 
 /**
- *	handle_level_irq - Level type irq handler
- *	@desc:	the interrupt description structure for this irq
+ * handle_level_irq - Level type irq handler
+ * @desc:	the interrupt description structure for this irq
  *
- *	Level type interrupts are active as long as the hardware line has
- *	the active level. This may require to mask the interrupt and unmask
- *	it after the associated handler has acknowledged the device, so the
- *	interrupt line is back to inactive.
+ * Level type interrupts are active as long as the hardware line has the
+ * active level. This may require to mask the interrupt and unmask it after
+ * the associated handler has acknowledged the device, so the interrupt
+ * line is back to inactive.
  */
 void handle_level_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	/*
-	 * If its disabled or no action available
-	 * keep it masked and get out of here
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
-	}
+	if (!irq_can_handle(desc))
+		return;
 
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_irq(desc);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 

