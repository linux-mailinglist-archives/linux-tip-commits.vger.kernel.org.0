Return-Path: <linux-tip-commits+bounces-2651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C570F9B6680
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31568B22027
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006E1F80D2;
	Wed, 30 Oct 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2MM3dGY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jEmZfzp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B21F4736;
	Wed, 30 Oct 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299799; cv=none; b=IhuQn+kuYwzMTND8JT5UpDRVSuyT8C097jsfnwh1M+UYFp/oIcDvUkf7Q1/CNzmLk7oiDgT4mIq/Da/M92r/rFHEnEcW+jnUl12qcrPACrtDqDrwLCEWWr7ijyG9BzXHUophjimaz/QyH/p/IybDfXYVEX779lI0lGyeWWvYvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299799; c=relaxed/simple;
	bh=ylV9iLD9mtsxx08KkDf5yGoSyBC53QMY+Z7pvp0Jl/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Og8254coBBR/9bn7RRvJB2jHdTLHbzZJX+eKX4IxVwp2+Jjo7NrwVMYADgD20UHr2LoWfl7sLrKxg3zpjZMrtPPiaxF7Jlk0615AElBO3uvVIs1WyNnDl2Pgv1IXYIFHBYqq1v/2/Ociwb9VwRxklHH4vkko5Z9j+WskVSZQMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X2MM3dGY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jEmZfzp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 14:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730299795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBIigrVFGVFArIcgn5K3WkrJt2/Ue66Ekr6IZBCOvj0=;
	b=X2MM3dGYu/Erf4paZbAsG5UySMVORxMnAigM4ADr9L5gCLbMxDcDjRRd1oXxqioB8Z5Pg0
	QU8LJwTujNf8UGzv/Iz72EZHlli1K5uX1zKg51WokzcRB6sKLBtelnccuqPCR+jSVxvs5i
	ai0Tow7PL6FPSGiL4jFavYbduz+6RYJcSrYGiyPyZ3hJ/Fu2jMcbVD5p5aHG7sJhE7Uoud
	0Bk17E/tltHA97Vh/q4V1aVYBWfD/P1wPf9xzgHO0p3OyIdkT0XJTNWQ2302GKgEaMYNox
	bomIAfHXZq1CwUAmenzjfqlNQCrf1ls80JhUFsALASQgPAOlDGQs1dA+UQiTCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730299795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBIigrVFGVFArIcgn5K3WkrJt2/Ue66Ekr6IZBCOvj0=;
	b=3jEmZfzpE9BjC8WZUOl7Vv9WYUG5z6VDS4h74pJpU51UH5PyLVWkRsWOqjxsZ+lFUwiunM
	H5a1R9CqG2+xMjCA==
From: "tip-bot2 for Paul Burton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/mips-gic: Replace open coded online CPU iterations
Cc: Paul Burton <paulburton@kernel.org>, "Chao-ying Fu" <cfu@wavecomp.com>,
 Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Serge Semin <fancer.lancer@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241028175935.51250-2-arikalo@gmail.com>
References: <20241028175935.51250-2-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173029979395.3137.3954011686630855852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     496461050b74d44a2adb39511403a36c9a555bc7
Gitweb:        https://git.kernel.org/tip/496461050b74d44a2adb39511403a36c9a555bc7
Author:        Paul Burton <paulburton@kernel.org>
AuthorDate:    Mon, 28 Oct 2024 18:59:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 15:41:18 +01:00

irqchip/mips-gic: Replace open coded online CPU iterations

Several places in the MIPS GIC driver iterate over the online CPUs to
operate on the CPU's GIC local register block, accessed via the GIC's
other/redirect register block.

Abstract the process of iterating over online CPUs & configuring the
other/redirect region to access their registers through a new
for_each_online_cpu_gic() macro and convert all usage sites over.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/all/20241028175935.51250-2-arikalo@gmail.com

---
 drivers/irqchip/irq-mips-gic.c | 59 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 76253e8..6c7a7d2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -66,6 +66,44 @@ static struct gic_all_vpes_chip_data {
 	bool	mask;
 } gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
 
+static int __gic_with_next_online_cpu(int prev)
+{
+	unsigned int cpu;
+
+	/* Discover the next online CPU */
+	cpu = cpumask_next(prev, cpu_online_mask);
+
+	/* If there isn't one, we're done */
+	if (cpu >= nr_cpu_ids)
+		return cpu;
+
+	/*
+	 * Move the access lock to the next CPU's GIC local register block.
+	 *
+	 * Set GIC_VL_OTHER. Since the caller holds gic_lock nothing can
+	 * clobber the written value.
+	 */
+	write_gic_vl_other(mips_cm_vp_id(cpu));
+
+	return cpu;
+}
+
+/**
+ * for_each_online_cpu_gic() - Iterate over online CPUs, access local registers
+ * @cpu: An integer variable to hold the current CPU number
+ * @gic_lock: A pointer to raw spin lock used as a guard
+ *
+ * Iterate over online CPUs & configure the other/redirect register region to
+ * access each CPUs GIC local register block, which can be accessed from the
+ * loop body using read_gic_vo_*() or write_gic_vo_*() accessor functions or
+ * their derivatives.
+ */
+#define for_each_online_cpu_gic(cpu, gic_lock)		\
+	guard(raw_spinlock_irqsave)(gic_lock);		\
+	for ((cpu) = __gic_with_next_online_cpu(-1);	\
+	     (cpu) < nr_cpu_ids;			\
+	     (cpu) = __gic_with_next_online_cpu(cpu))
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -350,37 +388,27 @@ static struct irq_chip gic_local_irq_controller = {
 static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	int intr, cpu;
 
 	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
 
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_rmask(BIT(intr));
-	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	int intr, cpu;
 
 	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
 
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_smask(BIT(intr));
-	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_all_vpes_irq_cpu_online(void)
@@ -469,7 +497,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			      irq_hw_number_t hwirq)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	unsigned int intr;
 	int err, cpu;
 	u32 map;
@@ -533,12 +560,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
-	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }

