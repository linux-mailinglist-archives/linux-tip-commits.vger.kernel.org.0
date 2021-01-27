Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5D306411
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhA0Tby (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:31:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhA0Tbx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:53 -0500
Date:   Wed, 27 Jan 2021 19:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oNdGPo91Z3Fd91nR4JeWxwcUUOF8Mj2Xm3liYZtW/ew=;
        b=bsmlgqFBHsVfwWyphjFbPnd5FVeJKWoRsDIZ165677HLhtf30Y2/DYy4PBEQ8zyR3i4RO+
        Lz+qq19QxPPpz5OVulkpyy7pA2N2cH+JoK6W43olqODNuihIKs6hCCVwxl5q/WKE26zJ9D
        W5dTt58Roaqvw3FBjI87FahQfYM8kCLnehl0SlcvsVaLYK2yiaYGn+ZoulTMQ7aGzgdcjj
        rRWfUCCMHCjWt6olwa9s+jRMoDbXdEI5ARuwEDazmMwJ4g4dBw5rb/vynMtdRSzoZeQxUG
        r7CnNzCXNhGdSBK++36qsr+aQgFL9Mg7uBgeoKknpyIKu7EDuMP5U+88I4PxbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oNdGPo91Z3Fd91nR4JeWxwcUUOF8Mj2Xm3liYZtW/ew=;
        b=/bai/o5AZ8nEdu2rsKTXSC0RV7J/kI/M5FRhIgjVq2I6SciZUnflNocylSIKUNhw38FXrK
        tONVuwBawHzsC+Dg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: x86: clean up previous struct mm switching
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587021.23325.12823058002123361283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     514b1a8477d25a157f65bf52a443f8ffcc2eb54e
Gitweb:        https://git.kernel.org/tip/514b1a8477d25a157f65bf52a443f8ffcc2eb54e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 19 Jan 2021 15:05:40 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 19 Jan 2021 17:57:15 +01:00

efi: x86: clean up previous struct mm switching

EFI on x86_64 keeps track of the process's MM pointer by storing it
in a global struct called 'efi_scratch', which also used to contain
the mixed mode stack pointer. Let's clean this up a little bit, by
getting rid of the struct, and pushing the mm handling into the
callees entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 17 +++++------------
 arch/x86/platform/efi/efi_64.c | 27 +++++++++++++++------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 5e37e6d..1328b79 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -95,20 +95,12 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 	__efi_call(__VA_ARGS__);					\
 })
 
-/*
- * struct efi_scratch - Scratch space used while switching to/from efi_mm
- * @prev_mm:    store/restore stolen mm_struct while switching to/from efi_mm
- */
-struct efi_scratch {
-	struct mm_struct	*prev_mm;
-} __packed;
-
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_sync_low_kernel_mappings();					\
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
-	efi_switch_mm(&efi_mm);						\
+	efi_enter_mm();							\
 })
 
 #define arch_efi_call_virt(p, f, args...)				\
@@ -116,7 +108,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	efi_switch_mm(efi_scratch.prev_mm);				\
+	efi_leave_mm();							\
 	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 })
@@ -135,7 +127,6 @@ struct efi_scratch {
 
 #endif /* CONFIG_X86_32 */
 
-extern struct efi_scratch efi_scratch;
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_print_memmap(void);
 extern void __init efi_map_region(efi_memory_desc_t *md);
@@ -148,10 +139,12 @@ extern void __init efi_dump_pagetable(void);
 extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
-extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
+void efi_enter_mm(void);
+void efi_leave_mm(void);
+
 /* kexec external ABI */
 struct efi_setup_data {
 	u64 fw_vendor;
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 1d90418..62a6c86 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -54,10 +54,7 @@
  * 0xffff_ffff_0000_0000 and limit EFI VA mapping space to 64G.
  */
 static u64 efi_va = EFI_VA_START;
-
-struct efi_scratch efi_scratch;
-
-EXPORT_SYMBOL_GPL(efi_mm);
+static struct mm_struct *efi_prev_mm;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -481,11 +478,17 @@ void __init efi_dump_pagetable(void)
  * can not change under us.
  * It should be ensured that there are no concurent calls to this function.
  */
-void efi_switch_mm(struct mm_struct *mm)
+void efi_enter_mm(void)
+{
+	efi_prev_mm = current->active_mm;
+	current->active_mm = &efi_mm;
+	switch_mm(efi_prev_mm, &efi_mm, NULL);
+}
+
+void efi_leave_mm(void)
 {
-	efi_scratch.prev_mm = current->active_mm;
-	current->active_mm = mm;
-	switch_mm(efi_scratch.prev_mm, mm, NULL);
+	current->active_mm = efi_prev_mm;
+	switch_mm(&efi_mm, efi_prev_mm, NULL);
 }
 
 static DEFINE_SPINLOCK(efi_runtime_lock);
@@ -549,12 +552,12 @@ efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
 	efi_sync_low_kernel_mappings();
 	local_irq_save(flags);
 
-	efi_switch_mm(&efi_mm);
+	efi_enter_mm();
 
 	status = __efi_thunk(set_virtual_address_map, memory_map_size,
 			     descriptor_size, descriptor_version, virtual_map);
 
-	efi_switch_mm(efi_scratch.prev_mm);
+	efi_leave_mm();
 	local_irq_restore(flags);
 
 	return status;
@@ -848,7 +851,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 							 descriptor_size,
 							 descriptor_version,
 							 virtual_map);
-	efi_switch_mm(&efi_mm);
+	efi_enter_mm();
 
 	kernel_fpu_begin();
 
@@ -864,7 +867,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 	/* grab the virtually remapped EFI runtime services table pointer */
 	efi.runtime = READ_ONCE(systab->runtime);
 
-	efi_switch_mm(efi_scratch.prev_mm);
+	efi_leave_mm();
 
 	return status;
 }
