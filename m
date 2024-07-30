Return-Path: <linux-tip-commits+bounces-1829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB99410CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE791C236E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4F1A00E0;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AwTOpDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxvcxVW9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5019EED2;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=c3hhUN7MsIYiZrfKdfaKWgHzGApRGoltrLcYoirUPlCmR4WmHyt5Ol2E/09OHLpV5lYePVkpr05MQWKd5Kjs7+vycSuoXuWWpvCl52lAvkeXYaAjKOVbs1jEQsDY8GmFFsH9rkwJngfITsU2K79z49VWF0hjZXFzuIY//Tn5dMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=3TyYc/VmgryJgMpoQ30xPZWVq3JRjNxDSPru3N8mJo0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b/nyqLoXhTVDJsJOAJ4bfejFWZuAWWxWFzWiTupFQOH3r93QePiBf9AX2c6xPkTiACTFRGomFE5/Y2/BHzQR1U5SqLGMFqX6YkWICqHX8K7WuWey/ADxX6MYVamfKkMAY1JllrQEmI33qkxQs4McYf8mB5SrWQH5dOFVlaI6e+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AwTOpDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxvcxVW9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhRbaYokP3dAS29ZI0jVVuj0EjFedIndTxJlVew/4YA=;
	b=0AwTOpDDkyMDbP4YIQqgC73L1O61ELVwXGDFMkB7Zx+Ky+lRSx2YI+QH+Sb5OGm3kM3RBQ
	1mFyc3bY2ZACtu2aOXpMcCO6zf1AULfYrDf9GWJ0rtebaMLxy6DNiXpoMik2cfOJzB/KLK
	vvslL04Gq2ggCd6eE+5E2EKeHHawza+xZ+qt0RtnjQDeptLQFC/lDwbiFoGzbgu3hzBpAM
	dQn3CJFylxoZ804j1qK1wg9eEgRR+Ijyx6rvLHuz+CbTEPqQwJVNrGOv3j6MEOG3QsQsNz
	oc8qxJMK6hGgrexR/OjWtkVjsO1i+rfaBnuDZjkYa+sTgqFK+RFIOV2BwNxBOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhRbaYokP3dAS29ZI0jVVuj0EjFedIndTxJlVew/4YA=;
	b=IxvcxVW94qAGZ0aSwo/RpNIIRoWtWep6kgTzHC9lEFbVThTD3EMwQGXwVlJNPNo/zyZy22
	WjQdJNZBXknofpDg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Refactor handling IPI interrupts
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-11-kabel@kernel.org>
References: <20240711115748.30268-11-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959981.2215.4046444408891846790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     baf01c726b7f99b72f2abfa54e249d766cbd59a5
Gitweb:        https://git.kernel.org/tip/baf01c726b7f99b72f2abfa54e249d766cb=
d59a5
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

irqchip/armada-370-xp: Refactor handling IPI interrupts

Refactor the handling of IPI interrupts
- put into own function mpic_handle_ipi_irq(), similar to
  mpic_handle_msi_irq()
- rename the variable holding the doorbell cause register to "cause"
- retype and rename the variable holding the IPI HW IRQ number to
  "irq_hw_number_t i"

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-11-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 30 ++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 5c2631f..d42c7a1 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -619,6 +619,22 @@ static void mpic_handle_msi_irq(void)
 static void mpic_handle_msi_irq(void) {}
 #endif
=20
+#ifdef CONFIG_SMP
+static void mpic_handle_ipi_irq(void)
+{
+	unsigned long cause;
+	irq_hw_number_t i;
+
+	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	cause &=3D IPI_DOORBELL_MASK;
+
+	for_each_set_bit(i, &cause, IPI_DOORBELL_END)
+		generic_handle_domain_irq(mpic_ipi_domain, i);
+}
+#else
+static inline void mpic_handle_ipi_irq(void) {}
+#endif
+
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
@@ -669,19 +685,9 @@ static void __exception_irq_entry mpic_handle_irq(struct=
 pt_regs *regs)
 		if (irqnr =3D=3D 1)
 			mpic_handle_msi_irq();
=20
-#ifdef CONFIG_SMP
 		/* IPI Handling */
-		if (irqnr =3D=3D 0) {
-			unsigned long ipimask;
-			int ipi;
-
-			ipimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE) &
-				  IPI_DOORBELL_MASK;
-
-			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				generic_handle_domain_irq(mpic_ipi_domain, ipi);
-		}
-#endif
+		if (irqnr =3D=3D 0)
+			mpic_handle_ipi_irq();
 	} while (1);
 }
=20

