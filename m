Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5917A6CAF71
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Mar 2023 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjC0UKC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Mar 2023 16:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjC0UJ7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF29198C;
        Mon, 27 Mar 2023 13:09:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taKDGhCu2UaG74xgu7nJs4Qb2WguRmRjPzmmokYkMPg=;
        b=q6sItxJP0QHx/7UlvcwP0utQjdyZZW95iKAX0CSXaa3c6a0LKYHN6t66yzdGLYCX1IRw89
        niLPYoAmFUCp5GSw2dc43KSDMXNf3RgnxJ/XYyyDH6v6mc6kPmjumyUb0MDKRfziqwDZ0l
        VfOvFDzhrlDUtxG1q13CDNHdlsxlrtNT9hPDayvdZZ2NFGcPwyfgBOLjBQRDNVNRiiQ/oE
        JJUqic7rzjQ5bymmrajOdwh4L17DVnxjFvDsMR89YZ8LOjaeo1/hWC7vPkQYWIfIiAbzms
        Od2Ba0a/KqXEpYegxuxk9k1J+IyNRHX++CFTBjkkFA8uoHxVQ54qCpuVoDezMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taKDGhCu2UaG74xgu7nJs4Qb2WguRmRjPzmmokYkMPg=;
        b=NvroImoxTqgcy5if7ffCDSGTbi1ai4yqoQZMtdlxZ68WR81+6tqc2nve2a3V5ZW6VIoHT0
        bYExH2SAg2Vr85Cw==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/hyperv: Change vTOM handling to use standard coco
 mechanisms
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1679838727-87310-7-git-send-email-mikelley@microsoft.com>
References: <1679838727-87310-7-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779216.5837.15623526697891596227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     812b0597fb4043240724e4c7bed7ba1fe15c0e3f
Gitweb:        https://git.kernel.org/tip/812b0597fb4043240724e4c7bed7ba1fe15c0e3f
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Sun, 26 Mar 2023 06:52:01 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Mar 2023 09:31:43 +02:00

x86/hyperv: Change vTOM handling to use standard coco mechanisms

Hyper-V guests on AMD SEV-SNP hardware have the option of using the
"virtual Top Of Memory" (vTOM) feature specified by the SEV-SNP
architecture. With vTOM, shared vs. private memory accesses are
controlled by splitting the guest physical address space into two
halves.

vTOM is the dividing line where the uppermost bit of the physical
address space is set; e.g., with 47 bits of guest physical address
space, vTOM is 0x400000000000 (bit 46 is set).  Guest physical memory is
accessible at two parallel physical addresses -- one below vTOM and one
above vTOM.  Accesses below vTOM are private (encrypted) while accesses
above vTOM are shared (decrypted). In this sense, vTOM is like the
GPA.SHARED bit in Intel TDX.

Support for Hyper-V guests using vTOM was added to the Linux kernel in
two patch sets[1][2]. This support treats the vTOM bit as part of
the physical address. For accessing shared (decrypted) memory, these
patch sets create a second kernel virtual mapping that maps to physical
addresses above vTOM.

A better approach is to treat the vTOM bit as a protection flag, not
as part of the physical address. This new approach is like the approach
for the GPA.SHARED bit in Intel TDX. Rather than creating a second kernel
virtual mapping, the existing mapping is updated using recently added
coco mechanisms.

When memory is changed between private and shared using
set_memory_decrypted() and set_memory_encrypted(), the PTEs for the
existing kernel mapping are changed to add or remove the vTOM bit in the
guest physical address, just as with TDX. The hypercalls to change the
memory status on the host side are made using the existing callback
mechanism. Everything just works, with a minor tweak to map the IO-APIC
to use private accesses.

To accomplish the switch in approach, the following must be done:

* Update Hyper-V initialization to set the cc_mask based on vTOM
  and do other coco initialization.

* Update physical_mask so the vTOM bit is no longer treated as part
  of the physical address

* Remove CC_VENDOR_HYPERV and merge the associated vTOM functionality
  under CC_VENDOR_AMD. Update cc_mkenc() and cc_mkdec() to set/clear
  the vTOM bit as a protection flag.

* Code already exists to make hypercalls to inform Hyper-V about pages
  changing between shared and private.  Update this code to run as a
  callback from __set_memory_enc_pgtable().

* Remove the Hyper-V special case from __set_memory_enc_dec()

* Remove the Hyper-V specific call to swiotlb_update_mem_attributes()
  since mem_encrypt_init() will now do it.

* Add a Hyper-V specific implementation of the is_private_mmio()
  callback that returns true for the IO-APIC and vTPM MMIO addresses

  [1] https://lore.kernel.org/all/20211025122116.264793-1-ltykernel@gmail.com/
  [2] https://lore.kernel.org/all/20211213071407.314309-1-ltykernel@gmail.com/

  [ bp: Touchups. ]

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/1679838727-87310-7-git-send-email-mikelley@microsoft.com
---
 arch/x86/coco/core.c               | 40 ++++++++++++----
 arch/x86/hyperv/hv_init.c          | 11 +----
 arch/x86/hyperv/ivm.c              | 72 ++++++++++++++++++++++++-----
 arch/x86/include/asm/coco.h        |  1 +-
 arch/x86/include/asm/mem_encrypt.h |  1 +-
 arch/x86/include/asm/mshyperv.h    | 16 +++---
 arch/x86/kernel/cpu/mshyperv.c     | 15 ++----
 arch/x86/mm/pat/set_memory.c       |  3 +-
 drivers/hv/vmbus_drv.c             |  1 +-
 include/asm-generic/mshyperv.h     |  2 +-
 10 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f8..f4f0625 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -30,6 +30,22 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 }
 
 /*
+ * Handle the SEV-SNP vTOM case where sme_me_mask is zero, and
+ * the other levels of SME/SEV functionality, including C-bit
+ * based SEV-SNP, are not enabled.
+ */
+static __maybe_unused bool amd_cc_platform_vtom(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
  * cc_platform_has() function is used for this.  When a distinction isn't
@@ -41,9 +57,14 @@ static bool intel_cc_platform_has(enum cc_attr attr)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
+
 static bool amd_cc_platform_has(enum cc_attr attr)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+
+	if (sev_status & MSR_AMD64_SNP_VTOM)
+		return amd_cc_platform_vtom(attr);
+
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
 		return sme_me_mask;
@@ -76,11 +97,6 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
-static bool hyperv_cc_platform_has(enum cc_attr attr)
-{
-	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
-}
-
 bool cc_platform_has(enum cc_attr attr)
 {
 	switch (vendor) {
@@ -88,8 +104,6 @@ bool cc_platform_has(enum cc_attr attr)
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
 		return intel_cc_platform_has(attr);
-	case CC_VENDOR_HYPERV:
-		return hyperv_cc_platform_has(attr);
 	default:
 		return false;
 	}
@@ -103,11 +117,14 @@ u64 cc_mkenc(u64 val)
 	 * encryption status of the page.
 	 *
 	 * - for AMD, bit *set* means the page is encrypted
-	 * - for Intel *clear* means encrypted.
+	 * - for AMD with vTOM and for Intel, *clear* means encrypted
 	 */
 	switch (vendor) {
 	case CC_VENDOR_AMD:
-		return val | cc_mask;
+		if (sev_status & MSR_AMD64_SNP_VTOM)
+			return val & ~cc_mask;
+		else
+			return val | cc_mask;
 	case CC_VENDOR_INTEL:
 		return val & ~cc_mask;
 	default:
@@ -120,7 +137,10 @@ u64 cc_mkdec(u64 val)
 	/* See comment in cc_mkenc() */
 	switch (vendor) {
 	case CC_VENDOR_AMD:
-		return val & ~cc_mask;
+		if (sev_status & MSR_AMD64_SNP_VTOM)
+			return val | cc_mask;
+		else
+			return val & ~cc_mask;
 	case CC_VENDOR_INTEL:
 		return val | cc_mask;
 	default:
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 41ef036..edbc67e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,7 +29,6 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
-#include <linux/swiotlb.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -504,16 +503,6 @@ void __init hyperv_init(void)
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
 
-#ifdef CONFIG_SWIOTLB
-	/*
-	 * Swiotlb bounce buffer needs to be mapped in extra address
-	 * space. Map function doesn't work in the early place and so
-	 * call swiotlb_update_mem_attributes() here.
-	 */
-	if (hv_is_isolation_supported())
-		swiotlb_update_mem_attributes();
-#endif
-
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 5648efb..f6a020c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -13,6 +13,8 @@
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
+#include <asm/coco.h>
+#include <asm/mem_encrypt.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 
@@ -233,7 +235,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
-#endif
 
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
@@ -286,27 +287,25 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 }
 
 /*
- * hv_set_mem_host_visibility - Set specified memory visible to host.
+ * hv_vtom_set_host_visibility - Set specified memory visible to host.
  *
  * In Isolation VM, all guest memory is encrypted from host and guest
  * needs to set memory visible to host via hvcall before sharing memory
  * with host. This function works as wrap of hv_mark_gpa_visibility()
  * with memory base and size.
  */
-int hv_set_mem_host_visibility(unsigned long kbuffer, int pagecount, bool visible)
+static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
 {
-	enum hv_mem_host_visibility visibility = visible ?
-			VMBUS_PAGE_VISIBLE_READ_WRITE : VMBUS_PAGE_NOT_VISIBLE;
+	enum hv_mem_host_visibility visibility = enc ?
+			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
 	int ret = 0;
+	bool result = true;
 	int i, pfn;
 
-	if (!hv_is_isolation_supported() || !hv_hypercall_pg)
-		return 0;
-
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!pfn_array)
-		return -ENOMEM;
+		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
 		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
@@ -315,17 +314,68 @@ int hv_set_mem_host_visibility(unsigned long kbuffer, int pagecount, bool visibl
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
 			ret = hv_mark_gpa_visibility(pfn, pfn_array,
 						     visibility);
-			if (ret)
+			if (ret) {
+				result = false;
 				goto err_free_pfn_array;
+			}
 			pfn = 0;
 		}
 	}
 
  err_free_pfn_array:
 	kfree(pfn_array);
-	return ret;
+	return result;
 }
 
+static bool hv_vtom_tlb_flush_required(bool private)
+{
+	return true;
+}
+
+static bool hv_vtom_cache_flush_required(void)
+{
+	return false;
+}
+
+static bool hv_is_private_mmio(u64 addr)
+{
+	/*
+	 * Hyper-V always provides a single IO-APIC in a guest VM.
+	 * When a paravisor is used, it is emulated by the paravisor
+	 * in the guest context and must be mapped private.
+	 */
+	if (addr >= HV_IOAPIC_BASE_ADDRESS &&
+	    addr < (HV_IOAPIC_BASE_ADDRESS + PAGE_SIZE))
+		return true;
+
+	/* Same with a vTPM */
+	if (addr >= VTPM_BASE_ADDRESS &&
+	    addr < (VTPM_BASE_ADDRESS + PAGE_SIZE))
+		return true;
+
+	return false;
+}
+
+void __init hv_vtom_init(void)
+{
+	/*
+	 * By design, a VM using vTOM doesn't see the SEV setting,
+	 * so SEV initialization is bypassed and sev_status isn't set.
+	 * Set it here to indicate a vTOM VM.
+	 */
+	sev_status = MSR_AMD64_SNP_VTOM;
+	cc_set_vendor(CC_VENDOR_AMD);
+	cc_set_mask(ms_hyperv.shared_gpa_boundary);
+	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
+
+	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
+	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
+	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
+}
+
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+
 /*
  * hv_map_memory - map memory to extra space in the AMD SEV-SNP Isolation VM.
  */
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a..d2c6a2e 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -7,7 +7,6 @@
 enum cc_vendor {
 	CC_VENDOR_NONE,
 	CC_VENDOR_AMD,
-	CC_VENDOR_HYPERV,
 	CC_VENDOR_INTEL,
 };
 
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 72ca905..b712670 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -56,6 +56,7 @@ void __init sev_es_init_vc_handling(void);
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
+#define sev_status	0ULL
 
 static inline void __init sme_early_encrypt(resource_size_t paddr,
 					    unsigned long size) { }
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec..e3cef98 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -11,6 +11,14 @@
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
 
+/*
+ * Hyper-V always provides a single IO-APIC at this MMIO address.
+ * Ideally, the value should be looked up in ACPI tables, but it
+ * is needed for mapping the IO-APIC early in boot on Confidential
+ * VMs, before ACPI functions can be used.
+ */
+#define HV_IOAPIC_BASE_ADDRESS 0xfec00000
+
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
@@ -206,18 +214,19 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
-int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void hv_ghcb_terminate(unsigned int set, unsigned int reason);
+void hv_vtom_init(void);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
+static inline void hv_vtom_init(void) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
@@ -259,11 +268,6 @@ static inline void hv_set_register(unsigned int reg, u64 value) { }
 static inline u64 hv_get_register(unsigned int reg) { return 0; }
 static inline void hv_set_non_nested_register(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
-static inline int hv_set_mem_host_visibility(unsigned long addr, int numpages,
-					     bool visible)
-{
-	return -1;
-}
 #endif /* CONFIG_HYPERV */
 
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f36dc2f..ded7506 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,7 +33,6 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
-#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -397,8 +396,10 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
-		ms_hyperv.shared_gpa_boundary =
-			BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
+
+		if (ms_hyperv.shared_gpa_boundary_active)
+			ms_hyperv.shared_gpa_boundary =
+				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
@@ -409,11 +410,6 @@ static void __init ms_hyperv_init_platform(void)
 			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
 #endif
 		}
-		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
-		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
-				cc_set_vendor(CC_VENDOR_HYPERV);
-		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
@@ -482,6 +478,9 @@ static void __init ms_hyperv_init_platform(void)
 	i8253_clear_counter_on_shutdown = false;
 
 #if IS_ENABLED(CONFIG_HYPERV)
+	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
+	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP))
+		hv_vtom_init();
 	/*
 	 * Setup the hook to get control post apic initialization.
 	 */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 356758b..b037954 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2175,9 +2175,6 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (hv_is_isolation_supported())
-		return hv_set_mem_host_visibility(addr, numpages, !enc);
-
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return __set_memory_enc_pgtable(addr, numpages, enc);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d24dd65..e9e1c41 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2156,7 +2156,6 @@ void vmbus_device_unregister(struct hv_device *device_obj)
  * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
  */
-#define VTPM_BASE_ADDRESS 0xfed40000
 static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 {
 	resource_size_t start = 0;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8845a2e..90d7f68 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -26,6 +26,8 @@
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
 
+#define VTPM_BASE_ADDRESS 0xfed40000
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
