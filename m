Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAD34376C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 04:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVD3k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 23:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVD3I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 23:29:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEEEC061574;
        Sun, 21 Mar 2021 20:29:07 -0700 (PDT)
Date:   Mon, 22 Mar 2021 03:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616383744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dVqEAhs6mh2ujnZ9/pIx4veuGSHEcsIoGkaCRvw2eKs=;
        b=2QX2ROeZaB7sjim/iiM+eisaHEZDyjJaZQEjOtBJ1AZVnqZ6AOD2FKYjdagluTG6z2kl69
        FO2sMHrLINowolcqlVYCGe3xVKLkJXwwTLgrDHV1/I0YtpU7x0GU667bHNrfvVkwgqRXZN
        u7upya7Z1neaOq2rbvkvysJOZsxTcAfZbftAJoUdkCUwKRtRDT+pzS6mlWw80r5yemrS7q
        0aguUYXGssUg7/+2TkPxbosVJjr+3CDZS1xL0ReJPoCZwZLtK0cTS36qYpvng1+l9kjDTo
        Tk2s+RRJGovD+l+4jBy4DXsioinuVwvOZ2M6BmygjkKHLBESIIXN2y+rA2ZWyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616383744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dVqEAhs6mh2ujnZ9/pIx4veuGSHEcsIoGkaCRvw2eKs=;
        b=FDgYmreUgjlXPszpAAdnSeBJjVxdckr6mg+Ewz3+H4eiMUoffHz9zcyI6x9x7HWbT/SMpP
        1p9flCQqakG/oLCg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq: Fix typos in comments
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161638374359.398.16793210133890396300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a359f757965aafd0f58570de95dc6bc06cf12a9c
Gitweb:        https://git.kernel.org/tip/a359f757965aafd0f58570de95dc6bc06cf12a9c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 04:21:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 04:23:14 +01:00

irq: Fix typos in comments

Fix ~36 single-word typos in the IRQ, irqchip and irqdomain code comments.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/irqchip/irq-aspeed-vic.c       |  4 ++--
 drivers/irqchip/irq-bcm7120-l2.c       |  2 +-
 drivers/irqchip/irq-csky-apb-intc.c    |  2 +-
 drivers/irqchip/irq-gic-v2m.c          |  2 +-
 drivers/irqchip/irq-gic-v3-its.c       | 10 +++++-----
 drivers/irqchip/irq-gic-v3.c           |  2 +-
 drivers/irqchip/irq-loongson-pch-pic.c |  2 +-
 drivers/irqchip/irq-meson-gpio.c       |  2 +-
 drivers/irqchip/irq-mtk-cirq.c         |  2 +-
 drivers/irqchip/irq-mxs.c              |  4 ++--
 drivers/irqchip/irq-sun4i.c            |  2 +-
 drivers/irqchip/irq-ti-sci-inta.c      |  2 +-
 drivers/irqchip/irq-vic.c              |  4 ++--
 drivers/irqchip/irq-xilinx-intc.c      |  2 +-
 include/linux/irq.h                    |  4 ++--
 include/linux/irqdesc.h                |  2 +-
 kernel/irq/chip.c                      |  2 +-
 kernel/irq/dummychip.c                 |  2 +-
 kernel/irq/irqdesc.c                   |  2 +-
 kernel/irq/irqdomain.c                 |  8 ++++----
 kernel/irq/manage.c                    |  6 +++---
 kernel/irq/msi.c                       |  2 +-
 kernel/irq/timings.c                   |  2 +-
 23 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vic.c
index 6567ed7..58717cd 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -71,7 +71,7 @@ static void vic_init_hw(struct aspeed_vic *vic)
 	writel(0, vic->base + AVIC_INT_SELECT);
 	writel(0, vic->base + AVIC_INT_SELECT + 4);
 
-	/* Some interrupts have a programable high/low level trigger
+	/* Some interrupts have a programmable high/low level trigger
 	 * (4 GPIO direct inputs), for now we assume this was configured
 	 * by firmware. We read which ones are edge now.
 	 */
@@ -203,7 +203,7 @@ static int __init avic_of_init(struct device_node *node,
 	}
 	vic->base = regs;
 
-	/* Initialize soures, all masked */
+	/* Initialize sources, all masked */
 	vic_init_hw(vic);
 
 	/* Ready to receive interrupts */
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index c7c9e97..ad59656 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -309,7 +309,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 
 		if (data->can_wake) {
 			/* This IRQ chip can wake the system, set all
-			 * relevant child interupts in wake_enabled mask
+			 * relevant child interrupts in wake_enabled mask
 			 */
 			gc->wake_enabled = 0xffffffff;
 			gc->wake_enabled &= ~gc->unused;
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 5a2ec43..ab91afa 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -176,7 +176,7 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 	writel(0x0, reg_base + GX_INTC_NEN63_32);
 
 	/*
-	 * Initial mask reg with all unmasked, because we only use enalbe reg
+	 * Initial mask reg with all unmasked, because we only use enable reg
 	 */
 	writel(0x0, reg_base + GX_INTC_NMASK31_00);
 	writel(0x0, reg_base + GX_INTC_NMASK63_32);
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index fbec07d..4116b48 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -371,7 +371,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	 * the MSI data is the absolute value within the range from
 	 * spi_start to (spi_start + num_spis).
 	 *
-	 * Broadom NS2 GICv2m implementation has an erratum where the MSI data
+	 * Broadcom NS2 GICv2m implementation has an erratum where the MSI data
 	 * is 'spi_number - 32'
 	 *
 	 * Reading that register fails on the Graviton implementation
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ed46e60..c3485b2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1492,7 +1492,7 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 	 *
 	 * Ideally, we'd issue a VMAPTI to set the doorbell to its LPI
 	 * value or to 1023, depending on the enable bit. But that
-	 * would be issueing a mapping for an /existing/ DevID+EventID
+	 * would be issuing a mapping for an /existing/ DevID+EventID
 	 * pair, which is UNPREDICTABLE. Instead, let's issue a VMOVI
 	 * to the /same/ vPE, using this opportunity to adjust the
 	 * doorbell. Mouahahahaha. We loves it, Precious.
@@ -3122,7 +3122,7 @@ static void its_cpu_init_lpis(void)
 
 		/*
 		 * It's possible for CPU to receive VLPIs before it is
-		 * sheduled as a vPE, especially for the first CPU, and the
+		 * scheduled as a vPE, especially for the first CPU, and the
 		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
 		 * as out of range and dropped by GIC.
 		 * So we initialize IDbits to known value to avoid VLPI drop.
@@ -3616,7 +3616,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 
 	/*
 	 * If all interrupts have been freed, start mopping the
-	 * floor. This is conditionned on the device not being shared.
+	 * floor. This is conditioned on the device not being shared.
 	 */
 	if (!its_dev->shared &&
 	    bitmap_empty(its_dev->event_map.lpi_map,
@@ -4194,7 +4194,7 @@ static int its_sgi_set_affinity(struct irq_data *d,
 {
 	/*
 	 * There is no notion of affinity for virtual SGIs, at least
-	 * not on the host (since they can only be targetting a vPE).
+	 * not on the host (since they can only be targeting a vPE).
 	 * Tell the kernel we've done whatever it asked for.
 	 */
 	irq_data_update_effective_affinity(d, mask_val);
@@ -4239,7 +4239,7 @@ static int its_sgi_get_irqchip_state(struct irq_data *d,
 	/*
 	 * Locking galore! We can race against two different events:
 	 *
-	 * - Concurent vPE affinity change: we must make sure it cannot
+	 * - Concurrent vPE affinity change: we must make sure it cannot
 	 *   happen, or we'll talk to the wrong redistributor. This is
 	 *   identical to what happens with vLPIs.
 	 *
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eb0ee35..94b8925 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1379,7 +1379,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		/*
 		 * Make it clear that broken DTs are... broken.
-		 * Partitionned PPIs are an unfortunate exception.
+		 * Partitioned PPIs are an unfortunate exception.
 		 */
 		WARN_ON(*type == IRQ_TYPE_NONE &&
 			fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 9bf6b9a..f790ca6 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -163,7 +163,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 	int i;
 
 	for (i = 0; i < PIC_COUNT; i++) {
-		/* Write vectore ID */
+		/* Write vectored ID */
 		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index bc7aebc..e50676c 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -227,7 +227,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 
 	/*
 	 * Get the hwirq number assigned to this channel through
-	 * a pointer the channel_irq table. The added benifit of this
+	 * a pointer the channel_irq table. The added benefit of this
 	 * method is that we can also retrieve the channel index with
 	 * it, using the table base.
 	 */
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 69ba8ce..9bca091 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -217,7 +217,7 @@ static void mtk_cirq_resume(void)
 {
 	u32 value;
 
-	/* flush recored interrupts, will send signals to parent controller */
+	/* flush recorded interrupts, will send signals to parent controller */
 	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
 	writel_relaxed(value | CIRQ_FLUSH, cirq_data->base + CIRQ_CONTROL);
 
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index a671938..d1f5740 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -58,7 +58,7 @@ struct icoll_priv {
 static struct icoll_priv icoll_priv;
 static struct irq_domain *icoll_domain;
 
-/* calculate bit offset depending on number of intterupt per register */
+/* calculate bit offset depending on number of interrupt per register */
 static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
 {
 	/*
@@ -68,7 +68,7 @@ static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
 	return bit << ((d->hwirq & 3) << 3);
 }
 
-/* calculate mem offset depending on number of intterupt per register */
+/* calculate mem offset depending on number of interrupt per register */
 static void __iomem *icoll_intr_reg(struct irq_data *d)
 {
 	/* offset = hwirq / intr_per_reg * 0x10 */
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index fb78d66..9ea9445 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -189,7 +189,7 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 	 * 3) spurious irq
 	 * So if we immediately get a reading of 0, check the irq-pending reg
 	 * to differentiate between 2 and 3. We only do this once to avoid
-	 * the extra check in the common case of 1 hapening after having
+	 * the extra check in the common case of 1 happening after having
 	 * read the vector-reg once.
 	 */
 	hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 532d0ae..ca1f593 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -78,7 +78,7 @@ struct ti_sci_inta_vint_desc {
  * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
  *				   Interrupt Aggregator IRQ domain.
  * @sci:		Pointer to TISCI handle
- * @vint:		TISCI resource pointer representing IA inerrupts.
+ * @vint:		TISCI resource pointer representing IA interrupts.
  * @global_event:	TISCI resource pointer representing global events.
  * @vint_list:		List of the vints active in the system
  * @vint_mutex:		Mutex to protect vint_list
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index e460363..62f3d29 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -163,7 +163,7 @@ static struct syscore_ops vic_syscore_ops = {
 };
 
 /**
- * vic_pm_init - initicall to register VIC pm
+ * vic_pm_init - initcall to register VIC pm
  *
  * This is called via late_initcall() to register
  * the resources for the VICs due to the early
@@ -397,7 +397,7 @@ static void __init vic_clear_interrupts(void __iomem *base)
 /*
  * The PL190 cell from ARM has been modified by ST to handle 64 interrupts.
  * The original cell has 32 interrupts, while the modified one has 64,
- * replocating two blocks 0x00..0x1f in 0x20..0x3f. In that case
+ * replicating two blocks 0x00..0x1f in 0x20..0x3f. In that case
  * the probe function is called twice, with base set to offset 000
  *  and 020 within the page. We call this "second block".
  */
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 1d3d273..8cd1bfc 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -210,7 +210,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 
 	/*
 	 * Disable all external interrupts until they are
-	 * explicity requested.
+	 * explicitly requested.
 	 */
 	xintc_write(irqc, IER, 0);
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2efde6a..bee8280 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -116,7 +116,7 @@ enum {
  * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_common_data.affinity
  * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
  *			  support stacked irqchips, which indicates skipping
- *			  all descendent irqchips.
+ *			  all descendant irqchips.
  */
 enum {
 	IRQ_SET_MASK_OK = 0,
@@ -302,7 +302,7 @@ static inline bool irqd_is_level_type(struct irq_data *d)
 
 /*
  * Must only be called of irqchip.irq_set_affinity() or low level
- * hieararchy domain allocation functions.
+ * hierarchy domain allocation functions.
  */
 static inline void irqd_set_single_target(struct irq_data *d)
 {
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 891b323..df46512 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -32,7 +32,7 @@ struct pt_regs;
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
- * @threads_handled_last: comparator field for deferred spurious detection of theraded handlers
+ * @threads_handled_last: comparator field for deferred spurious detection of threaded handlers
  * @lock:		locking for SMP
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 042399c..8cc8e57 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -808,7 +808,7 @@ void handle_edge_irq(struct irq_desc *desc)
 		/*
 		 * When another irq arrived while we were handling
 		 * one, we could have masked the irq.
-		 * Renable it, if it was not disabled in meantime.
+		 * Reenable it, if it was not disabled in meantime.
 		 */
 		if (unlikely(desc->istate & IRQS_PENDING)) {
 			if (!irqd_irq_disabled(&desc->irq_data) &&
diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 0b0cdf2..7fe6cff 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -13,7 +13,7 @@
 
 /*
  * What should we do if we get a hw irq event on an illegal vector?
- * Each architecture has to answer this themself.
+ * Each architecture has to answer this themselves.
  */
 static void ack_bad(struct irq_data *data)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index cc1a094..4a617d7 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -31,7 +31,7 @@ static int __init irq_affinity_setup(char *str)
 	cpulist_parse(str, irq_default_affinity);
 	/*
 	 * Set at least the boot cpu. We don't want to end up with
-	 * bugreports caused by random comandline masks
+	 * bugreports caused by random commandline masks
 	 */
 	cpumask_set_cpu(smp_processor_id(), irq_default_affinity);
 	return 1;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2881513..6cb7a9d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -62,7 +62,7 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * @name:	Optional user provided domain name
  * @pa:		Optional user-provided physical address
  *
- * Allocate a struct irqchip_fwid, and return a poiner to the embedded
+ * Allocate a struct irqchip_fwid, and return a pointer to the embedded
  * fwnode_handle (or NULL on failure).
  *
  * Note: The types IRQCHIP_FWNODE_NAMED and IRQCHIP_FWNODE_NAMED_ID are
@@ -665,7 +665,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 
 	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
 
-	/* Look for default domain if nececssary */
+	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL) {
@@ -906,7 +906,7 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 {
 	struct irq_data *data;
 
-	/* Look for default domain if nececssary */
+	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL)
@@ -1436,7 +1436,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
  * The whole process to setup an IRQ has been split into two steps.
  * The first step, __irq_domain_alloc_irqs(), is to allocate IRQ
  * descriptor and required hardware resources. The second step,
- * irq_domain_activate_irq(), is to program hardwares with preallocated
+ * irq_domain_activate_irq(), is to program the hardware with preallocated
  * resources. In this way, it's easier to rollback when failing to
  * allocate resources.
  */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 07ed2e4..e976c49 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -326,7 +326,7 @@ static bool irq_set_affinity_deactivated(struct irq_data *data,
 	 * If the interrupt is not yet activated, just store the affinity
 	 * mask and do not call the chip driver at all. On activation the
 	 * driver has to make sure anyway that the interrupt is in a
-	 * useable state so startup works.
+	 * usable state so startup works.
 	 */
 	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
 	    irqd_is_activated(data) || !irqd_affinity_on_activate(data))
@@ -1054,7 +1054,7 @@ again:
 	 * to IRQS_INPROGRESS and the irq line is masked forever.
 	 *
 	 * This also serializes the state of shared oneshot handlers
-	 * versus "desc->threads_onehsot |= action->thread_mask;" in
+	 * versus "desc->threads_oneshot |= action->thread_mask;" in
 	 * irq_wake_thread(). See the comment there which explains the
 	 * serialization.
 	 */
@@ -1909,7 +1909,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* Last action releases resources */
 	if (!desc->action) {
 		/*
-		 * Reaquire bus lock as irq_release_resources() might
+		 * Reacquire bus lock as irq_release_resources() might
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b338d62..c41965e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -5,7 +5,7 @@
  *
  * This file is licensed under GPLv2.
  *
- * This file contains common code to support Message Signalled Interrupt for
+ * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
 #include <linux/types.h>
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index c318605..d309d6f 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -485,7 +485,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 
 	/*
 	 * The interrupt triggered more than one second apart, that
-	 * ends the sequence as predictible for our purpose. In this
+	 * ends the sequence as predictable for our purpose. In this
 	 * case, assume we have the beginning of a sequence and the
 	 * timestamp is the first value. As it is impossible to
 	 * predict anything at this point, return.
