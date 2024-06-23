Return-Path: <linux-tip-commits+bounces-1489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC5913C5C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B9B20EE0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B9181BBA;
	Sun, 23 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQqWomOv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Z6IuwZ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C7383A2;
	Sun, 23 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156632; cv=none; b=grfrTKlAhWu4yMjjB3jhaaE/jsNti0n7ie7UP6CRG466pad0940vYu7LSsf6y7p/OQ65pHeL+TaSIOC06XvXgRqQaZqVYISYSRwovWiLcRmRZadprMdFR+QmzNwSuwoqqqUtSTFDEAa33ia6PGL8vjslGpzximOZlELiDgwTxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156632; c=relaxed/simple;
	bh=fLaAUdCXl3SPS7buADscQ+/GakcFK4FuWZzPincktaY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oZV144VvH+ybIpiX6SlqkBbYsPLs/fUi8r3N8fJPpDnAj3RzAeK/JD3a2i5fWQBlfTrKER2/GvWj6AOuNt9R0HDLXtJIWIBC48BXQTz2OjumTlCWONuTdy1pcxSEv3vxF7UkxJfnO6YDCslPoLqYFAAV1qAMl39igIjs54iyrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQqWomOv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Z6IuwZ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MBEgOJIV2TUnqAdeE3D2MfTE7hGYI1Ehb4nANujx6OI=;
	b=AQqWomOvEY7BoEDmAltZWmsdbiNmufZL2+2AcmJQIvpyDLggaESCHt0B1rN91bKZyNvBu2
	QKN+5n4+dRYGMVlN9U6bYU3bUJ3CExpSc18551puWzED1aDwnRqbf3gYCmELPWT/VVI0p3
	FlTo+RclAnq3kaoMv5AgO+zDNlt+IFUzm0sBbR5uxXEgh2gySMwyb9gy5pRZhC56wvkFHk
	ISCxTPLOTOcYtJJEXMA6wSG1+WktTzo5Le1a7yfyRyP4TwIWT63JSfQjeS3w8wpEMpCkZw
	/bl/nDUpi6G5QNfnW5Hss+buVVXtn+EES5GhzWoRxzl74mpCg2JMtaJw4KTlZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MBEgOJIV2TUnqAdeE3D2MfTE7hGYI1Ehb4nANujx6OI=;
	b=0Z6IuwZ98TzinplI33EvnkbXbQUKCfDyzIhiVq9bbkOZOtdA7VwfVvm4XISVwKu6CQbb9G
	OCPNk4eXkITTZmAA==
From: tip-bot2 for Pali =?utf-8?q?Roh=C3=A1r?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Do not touch IPI registers on
 platforms without IPI
Cc: pali@kernel.org, kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662859.10875.17816084553826058337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9d80f6bd3ad8f2b49651d4685bb391399ecf80a2
Gitweb:        https://git.kernel.org/tip/9d80f6bd3ad8f2b49651d4685bb391399ec=
f80a2
Author:        Pali Roh=C3=A1r <pali@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:38:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/armada-370-xp: Do not touch IPI registers on platforms without IPI

On platforms where IPI is not available in the MPIC, the IPI registers
instead represent an additional set of MSI interrupt registers (currently
unused by the driver).

Do not touch these registers on platforms where IPI is not available in the
MPIC.

[ Marek: refactored, changed commit message ]

Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/irqchip/irq-armada-370-xp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index deb4c9b..94a81c5 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -502,6 +502,9 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (i =3D 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
=20
+	if (!is_ipi_available())
+		return;
+
 	/* Disable all IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
=20
@@ -752,7 +755,7 @@ static void armada_370_xp_mpic_resume(void)
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
 	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-	if (doorbell_mask_reg & IPI_DOORBELL_MASK)
+	if (is_ipi_available() && (doorbell_mask_reg & IPI_DOORBELL_MASK))
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
@@ -803,13 +806,18 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 	BUG_ON(!armada_370_xp_mpic_domain);
 	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
=20
+	/*
+	 * Initialize parent_irq before calling any other functions, since it is
+	 * used to distinguish between IPI and non-IPI platforms.
+	 */
+	parent_irq =3D irq_of_parse_and_map(node, 0);
+
 	/* Setup for the boot CPU */
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
=20
 	armada_370_xp_msi_init(node, main_int_res.start);
=20
-	parent_irq =3D irq_of_parse_and_map(node, 0);
 	if (parent_irq <=3D 0) {
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);

