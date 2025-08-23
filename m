Return-Path: <linux-tip-commits+bounces-6326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADCB32BAA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5603F189E073
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4922EB861;
	Sat, 23 Aug 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Chq5KWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HbjBKMa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13A24291C;
	Sat, 23 Aug 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977429; cv=none; b=YPZRpbsLfNJDJ2Q1rxLlTxyKeXZPgegvOT5MihEycUBpHr5qkZz/QK5GSRLohChyLDrj92dGORmGlJtTbb/BAltuuA9icxXfiw8zNFQ93kM+U9KVlZwvlG3nHH3AAxwKoDsV3caAl8KRxmrT2jmAgcbxUPRtEXq7e5fMcJQuIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977429; c=relaxed/simple;
	bh=1TRPMMkcHgRFeGF/P51GJhMX5qv9vYDC7eqPKm9UPhA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DfnyITaxL0Bb4nMO8GaR0sVeuHMGIXWubF7cpuqp8KL5TDiirstV7fXVc4RfydRN36KMM7DiEcuyXyPCgDGPndkD9RAjqKLmvDj0ac+ueZbG4KApqfZdQMgg3sVhoi9Yo9cZUt/86jLNRIqAxMABy4gwP5J2lIh1lDtpZ32s/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Chq5KWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HbjBKMa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 19:30:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R74hhFtOospAF8u7SAmIqnYGAk9ZAfqC9k5jYVKn4zI=;
	b=3Chq5KWdO+u+h0oJBAdRRJNGaRhlgrr74On6oStG2sBy43GrsQzTeKHEF+X2ei7fNkzQ0E
	5mryoL27Y9juo+Ix5p6+NLsuPxAQ/2u79GDDsJlDD6aveCgYSgRQA3L91ruj3Kuw7Fq/GV
	Es5P3oTuSCK4UmcvZ8cEPY9IbDysUWbe3RMSHcmpqM0JY94irmK1lZznG5otfgr7NoJEup
	3uHuYr9+Doy0w64idsGT/FhZugvMTmcstdsAZGACGBhUUJW6M+ru9rQ042HtJT15AJN5PQ
	akj53aOA7c9MohbRge0nplCBdMDCP5LHNbfhtJhNS7Bizp/NFFAckq1b3xwYvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R74hhFtOospAF8u7SAmIqnYGAk9ZAfqC9k5jYVKn4zI=;
	b=3HbjBKMaF0Q2lz6SE5zjbuv90PlA0+2PKpg1T5Uok5DM4KusG0bLjVHgYDvQeFxCgY44dr
	x6sD3YB7VZx3uxCQ==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Fix broken affinity setting
Cc: Han Gao <rabenda.cn@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250813232835.43458-4-inochiama@gmail.com>
References: <20250813232835.43458-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597742319.1420.18175364380253885661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9d8c41816bac518b4824f83b346ae30a1be83f68
Gitweb:        https://git.kernel.org/tip/9d8c41816bac518b4824f83b346ae30a1be=
83f68
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 14 Aug 2025 07:28:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 21:21:13 +02:00

irqchip/sg2042-msi: Fix broken affinity setting

When using NVME on SG2044, the NVME drvier always complains about "I/O tag
XXX (XXX) QID XX timeout, completion polled", which is caused by the broken
affinity setting mechanism of the sg2042-msi driver.

The PLIC driver can only the set the affinity when enabled, but the
sg2042-msi driver invokes the affinity setter in disabled state, which
causes the change to be lost.

Cure this by implementing the irq_startup()/shutdown() callbacks, which
allow to startup (enabled) the underlying PLIC first.

Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt=
 controller")
Reported-by: Han Gao <rabenda.cn@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250813232835.43458-4-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
index bcfddc5..2fd4d94 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -85,6 +85,8 @@ static void sg2042_msi_irq_compose_msi_msg(struct irq_data =
*d, struct msi_msg *m
=20
 static const struct irq_chip sg2042_msi_middle_irq_chip =3D {
 	.name			=3D "SG2042 MSI",
+	.irq_startup		=3D irq_chip_startup_parent,
+	.irq_shutdown		=3D irq_chip_shutdown_parent,
 	.irq_ack		=3D sg2042_msi_irq_ack,
 	.irq_mask		=3D irq_chip_mask_parent,
 	.irq_unmask		=3D irq_chip_unmask_parent,
@@ -114,6 +116,8 @@ static void sg2044_msi_irq_compose_msi_msg(struct irq_dat=
a *d, struct msi_msg *m
=20
 static struct irq_chip sg2044_msi_middle_irq_chip =3D {
 	.name			=3D "SG2044 MSI",
+	.irq_startup		=3D irq_chip_startup_parent,
+	.irq_shutdown		=3D irq_chip_shutdown_parent,
 	.irq_ack		=3D sg2044_msi_irq_ack,
 	.irq_mask		=3D irq_chip_mask_parent,
 	.irq_unmask		=3D irq_chip_unmask_parent,
@@ -185,8 +189,10 @@ static const struct irq_domain_ops sg204x_msi_middle_dom=
ain_ops =3D {
 	.select	=3D msi_lib_irq_domain_select,
 };
=20
-#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
=20
 #define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
=20
@@ -200,10 +206,12 @@ static const struct msi_parent_ops sg2042_msi_parent_op=
s =3D {
 	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
-#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
=20
-#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
 				    MSI_FLAG_PCI_MSIX)
=20
 static const struct msi_parent_ops sg2044_msi_parent_ops =3D {

