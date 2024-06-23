Return-Path: <linux-tip-commits+bounces-1491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4314913C5B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025FD1C20402
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23C181D15;
	Sun, 23 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AleNaKA8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yAH66aHZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A701C8D1;
	Sun, 23 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156632; cv=none; b=XIO9B2S+CvCymVXlDyAejjco9lj9/Pb8StP3jVGfcz/P9xA+RH86HXzYTDgVarz6X1dbUzDabjLqEhXeST+4MIi/UOyjT+OW/nvpBlhFGFJV1J+aXPPiPMYsPqug2WPnQ/NmuEOe23AAstbLlVsrYJNbYaH+ftwQ8gx2F+RE924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156632; c=relaxed/simple;
	bh=eTnpc4/lBhO4NPXsLTGXk1shgeCD1GxZQQL9IcYb96Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XzDrF01D9g4Xdl0DeaiTRjpyzL90Hpxhf5HnAJHK7dCYmP/EPNWyCzhBUUxLYIUSYj415t7tQa0l1fivzN0Z45g4nMq6lGmQHHSNDw+jJ3/6SH3oHJ0tRVqzx+1ksDaTJayFgqjgrQ7BtkNWZQz5BTQzlYVum/VOo4mDfVkUa9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AleNaKA8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yAH66aHZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Hs1UR8rn8OafnoOacTgQtaqlMyvCQuFsSgkEIQ4FoAM=;
	b=AleNaKA8mGhoy7fhh4RGq53IGS3MeKyZ7oZ6yX5OFRY9SYC7cDvi2I110JMGGQAZSbXDoB
	2BHC+ORec6GbVnBgRSf5OqbdfpXLXQIPS9CwgGff35/LVGOE76tDALA71lM2yrXsAA3PPM
	LHqhBJxItmevkolKCKWMoE9tIZqPUlPXqFFGiNpAlzG+6z7xQrBh3S9MDUoxKgR61LDqdN
	FWHqoL0Jprpf/zlOwqYR/MdNeAqZhS/nsRRvIiHrolKnM1it9LpQinlZPTco38Dn+jY8/d
	BDt5Yg9fg3pPEiu33OrpbdxU8wbzC/WD7nrMzaCIt2ijZ+aZE1cpNhxYg5XcjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Hs1UR8rn8OafnoOacTgQtaqlMyvCQuFsSgkEIQ4FoAM=;
	b=yAH66aHZE7irJKmlYKN43/6BlBLWOZbgB0rW9OFSPZIp/LW2cRKcCs2BXzb3l8AaAElGoW
	ktdMscHYFGK25WBg==
From: tip-bot2 for Pali =?utf-8?q?Roh=C3=A1r?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Add support for 32 MSI
 interrupts on non-IPI platforms
Cc: pali@kernel.org, kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662810.10875.12977162387791349357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     986b6ad0c4c653940fab7e5decf0d847670bf407
Gitweb:        https://git.kernel.org/tip/986b6ad0c4c653940fab7e5decf0d847670=
bf407
Author:        Pali Roh=C3=A1r <pali@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:38:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/armada-370-xp: Add support for 32 MSI interrupts on non-IPI platforms

The doorbell interrupts have the following layout on IPI vs no-IPI
platforms:

                    |  0...7  |  8...15  |       16...31       |
  ------------------+---------+----------+---------------------+
       IPI platform |   IPI   |   n/a    |         MSI         |
  ------------------+---------+----------+---------------------+
   non-IPI platform |                   MSI                    |
  ------------------+------------------------------------------+

Currently the driver only allows for the upper 16...31 interrupts for
MSI domain (i.e. the MSI domain has only 16 interrupts).

On platforms where IPI is not available, we can use whole 32 MSI
interrupts.

Implement support also for the lower 16 MSI interrupts on non-IPI
platforms.

[ Marek: refactored, changed commit message ]

Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/irqchip/irq-armada-370-xp.c | 77 ++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 94a81c5..dce2b80 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -13,6 +13,7 @@
  * warranty of any kind, whether express or implied.
  */
=20
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -136,6 +137,7 @@
=20
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
=20
+/* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
 #define IPI_DOORBELL_MASK                       0xFF
@@ -144,6 +146,14 @@
 #define PCI_MSI_DOORBELL_END                    (32)
 #define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
=20
+/* MSI interrupt definitions for non-IPI platforms */
+#define PCI_MSI_FULL_DOORBELL_START		0
+#define PCI_MSI_FULL_DOORBELL_NR		32
+#define PCI_MSI_FULL_DOORBELL_END		32
+#define PCI_MSI_FULL_DOORBELL_MASK		GENMASK(31, 0)
+#define PCI_MSI_FULL_DOORBELL_SRC0_MASK		GENMASK(15, 0)
+#define PCI_MSI_FULL_DOORBELL_SRC1_MASK		GENMASK(31, 16)
+
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
@@ -152,7 +162,7 @@ static int parent_irq;
 #ifdef CONFIG_PCI_MSI
 static struct irq_domain *armada_370_xp_msi_domain;
 static struct irq_domain *armada_370_xp_msi_inner_domain;
-static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
+static DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
@@ -168,6 +178,30 @@ static inline bool is_ipi_available(void)
 	return parent_irq <=3D 0;
 }
=20
+static inline u32 msi_doorbell_mask(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_MASK :
+				    PCI_MSI_FULL_DOORBELL_MASK;
+}
+
+static inline unsigned int msi_doorbell_start(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_START :
+				    PCI_MSI_FULL_DOORBELL_START;
+}
+
+static inline unsigned int msi_doorbell_size(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_NR :
+				    PCI_MSI_FULL_DOORBELL_NR;
+}
+
+static inline unsigned int msi_doorbell_end(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_END :
+				    PCI_MSI_FULL_DOORBELL_END;
+}
+
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	if (irq <=3D ARMADA_370_XP_MAX_PER_CPU_IRQS)
@@ -225,7 +259,7 @@ static void armada_370_xp_compose_msi_msg(struct irq_data=
 *data, struct msi_msg=20
=20
 	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
-	msg->data =3D BIT(cpu + 8) | (data->hwirq + PCI_MSI_DOORBELL_START);
+	msg->data =3D BIT(cpu + 8) | (data->hwirq + msi_doorbell_start());
 }
=20
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
@@ -258,7 +292,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 	int hwirq, i;
=20
 	mutex_lock(&msi_used_lock);
-	hwirq =3D bitmap_find_free_region(msi_used, PCI_MSI_DOORBELL_NR,
+	hwirq =3D bitmap_find_free_region(msi_used, msi_doorbell_size(),
 					order_base_2(nr_irqs));
 	mutex_unlock(&msi_used_lock);
=20
@@ -295,9 +329,10 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
-		| PCI_MSI_DOORBELL_MASK;
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg |=3D msi_doorbell_mask();
 	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
 	/* Unmask local doorbell interrupt */
 	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
@@ -309,7 +344,7 @@ static int armada_370_xp_msi_init(struct device_node *nod=
e,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS;
=20
 	armada_370_xp_msi_inner_domain =3D
-		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
+		irq_domain_add_linear(NULL, msi_doorbell_size(),
 				      &armada_370_xp_msi_domain_ops, NULL);
 	if (!armada_370_xp_msi_inner_domain)
 		return -ENOMEM;
@@ -325,6 +360,10 @@ static int armada_370_xp_msi_init(struct device_node *no=
de,
=20
 	armada_370_xp_msi_reenable_percpu();
=20
+	/* Unmask low 16 MSI irqs on non-IPI platforms */
+	if (!is_ipi_available())
+		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
 	return 0;
 }
 #else
@@ -613,20 +652,20 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs=
 *regs, bool is_chained)
 	u32 msimask, msinr;
=20
 	msimask =3D readl_relaxed(per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-		& PCI_MSI_DOORBELL_MASK;
+				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	msimask &=3D msi_doorbell_mask();
=20
 	writel(~msimask, per_cpu_int_base +
 	       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
=20
-	for (msinr =3D PCI_MSI_DOORBELL_START;
-	     msinr < PCI_MSI_DOORBELL_END; msinr++) {
+	for (msinr =3D msi_doorbell_start();
+	     msinr < msi_doorbell_end(); msinr++) {
 		unsigned int irq;
=20
 		if (!(msimask & BIT(msinr)))
 			continue;
=20
-		irq =3D msinr - PCI_MSI_DOORBELL_START;
+		irq =3D msinr - msi_doorbell_start();
=20
 		generic_handle_domain_irq(armada_370_xp_msi_inner_domain, irq);
 	}
@@ -655,7 +694,7 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct =
irq_desc *desc)
 		if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
 			continue;
=20
-		if (irqn =3D=3D 1) {
+		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
 			armada_370_xp_handle_msi_irq(NULL, true);
 			continue;
 		}
@@ -716,6 +755,7 @@ static int armada_370_xp_mpic_suspend(void)
=20
 static void armada_370_xp_mpic_resume(void)
 {
+	bool src0, src1;
 	int nirqs;
 	irq_hw_number_t irq;
=20
@@ -755,9 +795,18 @@ static void armada_370_xp_mpic_resume(void)
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
 	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-	if (is_ipi_available() && (doorbell_mask_reg & IPI_DOORBELL_MASK))
+
+	if (is_ipi_available()) {
+		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
+		src1 =3D doorbell_mask_reg & PCI_MSI_DOORBELL_MASK;
+	} else {
+		src0 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
+		src1 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
+	}
+
+	if (src0)
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
+	if (src1)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
=20
 	if (is_ipi_available())

