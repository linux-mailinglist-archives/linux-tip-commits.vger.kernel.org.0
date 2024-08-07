Return-Path: <linux-tip-commits+bounces-1984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E094AE12
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FE7B24AF8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9313E88B;
	Wed,  7 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIxvxnlQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzG0JWjB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096813C3C2;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047933; cv=none; b=DWfwfAb9V68rc4tm4ZycPprM4W+RTfgLgw9FbfUDmSdQqYR2j1mFkBuJBaT0fc6BAwSqIST6P+XP4QiPeQmNSTdT0qDAlajYnwxHDbXp705veP18rSPDsPqOEgvGaGfk4bWamxUwbsnjuubYBKxdMZyEpcJmgZIF9KOiZHCbthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047933; c=relaxed/simple;
	bh=g1YnThktkCMihcbe/19dqOpj0vHK1s8BKz5amUOkzK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XSQpXzILgJzcSufKsolSaCrJ+rc7rFbLJYvPGnPjD0ZMZI1M2ubdBCbQKqefRJ2MD8UD1itDrzAkTUKAzgkvC0FbbgitAQbBvO45HbgywCqevmAfdDiQ2Lt5nrEfVDJZtQGxK/41qmcsMqm8Jt8EB3eGnU11dw4OUn5WxB0wcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIxvxnlQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzG0JWjB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJC19AF93kDEIdzEaffckRQVvJ+V2gSwW9zgq3PlDEo=;
	b=MIxvxnlQp88iMSaf/OWGcgT2oNYZeMBa8bKbp/OCOiJ/NL8x0BbBJntKayc//nPcFs0lvz
	XzLHvmkJjr0cgtNbY69LYdrKWr39ZJ+VH4KrhGGlrp+gCRWH07qTZG7R6WTVAl7oWF6IFh
	8BYCk1OHmOj+l7SqxgEHhehsMW7tuCh+psVJnhvcZY/YouIShh2MRANY6Y3rRwj3US4FCi
	bpXvhWVknRBnfjfg/ZuXpVvi0zjLPSoiHdg6aTuWWsI8cVblh01FIHOuOmUZMa9elofMSi
	t2s8XDh3r5iv8DZTeJUSyl/czrjIWepouaw+qf4CKJasmdosfLxgocexkkMlRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJC19AF93kDEIdzEaffckRQVvJ+V2gSwW9zgq3PlDEo=;
	b=pzG0JWjBGuzoG/CtuiGaG3OjDeSQcPY1NqN1PwjeUxpfofyL4G3HQaCHPoMMjgifnk10gT
	4hKxzbt+5FHoIQDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup apic_printk()s
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.652239904@linutronix.de>
References: <20240802155440.652239904@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792875.2215.4552747680409188302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f47998da395c1dfa53449bd335db4cf508be5275
Gitweb:        https://git.kernel.org/tip/f47998da395c1dfa53449bd335db4cf508be5275
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/ioapic: Cleanup apic_printk()s

Replace apic_printk($LEVEL) with the corresponding apic_pr_*() helpers and
use pr_info() for APIC_QUIET as that is always printed so the indirection
is pointless noise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.652239904@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 176 +++++++++++++-------------------
 1 file changed, 73 insertions(+), 103 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 4715e2f..b978326 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -201,10 +201,9 @@ void mp_save_irq(struct mpc_intsrc *m)
 {
 	int i;
 
-	apic_printk(APIC_VERBOSE, "Int: type %d, pol %d, trig %d, bus %02x,"
-		" IRQ %02x, APIC ID %x, APIC INT %02x\n",
-		m->irqtype, m->irqflag & 3, (m->irqflag >> 2) & 3, m->srcbus,
-		m->srcbusirq, m->dstapic, m->dstirq);
+	apic_pr_verbose("Int: type %d, pol %d, trig %d, bus %02x, IRQ %02x, APIC ID %x, APIC INT %02x\n",
+			m->irqtype, m->irqflag & 3, (m->irqflag >> 2) & 3, m->srcbus,
+			m->srcbusirq, m->dstapic, m->dstirq);
 
 	for (i = 0; i < mp_irq_entries; i++) {
 		if (!memcmp(&mp_irqs[i], m, sizeof(*m)))
@@ -554,28 +553,23 @@ static int pirq_entries[MAX_PIRQS] = {
 
 static int __init ioapic_pirq_setup(char *str)
 {
-	int i, max;
-	int ints[MAX_PIRQS+1];
+	int i, max, ints[MAX_PIRQS+1];
 
 	get_options(str, ARRAY_SIZE(ints), ints);
 
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"PIRQ redirection, working around broken MP-BIOS.\n");
+	apic_pr_verbose("PIRQ redirection, working around broken MP-BIOS.\n");
+
 	max = MAX_PIRQS;
 	if (ints[0] < MAX_PIRQS)
 		max = ints[0];
 
 	for (i = 0; i < max; i++) {
-		apic_printk(APIC_VERBOSE, KERN_DEBUG
-				"... PIRQ%d -> IRQ %d\n", i, ints[i+1]);
-		/*
-		 * PIRQs are mapped upside down, usually.
-		 */
+		apic_pr_verbose("... PIRQ%d -> IRQ %d\n", i, ints[i + 1]);
+		/* PIRQs are mapped upside down, usually */
 		pirq_entries[MAX_PIRQS-i-1] = ints[i+1];
 	}
 	return 1;
 }
-
 __setup("pirq=", ioapic_pirq_setup);
 #endif /* CONFIG_X86_32 */
 
@@ -737,8 +731,7 @@ static bool EISA_ELCR(unsigned int irq)
 		unsigned int port = PIC_ELCR1 + (irq >> 3);
 		return (inb(port) >> (irq & 7)) & 1;
 	}
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"Broken MPtable reports ISA irq %d\n", irq);
+	apic_pr_verbose("Broken MPtable reports ISA irq %d\n", irq);
 	return false;
 }
 
@@ -1052,15 +1045,13 @@ static int pin_2_irq(int idx, int ioapic, int pin, unsigned int flags)
 	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
 	 */
 	if ((pin >= 16) && (pin <= 23)) {
-		if (pirq_entries[pin-16] != -1) {
-			if (!pirq_entries[pin-16]) {
-				apic_printk(APIC_VERBOSE, KERN_DEBUG
-						"disabling PIRQ%d\n", pin-16);
+		if (pirq_entries[pin - 16] != -1) {
+			if (!pirq_entries[pin - 16]) {
+				apic_pr_verbose("Disabling PIRQ%d\n", pin - 16);
 			} else {
 				int irq = pirq_entries[pin-16];
-				apic_printk(APIC_VERBOSE, KERN_DEBUG
-						"using PIRQ%d -> IRQ %d\n",
-						pin-16, irq);
+
+				apic_pr_verbose("Using PIRQ%d -> IRQ %d\n", pin - 16, irq);
 				return irq;
 			}
 		}
@@ -1111,12 +1102,10 @@ int IO_APIC_get_PCI_irq_vector(int bus, int slot, int pin)
 {
 	int irq, i, best_ioapic = -1, best_idx = -1;
 
-	apic_printk(APIC_DEBUG,
-		    "querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
-		    bus, slot, pin);
+	apic_pr_debug("Querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
+		      bus, slot, pin);
 	if (test_bit(bus, mp_bus_not_pci)) {
-		apic_printk(APIC_VERBOSE,
-			    "PCI BIOS passed nonexistent PCI bus %d!\n", bus);
+		apic_pr_verbose("PCI BIOS passed nonexistent PCI bus %d!\n", bus);
 		return -1;
 	}
 
@@ -1173,17 +1162,16 @@ static void __init setup_IO_APIC_irqs(void)
 	unsigned int ioapic, pin;
 	int idx;
 
-	apic_printk(APIC_VERBOSE, KERN_DEBUG "init IO_APIC IRQs\n");
+	apic_pr_verbose("Init IO_APIC IRQs\n");
 
 	for_each_ioapic_pin(ioapic, pin) {
 		idx = find_irq_entry(ioapic, pin, mp_INT);
-		if (idx < 0)
-			apic_printk(APIC_VERBOSE,
-				    KERN_DEBUG " apic %d pin %d not connected\n",
-				    mpc_ioapic_id(ioapic), pin);
-		else
-			pin_2_irq(idx, ioapic, pin,
-				  ioapic ? 0 : IOAPIC_MAP_ALLOC);
+		if (idx < 0) {
+			apic_pr_verbose("apic %d pin %d not connected\n",
+					mpc_ioapic_id(ioapic), pin);
+		} else {
+			pin_2_irq(idx, ioapic, pin, ioapic ? 0 : IOAPIC_MAP_ALLOC);
+		}
 	}
 }
 
@@ -1359,29 +1347,24 @@ void __init enable_IO_APIC(void)
 	i8259_apic = find_isa_irq_apic(0, mp_ExtINT);
 	/* Trust the MP table if nothing is setup in the hardware */
 	if ((ioapic_i8259.pin == -1) && (i8259_pin >= 0)) {
-		printk(KERN_WARNING "ExtINT not setup in hardware but reported by MP table\n");
+		pr_warn("ExtINT not setup in hardware but reported by MP table\n");
 		ioapic_i8259.pin  = i8259_pin;
 		ioapic_i8259.apic = i8259_apic;
 	}
 	/* Complain if the MP table and the hardware disagree */
 	if (((ioapic_i8259.apic != i8259_apic) || (ioapic_i8259.pin != i8259_pin)) &&
-		(i8259_pin >= 0) && (ioapic_i8259.pin >= 0))
-	{
-		printk(KERN_WARNING "ExtINT in hardware and MP table differ\n");
-	}
+	    (i8259_pin >= 0) && (ioapic_i8259.pin >= 0))
+		pr_warn("ExtINT in hardware and MP table differ\n");
 
-	/*
-	 * Do not trust the IO-APIC being empty at bootup
-	 */
+	/* Do not trust the IO-APIC being empty at bootup */
 	clear_IO_APIC();
 }
 
 void native_restore_boot_irq_mode(void)
 {
 	/*
-	 * If the i8259 is routed through an IOAPIC
-	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrupts can be delivered.
+	 * If the i8259 is routed through an IOAPIC Put that IOAPIC in
+	 * virtual wire mode so legacy interrupts can be delivered.
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
@@ -1469,8 +1452,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 			set_bit(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
-			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
-				    mpc_ioapic_id(ioapic_idx));
+			apic_pr_verbose("Setting %d in the phys_id_present_map\n",
+					mpc_ioapic_id(ioapic_idx));
 			set_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
 
@@ -1491,9 +1474,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		if (mpc_ioapic_id(ioapic_idx) == reg_00.bits.ID)
 			continue;
 
-		apic_printk(APIC_VERBOSE, KERN_INFO
-			"...changing IO-APIC physical APIC ID to %d ...",
-			mpc_ioapic_id(ioapic_idx));
+		apic_pr_verbose("...changing IO-APIC physical APIC ID to %d ...",
+				mpc_ioapic_id(ioapic_idx));
 
 		reg_00.bits.ID = mpc_ioapic_id(ioapic_idx);
 		scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
@@ -1504,7 +1486,7 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		if (reg_00.bits.ID != mpc_ioapic_id(ioapic_idx))
 			pr_cont("could not set ID!\n");
 		else
-			apic_printk(APIC_VERBOSE, " ok.\n");
+			apic_pr_verbose(" ok.\n");
 	}
 }
 
@@ -2136,9 +2118,8 @@ static inline void __init check_timer(void)
 	pin2  = ioapic_i8259.pin;
 	apic2 = ioapic_i8259.apic;
 
-	apic_printk(APIC_QUIET, KERN_INFO "..TIMER: vector=0x%02X "
-		    "apic1=%d pin1=%d apic2=%d pin2=%d\n",
-		    cfg->vector, apic1, pin1, apic2, pin2);
+	pr_info("..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n",
+		cfg->vector, apic1, pin1, apic2, pin2);
 
 	/*
 	 * Some BIOS writers are clueless and report the ExtINTA
@@ -2182,13 +2163,10 @@ static inline void __init check_timer(void)
 		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
-			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
-				    "8254 timer not connected to IO-APIC\n");
+			pr_err("..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 
-		apic_printk(APIC_QUIET, KERN_INFO "...trying to set up timer "
-			    "(IRQ0) through the 8259A ...\n");
-		apic_printk(APIC_QUIET, KERN_INFO
-			    "..... (found apic %d pin %d) ...\n", apic2, pin2);
+		pr_info("...trying to set up timer (IRQ0) through the 8259A ...\n");
+		pr_info("..... (found apic %d pin %d) ...\n", apic2, pin2);
 		/*
 		 * legacy devices should be connected to IO APIC #0
 		 */
@@ -2197,7 +2175,7 @@ static inline void __init check_timer(void)
 		irq_domain_activate_irq(irq_data, false);
 		legacy_pic->unmask(0);
 		if (timer_irq_works()) {
-			apic_printk(APIC_QUIET, KERN_INFO "....... works.\n");
+			pr_info("....... works.\n");
 			goto out;
 		}
 		/*
@@ -2205,26 +2183,24 @@ static inline void __init check_timer(void)
 		 */
 		legacy_pic->mask(0);
 		clear_IO_APIC_pin(apic2, pin2);
-		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
+		pr_info("....... failed.\n");
 	}
 
-	apic_printk(APIC_QUIET, KERN_INFO
-		    "...trying to set up timer as Virtual Wire IRQ...\n");
+	pr_info("...trying to set up timer as Virtual Wire IRQ...\n");
 
 	lapic_register_intr(0);
 	apic_write(APIC_LVT0, APIC_DM_FIXED | cfg->vector);	/* Fixed mode */
 	legacy_pic->unmask(0);
 
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
+		pr_info("..... works.\n");
 		goto out;
 	}
 	legacy_pic->mask(0);
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
-	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
+	pr_info("..... failed.\n");
 
-	apic_printk(APIC_QUIET, KERN_INFO
-		    "...trying to set up timer as ExtINT IRQ...\n");
+	pr_info("...trying to set up timer as ExtINT IRQ...\n");
 
 	legacy_pic->init(0);
 	legacy_pic->make_irq(0);
@@ -2234,14 +2210,15 @@ static inline void __init check_timer(void)
 	unlock_ExtINT_logic();
 
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
+		pr_info("..... works.\n");
 		goto out;
 	}
-	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
-	if (apic_is_x2apic_enabled())
-		apic_printk(APIC_QUIET, KERN_INFO
-			    "Perhaps problem with the pre-enabled x2apic mode\n"
-			    "Try booting with x2apic and interrupt-remapping disabled in the bios.\n");
+
+	pr_info("..... failed :\n");
+	if (apic_is_x2apic_enabled()) {
+		pr_info("Perhaps problem with the pre-enabled x2apic mode\n"
+			"Try booting with x2apic and interrupt-remapping disabled in the bios.\n");
+	}
 	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
 		"report.  Then try booting with the 'noapic' option.\n");
 out:
@@ -2339,7 +2316,7 @@ void __init setup_IO_APIC(void)
 
 	io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
 
-	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
+	apic_pr_verbose("ENABLING IO-APIC IRQs\n");
 	for_each_ioapic(ioapic)
 		BUG_ON(mp_irqdomain_create(ioapic));
 
@@ -2478,7 +2455,7 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 		}
 	}
 
-	apic_printk(APIC_VERBOSE, KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
+	apic_pr_verbose("IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
 
 	return apic_id;
 }
@@ -2514,8 +2491,8 @@ static u8 io_apic_unique_id(int idx, u8 id)
 
 	new_id = reg_00.bits.ID;
 	if (!test_bit(new_id, used)) {
-		apic_printk(APIC_VERBOSE, KERN_INFO "IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
-			    idx, new_id, id);
+		apic_pr_verbose("IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
+				idx, new_id, id);
 		return new_id;
 	}
 
@@ -2614,9 +2591,7 @@ void __init io_apic_init_mappings(void)
 			ioapic_phys = mpc_ioapic_addr(i);
 #ifdef CONFIG_X86_32
 			if (!ioapic_phys) {
-				printk(KERN_ERR
-				       "WARNING: bogus zero IO-APIC "
-				       "address found in MPTABLE, "
+				pr_err("WARNING: bogus zero IO-APIC address found in MPTABLE, "
 				       "disabling IO/APIC support!\n");
 				smp_found_config = 0;
 				ioapic_is_disabled = true;
@@ -2635,9 +2610,8 @@ fake_ioapic_page:
 			ioapic_phys = __pa(ioapic_phys);
 		}
 		io_apic_set_fixmap(idx, ioapic_phys);
-		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
-			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
-			ioapic_phys);
+		apic_pr_verbose("mapped IOAPIC to %08lx (%08lx)\n",
+				__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK), ioapic_phys);
 		idx++;
 
 		ioapic_res->start = ioapic_phys;
@@ -2648,13 +2622,12 @@ fake_ioapic_page:
 
 void __init ioapic_insert_resources(void)
 {
-	int i;
 	struct resource *r = ioapic_resources;
+	int i;
 
 	if (!r) {
 		if (nr_ioapics > 0)
-			printk(KERN_ERR
-				"IO APIC resources couldn't be allocated.\n");
+			pr_err("IO APIC resources couldn't be allocated.\n");
 		return;
 	}
 
@@ -2674,11 +2647,12 @@ int mp_find_ioapic(u32 gsi)
 	/* Find the IOAPIC that manages this GSI. */
 	for_each_ioapic(i) {
 		struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(i);
+
 		if (gsi >= gsi_cfg->gsi_base && gsi <= gsi_cfg->gsi_end)
 			return i;
 	}
 
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
+	pr_err("ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
 	return -1;
 }
 
@@ -2745,12 +2719,13 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 		pr_warn("Bogus (zero) I/O APIC address found, skipping!\n");
 		return -EINVAL;
 	}
-	for_each_ioapic(ioapic)
+
+	for_each_ioapic(ioapic) {
 		if (ioapics[ioapic].mp_config.apicaddr == address) {
-			pr_warn("address 0x%x conflicts with IOAPIC%d\n",
-				address, ioapic);
+			pr_warn("address 0x%x conflicts with IOAPIC%d\n", address, ioapic);
 			return -EEXIST;
 		}
+	}
 
 	idx = find_free_ioapic_entry();
 	if (idx >= MAX_IO_APICS) {
@@ -2785,8 +2760,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 		    (gsi_end >= gsi_cfg->gsi_base &&
 		     gsi_end <= gsi_cfg->gsi_end)) {
 			pr_warn("GSI range [%u-%u] for new IOAPIC conflicts with GSI[%u-%u]\n",
-				gsi_base, gsi_end,
-				gsi_cfg->gsi_base, gsi_cfg->gsi_end);
+				gsi_base, gsi_end, gsi_cfg->gsi_base, gsi_cfg->gsi_end);
 			clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 			return -ENOSPC;
 		}
@@ -2820,8 +2794,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 	ioapics[idx].nr_registers = entries;
 
 	pr_info("IOAPIC[%d]: apic_id %d, version %d, address 0x%x, GSI %d-%d\n",
-		idx, mpc_ioapic_id(idx),
-		mpc_ioapic_ver(idx), mpc_ioapic_addr(idx),
+		idx, mpc_ioapic_id(idx), mpc_ioapic_ver(idx), mpc_ioapic_addr(idx),
 		gsi_cfg->gsi_base, gsi_cfg->gsi_end);
 
 	return 0;
@@ -2850,8 +2823,7 @@ int mp_unregister_ioapic(u32 gsi_base)
 		if (irq >= 0) {
 			data = irq_get_chip_data(irq);
 			if (data && data->count) {
-				pr_warn("pin%d on IOAPIC%d is still in use.\n",
-					pin, ioapic);
+				pr_warn("pin%d on IOAPIC%d is still in use.\n",	pin, ioapic);
 				return -EBUSY;
 			}
 		}
@@ -2968,10 +2940,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		legacy_pic->mask(virq);
 	local_irq_restore(flags);
 
-	apic_printk(APIC_VERBOSE, KERN_DEBUG
-		    "IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i ActiveLow:%i)\n",
-		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
-		    data->is_level, data->active_low);
+	apic_pr_verbose("IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i ActiveLow:%i)\n",
+			ioapic, mpc_ioapic_id(ioapic), pin, virq, data->is_level, data->active_low);
 	return 0;
 
 free_irqs:

