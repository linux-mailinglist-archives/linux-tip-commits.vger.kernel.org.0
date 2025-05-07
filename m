Return-Path: <linux-tip-commits+bounces-5376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00648AADAC5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4504E778B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4423535F;
	Wed,  7 May 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfu4QG2F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hu3i8/Px"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9E233704;
	Wed,  7 May 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608847; cv=none; b=Sh1SfSlXtvAkquVlZChiiLO/3/whEhA1d1qSMvc8gTOe1lmkIgLeOk0NY9EVJYFwg7WwojEmYdYwlyp8kFTetF1mYp+tg3iapmcfMM3+T2EE7nzuw0jA01bgba6e8bPdYZ/ZVmvn8LuPozaI3JIrJ4gWlYKeoGE32KUfqxukhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608847; c=relaxed/simple;
	bh=bPbM7g2CKqXvnmL+ZAJhNufS6ixTewWk6olldS3JjVs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GC8EZc7xB+WOtKaHgz+Jb5Yw3sewF+61Zqr1+Yo1h6lVeA8r9NDB1uRE3ok0FwaZTENydT+QGXI8O6hpdhqkNasUzd3QsE1Su6B2ibza25Hge7+TriFmrRvtrlma7sI4oniv0drNdqf7FOKeKhYl2GZ1KCsZUmbcDGIUYuZSieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfu4QG2F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hu3i8/Px; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsWny4Gs3P8q2ufd8+a37bqTLIR+Tt6BetMiCeOD5BY=;
	b=cfu4QG2FP/TyoRJo55tW/VCrIv/iUz8N7OfnWMrXusl8x3uz5FaL5dzaJ6jXI4/fOBOiQV
	McXmrwvy6uzTMVrVq40VXxngmgWmlzTVc6qPcn9CCGZelYkAuaoyzYYRY6ctrxSQBzx5NL
	K60kbamT4xC6u1c6hNUvjX9dTZtO4bVYiSNNP+wxyIDFocWzeERma+mrxgzbsVC2WXyA3M
	Oyy4SdHvNVkRwo+8Ei3zrbXSeYrH+lE8R3h92ryC0YymGz9aoD8RVxX1ODOxLbG6FX1l38
	AH/+HMHG87tFxrMTE1EnE4jHaBodgHRJFtYgtAkqOsUQ3qChDrBbchHhXy9ImQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsWny4Gs3P8q2ufd8+a37bqTLIR+Tt6BetMiCeOD5BY=;
	b=Hu3i8/PxrmxIgexVDd1FTzuRCRazyZORi2osUmBtp4yNK7pkSP9kKAVEh47mBzyrHfRGiQ
	sKdlPp/PuBaRn0DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework enable_percpu_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.315844964@linutronix.de>
References: <20250429065422.315844964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884323.406.8439250946666534219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     508bd94c3ad4bd8b5dba8280198ce1eb31eb625a
Gitweb:        https://git.kernel.org/tip/508bd94c3ad4bd8b5dba8280198ce1eb31eb625a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework enable_percpu_irq()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.315844964@linutronix.de


---
 kernel/irq/manage.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a08bbad..e27fa4e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2286,35 +2286,25 @@ err_out:
 
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
-
-	if (!desc)
-		return;
-
-	/*
-	 * If the trigger type is not specified by the caller, then
-	 * use the default for this interrupt.
-	 */
-	type &= IRQ_TYPE_SENSE_MASK;
-	if (type == IRQ_TYPE_NONE)
-		type = irqd_get_trigger_type(&desc->irq_data);
-
-	if (type != IRQ_TYPE_NONE) {
-		int ret;
-
-		ret = __irq_set_trigger(desc, type);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-		if (ret) {
-			WARN(1, "failed to set type for IRQ%d\n", irq);
-			goto out;
+		/*
+		 * If the trigger type is not specified by the caller, then
+		 * use the default for this interrupt.
+		 */
+		type &= IRQ_TYPE_SENSE_MASK;
+		if (type == IRQ_TYPE_NONE)
+			type = irqd_get_trigger_type(&desc->irq_data);
+
+		if (type != IRQ_TYPE_NONE) {
+			if (__irq_set_trigger(desc, type)) {
+				WARN(1, "failed to set type for IRQ%d\n", irq);
+				return;
+			}
 		}
+		irq_percpu_enable(desc, smp_processor_id());
 	}
-
-	irq_percpu_enable(desc, cpu);
-out:
-	irq_put_desc_unlock(desc, flags);
 }
 EXPORT_SYMBOL_GPL(enable_percpu_irq);
 

