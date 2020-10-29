Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA429EB91
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJ2MPh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgJ2MPg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:36 -0400
Date:   Thu, 29 Oct 2020 12:15:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//qZoCCQO3deNHtHSmoH0++lZh9wrV8TsjbdSz9NDPY=;
        b=3Pd09/sECEx22cRucsPFsu9av6GTeiKq6qGhHEHV9yXh+AzyDTh4CaVky0zFiM6/vqE5+2
        cD/HvIpu9AXx8t3XSr8TtOvWU7rH9Geme84YMoEe2xd59BbXm/d/NeqaDMkuEbxJb5clgi
        LspduDab7Xox+OBZbBlWodRXvoBalUX52L0F/f+Rhu/YUYmCL8bYlJ3QEFfA6fe0iu7a4u
        Kyw3dvp9AAuLgb+hGFShU1g8Iokp/FWdluw287hFblPI89kzIIotszRKUJw+cLr3FPV3Wa
        l/JIdFzyJyeUQML25y/EK7poEbtxQhP+PJoAmJMnJh0Gdlsnj18KE3Fyy9m5sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//qZoCCQO3deNHtHSmoH0++lZh9wrV8TsjbdSz9NDPY=;
        b=oXaXqbJanGJMKGs6Se/iaV1luetfAusJdXAhMQr6YBSfXaTfzV4or5QbtCOpAok6blUdWL
        VnURg86gPYJR28Dg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Handle Extended Destination ID field in RTE
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-32-dwmw2@infradead.org>
References: <20201024213535.443185-32-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373058.397.13190116855883047380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     51130d21881d435fad5fa7f25bea77aa0ffc9a4e
Gitweb:        https://git.kernel.org/tip/51130d21881d435fad5fa7f25bea77aa0ffc9a4e
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

x86/ioapic: Handle Extended Destination ID field in RTE

Bits 63-48 of the I/OAPIC Redirection Table Entry map directly to bits 19-4
of the address used in the resulting MSI cycle.

Historically, the x86 MSI format only used the top 8 of those 16 bits as
the destination APIC ID, and the "Extended Destination ID" in the lower 8
bits was unused.

With interrupt remapping, the lowest bit of the Extended Destination ID
(bit 48 of RTE, bit 4 of MSI address) is now used to indicate a remappable
format MSI.

A hypervisor can use the other 7 bits of the Extended Destination ID to
permit guests to address up to 15 bits of APIC IDs, thus allowing 32768
vCPUs before having to expose a vIOMMU and interrupt remapping to the
guest.

No behavioural change in this patch, since nothing yet permits APIC IDs
above 255 to be used with the non-IR I/OAPIC domain.

[ tglx: Converted it to the cleaned up entry/msi_msg format and added
  	commentry ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-32-dwmw2@infradead.org

---
 arch/x86/include/asm/io_apic.h |  3 ++-
 arch/x86/kernel/apic/io_apic.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 73da644..437aa8d 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -67,7 +67,8 @@ struct IO_APIC_route_entry {
 				is_level		:  1,
 				masked			:  1,
 				reserved_0		: 15,
-				reserved_1		: 24,
+				reserved_1		: 17,
+				virt_destid_8_14	:  7,
 				destid_0_7		:  8;
 		};
 		struct {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 443d2c9..1cfd65e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1238,9 +1238,10 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
 				entry.ir_zero);
 		} else {
-			printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n", buf,
+			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
 			       entry.dest_mode_logical ? "logical " : "physical",
-			       entry.destid_0_7, entry.delivery_mode);
+			       entry.virt_destid_8_14, entry.destid_0_7,
+			       entry.delivery_mode);
 		}
 	}
 }
@@ -1409,6 +1410,7 @@ void native_restore_boot_irq_mode(void)
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
+		u32 apic_id = read_apic_id();
 
 		memset(&entry, 0, sizeof(entry));
 		entry.masked		= false;
@@ -1416,7 +1418,8 @@ void native_restore_boot_irq_mode(void)
 		entry.active_low	= false;
 		entry.dest_mode_logical	= false;
 		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
-		entry.destid_0_7	= read_apic_id();
+		entry.destid_0_7	= apic_id & 0xFF;
+		entry.virt_destid_8_14	= apic_id >> 8;
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
@@ -1885,7 +1888,11 @@ static void ioapic_setup_msg_from_msi(struct irq_data *irq_data,
 	/* DMAR/IR: 1, 0 for all other modes */
 	entry->ir_format		= msg.arch_addr_lo.dmar_format;
 	/*
-	 * DMAR/IR: index bit 0-14.
+	 * - DMAR/IR: index bit 0-14.
+	 *
+	 * - Virt: If the host supports x2apic without a virtualized IR
+	 *	   unit then bit 0-6 of dmar_index_0_14 are providing bit
+	 *	   8-14 of the destination id.
 	 *
 	 * All other modes have bit 0-6 of dmar_index_0_14 cleared and the
 	 * topmost 8 bits are destination id bit 0-7 (entry::destid_0_7).
@@ -2063,6 +2070,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	int apic, pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	u32 apic_id;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
 	if (pin == -1) {
@@ -2078,11 +2086,13 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
+	apic_id = hard_smp_processor_id();
 	memset(&entry1, 0, sizeof(entry1));
 
 	entry1.dest_mode_logical	= true;
 	entry1.masked			= false;
-	entry1.destid_0_7		= hard_smp_processor_id();
+	entry1.destid_0_7		= apic_id & 0xFF;
+	entry1.virt_destid_8_14		= apic_id >> 8;
 	entry1.delivery_mode		= APIC_DELIVERY_MODE_EXTINT;
 	entry1.active_low		= entry0.active_low;
 	entry1.is_level			= false;
