Return-Path: <linux-tip-commits+bounces-6541-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E9B4FBA2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D6344AF9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08C33A035;
	Tue,  9 Sep 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="prFrUmy6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvd+/DIY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AC27380C;
	Tue,  9 Sep 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422081; cv=none; b=LiogfTSNL4nT9WZrr/8nuVL1jroI50D45IiOS4gmVV8y4gtDi4uUfioZ3aRx3L3GNTWu9zwTMwqzj8A5ykjpTwtOBEuPUZZAJ30dt84hNdmC7KkNrGdtjsQm685c9MX1PxGPBJAJ/pC3FGzDtYiMn6TrQrwKXTVO+rOOrGJq8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422081; c=relaxed/simple;
	bh=hIMMvJjhmiv7aMri57ls9GT/VhKf/A7nt2Q3oWnO9yI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n3LKj5XGrEZzKp5HQUNG4/n4l/p85icnX9OcdwbTyXNIlCCyWjeyBs34uGEJd2xSCVDzh71vmlXv5n1bWSXE5y5g7FTynjpUYr8M6SUo67ui1h3ZgnGWA+vWjDm6av+cJHWLivs4SlNo5Q664cwTxA78jczHzRu5ei3wPqPOuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=prFrUmy6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvd+/DIY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 12:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757422077;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn+dqYxc/eNRVXXVyrbbdrPTfuUY/kvsNhOXijLDBjk=;
	b=prFrUmy6Q2s3HQEIPwU/935ZcKG8fkr9/cn3pUVRfIJkiQgVjXX0mPSbXLpUVltXK6natq
	ksPGw035RIxTRGH95pWorJhFxKNdTEWkdg2tLBqeigE2tvH6uluH8s6SqEz3D0F4qwVmWk
	J/kT68aJW/d9HZM0421rVLrI9fqChyWVAJd1kprXbv+6hYOmyyr6tfUln88PBbCeFUrNh8
	FwKfo2cre5jprAGaCOE8gtiRHzLQQlrjmD/CAT3V02m5+v3TpXiPI6edsGMyBB5qwdaDJd
	lqpnA8FCqEHCnJrHLWJ9Jx58p+sJynK17YMOvATQIQkc132hESZD3JjBMV9WdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757422077;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn+dqYxc/eNRVXXVyrbbdrPTfuUY/kvsNhOXijLDBjk=;
	b=yvd+/DIYXmkAHjMZ55Tzy5pcEMEkk5X/UycKMRUcFhRKoQHT8rjTE+0nNbVmAn1GMoygmw
	NGIgQ1r0+B/7/0Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] PCI/MSI: Remove the conditional parent [un]mask logic
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250903135433.444329373@linutronix.de>
References: <20250903135433.444329373@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175742207611.1920.5860365718624179544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     ba9d484ed3578705fcd24795b800e8e4364afb8c
Gitweb:        https://git.kernel.org/tip/ba9d484ed3578705fcd24795b800e8e4364=
afb8c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 03 Sep 2025 16:04:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 14:44:30 +02:00

PCI/MSI: Remove the conditional parent [un]mask logic

Now that msi_lib_init_dev_msi_info() overwrites the irq_[un]mask()
callbacks when the MSI_FLAG_PCI_MSI_MASK_PARENT flag is set by the parent
domain, the conditional [un]mask logic is obsolete.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250903135433.444329373@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index b11b7f6..dfb61f1 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -170,22 +170,6 @@ static unsigned int cond_startup_parent(struct irq_data =
*data)
 	return 0;
 }
=20
-static __always_inline void cond_mask_parent(struct irq_data *data)
-{
-	struct msi_domain_info *info =3D data->domain->host_data;
-
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
-		irq_chip_mask_parent(data);
-}
-
-static __always_inline void cond_unmask_parent(struct irq_data *data)
-{
-	struct msi_domain_info *info =3D data->domain->host_data;
-
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
-		irq_chip_unmask_parent(data);
-}
-
 static void pci_irq_shutdown_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
@@ -208,14 +192,12 @@ static void pci_irq_mask_msi(struct irq_data *data)
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
-	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
-	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
=20
@@ -268,12 +250,10 @@ static unsigned int pci_irq_startup_msix(struct irq_dat=
a *data)
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
-	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
-	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
=20

