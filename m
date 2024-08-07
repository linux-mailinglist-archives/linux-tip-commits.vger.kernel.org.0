Return-Path: <linux-tip-commits+bounces-1974-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD694AE00
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18395284497
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C013A3FF;
	Wed,  7 Aug 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="siYIUpFP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K6SY75K1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FE132117;
	Wed,  7 Aug 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047929; cv=none; b=Cxmpcka3pSS3ANPBlSnLuAxcd++Lm3Q2RnzqBp76Nb0wnUAoQUVXn83E5gQDmT1SA/JiYX71rYmWd7+E/DAfUkQppNmKuO2mimgMmvHGHYkU7PE1mayX4IdbgyBhyPOAFslL6e8S4f6E9fJJxltq6GPbAwV++TejZObwDfpDsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047929; c=relaxed/simple;
	bh=HNMSi/pt+CVBj9YzNbZybjdw4WLut1cLx940J03YIm0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NhsXC/Qhj9vQrw9HwFcSkNhhdgLNYHmpL69fk9SrBOOfeqnGFvbToXsnLyfD2AMlblxb8y62KrHdLUTxwtFn933tOeQdalWGD19/ftsnxV/NJ+SQhXIR2a0W2oKz+9yxvpUhVjds3Hz1IRDfye+tZVUbeEeD1omcRPyYL/ma80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=siYIUpFP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K6SY75K1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIJKtiWRooMH/Uu/O5D9ERcuQPW/psdGqC6TjZ2EUoY=;
	b=siYIUpFPjhbpICKLydtNctk7ytopZKu8d60oAFPNXVnLfleDDAKe0GrdPuTxSIJkZn8nU4
	czNsBQLHAx+j0DM9PWw1BXi4r4bne/uvLZHwXW8wxeLAGBorW7flWN0bfDeSnDDQdZpU44
	Ojg+dReo1rjrUN0sMZLdZrmHrCwj1nU3uC7ZYWIpi55FyzRBHd5zdNZ0AkmLqvadr/lbQm
	dXYEKle61tJiqhflhLEaeaPo82DDInzOcFiScgUOkHHtGQuEuy9l4lk3R2gu6yMO21Crxn
	6FFsZEXmfv4buwfeuYEmcBYIG7ZklOh4SrmReBmD4YPtPN1uyjBnmr+OTtcPxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIJKtiWRooMH/Uu/O5D9ERcuQPW/psdGqC6TjZ2EUoY=;
	b=K6SY75K1J/93UsFyWa6/Zblo/QKGoxj9zpppcKYSNw6obYsLvEzYLLfM7RKhNsTlvcePEq
	PhQ+ch7U7Is2LyAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup line breaks
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155441.095653193@linutronix.de>
References: <20240802155441.095653193@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792541.2215.2723956442841188830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     966e09b1862555267effa1db9032dc3dbc0cc588
Gitweb:        https://git.kernel.org/tip/966e09b1862555267effa1db9032dc3dbc0cc588
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:29 +02:00

x86/ioapic: Cleanup line breaks

80 character limit is history.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155441.095653193@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 55 ++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8d81c47..051779f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -637,10 +637,8 @@ static int __init find_isa_irq_pin(int irq, int type)
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].srcbus;
 
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype == type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype == type) &&
 		    (mp_irqs[i].srcbusirq == irq))
-
 			return mp_irqs[i].dstirq;
 	}
 	return -1;
@@ -653,8 +651,7 @@ static int __init find_isa_irq_apic(int irq, int type)
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].srcbus;
 
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype == type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype == type) &&
 		    (mp_irqs[i].srcbusirq == irq))
 			break;
 	}
@@ -907,8 +904,7 @@ static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 		return -1;
 	}
 
-	return __irq_domain_alloc_irqs(domain, irq, 1,
-				       ioapic_alloc_attr_node(info),
+	return __irq_domain_alloc_irqs(domain, irq, 1, ioapic_alloc_attr_node(info),
 				       info, legacy, NULL);
 }
 
@@ -922,13 +918,12 @@ static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
  * PIRQs instead of reprogramming the interrupt routing logic. Thus there may be
  * multiple pins sharing the same legacy IRQ number when ACPI is disabled.
  */
-static int alloc_isa_irq_from_domain(struct irq_domain *domain,
-				     int irq, int ioapic, int pin,
+static int alloc_isa_irq_from_domain(struct irq_domain *domain, int irq, int ioapic, int pin,
 				     struct irq_alloc_info *info)
 {
-	struct mp_chip_data *data;
 	struct irq_data *irq_data = irq_get_irq_data(irq);
 	int node = ioapic_alloc_attr_node(info);
+	struct mp_chip_data *data;
 
 	/*
 	 * Legacy ISA IRQ has already been allocated, just add pin to
@@ -942,8 +937,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
-		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
-					      NULL);
+		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true, NULL);
 		if (irq >= 0) {
 			irq_data = irq_domain_get_irq_data(domain, irq);
 			data = irq_data->chip_data;
@@ -1121,8 +1115,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, int slot, int pin)
 		return -1;
 
 out:
-	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq,
-			 IOAPIC_MAP_ALLOC);
+	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq, IOAPIC_MAP_ALLOC);
 }
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 
@@ -1293,14 +1286,12 @@ void __init enable_IO_APIC(void)
 		 * If the interrupt line is enabled and in ExtInt mode I
 		 * have found the pin where the i8259 is connected.
 		 */
-		if (!entry.masked &&
-		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
+		if (!entry.masked && entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
-			goto found_i8259;
+			break;
 		}
 	}
- found_i8259:
 
 	/*
 	 * Look to see what if the MP table has reported the ExtINT
@@ -1496,8 +1487,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000ULL / HZ &&
-		time_before_eq(jiffies, end));
+	} while ((now - start) < 40000000000ULL / HZ &&	time_before_eq(jiffies, end));
 }
 
 static void __init delay_without_tsc(void)
@@ -1912,20 +1902,17 @@ static inline void init_IO_APIC_traps(void)
 /*
  * The local APIC irq-chip implementation:
  */
-
 static void mask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v = apic_read(APIC_LVT0);
 
-	v = apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 }
 
 static void unmask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v = apic_read(APIC_LVT0);
 
-	v = apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v & ~APIC_LVT_MASKED);
 }
 
@@ -1944,8 +1931,7 @@ static struct irq_chip lapic_chip __read_mostly = {
 static void lapic_register_intr(int irq)
 {
 	irq_clear_status_flags(irq, IRQ_LEVEL);
-	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq,
-				      "edge");
+	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq, "edge");
 }
 
 /*
@@ -2265,10 +2251,8 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
 
-	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
-	    cfg->type == IOAPIC_DOMAIN_STRICT)
-		ioapic_dynirq_base = max(ioapic_dynirq_base,
-					 gsi_cfg->gsi_end + 1);
+	if (cfg->type == IOAPIC_DOMAIN_LEGACY || cfg->type == IOAPIC_DOMAIN_STRICT)
+		ioapic_dynirq_base = max(ioapic_dynirq_base, gsi_cfg->gsi_end + 1);
 
 	return 0;
 }
@@ -2682,8 +2666,7 @@ static int find_free_ioapic_entry(void)
  * @gsi_base:	base of GSI associated with the IOAPIC
  * @cfg:	configuration information for the IOAPIC
  */
-int mp_register_ioapic(int id, u32 address, u32 gsi_base,
-		       struct ioapic_domain_cfg *cfg)
+int mp_register_ioapic(int id, u32 address, u32 gsi_base, struct ioapic_domain_cfg *cfg)
 {
 	bool hotplug = !!ioapic_initialized;
 	struct mp_ioapic_gsi *gsi_cfg;
@@ -2835,8 +2818,7 @@ static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 	if (info && info->ioapic.valid) {
 		data->is_level = info->ioapic.is_level;
 		data->active_low = info->ioapic.active_low;
-	} else if (__acpi_get_override_irq(gsi, &data->is_level,
-					   &data->active_low) < 0) {
+	} else if (__acpi_get_override_irq(gsi, &data->is_level, &data->active_low) < 0) {
 		/* PCI interrupts are always active low level triggered. */
 		data->is_level = true;
 		data->active_low = true;
@@ -2956,8 +2938,7 @@ void mp_irqdomain_deactivate(struct irq_domain *domain,
 			     struct irq_data *irq_data)
 {
 	/* It won't be called for IRQ with multiple IOAPIC pins associated */
-	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
-			  (int)irq_data->hwirq);
+	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain), (int)irq_data->hwirq);
 }
 
 int mp_irqdomain_ioapic_idx(struct irq_domain *domain)

