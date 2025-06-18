Return-Path: <linux-tip-commits+bounces-5868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB6ADF68E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DD0188C066
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175922F5493;
	Wed, 18 Jun 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDjsx6jh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXITTsBs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE63085C7;
	Wed, 18 Jun 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273063; cv=none; b=rd089zDqSAeG3iA6MrILN4xVc+doPTSoSPKkxHE0csZboauDVKQLwO9DXKNQqRXBJg4B9Of+gNWln7LFMbpf7eWdApdaufMtUTB6Ef4ULmSbsAXg804vwP04Dvh0hs7nN+GMp2+yXqRcUwdKjtG78HtZfNO+k89niSNmu9lnFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273063; c=relaxed/simple;
	bh=N367C3NSyuYpiAnA0ejNpbLNZMUkvZFZQstaYqW+p2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P3K2w/ouv3wqLopNLu3Gh+bPI//2efb/3GQtApn/bx8joqVcmghzy+pWqHaxu6nSCmg3cLXF0+6R58KGsBFwPSR3kNdf8BHDEpDWYVt/RB0uaYdAwnkUQCAtotEv5Iyn36/XC0a0/OZbv9kPMrCPjawY3NV5T9LT3sEzJ9Ka+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lDjsx6jh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXITTsBs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 18:57:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750273059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTRx/vVMZ26Qml2HVIkFo2aTTcCycCrwn1A715lThMM=;
	b=lDjsx6jhWVfmiHcjpv75xdhVVbwQA8+Lai5KEg8X2kmSrlLedvOahkxNlPdofQo7HG8wer
	gcGNuXR5bGFGXxlsVHydI58PuB9BZjJwQW5+9V3Z5XtdAeQcH4grjvaTrz0FzAK4smheBu
	lGSMVX8bL28Syhff6RPMOhv1Y+zdwS5i3NkJtwljZl4J2uCSsT9gfnlg+NWngtdqNBq00N
	JWJGd3UlYGNukeSE7si3af275vhgkEC0RPWg40Q1jyHS9uAB9/bB/cjFB82UcurY3O9/kY
	cid7015f1tupgTN5MmO2e+HptcGeJ+bpxcjuUoEeP9Y9s6cZ7YNjH317Dlxzqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750273059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTRx/vVMZ26Qml2HVIkFo2aTTcCycCrwn1A715lThMM=;
	b=sXITTsBsMfHv/ITN1dTbl0D06ETjpY1m2kNVcH+04Y70Lzek/4rO3lLJdqDriT9wWzApMN
	MpmvQ+m4SMDZTHAg==
From: "tip-bot2 for Chris Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Remove duplicated to_pci_dev() conversion
Cc: Chris Li <chrisl@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75b0419023@kernel.org>
References: <20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75b0419023@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175027305832.406.5307204713998818037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     4a089c0b3f55b400689a5c35f7dfa0a74c363dae
Gitweb:        https://git.kernel.org/tip/4a089c0b3f55b400689a5c35f7dfa0a74c3=
63dae
Author:        Chris Li <chrisl@kernel.org>
AuthorDate:    Tue, 17 Jun 2025 16:57:30 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 18 Jun 2025 20:50:04 +02:00

PCI/MSI: Remove duplicated to_pci_dev() conversion

In pci_msi_update_mask(), "lock =3D &to_pci_dev()" does the to_pci_dev()
lookup, and there's another one buried inside msi_desc_to_pci_dev().

Introduce a local variable to remove that duplication.

Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75=
b0419023@kernel.org

---
 drivers/pci/msi/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a..78bed2d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
=20
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
+	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
+	raw_spinlock_t *lock =3D &dev->msi_lock;
 	unsigned long flags;
=20
 	if (!desc->pci.msi_attrib.can_mask)
@@ -122,8 +123,7 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear=
, u32 set)
 	raw_spin_lock_irqsave(lock, flags);
 	desc->pci.msi_mask &=3D ~clear;
 	desc->pci.msi_mask |=3D set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
-			       desc->pci.msi_mask);
+	pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
=20

