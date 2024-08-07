Return-Path: <linux-tip-commits+bounces-1976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BB94AE02
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7149C1F23BDB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB113B290;
	Wed,  7 Aug 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBQfa2ip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88e9EPy8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572813664E;
	Wed,  7 Aug 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047930; cv=none; b=TrMdPpJnAk2d/iJnPurOjbmPY5p+CJT1Fvq/zAzIgmSU0pJdR1r5NCOTCQ4phba5mtDZIn9AA7QVOS4HxaS82/gQLS9K/ssbDu7c5BvCG/IJcoC0CpezUaVcrAYilEdOOq6Ybzlfshzks9qXXgHmBiQdSCsZ2t0T+Id6t62/Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047930; c=relaxed/simple;
	bh=I3AGRESc5p8REI4yajVN99TFEMPoLyxG3K3/N1xWWbY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lW/SFg2hjGgkWRkXEr2B69DAttmk8qVO2fUxaQ5p1fX2oufYSWz7vjqEXHVW6aLnYnrR3r4SkFKT8qSri6NACM4/8nH6Ut9qBXrANyzcZYnsEqnyfk806wyxz94zsPHCz52BuppKj4LAAQsWTh9kx/oqjamPUbBb5MK+IFb5aC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mBQfa2ip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88e9EPy8; arc=none smtp.client-ip=193.142.43.55
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
	bh=Ohqb3tj5j0l6VtBbkrNNUmYdGVuauQsLyjHhYTdMplc=;
	b=mBQfa2ipsW0Nxv2vpJZJIZ1KlUlDrFDA8f/zM9PdC+THijlC/xNXVSbhhH3l9xl6ZpcWKY
	0N7oDmvaY2aShPjwDHR8AW1VJA/qkN/lbMHgOT6bROGV+C0OqBpHf317IuiDXe04Xv7NtR
	mK5aw3GyAwPX/TGLwcDaQzgPZpc/SgRgDTfjwcf/VV+HmIENooZE8twJRos2ifdOudaiR4
	a7mTGqInAKidHJMTotdf8ZBL0ASJulDe2pPWXhkwLDniTyE7AtpAcFftcHqVFTNRmvthfP
	3LAhnU0v3Oe0VAWPKG6GehXe7y9EuAoQXrkkzyRRwWk5q344l5cwErKIgM/VQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ohqb3tj5j0l6VtBbkrNNUmYdGVuauQsLyjHhYTdMplc=;
	b=88e9EPy8GRTJwXd8eH6iZ4EcyfuBmUTKYsX21RyccmH/3CPpc6O5lMtkBLz6+9rnC68YDw
	r3HsJNFdovW1hjAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup bracket usage
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155441.032045616@linutronix.de>
References: <20240802155441.032045616@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792603.2215.1502873980201261831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4bcfdf76d7d1976b035ca75776bc8d266a09d6c3
Gitweb:        https://git.kernel.org/tip/4bcfdf76d7d1976b035ca75776bc8d266a09d6c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:29 +02:00

x86/ioapic: Cleanup bracket usage

Add brackets around if/for constructs as required by coding style or remove
pointless line breaks to make it true single line statements which do not
require brackets.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155441.032045616@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 34 +++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 25d1d1a..8d81c47 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -362,12 +362,13 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 {
 	struct irq_pin_list *tmp, *entry;
 
-	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list)
+	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list) {
 		if (entry->apic == apic && entry->pin == pin) {
 			list_del(&entry->list);
 			kfree(entry);
 			return;
 		}
+	}
 }
 
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
@@ -562,8 +563,7 @@ int save_ioapic_entries(void)
 		}
 
 		for_each_pin(apic, pin)
-			ioapics[apic].saved_registers[pin] =
-				ioapic_read_entry(apic, pin);
+			ioapics[apic].saved_registers[pin] = ioapic_read_entry(apic, pin);
 	}
 
 	return err;
@@ -604,8 +604,7 @@ int restore_ioapic_entries(void)
 			continue;
 
 		for_each_pin(apic, pin)
-			ioapic_write_entry(apic, pin,
-					   ioapics[apic].saved_registers[pin]);
+			ioapic_write_entry(apic, pin, ioapics[apic].saved_registers[pin]);
 	}
 	return 0;
 }
@@ -617,12 +616,13 @@ static int find_irq_entry(int ioapic_idx, int pin, int type)
 {
 	int i;
 
-	for (i = 0; i < mp_irq_entries; i++)
+	for (i = 0; i < mp_irq_entries; i++) {
 		if (mp_irqs[i].irqtype == type &&
 		    (mp_irqs[i].dstapic == mpc_ioapic_id(ioapic_idx) ||
 		     mp_irqs[i].dstapic == MP_APIC_ALL) &&
 		    mp_irqs[i].dstirq == pin)
 			return i;
+	}
 
 	return -1;
 }
@@ -662,9 +662,10 @@ static int __init find_isa_irq_apic(int irq, int type)
 	if (i < mp_irq_entries) {
 		int ioapic_idx;
 
-		for_each_ioapic(ioapic_idx)
+		for_each_ioapic(ioapic_idx) {
 			if (mpc_ioapic_id(ioapic_idx) == mp_irqs[i].dstapic)
 				return ioapic_idx;
+		}
 	}
 
 	return -1;
@@ -1424,11 +1425,12 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		 * We need to adjust the IRQ routing table if the ID
 		 * changed.
 		 */
-		if (old_id != mpc_ioapic_id(ioapic_idx))
-			for (i = 0; i < mp_irq_entries; i++)
+		if (old_id != mpc_ioapic_id(ioapic_idx)) {
+			for (i = 0; i < mp_irq_entries; i++) {
 				if (mp_irqs[i].dstapic == old_id)
-					mp_irqs[i].dstapic
-						= mpc_ioapic_id(ioapic_idx);
+					mp_irqs[i].dstapic = mpc_ioapic_id(ioapic_idx);
+			}
+		}
 
 		/*
 		 * Update the ID register according to the right value from
@@ -2666,12 +2668,10 @@ static int bad_ioapic_register(int idx)
 
 static int find_free_ioapic_entry(void)
 {
-	int idx;
-
-	for (idx = 0; idx < MAX_IO_APICS; idx++)
+	for (int idx = 0; idx < MAX_IO_APICS; idx++) {
 		if (ioapics[idx].nr_registers == 0)
 			return idx;
-
+	}
 	return MAX_IO_APICS;
 }
 
@@ -2780,11 +2780,13 @@ int mp_unregister_ioapic(u32 gsi_base)
 	int ioapic, pin;
 	int found = 0;
 
-	for_each_ioapic(ioapic)
+	for_each_ioapic(ioapic) {
 		if (ioapics[ioapic].gsi_config.gsi_base == gsi_base) {
 			found = 1;
 			break;
 		}
+	}
+
 	if (!found) {
 		pr_warn("can't find IOAPIC for GSI %d\n", gsi_base);
 		return -ENODEV;

