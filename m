Return-Path: <linux-tip-commits+bounces-8158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJZZLXZKfWlZRQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:19:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35CBF9A9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A583011C62
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 00:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74D2FFF87;
	Sat, 31 Jan 2026 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bVWp11J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQRZylWR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3E2F1FFA;
	Sat, 31 Jan 2026 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818703; cv=none; b=ZMJympAbStSAmv4q1auZazCuir56iW9g8EpyHlnQVz6b7lu0vJHZZlsZs4FSHHbZ7bAUIwm7pQeov634UutENDZIRywpkANJ3mZa+4j1s6QmRqE4BPuH5mk+Bp1Wvu83Wq0oWnplF2vwD89/6jcjV79hxpj12GbGpEGhXqYyT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818703; c=relaxed/simple;
	bh=TdnnrpUsE2qCps/A60bJOim+yvbNG53ePlSYjVK8/ck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pw9R5PCQWkUGqDRLaeFj5fQ809nDqKLkASHdQxyWA7PwXWZPlYyzO+40cD+xZE/7n28fBWj6FoQ33OM0uaSIq4HuoM+lU/mRv/wbCd61vffV/4I+igJiw3PxZX6Srr8Jo3jRD50hde54Ik+OxA8VT4JFTIZZKiHP7wFIoY3vKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bVWp11J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQRZylWR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 00:18:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769818699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqroe+eg2+UxmzDI511NAX/fQ+S6IrAZAv0msM+4xzA=;
	b=0bVWp11Jq28bAZF2zwBa1Pa08ZjkXfT/W6DJUijMd3y9Sh/SXmY1yJHM2nfeRNZ9JWUbhU
	wer0Hu2RNu8RwCVMPygnyBjKGLNJIu8ztr7t+auyaUcJFUl72PBoxTY1hmYX5jgX1l/MT/
	3mquZjSt3/Y92LEoqwfTV1Mcxwl7E8FAUYZ2n7bbhSthstKzJmq0CwiWR8006yXR3fOhjz
	Vh2wo2HfH/y3TjEFX+OOP1zrmE4r1zkurImcvU+1D+nO5mwNUoPXBpnTSbqhmYCLdJQ83m
	jTJFtF5Hx59GKPra90deNXx8GCsDZC2sDYB9jM10RSsvQpORt9rlXbYn/fSx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769818699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqroe+eg2+UxmzDI511NAX/fQ+S6IrAZAv0msM+4xzA=;
	b=WQRZylWRLumtMrJsGnSagG9dvUiV78YnXRTDnyR1XfLV1mUGvFfnaQ8C1jp+dC7VUzrKVm
	Zj4y4EHoZOcpx2Dw==
From: "tip-bot2 for Vivian Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Convert the boolean no_64bit_msi flag to a
 DMA address mask
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 Brett Creeley <brett.creeley@amd.com>, Takashi Iwai <tiwai@suse.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260129-pci-msi-addr-mask-v4-1-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-1-70da998f2750@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981869796.2495410.17885428091191620081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8158-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,amd.com:email,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 4A35CBF9A9
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     386ced19e9a348e8131d20f009e692fa8fcc4568
Gitweb:        https://git.kernel.org/tip/386ced19e9a348e8131d20f009e692fa8fc=
c4568
Author:        Vivian Wang <wangruikang@iscas.ac.cn>
AuthorDate:    Thu, 29 Jan 2026 09:56:06 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 31 Jan 2026 01:11:48 +01:00

PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask

Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
implement less than 64 address bits. This breaks on platforms where such
a device is assigned an MSI address higher than what's supported.

Currently, no_64bit_msi bit is set for these devices, meaning that only
32-bit MSI addresses are allowed for them. However, on some platforms the
MSI doorbell address is above the 32-bit limit but within the addressable
range of the device.

As a first step to enable MSI on those combinations of devices and
platforms, convert the boolean no_64bit_msi flag to a DMA mask and fixup
the affected usage sites:

  - no_64bit_msi =3D 1    ->    msi_addr_mask =3D DMA_BIT_MASK(32)
  - no_64bit_msi =3D 0    ->    msi_addr_mask =3D DMA_BIT_MASK(64)
  - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))

Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) are used,
this is functionally equivalent.

This prepares for changing the binary decision between 32 and 64 bit to a
DMA mask based decision which allows to support systems which have a DMA
address space less than 64bit but a MSI doorbell address above the 32-bit
limit.

[ tglx: Massaged changelog ]

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Brett Creeley <brett.creeley@amd.com> # ionic
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Takashi Iwai <tiwai@suse.de> # sound
Link: https://patch.msgid.link/20260129-pci-msi-addr-mask-v4-1-70da998f2750@i=
scas.ac.cn
---
 arch/powerpc/platforms/powernv/pci-ioda.c           | 2 +-
 arch/powerpc/platforms/pseries/msi.c                | 4 ++--
 drivers/gpu/drm/radeon/radeon_irq_kms.c             | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
 drivers/pci/msi/msi.c                               | 2 +-
 drivers/pci/msi/pcidev_msi.c                        | 2 +-
 drivers/pci/probe.c                                 | 7 +++++++
 include/linux/pci.h                                 | 8 +++++++-
 sound/hda/controllers/intel.c                       | 2 +-
 9 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platfor=
ms/powernv/pci-ioda.c
index b0c1d9d..1c78fdf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1666,7 +1666,7 @@ static int __pnv_pci_ioda_msi_setup(struct pnv_phb *phb=
, struct pci_dev *dev,
 		return -ENXIO;
=20
 	/* Force 32-bit MSI on some broken devices */
-	if (dev->no_64bit_msi)
+	if (dev->msi_addr_mask < DMA_BIT_MASK(64))
 		is_64 =3D 0;
=20
 	/* Assign XIVE to PE */
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/ps=
eries/msi.c
index a82aaa7..7473c7c 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -383,7 +383,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, in=
t nvec_in, int type,
 	 */
 again:
 	if (type =3D=3D PCI_CAP_ID_MSI) {
-		if (pdev->no_64bit_msi) {
+		if (pdev->msi_addr_mask < DMA_BIT_MASK(64)) {
 			rc =3D rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
 			if (rc < 0) {
 				/*
@@ -409,7 +409,7 @@ again:
 		if (use_32bit_msi_hack && rc > 0)
 			rtas_hack_32bit_msi_gen2(pdev);
 	} else {
-		if (pdev->no_64bit_msi)
+		if (pdev->msi_addr_mask < DMA_BIT_MASK(64))
 			rc =3D rtas_change_msi(pdn, RTAS_CHANGE_32MSIX_FN, nvec);
 		else
 			rc =3D rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon=
/radeon_irq_kms.c
index 9961251..d550554 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -252,7 +252,7 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	 */
 	if (rdev->family < CHIP_BONAIRE) {
 		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
-		rdev->pdev->no_64bit_msi =3D 1;
+		rdev->pdev->msi_addr_mask =3D DMA_BIT_MASK(32);
 	}
=20
 	/* force MSI on */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/ne=
t/ethernet/pensando/ionic/ionic_bus_pci.c
index 70d86c5..0671dea 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -331,7 +331,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct=
 pci_device_id *ent)
=20
 #ifdef CONFIG_PPC64
 	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
-	pdev->no_64bit_msi =3D 1;
+	pdev->msi_addr_mask =3D DMA_BIT_MASK(32);
 #endif
=20
 	err =3D ionic_setup_one(ionic);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index e010ecd..fb9a42b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -322,7 +322,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
=20
-	if (!dev->no_64bit_msi)
+	if (dev->msi_addr_mask =3D=3D DMA_BIT_MASK(64))
 		return 0;
=20
 	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
index 5520aff..0b03468 100644
--- a/drivers/pci/msi/pcidev_msi.c
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -24,7 +24,7 @@ void pci_msi_init(struct pci_dev *dev)
 	}
=20
 	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
-		dev->no_64bit_msi =3D 1;
+		dev->msi_addr_mask =3D DMA_BIT_MASK(32);
 }
=20
 void pci_msix_init(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183ae..a2bff57 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2047,6 +2047,13 @@ int pci_setup_device(struct pci_dev *dev)
 	 */
 	dev->dma_mask =3D 0xffffffff;
=20
+	/*
+	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
+	 * if MSI (rather than MSI-X) capability does not have
+	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
+	 */
+	dev->msi_addr_mask =3D DMA_BIT_MASK(64);
+
 	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8647756..0fe32fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -377,6 +377,13 @@ struct pci_dev {
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
+	u64		msi_addr_mask;	/* Mask of the bits of bus address for
+					   MSI that this device implements.
+					   Normally set based on device
+					   capabilities. You only need to
+					   change this if your device claims
+					   to support 64-bit MSI but implements
+					   fewer than 64 address bits. */
=20
 	struct device_dma_parameters dma_parms;
=20
@@ -441,7 +448,6 @@ struct pci_dev {
=20
 	unsigned int	is_busmaster:1;		/* Is busmaster */
 	unsigned int	no_msi:1;		/* May not use MSI */
-	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
 	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1e8e3d6..c9542eb 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1905,7 +1905,7 @@ static int azx_first_init(struct azx *chip)
=20
 	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
 		dev_dbg(card->dev, "Disabling 64bit MSI\n");
-		pci->no_64bit_msi =3D true;
+		pci->msi_addr_mask =3D DMA_BIT_MASK(32);
 	}
=20
 	pci_set_master(pci);

