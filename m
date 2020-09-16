Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF02D26C495
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIPPss (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPP3F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE4C02C28D;
        Wed, 16 Sep 2020 08:17:21 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/X6IKeVzfM2VQpbYSG1z/SK6cJOcg608W2DEcCWZA68=;
        b=YnkMB6UENR/d+IETXSeJi/z1QdigmaCtaV+UcvlihJ99GyY7PjOlaWcjnGrYmjuiEDopDf
        i8VFBmdZiQcDpvFVupaUj4Xpjf1MmbWzqCG8/gvw08pXruo7dNAClPo7ruTSTEC+Wp+kcY
        jaPj2+MQk4GYZRrqFAuIDwGxrnC2TFo4B2D5+1RJWxOiOjvA7RtJft0fGG19KOYTBQ+GBY
        tcqS2b/iyOidemP1nxz39Mphx88e68cTdawKNIsni7kv1RifOWhwulTlMgBujVsa5I/Byx
        Z0rEiJft6lvKvakogx1zyGZH0sQ2hdC/+R0Jd2bfqRCDAbtTI1Rx5VBmDftKKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/X6IKeVzfM2VQpbYSG1z/SK6cJOcg608W2DEcCWZA68=;
        b=cv40iHnBM/b76Yh3u4E6Jw+Ch6vlUnXXojdJ/DWh2Ugiv9iksnFkrAvYEMOqPdoti8LAJc
        mdzhEgYZX6ehdrCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/init: Remove unused init ops
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112330.806095671@linutronix.de>
References: <20200826112330.806095671@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914893.15536.14500779969010281588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     ccbecea1460201f87b92cc97bc4707e2c89ed654
Gitweb:        https://git.kernel.org/tip/ccbecea1460201f87b92cc97bc4707e2c89ed654
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:28 +02:00

x86/init: Remove unused init ops

Some past platform removal forgot to get rid of this unused ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112330.806095671@linutronix.de
---
 arch/x86/include/asm/mpspec.h   | 10 ----------
 arch/x86/include/asm/x86_init.h | 10 ----------
 arch/x86/kernel/mpparse.c       | 26 ++++----------------------
 arch/x86/kernel/x86_init.c      |  4 ----
 4 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 606cbae..e90ac7e 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -67,21 +67,11 @@ static inline void find_smp_config(void)
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern int default_mpc_apic_id(struct mpc_cpu *m);
-extern void default_smp_read_mpc_oem(struct mpc_table *mpc);
-# ifdef CONFIG_X86_IO_APIC
-extern void default_mpc_oem_bus_info(struct mpc_bus *m, char *str);
-# else
-#  define default_mpc_oem_bus_info NULL
-# endif
 extern void default_find_smp_config(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable 0
-#define default_mpc_apic_id NULL
-#define default_smp_read_mpc_oem NULL
-#define default_mpc_oem_bus_info NULL
 #define default_find_smp_config x86_init_noop
 #define default_get_smp_config x86_init_uint_noop
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6807153..7cc32e7 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -11,22 +11,12 @@ struct cpuinfo_x86;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
- * @mpc_record:			platform specific mpc record accounting
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @mpc_apic_id:		platform specific mpc apic id assignment
- * @smp_read_mpc_oem:		platform specific oem mpc table setup
- * @mpc_oem_pci_bus:		platform specific pci bus setup (default NULL)
- * @mpc_oem_bus_info:		platform specific mpc bus info
  * @find_smp_config:		find the smp configuration
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
-	void (*mpc_record)(unsigned int mode);
 	void (*setup_ioapic_ids)(void);
-	int (*mpc_apic_id)(struct mpc_cpu *m);
-	void (*smp_read_mpc_oem)(struct mpc_table *mpc);
-	void (*mpc_oem_pci_bus)(struct mpc_bus *m);
-	void (*mpc_oem_bus_info)(struct mpc_bus *m, char *name);
 	void (*find_smp_config)(void);
 	void (*get_smp_config)(unsigned int early);
 };
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index baa2109..61d09bd 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -46,11 +46,6 @@ static int __init mpf_checksum(unsigned char *mp, int len)
 	return sum & 0xFF;
 }
 
-int __init default_mpc_apic_id(struct mpc_cpu *m)
-{
-	return m->apicid;
-}
-
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	int apicid;
@@ -61,7 +56,7 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 		return;
 	}
 
-	apicid = x86_init.mpparse.mpc_apic_id(m);
+	apicid = m->apicid;
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR) {
 		bootup_cpu = " (Bootup-CPU)";
@@ -73,7 +68,7 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 }
 
 #ifdef CONFIG_X86_IO_APIC
-void __init default_mpc_oem_bus_info(struct mpc_bus *m, char *str)
+static void __init mpc_oem_bus_info(struct mpc_bus *m, char *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
@@ -84,7 +79,7 @@ static void __init MP_bus_info(struct mpc_bus *m)
 {
 	char str[7];
 
-	x86_init.mpparse.mpc_oem_bus_info(m, str);
+	mpc_oem_bus_info(m, str);
 
 #if MAX_MP_BUSSES < 256
 	if (m->busid >= MAX_MP_BUSSES) {
@@ -100,9 +95,6 @@ static void __init MP_bus_info(struct mpc_bus *m)
 		mp_bus_id_to_type[m->busid] = MP_BUS_ISA;
 #endif
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI) - 1) == 0) {
-		if (x86_init.mpparse.mpc_oem_pci_bus)
-			x86_init.mpparse.mpc_oem_pci_bus(m);
-
 		clear_bit(m->busid, mp_bus_not_pci);
 #ifdef CONFIG_EISA
 		mp_bus_id_to_type[m->busid] = MP_BUS_PCI;
@@ -198,8 +190,6 @@ static void __init smp_dump_mptable(struct mpc_table *mpc, unsigned char *mpt)
 			1, mpc, mpc->length, 1);
 }
 
-void __init default_smp_read_mpc_oem(struct mpc_table *mpc) { }
-
 static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 {
 	char str[16];
@@ -218,14 +208,7 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 	if (early)
 		return 1;
 
-	if (mpc->oemptr)
-		x86_init.mpparse.smp_read_mpc_oem(mpc);
-
-	/*
-	 *      Now process the configuration blocks.
-	 */
-	x86_init.mpparse.mpc_record(0);
-
+	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
 		switch (*mpt) {
 		case MP_PROCESSOR:
@@ -256,7 +239,6 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 			count = mpc->length;
 			break;
 		}
-		x86_init.mpparse.mpc_record(1);
 	}
 
 	if (!num_processors)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 123f1c1..cec6f6a 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -67,11 +67,7 @@ struct x86_init_ops x86_init __initdata = {
 	},
 
 	.mpparse = {
-		.mpc_record		= x86_init_uint_noop,
 		.setup_ioapic_ids	= x86_init_noop,
-		.mpc_apic_id		= default_mpc_apic_id,
-		.smp_read_mpc_oem	= default_smp_read_mpc_oem,
-		.mpc_oem_bus_info	= default_mpc_oem_bus_info,
 		.find_smp_config	= default_find_smp_config,
 		.get_smp_config		= default_get_smp_config,
 	},
