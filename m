Return-Path: <linux-tip-commits+bounces-5746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92422ACDAF1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F56F1885386
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66228BAAA;
	Wed,  4 Jun 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmKVFBJ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N4r51sj9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78574204C2F;
	Wed,  4 Jun 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029054; cv=none; b=u2EoAeUF5oiqPA+Y8ymhbTEzS07eW5H02ayughoH7qd+I8DuxI49LSwlPUWt3lKJ3W4n2chLL4cyI9JDGmJmmrMPZLaHBR9sdwaSmq4ZeCZ3OaN9LGEghvG167wx+J/5ncRtYusIO7ykOBdAo6xPAFlfe2pkoUY6LK7Hl8mODkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029054; c=relaxed/simple;
	bh=3Vt9Ersmy51fQ4UGCzG+5fBUf5HJgTPUKNpIdSpjnHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V8tDHeucIqRfEsFPAl6HM0CDDdBegZW7slZ8hPDaVLlXWVCswRQwu5ybSB4rJKcY0KL7LAgSOndX9xrRz3kq9vtDjMWEO+4LoUoLeMkAPFfIdq1ZxBk0R3A32QUrsX9jn/sxeYGJU/nXSxx07/IdO/geaNoFLI57RhXYGfCufJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmKVFBJ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N4r51sj9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Jun 2025 09:24:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749029050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMYbWrQ6EXrRjZdoFNsi/rJdPmu0zrgE79fu3+vahOY=;
	b=qmKVFBJ++JmXnhLriGTx0+0qfHCH5MKzmyOwPB0ncewRzCgAvsjFXWx1fgSh7MZ/t3tUl2
	JOIOg26EGJ3aIzaHAvdQMumOk+uMZr+gyiUrAiILGl+tGAHnVvAWHGLMo533n9xjiv/APh
	rgWfrOnpu3y4wmnsx7g2EajUg/+5aii459iqjj3ItFGSpUIUMw8rnSrWhM90C8uw9pYUp9
	utBkp8Wcmf0aIUqrvFfVlErVKKW9M98WEGcZ3mtbvhs1ZMPztEf02qLw8GyzE53Ikhe1qp
	8s9Vu2N7N8W/NoaSXKJUIzknrs7okJnT2IoAvDYbzqaHiD5SD+6cenBArS1QHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749029050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMYbWrQ6EXrRjZdoFNsi/rJdPmu0zrgE79fu3+vahOY=;
	b=N4r51sj92GSK9ydR6XP00VmTi7imjiDm9ktSmA432AhB4i3ihEvtXnWwsMwG5CQvU0H9zK
	bDbsicOxO0ymE/Dg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Size device MSI domain with the maximum
 number of vectors
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603141801.915305-1-maz@kernel.org>
References: <20250603141801.915305-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174902904863.406.10681052840126037634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9cc82d99b13c1ad04e3dff9182b7953a8dba10b6
Gitweb:        https://git.kernel.org/tip/9cc82d99b13c1ad04e3dff9182b7953a8dba10b6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 03 Jun 2025 15:18:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Jun 2025 11:19:25 +02:00

PCI/MSI: Size device MSI domain with the maximum number of vectors

Zenghui reports that since 1396e89e09f0 ("genirq/msi: Move prepare() call
to per-device allocation"), his Multi-MSI capable device isn't working
anymore.

This is a consequence of 15c72f824b32 ("PCI/MSI: Add support for per device
MSI[X] domains"), which always creates a MSI domain of size 1, even in the
presence of Multi-MSI.

While this was somehow working until then, moving the .prepare() call ends
up sizing the ITS table with a tiny value for this device, and making the
endpoint driver unhappy.

Instead, always create the domain and call the .prepare() helper with the
maximum expected size.

Fixes: 1396e89e09f0 ("genirq/msi: Move prepare() call to per-device allocation")
Fixes: 15c72f824b32 ("PCI/MSI: Add support for per device MSI[X] domains")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Link: https://lore.kernel.org/all/20250603141801.915305-1-maz@kernel.org
Closes: https://lore.kernel.org/r/0b1d7aec-1eac-a9cd-502a-339e216e08a1@huawei.com
---
 drivers/pci/msi/irqdomain.c | 5 +++--
 drivers/pci/msi/msi.c       | 8 ++++----
 drivers/pci/msi/msi.h       | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index d7ba879..c051527 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -271,6 +271,7 @@ static bool pci_create_device_domain(struct pci_dev *pdev, const struct msi_doma
 /**
  * pci_setup_msi_device_domain - Setup a device MSI interrupt domain
  * @pdev:	The PCI device to create the domain on
+ * @hwsize:	The maximum number of MSI vectors
  *
  * Return:
  *  True when:
@@ -287,7 +288,7 @@ static bool pci_create_device_domain(struct pci_dev *pdev, const struct msi_doma
  *	- The device is removed
  *	- MSI is disabled and a MSI-X domain is created
  */
-bool pci_setup_msi_device_domain(struct pci_dev *pdev)
+bool pci_setup_msi_device_domain(struct pci_dev *pdev, unsigned int hwsize)
 {
 	if (WARN_ON_ONCE(pdev->msix_enabled))
 		return false;
@@ -297,7 +298,7 @@ bool pci_setup_msi_device_domain(struct pci_dev *pdev)
 	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
 		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
 
-	return pci_create_device_domain(pdev, &pci_msi_template, 1);
+	return pci_create_device_domain(pdev, &pci_msi_template, hwsize);
 }
 
 /**
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d6ce040..6ede55a 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -439,16 +439,16 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (nvec < minvec)
 		return -ENOSPC;
 
-	if (nvec > maxvec)
-		nvec = maxvec;
-
 	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
-	if (!pci_setup_msi_device_domain(dev))
+	if (!pci_setup_msi_device_domain(dev, nvec))
 		return -ENODEV;
 
+	if (nvec > maxvec)
+		nvec = maxvec;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index fc70b60..0b420b3 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -107,7 +107,7 @@ enum support_mode {
 };
 
 bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask, enum support_mode mode);
-bool pci_setup_msi_device_domain(struct pci_dev *pdev);
+bool pci_setup_msi_device_domain(struct pci_dev *pdev, unsigned int hwsize);
 bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize);
 
 /* Legacy (!IRQDOMAIN) fallbacks */

