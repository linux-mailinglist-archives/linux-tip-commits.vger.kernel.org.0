Return-Path: <linux-tip-commits+bounces-2017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AA94C10B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98A01F28573
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4C193068;
	Thu,  8 Aug 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0Wf0F5y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fP5YDpH8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626C1917C1;
	Thu,  8 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130511; cv=none; b=BxgWTbFxk+GpligTupTSjdO/7baM9BzhM8zdS9/Z3lIxlSQPubc4xKsWVOz43oadVXSdjbVhXK+ZxHOIOHT32MqBeoL93MwgcS2v/w6v2f5lUeEfx8qyH4ajpcNj9/FnWaTR6Wfy2pjKj+D20RBLPhzopgUHQNMmGzh0fIUbw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130511; c=relaxed/simple;
	bh=ZdXQB7qVPZbcDx3XD7kmmkn4LPqCbETM+WNv2js1fGI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=W1iMawcE/DQBtPQVIYSf3CJu8oPCtFWKCRI+Dnhc8FUpgXgutY4ZTyg8nejZem7FENnxHji0kLOfssvhDALSF0sfHKpoODCDiAmO0kb/+hexmemjCwTDZxD1Xq+Xc4Ak47FW+eCH+/xnD1gcWOEAfRZPbbkJWqVQ4E3fP0u3PBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0Wf0F5y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fP5YDpH8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M+C6XH2nM0nPahQgblQrnKjsCbUCIQ1cPddWJkddzZU=;
	b=I0Wf0F5yQtpWqidFebVs8PVonDXm/HRG15I3aeEbN+cZy1a1Kqd3iKYjI5TTn+gNTiYCH0
	knhXVWGCtHPH3ar6iS1ctYD5ysSt7JiQn1HBOHKbyQYlsZ4VAU41mysp6V/mPZybWjxJWp
	8N532vMHf+wrA/fMDnFeWeBatPdGv7hlxWL8H7FZHl4jN7Up0QK/p6cQIuSJUv+YHmY6c1
	vuniawLeQ01OUXpjVtyv1LLaWn+oDTUzRpBIFeOZ1bvcZl15TOuyhmxh8c6xUgIPVOpcnF
	ktL7OYqQdLo/UgMCAGCxUDsiVI/5sqtcJvq1zjHUSIp7lxwO0OeEzdYZgo8aGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M+C6XH2nM0nPahQgblQrnKjsCbUCIQ1cPddWJkddzZU=;
	b=fP5YDpH89feKJpyPToEFyCsMvkYlHiJ/qskjjHncKzfzKcDZqoVqP6GMp7i2+pwhOxiMCM
	3wixloJJhpULTtDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Put MSI doorbell limits into
 the mpic structure
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050537.2215.3099570451110149370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ee5d09cf14a10010af163ac98e21aa282de6c4cf
Gitweb:        https://git.kernel.org/tip/ee5d09cf14a10010af163ac98e21aa282de=
6c4cf
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Put MSI doorbell limits into the mpic structure

Put the MSI doorbell limits msi_doorbell_start, msi_doorbell_size and
msi_doorbell_mask into the driver private structure and get rid of the
corresponding functions.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 00f3842..1c95a61 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -161,6 +161,10 @@
  * @msi_used:		bitmap of used MSI numbers
  * @msi_lock:		mutex serializing access to @msi_used
  * @msi_doorbell_addr:	physical address of MSI doorbell register
+ * @msi_doorbell_mask:	mask of available doorbell bits for MSIs (either PCI_=
MSI_DOORBELL_MASK or
+ *			PCI_MSI_FULL_DOORBELL_MASK)
+ * @msi_doorbell_start:	first set bit in @msi_doorbell_mask
+ * @msi_doorbell_size:	number of set bits in @msi_doorbell_mask
  * @doorbell_mask:	doorbell mask of MSIs and IPIs, stored on suspend, restor=
ed on resume
  */
 struct mpic {
@@ -177,6 +181,8 @@ struct mpic {
 	DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 	struct mutex msi_lock;
 	phys_addr_t msi_doorbell_addr;
+	u32 msi_doorbell_mask;
+	unsigned int msi_doorbell_start, msi_doorbell_size;
 #endif
 	u32 doorbell_mask;
 };
@@ -195,21 +201,6 @@ static inline bool mpic_is_ipi_available(void)
 	return mpic->parent_irq <=3D 0;
 }
=20
-static inline u32 msi_doorbell_mask(void)
-{
-	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_MASK : PCI_MSI_FULL_DOORB=
ELL_MASK;
-}
-
-static inline unsigned int msi_doorbell_start(void)
-{
-	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_START : PCI_MSI_FULL_DOOR=
BELL_START;
-}
-
-static inline unsigned int msi_doorbell_size(void)
-{
-	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_NR : PCI_MSI_FULL_DOORBEL=
L_NR;
-}
-
 static inline bool mpic_is_percpu_irq(irq_hw_number_t hwirq)
 {
 	return hwirq <=3D MPIC_MAX_PER_CPU_IRQS;
@@ -260,7 +251,7 @@ static void mpic_compose_msi_msg(struct irq_data *d, stru=
ct msi_msg *msg)
=20
 	msg->address_lo =3D lower_32_bits(mpic->msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(mpic->msi_doorbell_addr);
-	msg->data =3D BIT(cpu + 8) | (d->hwirq + msi_doorbell_start());
+	msg->data =3D BIT(cpu + 8) | (d->hwirq + mpic->msi_doorbell_start);
 }
=20
 static int mpic_msi_set_affinity(struct irq_data *d, const struct cpumask *m=
ask, bool force)
@@ -292,7 +283,7 @@ static int mpic_msi_alloc(struct irq_domain *domain, unsi=
gned int virq, unsigned
 	int hwirq;
=20
 	mutex_lock(&mpic->msi_lock);
-	hwirq =3D bitmap_find_free_region(mpic->msi_used, msi_doorbell_size(),
+	hwirq =3D bitmap_find_free_region(mpic->msi_used, mpic->msi_doorbell_size,
 					order_base_2(nr_irqs));
 	mutex_unlock(&mpic->msi_lock);
=20
@@ -329,7 +320,7 @@ static void mpic_msi_reenable_percpu(void)
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
 	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
-	reg |=3D msi_doorbell_mask();
+	reg |=3D mpic->msi_doorbell_mask;
 	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
@@ -342,7 +333,17 @@ static int __init mpic_msi_init(struct device_node *node=
, phys_addr_t main_int_p
=20
 	mutex_init(&mpic->msi_lock);
=20
-	mpic->msi_inner_domain =3D irq_domain_add_linear(NULL, msi_doorbell_size(),
+	if (mpic_is_ipi_available()) {
+		mpic->msi_doorbell_start =3D PCI_MSI_DOORBELL_START;
+		mpic->msi_doorbell_size =3D PCI_MSI_DOORBELL_NR;
+		mpic->msi_doorbell_mask =3D PCI_MSI_DOORBELL_MASK;
+	} else {
+		mpic->msi_doorbell_start =3D PCI_MSI_FULL_DOORBELL_START;
+		mpic->msi_doorbell_size =3D PCI_MSI_FULL_DOORBELL_NR;
+		mpic->msi_doorbell_mask =3D PCI_MSI_FULL_DOORBELL_MASK;
+	}
+
+	mpic->msi_inner_domain =3D irq_domain_add_linear(NULL, mpic->msi_doorbell_s=
ize,
 						       &mpic_msi_domain_ops, NULL);
 	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
@@ -620,12 +621,11 @@ static void mpic_handle_msi_irq(void)
 	unsigned int i;
=20
 	cause =3D readl_relaxed(mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
-	cause &=3D msi_doorbell_mask();
+	cause &=3D mpic->msi_doorbell_mask;
 	writel(~cause, mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
=20
 	for_each_set_bit(i, &cause, BITS_PER_LONG)
-		generic_handle_domain_irq(mpic->msi_inner_domain,
-					  i - msi_doorbell_start());
+		generic_handle_domain_irq(mpic->msi_inner_domain, i - mpic->msi_doorbell_s=
tart);
 }
 #else
 static void mpic_handle_msi_irq(void) {}

