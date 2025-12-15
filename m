Return-Path: <linux-tip-commits+bounces-7713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F6CBFF3D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13EE3010A9E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E02DF14B;
	Mon, 15 Dec 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DFk22yOP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qnoSzqu8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699E13C3F2;
	Mon, 15 Dec 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834489; cv=none; b=tddz+hNR5FK8FB08pln1w6FHErvERGVw9K443mSSIJLs/w//fUGYXHRoluLfRcxwQa88mImdCdll3FyK7y4Ha1zBN/sz8JxWIaeryZ1B4YH3WUGAOSWY5CITZSaax1YYV+hLx7Ge+QILR0YD7E0DVlQT6BWEqw7NV2bSue5hLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834489; c=relaxed/simple;
	bh=rwbbd6JOb53k++oE4TpDdR+o4gUKPYrYcvTG3lWuo68=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=urj6/f3ZKVk10bkPRRVCa/z9yjAQa8BFKtckpQRdXIl+XHZCsdQjGR8XTwFTqSlN20hcRoTE26fz1QlfTCHU8Yr6HNCTWAgjogZ/evfrRTn7VbGbfpk3QrJvS5c1Zfxm/TdNQtfnM8Kj4GP17YcK0wSsKjnInLdvYKkS8x9F+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DFk22yOP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qnoSzqu8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMlFs7V1nJE2QC5rHb7UG6+7dwxRcm4Q5/BMhNRodH4=;
	b=DFk22yOPXCK2lmVIBMogR9dkFLl+84zloE4rgLxfukWFjUpM7vMra8TUelUUegza+HaZOX
	FhU0A6x1wpVYwyv5ztz9etvMkBRz3wyy2k0qhx+NOUTt8SaI66d6I7YVwjl5kmZKUUiZPU
	LbqNkaV1MNG0RZl+1WLaZ0sO2pW5bQQzhYTqOoJ6s5g7DNhGZwQwu9CDaK0879U6TWSSL0
	HcrwWjUCMm8YXNSIRtQBRLfyiDKaIjq02JeQ5lLdlQEFzgqS+nADw4dmEeLsrpp7fNJ0i0
	aui+DBNjDAanGWO1O7TuZ8OXRzhif2UtFiZBdaS/v9/GdAcUoCF+W0VU+0GjzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMlFs7V1nJE2QC5rHb7UG6+7dwxRcm4Q5/BMhNRodH4=;
	b=qnoSzqu8/M1HSC3UScjRIK5VVXkwXzOcGhHyfdJ3w1jimAKPZtiKQdjqqYbPE86rb1oZGX
	8w3h9F79vr67SWBw==
From: "tip-bot2 for Radu Rendec" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: dwc: Enable MSI affinity support
Cc: Thomas Gleixner <tglx@linutronix.de>, Radu Rendec <rrendec@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251128212055.1409093-4-rrendec@redhat.com>
References: <20251128212055.1409093-4-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583448396.510.10427292538118156779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     eaf290c404f7c39f23292e9ce83b8b5b51ab598a
Gitweb:        https://git.kernel.org/tip/eaf290c404f7c39f23292e9ce83b8b5b51a=
b598a
Author:        Radu Rendec <rrendec@redhat.com>
AuthorDate:    Fri, 28 Nov 2025 16:20:55 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00

PCI: dwc: Enable MSI affinity support

Leverage the interrupt redirection infrastructure to enable CPU affinity
support for MSI interrupts. Since the parent interrupt affinity cannot
be changed, affinity control for the child interrupt (MSI) is achieved
by redirecting the handler to run in IRQ work context on the target CPU.

This patch was originally prepared by Thomas Gleixner (see Link tag below)
in a patch series that was never submitted as is, and only parts of that
series have made it upstream so far.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Link: https://patch.msgid.link/20251128212055.1409093-4-rrendec@redhat.com
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 33 +++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/=
controller/dwc/pcie-designware-host.c
index 25ad1ae..f116591 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -26,9 +26,27 @@ static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
=20
+#ifdef CONFIG_SMP
+static void dw_irq_noop(struct irq_data *d) { }
+#endif
+
+static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain =
*domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+#ifdef CONFIG_SMP
+	info->chip->irq_ack =3D dw_irq_noop;
+	info->chip->irq_pre_redirect =3D irq_chip_pre_redirect_parent;
+#else
+	info->chip->irq_ack =3D irq_chip_ack_parent;
+#endif
+	return true;
+}
+
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
 				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
-				    MSI_FLAG_NO_AFFINITY		| \
 				    MSI_FLAG_PCI_MSI_MASK_PARENT)
 #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
 				     MSI_FLAG_PCI_MSIX			| \
@@ -40,9 +58,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops =
=3D {
 	.required_flags		=3D DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	=3D DW_PCIE_MSI_FLAGS_SUPPORTED,
 	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
-	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
 	.prefix			=3D "DW-",
-	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	=3D dw_pcie_init_dev_msi_info,
 };
=20
 /* MSI int handler */
@@ -63,7 +80,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			continue;
=20
 		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
-			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
+			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
=20
@@ -140,10 +157,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
=20
 static struct irq_chip dw_pci_msi_bottom_irq_chip =3D {
 	.name			=3D "DWPCI-MSI",
-	.irq_ack		=3D dw_pci_bottom_ack,
 	.irq_compose_msi_msg	=3D dw_pci_setup_msi_msg,
 	.irq_mask		=3D dw_pci_bottom_mask,
 	.irq_unmask		=3D dw_pci_bottom_unmask,
+#ifdef CONFIG_SMP
+	.irq_ack		=3D dw_irq_noop,
+	.irq_pre_redirect	=3D dw_pci_bottom_ack,
+	.irq_set_affinity	=3D irq_chip_redirect_set_affinity,
+#else
+	.irq_ack		=3D dw_pci_bottom_ack,
+#endif
 };
=20
 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int =
virq,

