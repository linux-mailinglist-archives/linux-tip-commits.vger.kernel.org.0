Return-Path: <linux-tip-commits+bounces-1779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC593F1BB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC28283260
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268A146A79;
	Mon, 29 Jul 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocwqtQ5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hrus2r5n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A4145359;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246593; cv=none; b=tYOKjGr8acENMlB0qPVDcXH8M0wNpYE0726mKVvFU6q8ZvUZFiP9NtLevngijVqu/hucTcXPQVT/ouhHK83jGQ2+0zs+QYLxDv1prnY1FBrk/ZszWg5SqLGHD/R2e+stn6gXI0BnEUVTRgL6VD+gqsYtLl9MzdHjALoA/9QsxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246593; c=relaxed/simple;
	bh=9Q+E1pt0m8BVBeOsStQQp/FpI66AORirJYhBwQ61v28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bKmldqm6hQpSoXGWw//ecSXWsI3V+ryuZ33xy+9FkNkfLFGAbxP06gyhKqfnNsRmFOKdWuTHb25tAEMkCzhag6xSzBt3W3dZsDoEcPPPW/4rmVJvQxnlSyhHPH/WhdnyILz9U5StyGEEzKUBE+ptmTksZhGLQtXnJXl6GQ5sxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocwqtQ5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hrus2r5n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJSCspDsxSqqI4X72qhFsZ1AlQLhsZorEOPKVGfO6HQ=;
	b=ocwqtQ5UuRAyvUK2nJEUkwx56/Ao16F0fipmNiSDZCaV9nwSl2clQkub3DArKqCdWu5apd
	yMyNbGQEA3hYrf9hzxmHCMhDWVe5ORKWvRXfU/xQ9pMEGdFAhNabFQaWGzcsTXnxVC05oS
	DHcGqsEytB/XYDQQu9tNxxMCm7VqiDmpVlMLah2LbQFaC8P9b7w8B1TSEhLLyCLQLKH5I8
	c15L8ySill01aNYbvL5PbArakcnHdtMda34mV7h5gDUMs2TyC0SsruvtjAYx9EfXJ9fSyC
	YMSOTk+++ltGagwyir/g2rs+7RUAXk0Yx6fHslz+UZj4vwQ94se20HuDVcHkUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJSCspDsxSqqI4X72qhFsZ1AlQLhsZorEOPKVGfO6HQ=;
	b=Hrus2r5nDjtfZqIJLO2gdkWPWzt/XdoMeXTdQ7vHUgX6Ne2k9Jk9EH7n4esai00Q+mUogK
	ovL3KEm6dNxzVwDA==
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
Message-ID: <172224658679.2215.8615544729658438621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8333f149fdbe8fbd2b25197b3979b3c393dec855
Gitweb:        https://git.kernel.org/tip/8333f149fdbe8fbd2b25197b3979b3c393d=
ec855
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

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

