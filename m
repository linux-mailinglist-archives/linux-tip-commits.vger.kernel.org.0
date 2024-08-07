Return-Path: <linux-tip-commits+bounces-1975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EF94AE01
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD441F23BF2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F213AD22;
	Wed,  7 Aug 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmhzEvdw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtJe7xhY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1E137747;
	Wed,  7 Aug 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047930; cv=none; b=ZHwp6E5YQlsuhSNU0lMmkoQUZSF0KtSEHFotLBWMBVhHVEJ5ZneoppRQ979YAWaHs4q5Hp9sAFxcVBt55hL2YeKt3fahIfBV/LTsmPXL5TUQF+Ke4WhxEemMwxv0ZEjpZycfP1+xXA1XUWvKnPM7E00mz0wN7K50vNZIG4xNR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047930; c=relaxed/simple;
	bh=rOFZsb9f3bqOVnFW794mQ12TfDmdMu9ZpTJt1QDp3xw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ml/a9yTkAMaHDQoNHJxUmMCimssT4CsKBmVtbl10eZhahrpXWaSeJBUtxdhQJwcN/rZLeh4fk9ToRVlTqk0uTA61ZUWd+qvATTacgur3vrYmLmBU6lw0bUqjdT/QeuvVqL0zjTTNjLrwfRTdwLSuhO6wNPfmK6134zfrH3Cmstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YmhzEvdw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtJe7xhY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdxR4bX8kHC1cITyjrxp8mvNH7GB/fb2AeIPUfeV2nA=;
	b=YmhzEvdwtteDJvOUgpHMHBfUh48ExxLyDy5Kbvl+XBA6iT3K6mqTY3Tdy1hWX9sJ5fZMMi
	RqVSCK/cdzcgNklBbEgJ6cP9Y2/7MIES+lsWZwoHglKCmti3j+GN59QDoTUEJ9RqNv/slU
	Lr+qGPYKkMscw3jyDaN5bm1vOil5w07322kjivhzsZCkFl0RSvEng+CBVlpy0CvlMImsjZ
	Mwp+Fo1t0rIwNXKO3TOYuALvZ6kngW2+Po/iXzbQSkODFP2lxnA9QVG3kZPdtzXrvMlD2P
	ZYm4NbY2QQEhi/m7kOJ46W7vl17J+Frmi9DVnjrhnZYA5fQ1LJ4tWD9tURmMTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdxR4bX8kHC1cITyjrxp8mvNH7GB/fb2AeIPUfeV2nA=;
	b=XtJe7xhYZGRRVhUiXgfQ0IexTsBwYyMcr9qVeeKwq3SRdbHVpkQkxeAyBNywDlSUOkXyU0
	mZ0Q+DhWFv8awcBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup comments
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.969619978@linutronix.de>
References: <20240802155440.969619978@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792653.2215.15727186050401933568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     75d449402b125648bf048309c9d22b39262d6fba
Gitweb:        https://git.kernel.org/tip/75d449402b125648bf048309c9d22b39262d6fba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/ioapic: Cleanup comments

Use proper comment styles and shrink comments to their scope where
applicable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.969619978@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 86 ++++++++++++++-------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 51ecfb5..25d1d1a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -384,12 +384,12 @@ static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 	}
 }
 
+/*
+ * Synchronize the IO-APIC and the CPU by doing a dummy read from the
+ * IO-APIC
+ */
 static void io_apic_sync(struct irq_pin_list *entry)
 {
-	/*
-	 * Synchronize the IO-APIC and the CPU by doing
-	 * a dummy read from the IO-APIC
-	 */
 	struct io_apic __iomem *io_apic;
 
 	io_apic = io_apic_base(entry->apic);
@@ -442,17 +442,13 @@ static void __eoi_ioapic_pin(int apic, int pin, int vector)
 
 		entry = entry1 = __ioapic_read_entry(apic, pin);
 
-		/*
-		 * Mask the entry and change the trigger mode to edge.
-		 */
+		/* Mask the entry and change the trigger mode to edge. */
 		entry1.masked = true;
 		entry1.is_level = false;
 
 		__ioapic_write_entry(apic, pin, entry1);
 
-		/*
-		 * Restore the previous level triggered entry.
-		 */
+		/* Restore the previous level triggered entry. */
 		__ioapic_write_entry(apic, pin, entry);
 	}
 }
@@ -1012,16 +1008,12 @@ static int pin_2_irq(int idx, int ioapic, int pin, unsigned int flags)
 {
 	u32 gsi = mp_pin_to_gsi(ioapic, pin);
 
-	/*
-	 * Debugging check, we are in big trouble if this message pops up!
-	 */
+	/* Debugging check, we are in big trouble if this message pops up! */
 	if (mp_irqs[idx].dstirq != pin)
 		pr_err("broken BIOS or MPTABLE parser, ayiee!!\n");
 
 #ifdef CONFIG_X86_32
-	/*
-	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
-	 */
+	/* PCI IRQ command line redirection. Yes, limits are hardcoded. */
 	if ((pin >= 16) && (pin <= 23)) {
 		if (pirq_entries[pin - 16] != -1) {
 			if (!pirq_entries[pin - 16]) {
@@ -1296,8 +1288,9 @@ void __init enable_IO_APIC(void)
 		/* See if any of the pins is in ExtINT mode */
 		struct IO_APIC_route_entry entry = ioapic_read_entry(apic, pin);
 
-		/* If the interrupt line is enabled and in ExtInt mode
-		 * I have found the pin where the i8259 is connected.
+		/*
+		 * If the interrupt line is enabled and in ExtInt mode I
+		 * have found the pin where the i8259 is connected.
 		 */
 		if (!entry.masked &&
 		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
@@ -1307,8 +1300,11 @@ void __init enable_IO_APIC(void)
 		}
 	}
  found_i8259:
-	/* Look to see what if the MP table has reported the ExtINT */
-	/* If we could not find the appropriate pin by looking at the ioapic
+
+	/*
+	 * Look to see what if the MP table has reported the ExtINT
+	 *
+	 * If we could not find the appropriate pin by looking at the ioapic
 	 * the i8259 probably is not connected the ioapic but give the
 	 * mptable a chance anyway.
 	 */
@@ -1348,9 +1344,7 @@ void native_restore_boot_irq_mode(void)
 		entry.destid_0_7	= apic_id & 0xFF;
 		entry.virt_destid_8_14	= apic_id >> 8;
 
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
+		/* Add it to the IO-APIC irq-routing table */
 		ioapic_write_entry(ioapic_i8259.apic, ioapic_i8259.pin, entry);
 	}
 
@@ -1427,8 +1421,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		}
 
 		/*
-		 * We need to adjust the IRQ routing table
-		 * if the ID changed.
+		 * We need to adjust the IRQ routing table if the ID
+		 * changed.
 		 */
 		if (old_id != mpc_ioapic_id(ioapic_idx))
 			for (i = 0; i < mp_irq_entries; i++)
@@ -1437,8 +1431,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 						= mpc_ioapic_id(ioapic_idx);
 
 		/*
-		 * Update the ID register according to the right value
-		 * from the MPC table if they are different.
+		 * Update the ID register according to the right value from
+		 * the MPC table if they are different.
 		 */
 		if (mpc_ioapic_id(ioapic_idx) == reg_00.bits.ID)
 			continue;
@@ -1562,21 +1556,17 @@ static int __init timer_irq_works(void)
  * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
  * better to do it this way as thus we do not have to be aware of
  * 'pending' interrupts in the IRQ path, except at this point.
- */
-/*
- * Edge triggered needs to resend any interrupt
- * that was delayed but this is now handled in the device
- * independent code.
- */
-
-/*
- * Starting up a edge-triggered IO-APIC interrupt is
- * nasty - we need to make sure that we get the edge.
- * If it is already asserted for some reason, we need
- * return 1 to indicate that is was pending.
  *
- * This is not complete - we should be able to fake
- * an edge even if it isn't on the 8259A...
+ *
+ * Edge triggered needs to resend any interrupt that was delayed but this
+ * is now handled in the device independent code.
+ *
+ * Starting up a edge-triggered IO-APIC interrupt is nasty - we need to
+ * make sure that we get the edge.  If it is already asserted for some
+ * reason, we need return 1 to indicate that is was pending.
+ *
+ * This is not complete - we should be able to fake an edge even if it
+ * isn't on the 8259A...
  */
 static unsigned int startup_ioapic_irq(struct irq_data *data)
 {
@@ -1627,7 +1617,8 @@ static inline bool ioapic_prepare_move(struct irq_data *data)
 static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 	if (unlikely(moveit)) {
-		/* Only migrate the irq if the ack has been received.
+		/*
+		 * Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
 		 * delayed going to ioapics, and if we reprogram the
@@ -1904,14 +1895,13 @@ static inline void init_IO_APIC_traps(void)
 		cfg = irq_cfg(irq);
 		if (IO_APIC_IRQ(irq) && cfg && !cfg->vector) {
 			/*
-			 * Hmm.. We don't have an entry for this,
-			 * so default to an old-fashioned 8259
-			 * interrupt if we can..
+			 * Hmm.. We don't have an entry for this, so
+			 * default to an old-fashioned 8259 interrupt if we
+			 * can. Otherwise set the dummy interrupt chip.
 			 */
 			if (irq < nr_legacy_irqs())
 				legacy_pic->make_irq(irq);
 			else
-				/* Strange. Oh, well.. */
 				irq_set_chip(irq, &no_irq_chip);
 		}
 	}
@@ -2307,9 +2297,7 @@ void __init setup_IO_APIC(void)
 	for_each_ioapic(ioapic)
 		BUG_ON(mp_irqdomain_create(ioapic));
 
-	/*
-         * Set up IO-APIC IRQ routing.
-         */
+	/* Set up IO-APIC IRQ routing. */
 	x86_init.mpparse.setup_ioapic_ids();
 
 	sync_Arb_IDs();

