Return-Path: <linux-tip-commits+bounces-1842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC39410E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A521C228B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E31A08D6;
	Tue, 30 Jul 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7obmZOi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/fKtmH4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101031A01CB;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339609; cv=none; b=AghAKhrOotbw4K7u/+ZB41UiV/4+tsMwWGC70nHuAXhOJAduf9YKh11sM3uQ5fEr3J/0WC5FieVZm9IhQ29CcHfhVGWE1myc9sNghvaQCUVAHpLo/rfsO250Ifb/1PdzeHH3W9rxK5NT7m/ts8wOuU0ouCnrh7NbMxi9zuisxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339609; c=relaxed/simple;
	bh=4efhS8FSGbKC5BFVHxQ0JTNF0Mrs2s8h/fDdqZmQhdM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uOHKEYWv34HZ0JDlRyyCMaKGAiFPsOR0WdCs0I8VAC+GfkMJIpYuelvZ8RItYXYihqdgcbotdHlgvGhrYhZy57Nb90sFi4PZBK4WSIIXzVMjuyYVz+TwIMn6qWo/meme6DrwKat22V3IV0hHkNaYXkFpDPanP2lzn/apwKdELDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r7obmZOi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/fKtmH4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cef72GegCIF0x3/Brad9tW2aj91QLklxV7i3i/1PAMs=;
	b=r7obmZOibrQ/YT8XyfHlKqkgI45EDmcKt0+TvmeLLeMyMTNhG0AJc0ktg8s4ydSlDmhBUc
	/m8wrxEJafWNo8dfy92SvzcDafzfaULnms+lnyUGGUHl1Y/Ppv2JpUKQkXZN4hfW/3eo6x
	bwpxoY1qDjoVt7ZLUa0+Vjd0n0fky7IVOJPJgnJvpv1SXoVCW87Dsih+JjVRvUMIneOVLN
	0p0TRezeBcjvUopGF1oZwsEu+C+CDEMTBuOABUifsbeM6yPaZKr3ZKxyhACloXFQDGjqR0
	FaJWfQ9LG0f4K5xhn4RLSD7aA5IHfaFLsvM+LBs/r9Rvx8TtxZ2rtix2Uo9zFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cef72GegCIF0x3/Brad9tW2aj91QLklxV7i3i/1PAMs=;
	b=n/fKtmH4/efc1/uJKQzmg9OWUHeQnCwyKU41A1fpsbks4QA/+belA6AwghIstomqQj+2P9
	slsbjY0+MzxOBcBg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Cosmetic fix parentheses in
 register constant definitions
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-6-kabel@kernel.org>
References: <20240708151801.11592-6-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960369.2215.2433149646489505304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9236717b97e3f5f0a5c77e40a85b8355b6025311
Gitweb:        https://git.kernel.org/tip/9236717b97e3f5f0a5c77e40a85b8355b60=
25311
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Cosmetic fix parentheses in register constant definiti=
ons

Drop parentheses where not needed and add them where it makes sense in
register constant definitions.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-6-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 18aca9b..14d213e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -116,33 +116,33 @@
  */
=20
 /* Registers relative to main_int_base */
-#define ARMADA_370_XP_INT_CONTROL		(0x00)
-#define ARMADA_370_XP_SW_TRIG_INT		(0x04)
-#define ARMADA_370_XP_INT_SET_ENABLE		(0x30)
-#define ARMADA_370_XP_INT_CLEAR_ENABLE		(0x34)
-#define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
+#define ARMADA_370_XP_INT_CONTROL		0x00
+#define ARMADA_370_XP_SW_TRIG_INT		0x04
+#define ARMADA_370_XP_INT_SET_ENABLE		0x30
+#define ARMADA_370_XP_INT_CLEAR_ENABLE		0x34
+#define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + (irq) * 4)
 #define ARMADA_370_XP_INT_SOURCE_CPU_MASK	GENMASK(3, 0)
-#define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
+#define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << (cpuid))
=20
 /* Registers relative to per_cpu_int_base */
-#define ARMADA_370_XP_IN_DRBEL_CAUSE		(0x08)
-#define ARMADA_370_XP_IN_DRBEL_MASK		(0x0c)
-#define ARMADA_375_PPI_CAUSE			(0x10)
-#define ARMADA_370_XP_CPU_INTACK		(0x44)
-#define ARMADA_370_XP_INT_SET_MASK		(0x48)
-#define ARMADA_370_XP_INT_CLEAR_MASK		(0x4C)
-#define ARMADA_370_XP_INT_FABRIC_MASK		(0x54)
+#define ARMADA_370_XP_IN_DRBEL_CAUSE		0x08
+#define ARMADA_370_XP_IN_DRBEL_MASK		0x0c
+#define ARMADA_375_PPI_CAUSE			0x10
+#define ARMADA_370_XP_CPU_INTACK		0x44
+#define ARMADA_370_XP_INT_SET_MASK		0x48
+#define ARMADA_370_XP_INT_CLEAR_MASK		0x4C
+#define ARMADA_370_XP_INT_FABRIC_MASK		0x54
 #define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	BIT(cpu)
=20
-#define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
+#define ARMADA_370_XP_MAX_PER_CPU_IRQS		28
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
-#define IPI_DOORBELL_START			(0)
-#define IPI_DOORBELL_END			(8)
+#define IPI_DOORBELL_START			0
+#define IPI_DOORBELL_END			8
 #define IPI_DOORBELL_MASK			GENMASK(7, 0)
-#define PCI_MSI_DOORBELL_START			(16)
-#define PCI_MSI_DOORBELL_NR			(16)
-#define PCI_MSI_DOORBELL_END			(32)
+#define PCI_MSI_DOORBELL_START			16
+#define PCI_MSI_DOORBELL_NR			16
+#define PCI_MSI_DOORBELL_END			32
 #define PCI_MSI_DOORBELL_MASK			GENMASK(31, 16)
=20
 /* MSI interrupt definitions for non-IPI platforms */

