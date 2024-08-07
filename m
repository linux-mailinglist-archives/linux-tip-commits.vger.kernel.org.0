Return-Path: <linux-tip-commits+bounces-1985-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA994AE10
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716AF1C21677
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D11411FD;
	Wed,  7 Aug 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQyyj45L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/aoeQcT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515913CF82;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047934; cv=none; b=TVJmEbs9qhwYvsKWljxjxhc8AXbEipYoRNFS6fO8Qot/MkppLxWlcCJ3jED7+U1uyFE2QgZNBFS/2rsEPmV+1h5EFYwR5wdD46qbMUF0fFh1WrpIZC1FzL1MGmzreybTzprQZwkMC3Dy4c38cfeIwGYgO+INvIAKJr26ajwgnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047934; c=relaxed/simple;
	bh=/F6cqQxjk6Xl1qF18pF+DdrTiXSc8mPwt+4wkWjmAJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AhX6+VbvkZXtNE4RaZVt19Hv0RyRgsda++Fivdetb6850P/4r/dA7kLa3dTBb/h0mF8+RDFr3RakvuM+zUYkU05iHMiB/4/f05K/Tvm5OmIfudreEk9MS9MjHv00cAKcQiEkiFRx74R7Z0txA6A9CB5PyM1gvhO+cTp5VCSsDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQyyj45L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/aoeQcT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUt5shujxrPbxtUR4771+i1qgkUwimQubXYJjqMpVoE=;
	b=gQyyj45L6PkGpYAoWFsH7DYmjQ98iArxG+UJ1tH7PlfJFNdVLiEAggSUBB7OjEZi8EPl6g
	hBTZK2CjA8B0FX6taDbYQHN4N19BDAWV62zNB1a1Oa+QK+JatqTlNKwmE0sEhBMue75fjj
	mVNEk8nGR24gQM75lLrXPG07JWL89cKCpb3dYxt81aw1C59P44ElhQNejzVZGJuyBx1uGf
	mWMiccr8JkquMvjlxuUY6BoZ5MTrMKgW1+QrRMCmyU7J+MFhaotWrZ1YURmk8KG80VZiTJ
	v/yGkhexpzPWGrKPJnR8fEkzRGRbLsCfZweudar47vjkFxz3nAMHfj+MOMNmFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUt5shujxrPbxtUR4771+i1qgkUwimQubXYJjqMpVoE=;
	b=B/aoeQcTmfRj5FzktDVKEWoV86rPtyXSUt6TflXdMR/cwkD7U1xvDotIsGe9MAGWNwy0Wg
	hb1GoThEw34gqVCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Use guard() for locking where applicable
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.464227224@linutronix.de>
References: <20240802155440.464227224@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792953.2215.4379114312337515990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ed57538b8510a5811ec049659b726cdb24ed6b46
Gitweb:        https://git.kernel.org/tip/ed57538b8510a5811ec049659b726cdb24ed6b46
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:27 +02:00

x86/ioapic: Use guard() for locking where applicable

KISS rules!

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.464227224@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 192 ++++++++++----------------------
 1 file changed, 64 insertions(+), 128 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e24d48d..4715e2f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -296,14 +296,8 @@ static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
 
 static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
-	struct IO_APIC_route_entry entry;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	entry = __ioapic_read_entry(apic, pin);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	return entry;
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
+	return __ioapic_read_entry(apic, pin);
 }
 
 /*
@@ -320,11 +314,8 @@ static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e
 
 static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	__ioapic_write_entry(apic, pin, e);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 /*
@@ -335,12 +326,10 @@ static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 static void ioapic_mask_entry(int apic, int pin)
 {
 	struct IO_APIC_route_entry e = { .masked = true };
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	io_apic_write(apic, 0x10 + 2*pin, e.w1);
 	io_apic_write(apic, 0x11 + 2*pin, e.w2);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 /*
@@ -433,11 +422,9 @@ static void io_apic_sync(struct irq_pin_list *entry)
 static void mask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	io_apic_modify_irq(data, true, &io_apic_sync);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 static void __unmask_ioapic(struct mp_chip_data *data)
@@ -448,11 +435,9 @@ static void __unmask_ioapic(struct mp_chip_data *data)
 static void unmask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	__unmask_ioapic(data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 /*
@@ -497,13 +482,11 @@ static void __eoi_ioapic_pin(int apic, int pin, int vector)
 
 static void eoi_ioapic_pin(int vector, struct mp_chip_data *data)
 {
-	unsigned long flags;
 	struct irq_pin_list *entry;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	for_each_irq_pin(entry, data->irq_2_pin)
 		__eoi_ioapic_pin(entry->apic, entry->pin, vector);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
@@ -526,8 +509,6 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 	}
 
 	if (entry.irr) {
-		unsigned long flags;
-
 		/*
 		 * Make sure the trigger mode is set to level. Explicit EOI
 		 * doesn't clear the remote-IRR if the trigger mode is not
@@ -537,9 +518,8 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 			entry.is_level = true;
 			ioapic_write_entry(apic, pin, entry);
 		}
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
+		guard(raw_spinlock_irqsave)(&ioapic_lock);
 		__eoi_ioapic_pin(apic, pin, entry.vector);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
 
 	/*
@@ -1033,7 +1013,7 @@ static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			return -EINVAL;
 	}
 
-	mutex_lock(&ioapic_mutex);
+	guard(mutex)(&ioapic_mutex);
 	if (!(flags & IOAPIC_MAP_ALLOC)) {
 		if (!legacy) {
 			irq = irq_find_mapping(domain, pin);
@@ -1054,8 +1034,6 @@ static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			data->count++;
 		}
 	}
-	mutex_unlock(&ioapic_mutex);
-
 	return irq;
 }
 
@@ -1120,10 +1098,9 @@ void mp_unmap_irq(int irq)
 	if (!data || data->isa_irq)
 		return;
 
-	mutex_lock(&ioapic_mutex);
+	guard(mutex)(&ioapic_mutex);
 	if (--data->count == 0)
 		irq_domain_free_irqs(irq, 1);
-	mutex_unlock(&ioapic_mutex);
 }
 
 /*
@@ -1251,16 +1228,15 @@ static void __init print_IO_APIC(int ioapic_idx)
 	union IO_APIC_reg_01 reg_01;
 	union IO_APIC_reg_02 reg_02;
 	union IO_APIC_reg_03 reg_03;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(ioapic_idx, 0);
-	reg_01.raw = io_apic_read(ioapic_idx, 1);
-	if (reg_01.bits.version >= 0x10)
-		reg_02.raw = io_apic_read(ioapic_idx, 2);
-	if (reg_01.bits.version >= 0x20)
-		reg_03.raw = io_apic_read(ioapic_idx, 3);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+		reg_00.raw = io_apic_read(ioapic_idx, 0);
+		reg_01.raw = io_apic_read(ioapic_idx, 1);
+		if (reg_01.bits.version >= 0x10)
+			reg_02.raw = io_apic_read(ioapic_idx, 2);
+		if (reg_01.bits.version >= 0x20)
+			reg_03.raw = io_apic_read(ioapic_idx, 3);
+	}
 
 	printk(KERN_DEBUG "IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
 	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
@@ -1451,7 +1427,6 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
-	unsigned long flags;
 	int ioapic_idx, i;
 
 	/*
@@ -1465,9 +1440,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 	 */
 	for_each_ioapic(ioapic_idx) {
 		/* Read the register 0 value */
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(ioapic_idx, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+			reg_00.raw = io_apic_read(ioapic_idx, 0);
 
 		old_id = mpc_ioapic_id(ioapic_idx);
 
@@ -1522,16 +1496,11 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 			mpc_ioapic_id(ioapic_idx));
 
 		reg_00.bits.ID = mpc_ioapic_id(ioapic_idx);
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic_idx, 0, reg_00.raw);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
-		/*
-		 * Sanity check
-		 */
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(ioapic_idx, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+			io_apic_write(ioapic_idx, 0, reg_00.raw);
+			reg_00.raw = io_apic_read(ioapic_idx, 0);
+		}
+		/* Sanity check */
 		if (reg_00.bits.ID != mpc_ioapic_id(ioapic_idx))
 			pr_cont("could not set ID!\n");
 		else
@@ -1661,17 +1630,14 @@ static int __init timer_irq_works(void)
 static unsigned int startup_ioapic_irq(struct irq_data *data)
 {
 	int was_pending = 0, irq = data->irq;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	if (irq < nr_legacy_irqs()) {
 		legacy_pic->mask(irq);
 		if (legacy_pic->irq_pending(irq))
 			was_pending = 1;
 	}
 	__unmask_ioapic(data->chip_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
 	return was_pending;
 }
 
@@ -1681,9 +1647,8 @@ atomic_t irq_mis_count;
 static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 {
 	struct irq_pin_list *entry;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	for_each_irq_pin(entry, data->irq_2_pin) {
 		struct IO_APIC_route_entry e;
 		int pin;
@@ -1691,13 +1656,9 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 		pin = entry->pin;
 		e.w1 = io_apic_read(entry->apic, 0x10 + pin*2);
 		/* Is the remote IRR bit set? */
-		if (e.irr) {
-			raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		if (e.irr)
 			return true;
-		}
 	}
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
 	return false;
 }
 
@@ -1898,18 +1859,16 @@ static void ioapic_configure_entry(struct irq_data *irqd)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
 
-static int ioapic_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+static int ioapic_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
-	unsigned long flags;
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE)
 		ioapic_configure_entry(irq_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return ret;
 }
@@ -1928,9 +1887,8 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
  *
  * Verify that the corresponding Remote-IRR bits are clear.
  */
-static int ioapic_irq_get_chip_state(struct irq_data *irqd,
-				   enum irqchip_irq_state which,
-				   bool *state)
+static int ioapic_irq_get_chip_state(struct irq_data *irqd, enum irqchip_irq_state which,
+				     bool *state)
 {
 	struct mp_chip_data *mcd = irqd->chip_data;
 	struct IO_APIC_route_entry rentry;
@@ -1940,7 +1898,8 @@ static int ioapic_irq_get_chip_state(struct irq_data *irqd,
 		return -EINVAL;
 
 	*state = false;
-	raw_spin_lock(&ioapic_lock);
+
+	guard(raw_spinlock)(&ioapic_lock);
 	for_each_irq_pin(p, mcd->irq_2_pin) {
 		rentry = __ioapic_read_entry(p->apic, p->pin);
 		/*
@@ -1954,7 +1913,6 @@ static int ioapic_irq_get_chip_state(struct irq_data *irqd,
 			break;
 		}
 	}
-	raw_spin_unlock(&ioapic_lock);
 	return 0;
 }
 
@@ -2129,9 +2087,8 @@ static int __init mp_alloc_timer_irq(int ioapic, int pin)
 		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
 		info.devid = mpc_ioapic_id(ioapic);
 		info.ioapic.pin = pin;
-		mutex_lock(&ioapic_mutex);
+		guard(mutex)(&ioapic_mutex);
 		irq = alloc_isa_irq_from_domain(domain, 0, ioapic, pin, &info);
-		mutex_unlock(&ioapic_mutex);
 	}
 
 	return irq;
@@ -2142,8 +2099,6 @@ static int __init mp_alloc_timer_irq(int ioapic, int pin)
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
- *
- * FIXME: really need to revamp this for all platforms.
  */
 static inline void __init check_timer(void)
 {
@@ -2404,16 +2359,14 @@ void __init setup_IO_APIC(void)
 
 static void resume_ioapic_id(int ioapic_idx)
 {
-	unsigned long flags;
 	union IO_APIC_reg_00 reg_00;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_00.raw = io_apic_read(ioapic_idx, 0);
 	if (reg_00.bits.ID != mpc_ioapic_id(ioapic_idx)) {
 		reg_00.bits.ID = mpc_ioapic_id(ioapic_idx);
 		io_apic_write(ioapic_idx, 0, reg_00.raw);
 	}
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 static void ioapic_resume(void)
@@ -2443,15 +2396,13 @@ device_initcall(ioapic_init_ops);
 static int io_apic_get_redir_entries(int ioapic)
 {
 	union IO_APIC_reg_01	reg_01;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_01.raw = io_apic_read(ioapic, 1);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	/* The register returns the maximum index redir index
-	 * supported, which is one less than the total number of redir
-	 * entries.
+	/*
+	 * The register returns the maximum index redir index supported,
+	 * which is one less than the total number of redir entries.
 	 */
 	return reg_01.bits.entries + 1;
 }
@@ -2481,16 +2432,14 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	static DECLARE_BITMAP(apic_id_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
-	unsigned long flags;
 	int i = 0;
 
 	/* Initialize the ID map */
 	if (bitmap_empty(apic_id_map, MAX_LOCAL_APIC))
 		copy_phys_cpu_present_map(apic_id_map);
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(ioapic, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+		reg_00.raw = io_apic_read(ioapic, 0);
 
 	if (apic_id >= broadcast_id) {
 		pr_warn("IOAPIC[%d]: Invalid apic_id %d, trying %d\n",
@@ -2517,21 +2466,19 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
 
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic, 0, reg_00.raw);
-		reg_00.raw = io_apic_read(ioapic, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+			io_apic_write(ioapic, 0, reg_00.raw);
+			reg_00.raw = io_apic_read(ioapic, 0);
+		}
 
 		/* Sanity check */
 		if (reg_00.bits.ID != apic_id) {
-			pr_err("IOAPIC[%d]: Unable to change apic_id!\n",
-			       ioapic);
+			pr_err("IOAPIC[%d]: Unable to change apic_id!\n", ioapic);
 			return -1;
 		}
 	}
 
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
+	apic_printk(APIC_VERBOSE, KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
 
 	return apic_id;
 }
@@ -2547,7 +2494,6 @@ static u8 io_apic_unique_id(int idx, u8 id)
 {
 	union IO_APIC_reg_00 reg_00;
 	DECLARE_BITMAP(used, 256);
-	unsigned long flags;
 	u8 new_id;
 	int i;
 
@@ -2563,26 +2509,23 @@ static u8 io_apic_unique_id(int idx, u8 id)
 	 * Read the current id from the ioapic and keep it if
 	 * available.
 	 */
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(idx, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+		reg_00.raw = io_apic_read(idx, 0);
+
 	new_id = reg_00.bits.ID;
 	if (!test_bit(new_id, used)) {
-		apic_printk(APIC_VERBOSE, KERN_INFO
-			"IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
-			 idx, new_id, id);
+		apic_printk(APIC_VERBOSE, KERN_INFO "IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
+			    idx, new_id, id);
 		return new_id;
 	}
 
-	/*
-	 * Get the next free id and write it to the ioapic.
-	 */
+	/* Get the next free id and write it to the ioapic. */
 	new_id = find_first_zero_bit(used, 256);
 	reg_00.bits.ID = new_id;
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(idx, 0, reg_00.raw);
-	reg_00.raw = io_apic_read(idx, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+		io_apic_write(idx, 0, reg_00.raw);
+		reg_00.raw = io_apic_read(idx, 0);
+	}
 	/* Sanity check */
 	BUG_ON(reg_00.bits.ID != new_id);
 
@@ -2592,12 +2535,10 @@ static u8 io_apic_unique_id(int idx, u8 id)
 
 static int io_apic_get_version(int ioapic)
 {
-	union IO_APIC_reg_01	reg_01;
-	unsigned long flags;
+	union IO_APIC_reg_01 reg_01;
 
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_01.raw = io_apic_read(ioapic, 1);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return reg_01.bits.version;
 }
@@ -3050,22 +2991,17 @@ void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,
 	irq_data = irq_domain_get_irq_data(domain, virq);
 	if (irq_data && irq_data->chip_data) {
 		data = irq_data->chip_data;
-		__remove_pin_from_irq(data, mp_irqdomain_ioapic_idx(domain),
-				      (int)irq_data->hwirq);
+		__remove_pin_from_irq(data, mp_irqdomain_ioapic_idx(domain), (int)irq_data->hwirq);
 		WARN_ON(!list_empty(&data->irq_2_pin));
 		kfree(irq_data->chip_data);
 	}
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
-int mp_irqdomain_activate(struct irq_domain *domain,
-			  struct irq_data *irq_data, bool reserve)
+int mp_irqdomain_activate(struct irq_domain *domain, struct irq_data *irq_data, bool reserve)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	ioapic_configure_entry(irq_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 	return 0;
 }
 

