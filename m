Return-Path: <linux-tip-commits+bounces-6542-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D8B4FBA4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D0F348409
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8649F33EB12;
	Tue,  9 Sep 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9Ud/8oV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQzE+Jpe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654F33A027;
	Tue,  9 Sep 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422082; cv=none; b=HLJ79Ehj5bH/1Qfc491ULsxxgMYADx3GQCAQaZaH/gMnqbzyWd2yAbR38/t4cPT2T2ldApQzqN+BE0MQNpx9ty8A2pFzpkCK5l0OT9xO2vFi4wfpFFpTwWvRlzdLbq3U9aNp0KUYs+ptX2HoM82L1zr2Pe/v6baUKiFevbSIXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422082; c=relaxed/simple;
	bh=u3drBXy0xF5QtMsfXJpc2suTYN7X9y0M8Qq1psiaq5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dYswessLKETP8m1xATHcde1FQ9qVqjKDf2cfgNfxVnMu2k+j7NvSFxil1gbGb6DVUbb60DC1L2+3oVDlosDODStKflb8rDDNqU+8PmMP7szBmpHBsnxrkEt6Bwxeez6aahzKFYXSfvOa7b912Q9r1ud/UhQE8RQ+BCirg02x1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9Ud/8oV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQzE+Jpe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 12:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757422079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1UXkmFuPW716nPTJSFM0aYJZy132tL7xjGpBQyqUww=;
	b=s9Ud/8oVTLJnYVo/Z9EG7AUe/JLTy1j50iEDXM19KPtlTSy7j4zhaGwOpSQoCh++zrcfhW
	ktNjXUHZI5hTY3armqlxXsykr37BRgJTpRNAlzahjN67qpwlbFc4HHewbab2066eZuQtgb
	ePmfBEo18YWe4iFsuUWhOpr2cCJ3HljLnjB8xEomMLawnvVLtm4ubjWpEBJ82/nhVkw0dS
	4CK38JjCdoexnip1PmjtlaWJonXvDLNHjEPTEY27OVztYAtidr68XG9ZBNGZ3Cl2Sr3gxv
	Y57jz6G0jQ7mgVhHT464thU24IThZmZTKzbxsFco2eXVClBDLpC0V+/SPPYuuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757422079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1UXkmFuPW716nPTJSFM0aYJZy132tL7xjGpBQyqUww=;
	b=oQzE+JpemnYwLbrm/2A+ZrFQvoPF6EecXecTBA+lxG2NKSM5hQ4mtHfC8s8+2G1svjb6JP
	dTiUFJiAvxf/ORCQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/msi-lib: Honor the
 MSI_FLAG_PCI_MSI_MASK_PARENT flag
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903135433.380783272@linutronix.de>
References: <20250903135433.380783272@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175742207769.1920.12315715882414101751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f09c1d63e895e1b45248a75656a41df2e8102874
Gitweb:        https://git.kernel.org/tip/f09c1d63e895e1b45248a75656a41df2e81=
02874
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 16:04:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 14:44:30 +02:00

irqchip/msi-lib: Honor the MSI_FLAG_PCI_MSI_MASK_PARENT flag

For systems that implement interrupt masking at the interrupt controller
level, the MSI library offers MSI_FLAG_PCI_MSI_MASK_PARENT.  It indicates
that it isn't enough to only unmask the interrupt at the PCI device level,
but that the interrupt controller must also be involved.

However, the way this is currently done is less than optimal, as the
masking/unmasking is done on both sides, always. It would be far cheaper to
unmask both at the start of times, and then only deal with the interrupt
controller mask, which is cheaper than a round-trip to the PCI endpoint.

Now that the PCI/MSI layer implements irq_startup() and irq_shutdown()
callbacks, which [un]mask at the PCI level and honor the request to
[un]mask the parent, this can be trivially done.

Overwrite the irq_mask/unmask() callbacks of the device domain interrupt
chip with irq_[un]mask_parent() when the parent domain asks for it.

[ tglx: Adopted to the PCI/MSI changes ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250903135433.380783272@linutronix.de

---
 drivers/irqchip/irq-msi-lib.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 9089440..d5eefc3 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -112,6 +112,20 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struc=
t irq_domain *domain,
 	 */
 	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity =3D msi_domain_set_affinity;
+
+	/*
+	 * If the parent domain insists on being in charge of masking, obey
+	 * blindly. The interrupt is un-masked at the PCI level on startup
+	 * and masked on shutdown to prevent rogue interrupts after the
+	 * driver freed the interrupt. Not masking it at the PCI level
+	 * speeds up operation for disable/enable_irq() as it avoids
+	 * getting all the way out to the PCI device.
+	 */
+	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
+		chip->irq_mask		=3D irq_chip_mask_parent;
+		chip->irq_unmask	=3D irq_chip_unmask_parent;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);

