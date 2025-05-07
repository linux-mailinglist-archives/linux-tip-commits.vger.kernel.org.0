Return-Path: <linux-tip-commits+bounces-5393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E689AADAE9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E52167F06
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461623F271;
	Wed,  7 May 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoCi8dRN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKa5xF9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC823C8A0;
	Wed,  7 May 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608859; cv=none; b=qOx2TbGiRr4yI/xbym/f6Q/Ny/TKROQpGRWqvig13hXb6uCR8EUV96XMRMDjJpmENlbira/F+ZH9EdyN7QZf9xaB/1c1WVeFJIzIsw4WJRtOhOZv1v66qOK1/yfcFf81bIFNReOZ2ryUE3MkpeW2Hh9KBT/I360mT9iOXMdLP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608859; c=relaxed/simple;
	bh=nkHyITw4bWWg3UJwVst+nLSyIxxPJwxz41rsNardM1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dFZ4NpJc1F6Tl0b8gEkZeSpMTFet3iURzXwhqDHJmjqkl+G7AA4yOtt85s2Ix5dsgQSQAZ4lJK3rcCQIDm7nTSZUGt+Burx3rSxemOjvDKMJXvdfNIXdAgC4IRK3p0BrVn8HrE1QzRT7VEqyMmCAEM3ycIMJFlKoKl3RqleYqwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoCi8dRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKa5xF9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608855;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lXu12nHlQr5wG8eALmM7tZK/HyFUPrg7houdcxFML0=;
	b=zoCi8dRN7lPsxMi00yEtWqjVpya1b/czD9LTRi4DzTNAAWgkyM2gU67SF/p1tvHBsNp5Rf
	GGxs/9xr7ptb/abD1Dx3DGfBwgJS4ArkINgLXazgYT1IDhAVNrxDHrAUZytpnp9yAgPGDn
	Ohi4X/bijwr1RvAeC9iGOQu702gwm2Aa7emwhqEVQH9t8YzdGP5MNtlsgpgF846o+rlGnZ
	/P76RcJ6Qwjtm1FqbN+QS7BZrNQHn+NLwlXCrsQdXTIUTJrPYB4rq3C4Eyd3v/IptzDu4y
	XIpNj9qLCKo2EFeIyOciNocuWfKgirfUTFnYgUBLXzPJduEvyCl5gc5dsmKO8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608855;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lXu12nHlQr5wG8eALmM7tZK/HyFUPrg7houdcxFML0=;
	b=wKa5xF9HODimpi6QBazwrvol3jr8/XEo9YigkVr8IHGpgvVbqXvTda/pebbAGKtvdWOzZ1
	aWjYXhsVpPIGwwCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_chip()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.295400891@linutronix.de>
References: <20250429065421.295400891@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885479.406.5474165666656981528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     46ff4d11f081ef9bc3df3d56f54a10e955dba733
Gitweb:        https://git.kernel.org/tip/46ff4d11f081ef9bc3df3d56f54a10e955dba733
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework irq_set_chip()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.295400891@linutronix.de


---
 kernel/irq/chip.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index daa356a..92bf81a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -34,26 +34,22 @@ struct irqaction chained_action = {
 };
 
 /**
- *	irq_set_chip - set the irq chip for an irq
- *	@irq:	irq number
- *	@chip:	pointer to irq chip description structure
+ * irq_set_chip - set the irq chip for an irq
+ * @irq:	irq number
+ * @chip:	pointer to irq chip description structure
  */
 int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
+	int ret = -EINVAL;
 
-	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
-	irq_put_desc_unlock(desc, flags);
-	/*
-	 * For !CONFIG_SPARSE_IRQ make the irq show up in
-	 * allocated_irqs.
-	 */
-	irq_mark_irq(irq);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
+		ret = 0;
+	}
+	/* For !CONFIG_SPARSE_IRQ make the irq show up in allocated_irqs. */
+	if (!ret)
+		irq_mark_irq(irq);
+	return ret;
 }
 EXPORT_SYMBOL(irq_set_chip);
 

