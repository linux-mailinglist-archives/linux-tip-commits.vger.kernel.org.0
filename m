Return-Path: <linux-tip-commits+bounces-1843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14C9410E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09651F24E37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A11A0B04;
	Tue, 30 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AMLonusC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="luGnF79O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C1A01D4;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339610; cv=none; b=CKks6tvpGcvtW+qrDwcIld2wl7FdqNC5XlOaqynYcOCgZrQdW9um7t5MMouwwJhF8AqD7L0dp1Wt70iAsn/qdb7ooJgZoZ3toOj0hNxJ6Nu8M6QG1EfvhX3T1l7ZPR3NKIUSjVhPH06rfDqSZn66Zgt8NqTHWZZlVds7/snToFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339610; c=relaxed/simple;
	bh=uMOESqomLlAjwXaJB+9eLmiQjaAdweyg+Wn4A4nz8DA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZsdR7IbxHA2GBGBWD2uv2QbIxycGlTY+M9jaa4YiMhr1EwWv9BzNSKWzNlK/Wws/5VaNicfkZqg1B4pbLPRq0uT0qbN0DSkUNmgFtGDkloVo+PLUoBE88Xlf6phzQxtnTT26jgqOsMw2ngLdEEWpAxEaFFTHaWF85pE8J9qQhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AMLonusC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=luGnF79O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5xlNazQPbgtKutjWod58hyblM7pyzNUPd0/BPDZc8I=;
	b=AMLonusC9T4CPw0TjgKToipaH7gFgo1RCAyLqZEzGrOpaZbdZwrDD0HAbHbPoAxavDNVqx
	k24uWE5gD9H/sDAyyASVhGcgCxFB+11B27AA0Vyly9T5BVhNvv0uAEJNjzSZaZyjHR4ABx
	uSJTbCFeE6ZRBdrbJKgrcxGfGAXDnHoXrFCBzliIt603EwWlgt/rKTvFAYAMz0fwv4rsdC
	kfWafkSw0MEUZ9xh7uVE3e6vxWg/0g4bi9rbgkVeC6XepYS+xZl8I4RXswdMshjT677nmZ
	+NYFh1nIwJDyqAohVmPaUVm3gbyhv+oE2aX7mQ2VANvTuTZDLq8QylX9OjILqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5xlNazQPbgtKutjWod58hyblM7pyzNUPd0/BPDZc8I=;
	b=luGnF79O0R/AZ3K1bnfNF1S26JZUqGi2b4yZ2t+qCt8fNzjrkeqCYGuiom1Rm49ZlQpIXi
	1Mlagy4kvfqVjFDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Change register constant
 suffix from _MSK to _MASK
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-3-kabel@kernel.org>
References: <20240708151801.11592-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960457.2215.328904555047445887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9fa3e59a003bb82977ade5011ca6255f5ec83c5d
Gitweb:        https://git.kernel.org/tip/9fa3e59a003bb82977ade5011ca6255f5ec=
83c5d
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:45 +02:00

irqchip/armada-370-xp: Change register constant suffix from _MSK to _MASK

There is one occurrence of suffix _MSK in register constants, others
have _MASK instead. Change the one to _MASK for consistency.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-3-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 66d6a2e..588a9e2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -126,7 +126,7 @@
=20
 /* Registers relative to per_cpu_int_base */
 #define ARMADA_370_XP_IN_DRBEL_CAUSE		(0x08)
-#define ARMADA_370_XP_IN_DRBEL_MSK		(0x0c)
+#define ARMADA_370_XP_IN_DRBEL_MASK		(0x0c)
 #define ARMADA_375_PPI_CAUSE			(0x10)
 #define ARMADA_370_XP_CPU_INTACK		(0x44)
 #define ARMADA_370_XP_INT_SET_MASK		(0x48)
@@ -324,9 +324,9 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
 	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
@@ -394,17 +394,17 @@ static struct irq_domain *ipi_domain;
 static void armada_370_xp_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_send_mask(struct irq_data *d,
@@ -539,7 +539,7 @@ static void armada_xp_mpic_smp_cpu_init(void)
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
@@ -740,7 +740,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
=20
 static int armada_370_xp_mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	return 0;
 }
=20
@@ -785,7 +785,7 @@ static void armada_370_xp_mpic_resume(void)
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
-	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	if (is_ipi_available()) {
 		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;

