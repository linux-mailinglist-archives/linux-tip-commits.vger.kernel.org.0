Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8E3E856E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhHJVgL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhHJVgJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:09 -0400
Date:   Tue, 10 Aug 2021 21:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlchAhQRjD5je/Q62Zr2voWdwZXycbAlk0d9EwiJ4uI=;
        b=hQZlEMDAkg/czQMaX11shXkvFB2dyeJeJ4zmncz+c84FoXzGTr2f2fqWqoXfz31BVzpi52
        241zDeKd1WHQzn9qRs/ELrmB6LjSxtLiZxzu1fD0KtoOyumSxyJprujyLWQZ1H/9b+SUb9
        huLjPvExei42tjJKL0l7oQ6ZBy7WS8dY5RcHuNJIkDhmA6wwvmVA/1a6ZwWLwV2fm8zJCh
        CwIZudsOps6FZeFnBAnpqoI8HvBep/4XTBLMw6k5mNSBvacbAMUaulfM8+DV1HT01C/KAh
        gVoR2sK9Q9Z8cBH6LemhFpeQrGdoYMH9qHO3Tojg8H91bi/mJGIzMs7IOMa22w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlchAhQRjD5je/Q62Zr2voWdwZXycbAlk0d9EwiJ4uI=;
        b=2m0DFyRtP8mD1h2/7CdT4D3PBR5jL2qipKveYq84UyaLGmbgl1mdqtGL6YLHPyb9UkJRfW
        P2jWRYnpxdKiPABg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107191702020.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107191702020.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134453.395.9644225791689896910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     1ce849c755342b236fc6236dfe39dbbf536b64b6
Gitweb:        https://git.kernel.org/tip/1ce849c755342b236fc6236dfe39dbbf536b64b6
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:27:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:43 +02:00

x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router

The ALi M1487 ISA Bus Controller (IBC), a part of the ALi FinALi 486 
chipset, implements PCI interrupt steering with a PIRQ router[1] in the 
form of four 4-bit mappings, spread across two PCI INTx Routing Table 
Mapping Registers, available in the port I/O space accessible indirectly 
via the index/data register pair at 0x22/0x23, located at indices 0x42 
and 0x43 for the INT1/INT2 and INT3/INT4 lines respectively.

Additionally there is a separate PCI INTx Sensitivity Register at index 
0x44 in the same port I/O space, whose bits 3:0 select the trigger mode 
for INT[4:1] lines respectively[2].  Manufacturer's documentation says 
that this register has to be set consistently with the relevant ELCR 
register[3].  Add a router-specific hook then and use it to handle this 
register.

Accesses to the port I/O space concerned here need to be unlocked by 
writing the value of 0xc5 to the Lock Register at index 0x03 
beforehand[4].  Do so then and then lock access after use for safety.

The IBC is implemented as a peer bridge on the host bus rather than a 
southbridge on PCI and therefore it does not itself appear in the PCI 
configuration space.  It is complemented by the M1489 Cache-Memory PCI 
Controller (CMP) host-to-PCI bridge, so use that device's identification 
for determining the presence of the IBC.

References:

[1] "M1489/M1487: 486 PCI Chip Set", Version 1.2, Acer Laboratories 
    Inc., July 1997, Section 4: "Configuration Registers", pp. 76-77

[2] same, p. 77

[3] same, Section 5: "M1489/M1487 Software Programming Guide", pp. 
    99-100

[4] same, Section 4: "Configuration Registers", p. 37

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107191702020.9461@angie.orcam.me.uk

---
 arch/x86/pci/irq.c      | 154 ++++++++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h |   1 +-
 2 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index d3a73f9..1bccbc4 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -13,9 +13,12 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <asm/io_apic.h>
 #include <linux/irq.h>
 #include <linux/acpi.h>
+
+#include <asm/pc-conf-reg.h>
 #include <asm/pci_x86.h>
 
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
@@ -47,6 +50,8 @@ struct irq_router {
 	int (*get)(struct pci_dev *router, struct pci_dev *dev, int pirq);
 	int (*set)(struct pci_dev *router, struct pci_dev *dev, int pirq,
 		int new);
+	int (*lvl)(struct pci_dev *router, struct pci_dev *dev, int pirq,
+		int irq);
 };
 
 struct irq_router_handler {
@@ -170,6 +175,139 @@ void elcr_set_level_irq(unsigned int irq)
 }
 
 /*
+ *	PIRQ routing for the M1487 ISA Bus Controller (IBC) ASIC used
+ *	with the ALi FinALi 486 chipset.  The IBC is not decoded in the
+ *	PCI configuration space, so we identify it by the accompanying
+ *	M1489 Cache-Memory PCI Controller (CMP) ASIC.
+ *
+ *	There are four 4-bit mappings provided, spread across two PCI
+ *	INTx Routing Table Mapping Registers, available in the port I/O
+ *	space accessible indirectly via the index/data register pair at
+ *	0x22/0x23, located at indices 0x42 and 0x43 for the INT1/INT2
+ *	and INT3/INT4 lines respectively.  The INT1/INT3 and INT2/INT4
+ *	lines are mapped in the low and the high 4-bit nibble of the
+ *	corresponding register as follows:
+ *
+ *	0000 : Disabled
+ *	0001 : IRQ9
+ *	0010 : IRQ3
+ *	0011 : IRQ10
+ *	0100 : IRQ4
+ *	0101 : IRQ5
+ *	0110 : IRQ7
+ *	0111 : IRQ6
+ *	1000 : Reserved
+ *	1001 : IRQ11
+ *	1010 : Reserved
+ *	1011 : IRQ12
+ *	1100 : Reserved
+ *	1101 : IRQ14
+ *	1110 : Reserved
+ *	1111 : IRQ15
+ *
+ *	In addition to the usual ELCR register pair there is a separate
+ *	PCI INTx Sensitivity Register at index 0x44 in the same port I/O
+ *	space, whose bits 3:0 select the trigger mode for INT[4:1] lines
+ *	respectively.  Any bit set to 1 causes interrupts coming on the
+ *	corresponding line to be passed to ISA as edge-triggered and
+ *	otherwise they are passed as level-triggered.  Manufacturer's
+ *	documentation says this register has to be set consistently with
+ *	the relevant ELCR register.
+ *
+ *	Accesses to the port I/O space concerned here need to be unlocked
+ *	by writing the value of 0xc5 to the Lock Register at index 0x03
+ *	beforehand.  Any other value written to said register prevents
+ *	further accesses from reaching the register file, except for the
+ *	Lock Register being written with 0xc5 again.
+ *
+ *	References:
+ *
+ *	"M1489/M1487: 486 PCI Chip Set", Version 1.2, Acer Laboratories
+ *	Inc., July 1997
+ */
+
+#define PC_CONF_FINALI_LOCK		0x03u
+#define PC_CONF_FINALI_PCI_INTX_RT1	0x42u
+#define PC_CONF_FINALI_PCI_INTX_RT2	0x43u
+#define PC_CONF_FINALI_PCI_INTX_SENS	0x44u
+
+#define PC_CONF_FINALI_LOCK_KEY		0xc5u
+
+static u8 read_pc_conf_nybble(u8 base, u8 index)
+{
+	u8 reg = base + (index >> 1);
+	u8 x;
+
+	x = pc_conf_get(reg);
+	return index & 1 ? x >> 4 : x & 0xf;
+}
+
+static void write_pc_conf_nybble(u8 base, u8 index, u8 val)
+{
+	u8 reg = base + (index >> 1);
+	u8 x;
+
+	x = pc_conf_get(reg);
+	x = index & 1 ? (x & 0x0f) | (val << 4) : (x & 0xf0) | val;
+	pc_conf_set(reg, x);
+}
+
+static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
+{
+	static const u8 irqmap[16] = {
+		0, 9, 3, 10, 4, 5, 7, 6, 0, 11, 0, 12, 0, 14, 0, 15
+	};
+	unsigned long flags;
+	u8 x;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	x = irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1)];
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return x;
+}
+
+static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	static const u8 irqmap[16] = {
+		0, 0, 0, 2, 4, 5, 7, 6, 0, 1, 3, 9, 11, 0, 13, 15
+	};
+	u8 val = irqmap[irq];
+	unsigned long flags;
+
+	if (!val)
+		return 0;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1, val);
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
+static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	u8 mask = ~(1u << (pirq - 1));
+	unsigned long flags;
+	u8 trig;
+
+	elcr_set_level_irq(irq);
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	trig = pc_conf_get(PC_CONF_FINALI_PCI_INTX_SENS);
+	trig &= mask;
+	pc_conf_set(PC_CONF_FINALI_PCI_INTX_SENS, trig);
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
+/*
  * Common IRQ routing practice: nibbles in config space,
  * offset by some magic constant.
  */
@@ -745,6 +883,12 @@ static __init int ite_router_probe(struct irq_router *r, struct pci_dev *router,
 static __init int ali_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
 	switch (device) {
+	case PCI_DEVICE_ID_AL_M1489:
+		r->name = "FinALi";
+		r->get = pirq_finali_get;
+		r->set = pirq_finali_set;
+		r->lvl = pirq_finali_lvl;
+		return 1;
 	case PCI_DEVICE_ID_AL_M1533:
 	case PCI_DEVICE_ID_AL_M1563:
 		r->name = "ALI";
@@ -968,11 +1112,17 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq)) && \
 	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask))) {
 		msg = "found";
-		elcr_set_level_irq(irq);
+		if (r->lvl)
+			r->lvl(pirq_router_dev, dev, pirq, irq);
+		else
+			elcr_set_level_irq(irq);
 	} else if (newirq && r->set &&
 		(dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
-			elcr_set_level_irq(newirq);
+			if (r->lvl)
+				r->lvl(pirq_router_dev, dev, pirq, newirq);
+			else
+				elcr_set_level_irq(newirq);
 			msg = "assigned";
 			irq = newirq;
 		}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac183..256fa4d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1121,6 +1121,7 @@
 #define PCI_DEVICE_ID_3COM_3CR990SVR	0x990a
 
 #define PCI_VENDOR_ID_AL		0x10b9
+#define PCI_DEVICE_ID_AL_M1489		0x1489
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1535		0x1535
 #define PCI_DEVICE_ID_AL_M1541		0x1541
