Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC529EBA5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgJ2MRO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ2MPm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:42 -0400
Date:   Thu, 29 Oct 2020 12:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSFqsfAOrF4hpkW1hAX8dila4Dob2Nx8/LKtAROW5NI=;
        b=Tqaa4b6HHVuGeWnwuXW2zSqgIAfQp30STDOU2mjmZ3j2H3CexE0Kxxe+PeLB1rawi/nG1F
        5EsNlo39C2xFGLDF73sWUzFHLrUrWOviRBXhjyX1Dc9Giwqsx8kZj7CIJ89/y7d22y0YIB
        Z4tkPCfcS+QEwouZ6Fjtk49zKtJ0oIyz+aRAX0mDJpBiXiRzdCRLozcYRNRQNVQ0AgPyz2
        pWI/Eo935gleyENum4ZhoqtnD7YjQVm/BFPNN3V6PFvHsxGAkIop7lNpX7ilo9brYbLABE
        DpRNDCQQwUtssf1tIFjUmwil8BBZtqhmpwXDvVrKcreaSqZM1cDcKbfYLN2/9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSFqsfAOrF4hpkW1hAX8dila4Dob2Nx8/LKtAROW5NI=;
        b=1eOwiNxS2aUUDkFkAOO+Ck86RgvtW8JRyK3U968Zq6Avv3mcy7Tv0Yfotpqy+E7mOFXlTu
        P4ekB8ewtsfoqgDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-20-dwmw2@infradead.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a27dca645d2c0f31abb7858aa0e10b2fa0f2f659
Gitweb:        https://git.kernel.org/tip/a27dca645d2c0f31abb7858aa0e10b2fa0f2f659
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

x86/io_apic: Cleanup trigger/polarity helpers

'trigger' and 'polarity' are used throughout the I/O-APIC code for handling
the trigger type (edge/level) and the active low/high configuration. While
there are defines for initializing these variables and struct members, they
are not used consequently and the meaning of 'trigger' and 'polarity' is
opaque and confusing at best.

Rename them to 'is_level' and 'active_low' and make them boolean in various
structs so it's entirely clear what the meaning is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-20-dwmw2@infradead.org

---
 arch/x86/include/asm/hw_irq.h       |   6 +-
 arch/x86/kernel/apic/io_apic.c      | 244 ++++++++++++---------------
 arch/x86/pci/intel_mid_pci.c        |   8 +-
 drivers/iommu/amd/iommu.c           |  10 +-
 drivers/iommu/intel/irq_remapping.c |   9 +-
 5 files changed, 130 insertions(+), 147 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index a4aeeaa..517847a 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -47,9 +47,9 @@ enum irq_alloc_type {
 struct ioapic_alloc_info {
 	int				pin;
 	int				node;
-	u32				trigger : 1;
-	u32				polarity : 1;
-	u32				valid : 1;
+	u32				is_level	: 1;
+	u32				active_low	: 1;
+	u32				valid		: 1;
 	struct IO_APIC_route_entry	*entry;
 };
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c6d92d2..24a7bba 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -89,12 +89,12 @@ struct irq_pin_list {
 };
 
 struct mp_chip_data {
-	struct list_head irq_2_pin;
-	struct IO_APIC_route_entry entry;
-	int trigger;
-	int polarity;
+	struct list_head		irq_2_pin;
+	struct IO_APIC_route_entry	entry;
+	bool				is_level;
+	bool				active_low;
+	bool				isa_irq;
 	u32 count;
-	bool isa_irq;
 };
 
 struct mp_ioapic_gsi {
@@ -745,44 +745,7 @@ static int __init find_isa_irq_apic(int irq, int type)
 	return -1;
 }
 
-#ifdef CONFIG_EISA
-/*
- * EISA Edge/Level control register, ELCR
- */
-static int EISA_ELCR(unsigned int irq)
-{
-	if (irq < nr_legacy_irqs()) {
-		unsigned int port = 0x4d0 + (irq >> 3);
-		return (inb(port) >> (irq & 7)) & 1;
-	}
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"Broken MPtable reports ISA irq %d\n", irq);
-	return 0;
-}
-
-#endif
-
-/* ISA interrupts are always active high edge triggered,
- * when listed as conforming in the MP table. */
-
-#define default_ISA_trigger(idx)	(IOAPIC_EDGE)
-#define default_ISA_polarity(idx)	(IOAPIC_POL_HIGH)
-
-/* EISA interrupts are always polarity zero and can be edge or level
- * trigger depending on the ELCR value.  If an interrupt is listed as
- * EISA conforming in the MP table, that means its trigger type must
- * be read in from the ELCR */
-
-#define default_EISA_trigger(idx)	(EISA_ELCR(mp_irqs[idx].srcbusirq))
-#define default_EISA_polarity(idx)	default_ISA_polarity(idx)
-
-/* PCI interrupts are always active low level triggered,
- * when listed as conforming in the MP table. */
-
-#define default_PCI_trigger(idx)	(IOAPIC_LEVEL)
-#define default_PCI_polarity(idx)	(IOAPIC_POL_LOW)
-
-static int irq_polarity(int idx)
+static bool irq_active_low(int idx)
 {
 	int bus = mp_irqs[idx].srcbus;
 
@@ -791,90 +754,139 @@ static int irq_polarity(int idx)
 	 */
 	switch (mp_irqs[idx].irqflag & MP_IRQPOL_MASK) {
 	case MP_IRQPOL_DEFAULT:
-		/* conforms to spec, ie. bus-type dependent polarity */
-		if (test_bit(bus, mp_bus_not_pci))
-			return default_ISA_polarity(idx);
-		else
-			return default_PCI_polarity(idx);
+		/*
+		 * Conforms to spec, ie. bus-type dependent polarity.  PCI
+		 * defaults to low active. [E]ISA defaults to high active.
+		 */
+		return !test_bit(bus, mp_bus_not_pci);
 	case MP_IRQPOL_ACTIVE_HIGH:
-		return IOAPIC_POL_HIGH;
+		return false;
 	case MP_IRQPOL_RESERVED:
 		pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
 		fallthrough;
 	case MP_IRQPOL_ACTIVE_LOW:
 	default: /* Pointless default required due to do gcc stupidity */
-		return IOAPIC_POL_LOW;
+		return true;
 	}
 }
 
 #ifdef CONFIG_EISA
-static int eisa_irq_trigger(int idx, int bus, int trigger)
+/*
+ * EISA Edge/Level control register, ELCR
+ */
+static bool EISA_ELCR(unsigned int irq)
+{
+	if (irq < nr_legacy_irqs()) {
+		unsigned int port = 0x4d0 + (irq >> 3);
+		return (inb(port) >> (irq & 7)) & 1;
+	}
+	apic_printk(APIC_VERBOSE, KERN_INFO
+			"Broken MPtable reports ISA irq %d\n", irq);
+	return false;
+}
+
+/*
+ * EISA interrupts are always active high and can be edge or level
+ * triggered depending on the ELCR value.  If an interrupt is listed as
+ * EISA conforming in the MP table, that means its trigger type must be
+ * read in from the ELCR.
+ */
+static bool eisa_irq_is_level(int idx, int bus, bool level)
 {
 	switch (mp_bus_id_to_type[bus]) {
 	case MP_BUS_PCI:
 	case MP_BUS_ISA:
-		return trigger;
+		return level;
 	case MP_BUS_EISA:
-		return default_EISA_trigger(idx);
+		return EISA_ELCR(mp_irqs[idx].srcbusirq);
 	}
 	pr_warn("IOAPIC: Invalid srcbus: %d defaulting to level\n", bus);
-	return IOAPIC_LEVEL;
+	return true;
 }
 #else
-static inline int eisa_irq_trigger(int idx, int bus, int trigger)
+static inline int eisa_irq_is_level(int idx, int bus, bool level)
 {
-	return trigger;
+	return level;
 }
 #endif
 
-static int irq_trigger(int idx)
+static bool irq_is_level(int idx)
 {
 	int bus = mp_irqs[idx].srcbus;
-	int trigger;
+	bool level;
 
 	/*
 	 * Determine IRQ trigger mode (edge or level sensitive):
 	 */
 	switch (mp_irqs[idx].irqflag & MP_IRQTRIG_MASK) {
 	case MP_IRQTRIG_DEFAULT:
-		/* conforms to spec, ie. bus-type dependent trigger mode */
-		if (test_bit(bus, mp_bus_not_pci))
-			trigger = default_ISA_trigger(idx);
-		else
-			trigger = default_PCI_trigger(idx);
+		/*
+		 * Conforms to spec, ie. bus-type dependent trigger
+		 * mode. PCI defaults to egde, ISA to level.
+		 */
+		level = test_bit(bus, mp_bus_not_pci);
 		/* Take EISA into account */
-		return eisa_irq_trigger(idx, bus, trigger);
+		return eisa_irq_is_level(idx, bus, level);
 	case MP_IRQTRIG_EDGE:
-		return IOAPIC_EDGE;
+		return false;
 	case MP_IRQTRIG_RESERVED:
 		pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
 		fallthrough;
 	case MP_IRQTRIG_LEVEL:
 	default: /* Pointless default required due to do gcc stupidity */
-		return IOAPIC_LEVEL;
+		return true;
 	}
 }
 
+static int __acpi_get_override_irq(u32 gsi, bool *trigger, bool *polarity)
+{
+	int ioapic, pin, idx;
+
+	if (skip_ioapic_setup)
+		return -1;
+
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0)
+		return -1;
+
+	pin = mp_find_ioapic_pin(ioapic, gsi);
+	if (pin < 0)
+		return -1;
+
+	idx = find_irq_entry(ioapic, pin, mp_INT);
+	if (idx < 0)
+		return -1;
+
+	*trigger = irq_is_level(idx);
+	*polarity = irq_active_low(idx);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+int acpi_get_override_irq(u32 gsi, int *is_level, int *active_low)
+{
+	*is_level = *active_low = 0;
+	return __acpi_get_override_irq(gsi, (bool *)is_level,
+				       (bool *)active_low);
+}
+#endif
+
 void ioapic_set_alloc_attr(struct irq_alloc_info *info, int node,
 			   int trigger, int polarity)
 {
 	init_irq_alloc_info(info, NULL);
 	info->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
 	info->ioapic.node = node;
-	info->ioapic.trigger = trigger;
-	info->ioapic.polarity = polarity;
+	info->ioapic.is_level = trigger;
+	info->ioapic.active_low = polarity;
 	info->ioapic.valid = 1;
 }
 
-#ifndef CONFIG_ACPI
-int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
-#endif
-
 static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
 				   struct irq_alloc_info *src,
 				   u32 gsi, int ioapic_idx, int pin)
 {
-	int trigger, polarity;
+	bool level, pol_low;
 
 	copy_irq_alloc_info(dst, src);
 	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
@@ -883,20 +895,20 @@ static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
 	dst->ioapic.valid = 1;
 	if (src && src->ioapic.valid) {
 		dst->ioapic.node = src->ioapic.node;
-		dst->ioapic.trigger = src->ioapic.trigger;
-		dst->ioapic.polarity = src->ioapic.polarity;
+		dst->ioapic.is_level = src->ioapic.is_level;
+		dst->ioapic.active_low = src->ioapic.active_low;
 	} else {
 		dst->ioapic.node = NUMA_NO_NODE;
-		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
-			dst->ioapic.trigger = trigger;
-			dst->ioapic.polarity = polarity;
+		if (__acpi_get_override_irq(gsi, &level, &pol_low) >= 0) {
+			dst->ioapic.is_level = level;
+			dst->ioapic.active_low = pol_low;
 		} else {
 			/*
 			 * PCI interrupts are always active low level
 			 * triggered.
 			 */
-			dst->ioapic.trigger = IOAPIC_LEVEL;
-			dst->ioapic.polarity = IOAPIC_POL_LOW;
+			dst->ioapic.is_level = true;
+			dst->ioapic.active_low = true;
 		}
 	}
 }
@@ -906,12 +918,12 @@ static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
 	return (info && info->ioapic.valid) ? info->ioapic.node : NUMA_NO_NODE;
 }
 
-static void mp_register_handler(unsigned int irq, unsigned long trigger)
+static void mp_register_handler(unsigned int irq, bool level)
 {
 	irq_flow_handler_t hdl;
 	bool fasteoi;
 
-	if (trigger) {
+	if (level) {
 		irq_set_status_flags(irq, IRQ_LEVEL);
 		fasteoi = true;
 	} else {
@@ -933,14 +945,14 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 	 * pin with real trigger and polarity attributes.
 	 */
 	if (irq < nr_legacy_irqs() && data->count == 1) {
-		if (info->ioapic.trigger != data->trigger)
-			mp_register_handler(irq, info->ioapic.trigger);
-		data->entry.trigger = data->trigger = info->ioapic.trigger;
-		data->entry.polarity = data->polarity = info->ioapic.polarity;
+		if (info->ioapic.is_level != data->is_level)
+			mp_register_handler(irq, info->ioapic.is_level);
+		data->entry.trigger = data->is_level = info->ioapic.is_level;
+		data->entry.polarity = data->active_low = info->ioapic.active_low;
 	}
 
-	return data->trigger == info->ioapic.trigger &&
-	       data->polarity == info->ioapic.polarity;
+	return data->is_level == info->ioapic.is_level &&
+	       data->active_low == info->ioapic.active_low;
 }
 
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
@@ -2179,9 +2191,9 @@ static inline void __init check_timer(void)
 			 * so only need to unmask if it is level-trigger
 			 * do we really have level trigger timer?
 			 */
-			int idx;
-			idx = find_irq_entry(apic1, pin1, mp_INT);
-			if (idx != -1 && irq_trigger(idx))
+			int idx = find_irq_entry(apic1, pin1, mp_INT);
+
+			if (idx != -1 && irq_is_level(idx))
 				unmask_ioapic_irq(irq_get_irq_data(0));
 		}
 		irq_domain_deactivate_irq(irq_data);
@@ -2588,30 +2600,6 @@ static int io_apic_get_version(int ioapic)
 	return reg_01.bits.version;
 }
 
-int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
-{
-	int ioapic, pin, idx;
-
-	if (skip_ioapic_setup)
-		return -1;
-
-	ioapic = mp_find_ioapic(gsi);
-	if (ioapic < 0)
-		return -1;
-
-	pin = mp_find_ioapic_pin(ioapic, gsi);
-	if (pin < 0)
-		return -1;
-
-	idx = find_irq_entry(ioapic, pin, mp_INT);
-	if (idx < 0)
-		return -1;
-
-	*trigger = irq_trigger(idx);
-	*polarity = irq_polarity(idx);
-	return 0;
-}
-
 /*
  * This function updates target affinity of IOAPIC interrupts to include
  * the CPUs which came online during SMP bringup.
@@ -2935,13 +2923,13 @@ static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 				  struct irq_alloc_info *info)
 {
 	if (info && info->ioapic.valid) {
-		data->trigger = info->ioapic.trigger;
-		data->polarity = info->ioapic.polarity;
-	} else if (acpi_get_override_irq(gsi, &data->trigger,
-					 &data->polarity) < 0) {
+		data->is_level = info->ioapic.is_level;
+		data->active_low = info->ioapic.active_low;
+	} else if (__acpi_get_override_irq(gsi, &data->is_level,
+					   &data->active_low) < 0) {
 		/* PCI interrupts are always active low level triggered. */
-		data->trigger = IOAPIC_LEVEL;
-		data->polarity = IOAPIC_POL_LOW;
+		data->is_level = true;
+		data->active_low = true;
 	}
 }
 
@@ -2953,16 +2941,13 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 	entry->dest_mode     = apic->dest_mode_logical;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
-	entry->trigger	     = data->trigger;
-	entry->polarity	     = data->polarity;
+	entry->trigger	     = data->is_level;
+	entry->polarity	     = data->active_low;
 	/*
 	 * Mask level triggered irqs. Edge triggered irqs are masked
 	 * by the irq core code in case they fire.
 	 */
-	if (data->trigger == IOAPIC_LEVEL)
-		entry->mask = IOAPIC_MASKED;
-	else
-		entry->mask = IOAPIC_UNMASKED;
+	entry->mask = data->is_level;
 }
 
 int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -3010,7 +2995,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	local_irq_save(flags);
 	if (info->ioapic.entry)
 		mp_setup_entry(cfg, data, info->ioapic.entry);
-	mp_register_handler(virq, data->trigger);
+	mp_register_handler(virq, data->is_level);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
 	local_irq_restore(flags);
@@ -3018,7 +3003,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	apic_printk(APIC_VERBOSE, KERN_DEBUG
 		    "IOAPIC[%d]: Set routing entry (%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i Dest:%d)\n",
 		    ioapic, mpc_ioapic_id(ioapic), pin, cfg->vector,
-		    virq, data->trigger, data->polarity, cfg->dest_apicid);
+		    virq, data->is_level, data->active_low,
+		    cfg->dest_apicid);
 
 	return 0;
 }
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 24ca4ee..95e2e6b 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -215,7 +215,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
-	int polarity;
+	bool polarity_low;
 	int ret;
 	u8 gsi;
 
@@ -230,7 +230,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 	switch (intel_mid_identify_cpu()) {
 	case INTEL_MID_CPU_CHIP_TANGIER:
-		polarity = IOAPIC_POL_HIGH;
+		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
 		if (gsi == 0) {
@@ -252,11 +252,11 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		}
 		break;
 	default:
-		polarity = IOAPIC_POL_LOW;
+		polarity_low = true;
 		break;
 	}
 
-	ioapic_set_alloc_attr(&info, dev_to_node(&dev->dev), 1, polarity);
+	ioapic_set_alloc_attr(&info, dev_to_node(&dev->dev), 1, polarity_low);
 
 	/*
 	 * MRST only have IOAPIC, the PCI irq lines are 1:1 mapped to
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 473de09..b0e5210 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3687,13 +3687,11 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 		entry = info->ioapic.entry;
 		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
-		entry->vector        = index;
-		entry->mask          = 0;
-		entry->trigger       = info->ioapic.trigger;
-		entry->polarity      = info->ioapic.polarity;
+		entry->vector	= index;
+		entry->trigger	= info->ioapic.is_level;
+		entry->polarity	= info->ioapic.active_low;
 		/* Mask level triggered irqs. */
-		if (info->ioapic.trigger)
-			entry->mask = 1;
+		entry->mask	= info->ioapic.is_level;
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 30269b7..54ca693 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1306,11 +1306,10 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		 * irq handler will do the explicit EOI to the io-apic.
 		 */
 		entry->vector	= info->ioapic.pin;
-		entry->mask	= 0;			/* enable IRQ */
-		entry->trigger	= info->ioapic.trigger;
-		entry->polarity	= info->ioapic.polarity;
-		if (info->ioapic.trigger)
-			entry->mask = 1; /* Mask level triggered irqs. */
+		entry->trigger	= info->ioapic.is_level;
+		entry->polarity	= info->ioapic.active_low;
+		/* Mask level triggered irqs. */
+		entry->mask	= info->ioapic.is_level;
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
