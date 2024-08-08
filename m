Return-Path: <linux-tip-commits+bounces-2010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56394C0FD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29A2890B8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E21191F96;
	Thu,  8 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vND9eaTt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhPF3c/h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF4190682;
	Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130509; cv=none; b=bl4BJEfPFVR8a2EC2BrOFQ1UCn3flSjH2dvZyL2ikYoI8UiieUsPq4EbapOTJtq5CwVuOvH3FIFNUoYkwmLCFDAnrlxhPKF5cwpHtczI+hYT/ZGH1Ro2hPRmz5ewY1qGEv5+ey6HzTrADxJhDxoL+t91uQnw1kHnjzmr3UKcUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130509; c=relaxed/simple;
	bh=txPxRG8pshwfthYCJ5ss03RBcnPbjOJlU2BgGoG2Jn0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZVv96/Z8vv1Ytd1+Et+p338zjqxrrcmR1HK35nHk0+R4tQQyMUKh+PTKKrxdUJ5nFLRsowQX7rVfmBuLD9av+AgWZzHXjMdZkvqkRk7l8Y4nUlaSjsIZJwNU+KtOGEpEmqtwiXr3tmlGeUg/kcX99yyy7GT3IFXXsTNI87ITbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vND9eaTt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhPF3c/h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ey93xj+iwHN45GZtCWrsxQ3ITjCEVkrMGZATONTaLIo=;
	b=vND9eaTt5UYF5FMwS+9YWR4wb93fQq6phk2GHvjVCyIoynr34oDdaQjX0LcYpkFbtJ0Z0R
	UArg1I0q8oePAFyKF4CkKus+rDdROGxbutJkQRs8CHsBOnrRWoUHBZIXpqrP2binOPLYxC
	Iuess8PI+jlmpKKC3zdVsGfT0hM6pIt2PRf2Ftog6V80GJcfxDA35Nb9bO1ZUG+89Srvmh
	KN5iRT9K3HZwg/sRP1z+aogyDaOkx8oBpYUpKl1LHw5uxmerQlzX4g+G2hu9a9aSsI8VXC
	Fq5sfF0i+OjpD2RertTEf643epNHGaAAxMsHUwZH9K9LlAEqIamY0TVVG/mhtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ey93xj+iwHN45GZtCWrsxQ3ITjCEVkrMGZATONTaLIo=;
	b=NhPF3c/hI1lllzpiFGZ77SVRIj+G9VWvki39LFgUkPwkU+JCYPJeGMOE/xM+mbrK8QFG4j
	hwUNSQ4tV+pLzHBA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Allow mapping only per-CPU interrupts
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050281.2215.6323633711908113154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d6ca3f440239fb4fa85228ead4c5e8b286645b7e
Gitweb:        https://git.kernel.org/tip/d6ca3f440239fb4fa85228ead4c5e8b2866=
45b7e
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:41:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/armada-370-xp: Allow mapping only per-CPU interrupts

On platforms where MPIC is not the top-level interrupt controller the
driver currently only supports handling of the per-CPU interrupts (the
first 29 interrupts). This is obvious from the code of
mpic_handle_cascade_irq(), which reads only one cause register.

Bound the number of available interrupts in the interrupt domain to 29 for
these platforms.

The corresponding device-trees refer only to per-CPU interrupts via MPIC,
the other interrupts are referred to via GIC.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 36d1bac..4f3f99a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -848,6 +848,19 @@ static int __init mpic_of_init(struct device_node *node,=
 struct device_node *par
 	for (irq_hw_number_t i =3D 0; i < nr_irqs; i++)
 		writel(i, mpic->base + MPIC_INT_CLEAR_ENABLE);
=20
+	/*
+	 * Initialize mpic->parent_irq before calling any other functions, since
+	 * it is used to distinguish between IPI and non-IPI platforms.
+	 */
+	mpic->parent_irq =3D irq_of_parse_and_map(node, 0);
+
+	/*
+	 * On non-IPI platforms the driver currently supports only the per-CPU
+	 * interrupts (the first 29 interrupts). See mpic_handle_cascade_irq().
+	 */
+	if (!mpic_is_ipi_available(mpic))
+		nr_irqs =3D MPIC_PER_CPU_IRQS_NR;
+
 	mpic->domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, mpic);
 	if (!mpic->domain) {
 		pr_err("%pOF: Unable to add IRQ domain\n", node);
@@ -856,12 +869,6 @@ static int __init mpic_of_init(struct device_node *node,=
 struct device_node *par
=20
 	irq_domain_update_bus_token(mpic->domain, DOMAIN_BUS_WIRED);
=20
-	/*
-	 * Initialize mpic->parent_irq before calling any other functions, since
-	 * it is used to distinguish between IPI and non-IPI platforms.
-	 */
-	mpic->parent_irq =3D irq_of_parse_and_map(node, 0);
-
 	/* Setup for the boot CPU */
 	mpic_perf_init(mpic);
 	mpic_smp_cpu_init(mpic);

