Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83167776854
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Aug 2023 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHITOS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Aug 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHITNj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571630F8;
        Wed,  9 Aug 2023 12:12:55 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BhNcG3RW2gPGVKT05cKmofNtobbogrPsenm0HcgBK2c=;
        b=hOh61FVuMZXu4a33IdwuvFgUaBWaAkupnWeKyTVMx9rxe8elORG0zWW/++VyK69fsHNFPP
        jYFrukRsde7oH/yJ+cUDP4R+aAALuxPpYy5M3xBhuj0L4MOdbe0vVPjDymOfsa5cBvE8ax
        DIWuSZga+4ZyMy/A44gO7GAXde+A2yErLSrc9ruz5SPng4ZwBaF3NCc35ZlcVBh8QXfeM0
        RaewNGbLumkbH1izU/3nxiTSrrE5GC2dYvHDVvBsQ1qKIBlMBDl5EY4UX5KUs9xAtAFk8V
        roiaVc50xY0JZ9rxbcY/ShAOxhLIDSOzKcvsvJsz+iYPgCnLHcw8I6YpQbe3lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BhNcG3RW2gPGVKT05cKmofNtobbogrPsenm0HcgBK2c=;
        b=Ef7rZZ/h/yFAUUX5oL/CfbjfWCWZ0Ip2tKBsMcXmtYsgnbXD06QCfCree5+X7wVscHc3rn
        OL+I4F0BqVqVpABQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/ioapic: Rename skip_ioapic_setup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834905.27769.5994413508640755019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ecf600f8942e04c9bf5f7046e096577eebaf6406
Gitweb:        https://git.kernel.org/tip/ecf600f8942e04c9bf5f7046e096577eebaf6406
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:41 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:16 -07:00

x86/apic/ioapic: Rename skip_ioapic_setup

Another variable name which is confusing at best. Convert to bool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/io_apic.h |  7 ++++---
 arch/x86/kernel/acpi/boot.c    |  2 +-
 arch/x86/kernel/apic/apic.c    | 12 ++++++------
 arch/x86/kernel/apic/io_apic.c | 12 ++++++------
 arch/x86/xen/smp_pv.c          |  2 +-
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 437aa8d..51c7826 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -109,8 +109,8 @@ extern int mp_irq_entries;
 /* MP IRQ source entries */
 extern struct mpc_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
-/* 1 if "noapic" boot option passed */
-extern int skip_ioapic_setup;
+/* True if "noapic" boot option passed */
+extern bool ioapic_is_disabled;
 
 /* 1 if "noapic" boot option passed */
 extern int noioapicquirk;
@@ -129,7 +129,7 @@ extern unsigned long io_apic_irqs;
  * assignment of PCI IRQ's.
  */
 #define io_apic_assign_pci_irqs \
-	(mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
+	(mp_irq_entries && !ioapic_is_disabled && io_apic_irqs)
 
 struct irq_cfg;
 extern void ioapic_insert_resources(void);
@@ -179,6 +179,7 @@ extern void print_IO_APICs(void);
 #define IO_APIC_IRQ(x)		0
 #define io_apic_assign_pci_irqs 0
 #define setup_ioapic_ids_from_mpc x86_init_noop
+#define nr_ioapics		(0)
 static inline void ioapic_insert_resources(void) { }
 static inline int arch_early_ioapic_init(void) { return 0; }
 static inline void print_IO_APICs(void) {}
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a..38a5298 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1275,7 +1275,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	/*
 	 * if "noapic" boot option, don't look for IO-APICs
 	 */
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		pr_info("Skipping IOAPIC probe due to 'noapic' option.\n");
 		return -ENODEV;
 	}
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a9dd903..cffec1f 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1691,7 +1691,7 @@ static void setup_local_APIC(void)
 	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
+	if (!cpu && (pic_mode || !value || ioapic_is_disabled)) {
 		value = APIC_DM_EXTINT;
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {
@@ -1956,7 +1956,7 @@ void __init enable_IR_x2apic(void)
 	unsigned long flags;
 	int ret, ir_stat;
 
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		pr_info("Not enabling interrupt remapping due to skipped IO-APIC setup\n");
 		return;
 	}
@@ -2956,11 +2956,11 @@ early_param("nolapic_timer", parse_nolapic_timer);
 static int __init apic_set_verbosity(char *arg)
 {
 	if (!arg)  {
-#ifdef CONFIG_X86_64
-		skip_ioapic_setup = 0;
+		if (IS_ENABLED(CONFIG_X86_32))
+			return -EINVAL;
+
+		ioapic_is_disabled = false;
 		return 0;
-#endif
-		return -EINVAL;
 	}
 
 	if (strcmp("debug", arg) == 0)
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 4241dc2..48975d5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -178,7 +178,7 @@ int mp_bus_id_to_type[MAX_MP_BUSSES];
 
 DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
-int skip_ioapic_setup;
+bool ioapic_is_disabled __ro_after_init;
 
 /**
  * disable_ioapic_support() - disables ioapic support at runtime
@@ -189,7 +189,7 @@ void disable_ioapic_support(void)
 	noioapicquirk = 1;
 	noioapicreroute = -1;
 #endif
-	skip_ioapic_setup = 1;
+	ioapic_is_disabled = true;
 }
 
 static int __init parse_noapic(char *str)
@@ -831,7 +831,7 @@ static int __acpi_get_override_irq(u32 gsi, bool *trigger, bool *polarity)
 {
 	int ioapic, pin, idx;
 
-	if (skip_ioapic_setup)
+	if (ioapic_is_disabled)
 		return -1;
 
 	ioapic = mp_find_ioapic(gsi);
@@ -1366,7 +1366,7 @@ void __init enable_IO_APIC(void)
 	int i8259_apic, i8259_pin;
 	int apic, pin;
 
-	if (skip_ioapic_setup)
+	if (ioapic_is_disabled)
 		nr_ioapics = 0;
 
 	if (!nr_legacy_irqs() || !nr_ioapics)
@@ -2399,7 +2399,7 @@ void __init setup_IO_APIC(void)
 {
 	int ioapic;
 
-	if (skip_ioapic_setup || !nr_ioapics)
+	if (ioapic_is_disabled || !nr_ioapics)
 		return;
 
 	io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
@@ -2715,7 +2715,7 @@ void __init io_apic_init_mappings(void)
 				       "address found in MPTABLE, "
 				       "disabling IO/APIC support!\n");
 				smp_found_config = 0;
-				skip_ioapic_setup = 1;
+				ioapic_is_disabled = true;
 				goto fake_ioapic_page;
 			}
 #endif
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index cef78b8..c6b42c6 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -210,7 +210,7 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned cpu;
 
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		char *m = (max_cpus == 0) ?
 			"The nosmp parameter is incompatible with Xen; " \
 			"use Xen dom0_max_vcpus=1 parameter" :
