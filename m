Return-Path: <linux-tip-commits+bounces-1831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512E9410CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2D2842BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8419B3F9;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wg1tHnB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h+X3Ak8W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921019EEDB;
	Tue, 30 Jul 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=QiQYlnb+foKhaGBcRaYLY0qfWjy3gjV2tsjagHE6ds9tjd9YhGIX2AOKmytLBNQ+CJFNjaNsDGZHj35BZdD1vKzO4mBnrrTtXPNp7uSNnKuWS/G97XXN3LQtloXgbRYm5rg1q+Xp5Lqyni5izLXV3yEAIjRpOx2HRdzdXlx0rRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=rXKh3OsXn8MRgtL48i63tRJvExsx67LXQhCc7K77PWE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MjlBAY7JYYB+YX4KUDg6ZoR/y+veTZcWkMKx3rmAl3x9qTwzTBAynbbEQK5YYGtI/3yZeuZGcUvo/Yh52kFmuViC0Hbtni9SjigFYz0lutdOLix48EzIhkgPIKW1kOaJV2G3tinSfkeEq1wXg9x1rsNkH9Ki7b5HVfaWJfBLZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wg1tHnB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h+X3Ak8W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGyI6Fft7bYsZPUi5ImrylPfFn2P99gXEehSpLhUVWU=;
	b=wg1tHnB+VpqkZBJiQrF66+hRd9DWaxzqqIl8uq4F7mSDPyg/UHB1Ral2yWkChCr1A2AP/N
	mfMao6THevvcdaeIMGRvvbzsZ/SbeVkZuS4iybWH+QwZcvp5XJwUzaQmpi8A8DIfIYYYEF
	wFGsSMsGpLiBSRiLpNs6BJ612TNuglqZibVusCuRm1YpuxbOu/zPESiIZR+SpMCGDkW+vk
	FFT88txxXLxKEcGRk1ZDsvgxL8vAlYP2B5yufkt3Q/e6XS/UHBYepdQnoLSqISUMSlf/vc
	dzhkEQZnS7s+1vT+0n0q66PfQ8vygQBLHE4cUqrMuw4Rw3wxKR+0YT80lvOTmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGyI6Fft7bYsZPUi5ImrylPfFn2P99gXEehSpLhUVWU=;
	b=h+X3Ak8WS+qjM5gVoM9VyUNyclmTnRbg2vvbHJ2gWtwu3yefK8lv4M5CIH2hJc9PcFDQWT
	eQQnpKu582k/3tCA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use FIELD_GET() and named
 register constant
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-9-kabel@kernel.org>
References: <20240711115748.30268-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960026.2215.590233129926121824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     92128c74e41868e42e6944f83d9d2130c9aa8a22
Gitweb:        https://git.kernel.org/tip/92128c74e41868e42e6944f83d9d2130c9a=
a8a22
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

irqchip/armada-370-xp: Use FIELD_GET() and named register constant

Use FIELD_GET() and named register mask constant when reading the number
of supported interrupts / current interrupt.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-9-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index e43eb26..179a30a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -10,6 +10,7 @@
  * Ben Dooks <ben.dooks@codethink.co.uk>
  */
=20
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -112,6 +113,7 @@
=20
 /* Registers relative to main_int_base */
 #define MPIC_INT_CONTROL			0x00
+#define MPIC_INT_CONTROL_NUMINT_MASK		GENMASK(12, 2)
 #define MPIC_SW_TRIG_INT			0x04
 #define MPIC_INT_SET_ENABLE			0x30
 #define MPIC_INT_CLEAR_ENABLE			0x34
@@ -124,6 +126,7 @@
 #define MPIC_IN_DRBEL_MASK			0x0c
 #define MPIC_PPI_CAUSE				0x10
 #define MPIC_CPU_INTACK				0x44
+#define MPIC_CPU_INTACK_IID_MASK		GENMASK(9, 0)
 #define MPIC_INT_SET_MASK			0x48
 #define MPIC_INT_CLEAR_MASK			0x4C
 #define MPIC_INT_FABRIC_MASK			0x54
@@ -660,7 +663,7 @@ static void __exception_irq_entry mpic_handle_irq(struct =
pt_regs *regs)
=20
 	do {
 		irqstat =3D readl_relaxed(per_cpu_int_base + MPIC_CPU_INTACK);
-		irqnr =3D irqstat & 0x3FF;
+		irqnr =3D FIELD_GET(MPIC_CPU_INTACK_IID_MASK, irqstat);
=20
 		if (irqnr > 1022)
 			break;
@@ -759,8 +762,7 @@ static int __init mpic_of_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
-	int nr_irqs;
-	u32 control;
+	unsigned int nr_irqs;
=20
 	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
 	BUG_ON(of_address_to_resource(node, 1, &per_cpu_int_res));
@@ -780,8 +782,7 @@ static int __init mpic_of_init(struct device_node *node,
 				   resource_size(&per_cpu_int_res));
 	BUG_ON(!per_cpu_int_base);
=20
-	control =3D readl(main_int_base + MPIC_INT_CONTROL);
-	nr_irqs =3D (control >> 2) & 0x3ff;
+	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(main_int_base + M=
PIC_INT_CONTROL));
=20
 	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);

