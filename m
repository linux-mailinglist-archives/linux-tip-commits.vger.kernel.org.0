Return-Path: <linux-tip-commits+bounces-2649-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9509B667B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF41F204DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0271F4739;
	Wed, 30 Oct 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6K31HDk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gGB/6dO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0271F4717;
	Wed, 30 Oct 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299797; cv=none; b=pEI9PMgRYFJpejw48xspMxtxwp4EwHwLo1b+YFlWGYXE70yQEMLM/mdxgn9SfsUXmnQcIQ0DWV/tQYkjPTLJIB3AiRgDtAiISjslH0dfQTBlBvtF4KFfUgJ9bwOy/r92rXSYudgYiUEpO4e4GMT5pqY8OYaL38vbj05JTIe2L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299797; c=relaxed/simple;
	bh=3lPWkW32hWl8AfexOGbICS5dr1e408tLuvniNicjBc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mrsFZJ6aop4vbAJeqJoIPLHckeV6LMtB7Y0qkIifTyYzUig/VrxGLp7L/x0kHxeeuT3GEap25g0iuhQcNu4iNUQLt1YvqEAXr7qmIX/Yke9b7XBgj8bAurxlaf3GJUCabyIqVij5Jyt1voCtFekPyXf4rVq7T3a+gI2xbhy6N9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6K31HDk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gGB/6dO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 14:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730299792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhw5TDkdI/wm0hFEphOAnFv1KynVGxXFayg/h3+LrgY=;
	b=u6K31HDkxbTjcIFDNhoDp1GA1QMUfrdnaXBpsh/3bAfh7LsJrm604LAZtuKeKAkUDkNNS2
	SZC26uKSx0imCxYGN20VqXjFPIOaswIcCDsnjMH0VI1GHe/ItpuOXzSFRBC5HAnKLot110
	DG1eZPq7mzV/aQuk3yWR7bF1sIvd8n9TvUsv/MaqHhO8D2KwZJk6m0y/kBr6i0bSp+iheP
	iPDtFxM3EjaqPGX30mIkRLql1c3cHAH9/Mkkh/amdGFReUmF3f18F+eEB6FAkpdcHB94bs
	A+7oOh0VeqPUs2gxPfAMux4yiRsYfOVx0UPHNSQJ/rNI06/TdcSxePA+1VFS8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730299792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhw5TDkdI/wm0hFEphOAnFv1KynVGxXFayg/h3+LrgY=;
	b=1gGB/6dOaXXjzhZDQXRLNx2uMSYrHsOyOomyq+juSzsW1tPRS+oG9qe59cDWXCd+TXwY3Q
	jdjAHv42kLYehlCg==
From: "tip-bot2 for Paul Burton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mips-gic: Multi-cluster support
Cc: Paul Burton <paulburton@kernel.org>, "Chao-ying Fu" <cfu@wavecomp.com>,
 Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Serge Semin <fancer.lancer@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241028175935.51250-5-arikalo@gmail.com>
References: <20241028175935.51250-5-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173029979171.3137.5721964738341029557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     322a9063876890895cb8308cc6f59de312e8aad5
Gitweb:        https://git.kernel.org/tip/322a9063876890895cb8308cc6f59de312e8aad5
Author:        Paul Burton <paulburton@kernel.org>
AuthorDate:    Mon, 28 Oct 2024 18:59:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 15:41:18 +01:00

irqchip/mips-gic: Multi-cluster support

The MIPS I6500 CPU & CM (Coherence Manager) 3.5 introduce the concept of
multiple clusters to the system. In these systems, each cluster contains
its own GIC, so the GIC isn't truly global any longer. Access to
registers in the GICs of remote clusters is possible using a redirect
register block much like the redirect register blocks provided by the
CM & CPC, and configured through the same GCR_REDIRECT register that
mips_cm_lock_other() abstraction builds upon.

It is expected that external interrupts are connected identically on all
clusters. That is, if there is a device providing an interrupt connected
to GIC interrupt pin 0 then it should be connected to pin 0 of every GIC
in the system. For the most part, the GIC can be treated as though it is
still truly global, so long as interrupts in the cluster are configured
properly.

Introduce support for such multi-cluster systems in the MIPS GIC irqchip
driver. A newly introduced gic_irq_lock_cluster() function allows:

  1) Configure access to a GIC in a remote cluster via the redirect
     register block, using mips_cm_lock_other().

Or:

  2) Detect that the interrupt in question is affine to the local
     cluster and plain old GIC register access to the GIC in the
     local cluster should be used.

It is possible to access the local cluster's GIC registers via the
redirect block, but keeping the special case for them is both good for
performance (because we avoid the locking & indirection overhead of
using the redirect block) and necessary to maintain compatibility with
systems using CM revisions prior to 3.5 which don't support the redirect
block.

The gic_irq_lock_cluster() function relies upon an IRQs effective
affinity in order to discover which cluster the IRQ is affine to. In
order to track this & allow it to be updated at an appropriate point
during gic_set_affinity() select the generic support for effective
affinity using CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK.

gic_set_affinity() is the one function which gains much complexity. It
now deconfigures routing to any VP(E), ie. CPU, on the old cluster when
moving affinity to a new cluster.

gic_shared_irq_domain_map() moves its update of the IRQs effective
affinity to before its use of gic_irq_lock_cluster(), to ensure that
operation is on the cluster the IRQ is affine to.

The remaining changes are straightforward use of the gic_irq_lock_cluster()
function to select between local cluster & remote cluster code-paths when
configuring interrupts.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/all/20241028175935.51250-5-arikalo@gmail.com

---
 drivers/irqchip/Kconfig        |   1 +-
 drivers/irqchip/irq-mips-gic.c | 161 ++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 006a47a..f20adf7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -352,6 +352,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	select GENERIC_IRQ_IPI if SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d93a076..f42f69b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -111,6 +111,41 @@ static inline void gic_unlock_cluster(void)
 	     gic_unlock_cluster(),			\
 	     (cpu) = __gic_with_next_online_cpu(cpu))
 
+/**
+ * gic_irq_lock_cluster() - Lock redirect block access to IRQ's cluster
+ * @d: struct irq_data corresponding to the interrupt we're interested in
+ *
+ * Locks redirect register block access to the global register block of the GIC
+ * within the remote cluster that the IRQ corresponding to @d is affine to,
+ * returning true when this redirect block setup & locking has been performed.
+ *
+ * If @d is affine to the local cluster then no locking is performed and this
+ * function will return false, indicating to the caller that it should access
+ * the local clusters registers without the overhead of indirection through the
+ * redirect block.
+ *
+ * In summary, if this function returns true then the caller should access GIC
+ * registers using redirect register block accessors & then call
+ * mips_cm_unlock_other() when done. If this function returns false then the
+ * caller should trivially access GIC registers in the local cluster.
+ *
+ * Returns true if locking performed, else false.
+ */
+static bool gic_irq_lock_cluster(struct irq_data *d)
+{
+	unsigned int cpu, cl;
+
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	BUG_ON(cpu >= NR_CPUS);
+
+	cl = cpu_cluster(&cpu_data[cpu]);
+	if (cl == cpu_cluster(&current_cpu_data))
+		return false;
+
+	mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	return true;
+}
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -157,7 +192,12 @@ static void gic_send_ipi(struct irq_data *d, unsigned int cpu)
 {
 	irq_hw_number_t hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(d));
 
-	write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(GIC_WEDGE_RW | hwirq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	}
 }
 
 int gic_get_c0_compare_int(void)
@@ -225,7 +265,13 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_rmask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_rmask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_rmask(intr);
+	}
+
 	gic_clear_pcpu_masks(intr);
 }
 
@@ -234,7 +280,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned int cpu;
 
-	write_gic_smask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_smask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_smask(intr);
+	}
 
 	gic_clear_pcpu_masks(intr);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -245,7 +296,12 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_wedge(irq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(irq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(irq);
+	}
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -285,9 +341,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		break;
 	}
 
-	change_gic_pol(irq, pol);
-	change_gic_trig(irq, trig);
-	change_gic_dual(irq, dual);
+	if (gic_irq_lock_cluster(d)) {
+		change_gic_redir_pol(irq, pol);
+		change_gic_redir_trig(irq, trig);
+		change_gic_redir_dual(irq, dual);
+		mips_cm_unlock_other();
+	} else {
+		change_gic_pol(irq, pol);
+		change_gic_trig(irq, trig);
+		change_gic_dual(irq, dual);
+	}
 
 	if (trig == GIC_TRIG_EDGE)
 		irq_set_chip_handler_name_locked(d, &gic_edge_irq_controller,
@@ -305,25 +368,72 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
+	unsigned int cpu, cl, old_cpu, old_cl;
 	unsigned long flags;
-	unsigned int cpu;
 
+	/*
+	 * The GIC specifies that we can only route an interrupt to one VP(E),
+	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
+	 * the first online CPU in the mask.
+	 */
 	cpu = cpumask_first_and(cpumask, cpu_online_mask);
 	if (cpu >= NR_CPUS)
 		return -EINVAL;
 
-	/* Assumption : cpumask refers to a single CPU */
-	raw_spin_lock_irqsave(&gic_lock, flags);
+	old_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	old_cl = cpu_cluster(&cpu_data[old_cpu]);
+	cl = cpu_cluster(&cpu_data[cpu]);
 
-	/* Re-route this IRQ */
-	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
-	/* Update the pcpu_masks */
-	gic_clear_pcpu_masks(irq);
-	if (read_gic_mask(irq))
-		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	/*
+	 * If we're moving affinity between clusters, stop routing the
+	 * interrupt to any VP(E) in the old cluster.
+	 */
+	if (cl != old_cl) {
+		if (gic_irq_lock_cluster(d)) {
+			write_gic_redir_map_vp(irq, 0);
+			mips_cm_unlock_other();
+		} else {
+			write_gic_map_vp(irq, 0);
+		}
+	}
 
+	/*
+	 * Update effective affinity - after this gic_irq_lock_cluster() will
+	 * begin operating on the new cluster.
+	 */
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	/*
+	 * If we're moving affinity between clusters, configure the interrupt
+	 * trigger type in the new cluster.
+	 */
+	if (cl != old_cl)
+		gic_set_type(d, irqd_get_trigger_type(d));
+
+	/* Route the interrupt to its new VP(E) */
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_map_pin(irq,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_redir_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(irq, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
@@ -471,11 +581,21 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	unsigned long flags;
 
 	data = irq_get_irq_data(virq);
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	/* Route the interrupt to its VP(E) */
+	if (gic_irq_lock_cluster(data)) {
+		write_gic_redir_map_pin(intr,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -651,6 +771,9 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 		if (ret)
 			goto error;
 
+		/* Set affinity to cpu.  */
+		irq_data_update_effective_affinity(irq_get_irq_data(virq + i),
+						   cpumask_of(cpu));
 		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
 		if (ret)
 			goto error;

