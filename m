Return-Path: <linux-tip-commits+bounces-5394-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC6AADAEB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A97B8256
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EF241676;
	Wed,  7 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YY1M4gT+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQ43OxGp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272123E33A;
	Wed,  7 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608860; cv=none; b=njTbe61Ftvj9EtoMEUhLQKB04+RF/Q6S1QvaZ+IY2xgQradHMB1Kju8+n1mRtPTtmptsD8oEQdnh6Ski4kCSp0dfSnOOb8rnj51KI5VElycEkoQ17N1g6P0vd4TRfcXkdrm7TesLnm4hv8oEHrfxW0sqy/LwoyeRTSNZxr6oN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608860; c=relaxed/simple;
	bh=fy+9qQlkTVdBmGZJ3obp2KU5GYNuCIgi/N/3LTphL+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f3q+F+PghUJn51FUfpS9qLX9G+lmQhG3r+wygEwFYE8QTRNyKHuI1pnX2/vBbPM/7XsWqerTI9TA6d3XGjs8OlRUZyK9z3Hv1FA9XQ7hUqJl7cDN+bI5pnIl/L21ewL5S3a9KYkpR3QVf0AONnBXBu4ORqo1WOr2/KPf5FqX5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YY1M4gT+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQ43OxGp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3pkTMXePOjDxi1s+n4+ciRjCZg9RoP1Dsi94Cz7ObA=;
	b=YY1M4gT+56PzNvYhXSSICszyZNgz/wld+j1nNRYyMcXlVk2k4tF7lE3wzMLw8Hbn2sv3EB
	kU4IRtROkE6MpWvEFpX44ff7BAxaxkIz2SSed36oSGERfAq6PiLGIXL7I1ATLU8cwHIEaQ
	JwizPZda418CD7G6+gAKd0gkuKGtZpPDzr3b9cnRG+Ar4Jn6MTdzSQW44xhmUo++Pu4g+4
	KlPqjdNO3OIkV2ErBZnkXM6gqH8qbVlvNQzAxfBUkPBu5i4+rngKViGEz2IcpULgh0Y1e8
	ojnDD2feY7PBlChVCEW3L0Rye1lwO0gXymPjgHOeGBk/HM42a8GunEowCDMrMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3pkTMXePOjDxi1s+n4+ciRjCZg9RoP1Dsi94Cz7ObA=;
	b=zQ43OxGpodaf1FiCoFf8dVOnKc8lWeGPTvqRS5vBDsO8UXC22M3k+dXniHoeM+qwjK2olj
	XTV1zIVmLwplBPBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Use lock guards where applicable
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.236248749@linutronix.de>
References: <20250429065421.236248749@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885549.406.2053447162944601098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e7c654255791e9a95b62b992ef3540dfee00e8d5
Gitweb:        https://git.kernel.org/tip/e7c654255791e9a95b62b992ef3540dfee00e8d5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Use lock guards where applicable

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.236248749@linutronix.de


---
 kernel/irq/chip.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2b23630..daa356a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1049,25 +1049,21 @@ EXPORT_SYMBOL_GPL(irq_modify_status);
  */
 void irq_cpu_online(void)
 {
-	struct irq_desc *desc;
-	struct irq_chip *chip;
-	unsigned long flags;
 	unsigned int irq;
 
 	for_each_active_irq(irq) {
-		desc = irq_to_desc(irq);
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
+
 		if (!desc)
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_online &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
 		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_online(&desc->irq_data);
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
@@ -1079,25 +1075,21 @@ void irq_cpu_online(void)
  */
 void irq_cpu_offline(void)
 {
-	struct irq_desc *desc;
-	struct irq_chip *chip;
-	unsigned long flags;
 	unsigned int irq;
 
 	for_each_active_irq(irq) {
-		desc = irq_to_desc(irq);
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
+
 		if (!desc)
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_offline &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
 		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_offline(&desc->irq_data);
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 #endif

