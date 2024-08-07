Return-Path: <linux-tip-commits+bounces-1980-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9AB94AE0B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B71F23C5A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CF13D532;
	Wed,  7 Aug 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3EJvtaE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyZct8U7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2913AD1D;
	Wed,  7 Aug 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047932; cv=none; b=bmMKEzCM5Pnf96JGL3wbMRQzWJP66yawVnwLM6oMwwfw7034eN6IJnrvqWfR+D/wmOLZLlwKoVzGUs2rXsxgzA1ZonRmU9l/+LNcmggshYMZDnvG7cvQeqlGMJwllcdNdXj8J04cZc0AWKHV214rPygw9/vi2kfKU7mNTbwg8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047932; c=relaxed/simple;
	bh=9uwMBIj5fX8xDkoSzVUkU4Ve/VEjcrmaUgSZBm8n2C8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d44AMS9VTRO57YCbKoYpnIANYF+9MUnJxHJtuCB71blndsNmjlectWG/gPgIwa7yzjilHE1OxjB3UyvFwxzDQTVdr/YbDn7sUxFRlBGaaR2bLLke5nXA0X7Lz+h6I9KGDRfgBazFjnyGwhG+Vv+o1tRMKEeCQm+WT21gx9m+SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3EJvtaE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyZct8U7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J006HBwU1tQ5ZZApAfmakpyLfWZUtQ7W4ZO5woyDK2c=;
	b=F3EJvtaEo7luoGBNA7ENpEHYzReb0Toe2lyvc5Nd0JvWaGFoaHTPDoukN7H1Ya8fM9VBkW
	hFQNaFBIhoy5yXLwFG4CRiMIk7ia8d5Jqq9SBqOUiaLdQsMoCcixYwqut4kkwhTn5U4fYL
	BP4k6vGSQa+aTL0MspqOTTC9ix5OoQX4xDjVPj8tNzzt4zZrO9OarbVV8NTUNIMbbUE+oP
	DznbiuonTPjNQmBzlJAkiYxPLnx3dkaiDQXzmltPZYfEF9XtzcJBSAgfkanXsBsJCSRweq
	0whoJV6Srq0761rlhLNZPDPtTVdnLTVY16JOpkFaGlsq7cjgb+LpRu4uhRMY2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J006HBwU1tQ5ZZApAfmakpyLfWZUtQ7W4ZO5woyDK2c=;
	b=zyZct8U74L4QsWHj/JOBcckL6DRpJG8QhYlokBqoGaRAtbulfgYrLOs/yz19Uhq8eSxtmY
	UMiILXjN4xuIM4AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup guarded debug printk()s
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.714763708@linutronix.de>
References: <20240802155440.714763708@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792850.2215.894191167642050388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     54cd3795b471057a7e82acaade2b6a22beee1242
Gitweb:        https://git.kernel.org/tip/54cd3795b471057a7e82acaade2b6a22beee1242
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/ioapic: Cleanup guarded debug printk()s

Cleanup the APIC printk()s which are inside of a apic verbosity guarded
region by using apic_dbg() for the KERN_DEBUG level prints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.714763708@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 67 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index b978326..3669b5d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1186,26 +1186,21 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 	char buf[256];
 	int i;
 
-	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
+	apic_dbg("IOAPIC %d:\n", apic);
 	for (i = 0; i <= nr_entries; i++) {
 		entry = ioapic_read_entry(apic, i);
-		snprintf(buf, sizeof(buf),
-			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
-			 i,
-			 entry.masked ? "disabled" : "enabled ",
+		snprintf(buf, sizeof(buf), " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
+			 i, entry.masked ? "disabled" : "enabled ",
 			 entry.is_level ? "level" : "edge ",
 			 entry.active_low ? "low " : "high",
 			 entry.vector, entry.irr, entry.delivery_status);
 		if (entry.ir_format) {
-			printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-			       buf,
-			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
-				entry.ir_zero);
+			apic_dbg("%s, remapped, I(%04X),  Z(%X)\n", buf,
+				 (entry.ir_index_15 << 15) | entry.ir_index_0_14, entry.ir_zero);
 		} else {
-			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
-			       entry.dest_mode_logical ? "logical " : "physical",
-			       entry.virt_destid_8_14, entry.destid_0_7,
-			       entry.delivery_mode);
+			apic_dbg("%s, %s, D(%02X%02X), M(%1d)\n", buf,
+				 entry.dest_mode_logical ? "logical " : "physic	al",
+				 entry.virt_destid_8_14, entry.destid_0_7, entry.delivery_mode);
 		}
 	}
 }
@@ -1226,19 +1221,15 @@ static void __init print_IO_APIC(int ioapic_idx)
 			reg_03.raw = io_apic_read(ioapic_idx, 3);
 	}
 
-	printk(KERN_DEBUG "IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
-	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
-	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
-	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
-	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.bits.LTS);
-
-	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
-	printk(KERN_DEBUG ".......     : max redirection entries: %02X\n",
-		reg_01.bits.entries);
-
-	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
-	printk(KERN_DEBUG ".......     : IO APIC version: %02X\n",
-		reg_01.bits.version);
+	apic_dbg("IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
+	apic_dbg(".... register #00: %08X\n", reg_00.raw);
+	apic_dbg(".......    : physical APIC id: %02X\n", reg_00.bits.ID);
+	apic_dbg(".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
+	apic_dbg(".......    : LTS          : %X\n", reg_00.bits.LTS);
+	apic_dbg(".... register #01: %08X\n", *(int *)&reg_01);
+	apic_dbg(".......     : max redirection entries: %02X\n", reg_01.bits.entries);
+	apic_dbg(".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
+	apic_dbg(".......     : IO APIC version: %02X\n", reg_01.bits.version);
 
 	/*
 	 * Some Intel chipsets with IO APIC VERSION of 0x1? don't have reg_02,
@@ -1246,8 +1237,8 @@ static void __init print_IO_APIC(int ioapic_idx)
 	 * value, so ignore it if reg_02 == reg_01.
 	 */
 	if (reg_01.bits.version >= 0x10 && reg_02.raw != reg_01.raw) {
-		printk(KERN_DEBUG ".... register #02: %08X\n", reg_02.raw);
-		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.bits.arbitration);
+		apic_dbg(".... register #02: %08X\n", reg_02.raw);
+		apic_dbg(".......     : arbitration: %02X\n", reg_02.bits.arbitration);
 	}
 
 	/*
@@ -1257,11 +1248,11 @@ static void __init print_IO_APIC(int ioapic_idx)
 	 */
 	if (reg_01.bits.version >= 0x20 && reg_03.raw != reg_02.raw &&
 	    reg_03.raw != reg_01.raw) {
-		printk(KERN_DEBUG ".... register #03: %08X\n", reg_03.raw);
-		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
+		apic_dbg(".... register #03: %08X\n", reg_03.raw);
+		apic_dbg(".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
 	}
 
-	printk(KERN_DEBUG ".... IRQ redirection table:\n");
+	apic_dbg(".... IRQ redirection table:\n");
 	io_apic_print_entries(ioapic_idx, reg_01.bits.entries);
 }
 
@@ -1270,11 +1261,11 @@ void __init print_IO_APICs(void)
 	int ioapic_idx;
 	unsigned int irq;
 
-	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
-	for_each_ioapic(ioapic_idx)
-		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mpc_ioapic_id(ioapic_idx),
-		       ioapics[ioapic_idx].nr_registers);
+	apic_dbg("number of MP IRQ sources: %d.\n", mp_irq_entries);
+	for_each_ioapic(ioapic_idx) {
+		apic_dbg("number of IO-APIC #%d registers: %d.\n",
+			 mpc_ioapic_id(ioapic_idx), ioapics[ioapic_idx].nr_registers);
+	}
 
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -1285,7 +1276,7 @@ void __init print_IO_APICs(void)
 	for_each_ioapic(ioapic_idx)
 		print_IO_APIC(ioapic_idx);
 
-	printk(KERN_DEBUG "IRQ to pin mappings:\n");
+	apic_dbg("IRQ to pin mappings:\n");
 	for_each_active_irq(irq) {
 		struct irq_pin_list *entry;
 		struct irq_chip *chip;
@@ -1300,7 +1291,7 @@ void __init print_IO_APICs(void)
 		if (list_empty(&data->irq_2_pin))
 			continue;
 
-		printk(KERN_DEBUG "IRQ%d ", irq);
+		apic_dbg("IRQ%d ", irq);
 		for_each_irq_pin(entry, data->irq_2_pin)
 			pr_cont("-> %d:%d", entry->apic, entry->pin);
 		pr_cont("\n");

