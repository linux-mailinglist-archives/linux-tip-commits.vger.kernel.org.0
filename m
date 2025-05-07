Return-Path: <linux-tip-commits+bounces-5380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DBAADACE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CC1BC2888
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D52367CD;
	Wed,  7 May 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SF5b+JgL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRTgVMUq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC832356D2;
	Wed,  7 May 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608850; cv=none; b=HFEfbltauEOrTN/NHCpRA+q5OY+p0wF+6BkbiRDHtJ0R9x05wteBEq2IJXkRhoFBR2Oi2msMwhfqU0i9+f9xaBrRkOa4Ta7QhQI+UaIHPsNtHGkyrf31d8UAg6D+YxxsILpWFkZwiaP3GlvP3hLc4gSxs2bntvLc+qroMnwCHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608850; c=relaxed/simple;
	bh=0qIuCwS47WtYv+nAydVvxSgKIWD6vuvUkwh9g7k40Z4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wm7RS1qwsCUI3tS5Q9aW67XzW2BDuCt1mz5XDcmSB2O7gtXAmcGZqHTB3jdOQvxdmRLIIyHJlh956Le/WVtZzylO90Czz48h+h0GnBzMe7Wc3MId4ExD6Lyb0LWNu0rasz/CE6xbwEEV8gySE8vp9mev9Qp0LO7xeEnteI57r80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SF5b+JgL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRTgVMUq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaVF6kDSXhwzX4mTPSePQcWIyPoBHnDqyos4TQz96mQ=;
	b=SF5b+JgLYl3oAN9hdlz9IIQicO9sa15iAUBQc4F3lkBuSqE9GPA4n5UNKBEG3FVftAoEUD
	KsuRwDjI5C5Vr/7H349AXitWAs9+gQ/UQr9mzwmueofUZBdYkqy7NmTwDIT0+WfdwiPaMu
	8Ol/3Vy7VPB9N7ZyH4e7WoiO0YBIU6+fFDczzc6YWNdc7yHtiqHmc8Y9HEweCi/Dm0fbmE
	R8g8yn2NDTrDKoMkLo546H0QS2J/jovEkzbwMUJ6gEmMZdK/uuTuOzXl0E1UW68c5oCE58
	Cb/JHyfDr46ApQyuwbhY9/X1fKw3MtX0OO+5mERzFvl2LICxXS1sURnLbDZQvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaVF6kDSXhwzX4mTPSePQcWIyPoBHnDqyos4TQz96mQ=;
	b=vRTgVMUq+HGt6vkuunS+yy+WITl3AtmPqG6AyiJrAsiBX8ShknF3Mukq6Z0gPXq2FCl5Rs
	OBYvr5cAsVNcspAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework enable_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.071157729@linutronix.de>
References: <20250429065422.071157729@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884603.406.3262019929737272414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bddd10c554073ba0c036b97b4f430119e2137aa4
Gitweb:        https://git.kernel.org/tip/bddd10c554073ba0c036b97b4f430119e2137aa4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework enable_irq()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.071157729@linutronix.de


---
 kernel/irq/manage.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index edc8118..b8f5985 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -789,18 +789,13 @@ void __enable_irq(struct irq_desc *desc)
  */
 void enable_irq(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return;
-	if (WARN(!desc->irq_data.chip,
-		 KERN_ERR "enable_irq before setup/request_irq: irq %u\n", irq))
-		goto out;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	__enable_irq(desc);
-out:
-	irq_put_desc_busunlock(desc, flags);
+		if (WARN(!desc->irq_data.chip, "enable_irq before setup/request_irq: irq %u\n", irq))
+			return;
+		__enable_irq(desc);
+	}
 }
 EXPORT_SYMBOL(enable_irq);
 

