Return-Path: <linux-tip-commits+bounces-3402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E336AA3966C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B19188C1B0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8407E234963;
	Tue, 18 Feb 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mk5EmTqD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fonkBM7t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490A22D4FF;
	Tue, 18 Feb 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869441; cv=none; b=XopdqfqMMCL1UrcvwBWGG1eiVKUuB5EGyBLwF/vaNOm2RlBVc7xLy9o6f0ST/pwW8aRtHg08wfutjCiIoYgpBTYX+b4N1OIaYM4TwKdcIHDkx7aqKoBSO1i8M8IEoV9P0ltUE32oQ5ALJuvXS7SW3bijlXKOcdr99u2kJKEZaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869441; c=relaxed/simple;
	bh=i76pA37gMaiWt4G01yENjvM7YCTneib/C62qt5x1sO0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nzYErnTFrQibTpBvYK6s+fBZYw6QjqHySWxwFvhrO2Qt5StxxG3vESycpwufBeMqeKMWj5G+6IF7FQVFoM/LJj3ZKdDce4RaSbS0wN1NsxCDdnaJ51oEs4LfWH5nI65gLoVHXAl2MbrH+2RupLR+K/nkSlgCkDgWn/GyB3d8h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mk5EmTqD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fonkBM7t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2urEjT1AHekiTat/TKNEdk3sawoMGkq1pqGTAfMVSI=;
	b=Mk5EmTqDG2RGXtPUMUgGKRaJtO91zT8uq3qblApiWS5/NAHcsg7ZOR8KmRfGlKrNp2Epu7
	7LxSJYxSmRsWPT1UQYC+MTUQYnFK78khLbrcgnhbb02U5d9IM9BY4yKRXqx9qROKkgITOJ
	8ypg7AwqyzSxej81YvoCC2dd0r5/xUVmg/vAesAxOl8iMpWPlyk6Jd6hPQUn2mYuRqqINh
	OApVAtdHNi0HjnHg5eA073N6jJoEIB90deLFoeMDEpXCRQ1o35VsJxXBqCn84iYvWdqPuR
	xPZpS+nzIZ0qzs1+BbwbiQxWPaonG2dH8+quwOz7j3y3EslDm+ZREvBgAVmAFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2urEjT1AHekiTat/TKNEdk3sawoMGkq1pqGTAfMVSI=;
	b=fonkBM7thzMzHRIX82eIuHW7M/J40HK0duOGxCy3ztc5OuA7PgoQmAcowkVXO2dYbH4sS7
	Wb/gsWUmfIjtjYAA==
From: "tip-bot2 for Andrew Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Set irq_set_affinity() for IMSIC base
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-2-apatel@ventanamicro.com>
References: <20250217085657.789309-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986943710.10177.15336602288384686290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     999f458c1771354371ba367dd84f55f9a62a4233
Gitweb:        https://git.kernel.org/tip/999f458c1771354371ba367dd84f55f9a62a4233
Author:        Andrew Jones <ajones@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:47 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:51:01 +01:00

irqchip/riscv-imsic: Set irq_set_affinity() for IMSIC base

The IMSIC driver assigns the IMSIC domain specific imsic_irq_set_affinity()
callback to the per device leaf MSI domain. That's a layering violation as
it is called with the leaf domain data and not with the IMSIC domain
data. This prevents moving the IMSIC driver to the common MSI library which
uses the generic msi_domain_set_affinity() callback for device MSI domains.

Instead of using imsic_irq_set_affinity() for leaf MSI domains, use
imsic_irq_set_affinity() for the non-leaf IMSIC base domain and use
irq_chip_set_affinity_parent() for leaf MSI domains.

[ tglx: Massaged change log ]

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-2-apatel@ventanamicro.com
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780..5d7c30a 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd = d->parent_data;
 
-	old_vec = irq_data_get_irq_chip_data(pd);
+	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
 
@@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -ENOSPC;
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
 	/* Update irq descriptors with the new vector */
-	pd->chip_data = new_vec;
+	d->chip_data = new_vec;
 
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
@@ -135,6 +134,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.name			= "IMSIC",
 	.irq_mask		= imsic_irq_mask,
 	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
@@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 #ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 		break;
 	default:

