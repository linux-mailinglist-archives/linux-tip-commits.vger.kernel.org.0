Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85434358A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Mar 2021 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCUWxt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhCUWxj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 18:53:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E625C061574;
        Sun, 21 Mar 2021 15:53:39 -0700 (PDT)
Date:   Sun, 21 Mar 2021 22:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616367215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kf1xO1Fd4l6JrCSBz3kHqd8CyRLjpT+crLsFdTonHnY=;
        b=2qtzmQer4yx3/7EXYRQdcQ9Uy2zZubdCj2SYpyVwa/hhtmqrOp/lzGMiPVDdN7LV/EloYI
        mzZAn+5Djf4izpY1DtAprzeUslzyF7BSK/vwOgUKiduSqbh56Njo8QMX8oqb4hL7Lq71mP
        JnWXrIseMeVGwHTXYBZxEKMTNYLJFUHaDrElRXxVAKwYZujRVp2Ud4/a7hsNZJkBICHvhR
        fb82OJCBHqjJanzpHCq8NhrELQCEsDDCmLqw+JXE2K+07ucImeIbPN6nkS/L8afEAYQtlc
        Yn9uyc4gTARJYEsE2GWNMG5YOiYledq+IPYrIB+AIDhZRLzmtUZEC32pJ3E4mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616367215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kf1xO1Fd4l6JrCSBz3kHqd8CyRLjpT+crLsFdTonHnY=;
        b=l1ehrPe+CCTO4V/4a8QNig3l70ykoTGK4a/KSWSo1gbotmaRX0K6SkK33OvrxuoEGFpPHZ
        ZtggtGvykz6SHBAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix various typos in comments, take #2
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161636721446.398.10245599045128189240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     163b099146b85d1b05bd2eaa045acbeee25c29e4
Gitweb:        https://git.kernel.org/tip/163b099146b85d1b05bd2eaa045acbeee25c29e4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 21 Mar 2021 22:28:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 21 Mar 2021 23:50:28 +01:00

x86: Fix various typos in comments, take #2

Fix another ~42 single-word typos in arch/x86/ code comments,
missed a few in the first pass, in particular in .S files.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/efi_thunk_64.S      | 2 +-
 arch/x86/boot/compressed/head_64.S           | 2 +-
 arch/x86/crypto/crc32-pclmul_glue.c          | 2 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S | 2 +-
 arch/x86/entry/entry_32.S                    | 2 +-
 arch/x86/entry/entry_64.S                    | 2 +-
 arch/x86/entry/vdso/vdso2c.c                 | 2 +-
 arch/x86/entry/vdso/vdso32/system_call.S     | 2 +-
 arch/x86/entry/vdso/vma.c                    | 2 +-
 arch/x86/entry/vdso/vsgx.S                   | 2 +-
 arch/x86/events/intel/bts.c                  | 2 +-
 arch/x86/events/intel/core.c                 | 2 +-
 arch/x86/events/intel/p4.c                   | 2 +-
 arch/x86/include/asm/agp.h                   | 2 +-
 arch/x86/include/asm/intel_pt.h              | 2 +-
 arch/x86/include/asm/set_memory.h            | 2 +-
 arch/x86/kernel/amd_nb.c                     | 2 +-
 arch/x86/kernel/apm_32.c                     | 2 +-
 arch/x86/kernel/cpu/intel.c                  | 2 +-
 arch/x86/kernel/cpu/mce/severity.c           | 2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c              | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c        | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c       | 2 +-
 arch/x86/kernel/relocate_kernel_32.S         | 2 +-
 arch/x86/kernel/relocate_kernel_64.S         | 2 +-
 arch/x86/kernel/smp.c                        | 2 +-
 arch/x86/kernel/tsc_sync.c                   | 2 +-
 arch/x86/kernel/umip.c                       | 2 +-
 arch/x86/kvm/svm/avic.c                      | 2 +-
 arch/x86/kvm/vmx/nested.c                    | 2 +-
 arch/x86/math-emu/reg_ld_str.c               | 2 +-
 arch/x86/math-emu/reg_round.S                | 2 +-
 arch/x86/mm/fault.c                          | 2 +-
 arch/x86/mm/init.c                           | 2 +-
 arch/x86/mm/pkeys.c                          | 2 +-
 arch/x86/platform/efi/quirks.c               | 2 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c       | 2 +-
 arch/x86/platform/olpc/olpc_dt.c             | 2 +-
 arch/x86/power/cpu.c                         | 2 +-
 arch/x86/realmode/init.c                     | 2 +-
 arch/x86/xen/mmu_pv.c                        | 2 +-
 41 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index c4bb0f9..95a223b 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -5,7 +5,7 @@
  * Early support for invoking 32-bit EFI services from a 64-bit kernel.
  *
  * Because this thunking occurs before ExitBootServices() we have to
- * restore the firmware's 32-bit GDT before we make EFI serivce calls,
+ * restore the firmware's 32-bit GDT before we make EFI service calls,
  * since the firmware's 32-bit IDT is still currently installed and it
  * needs to be able to service interrupts.
  *
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f..a8c4095 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -231,7 +231,7 @@ SYM_FUNC_START(startup_32)
 	/*
 	 * Setup for the jump to 64bit mode
 	 *
-	 * When the jump is performend we will be in long mode but
+	 * When the jump is performed we will be in long mode but
 	 * in 32bit compatibility mode with EFER.LME = 1, CS.L = 0, CS.D = 1
 	 * (and in turn EFER.LMA = 1).	To jump into 64bit mode we use
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 7c4c7b2..98cf3b4 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -24,7 +24,7 @@
 /*
  * Copyright 2012 Xyratex Technology Limited
  *
- * Wrappers for kernel crypto shash api to pclmulqdq crc32 imlementation.
+ * Wrappers for kernel crypto shash api to pclmulqdq crc32 implementation.
  */
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
index fc23552..bca4cea 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -88,7 +88,7 @@
 
 /*
  * Combined G1 & G2 function. Reordered with help of rotates to have moves
- * at begining.
+ * at beginning.
  */
 #define g1g2_3(ab, cd, Tx0, Tx1, Tx2, Tx3, Ty0, Ty1, Ty2, Ty3, x, y) \
 	/* G1,1 && G2,1 */ \
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017..cc7745a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -209,7 +209,7 @@
 	 *
 	 * Lets build a 5 entry IRET frame after that, such that struct pt_regs
 	 * is complete and in particular regs->sp is correct. This gives us
-	 * the original 6 enties as gap:
+	 * the original 6 entries as gap:
 	 *
 	 * 14*4(%esp) - <previous context>
 	 * 13*4(%esp) - gap / flags
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 400908d..0a7e964 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -511,7 +511,7 @@ SYM_CODE_START(\asmsym)
 	/*
 	 * No need to switch back to the IST stack. The current stack is either
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
-	 * so it is definitly mapped even with PTI enabled.
+	 * so it is definitely mapped even with PTI enabled.
 	 */
 	jmp	paranoid_exit
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 2d0f3d8..edfe978 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -218,7 +218,7 @@ int main(int argc, char **argv)
 
 	/*
 	 * Figure out the struct name.  If we're writing to a .so file,
-	 * generate raw output insted.
+	 * generate raw output instead.
 	 */
 	name = strdup(argv[3]);
 	namelen = strlen(name);
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index de1fff7..b15adf7 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -29,7 +29,7 @@ __kernel_vsyscall:
 	 * anyone with an AMD CPU, for example).  Nonetheless, we try to keep
 	 * it working approximately as well as it ever worked.
 	 *
-	 * This link may eludicate some of the history:
+	 * This link may elucidate some of the history:
 	 *   https://android-review.googlesource.com/#/q/Iac3295376d61ef83e713ac9b528f3b50aa780cd7
 	 * personally, I find it hard to understand what's going on there.
 	 *
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 825e829..235a579 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -358,7 +358,7 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	mmap_write_lock(mm);
 	/*
 	 * Check if we have already mapped vdso blob - fail to prevent
-	 * abusing from userspace install_speciall_mapping, which may
+	 * abusing from userspace install_special_mapping, which may
 	 * not do accounting and rlimit right.
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 86a0e94..99dafac 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -137,7 +137,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 
 	/*
 	 * If the return from callback is zero or negative, return immediately,
-	 * else re-execute ENCLU with the postive return value interpreted as
+	 * else re-execute ENCLU with the positive return value interpreted as
 	 * the requested ENCLU function.
 	 */
 	cmp	$0, %eax
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 731dd8d..6320d2c 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -594,7 +594,7 @@ static __init int bts_init(void)
 		 * we cannot use the user mapping since it will not be available
 		 * if we're not running the owning process.
 		 *
-		 * With PTI we can't use the kernal map either, because its not
+		 * With PTI we can't use the kernel map either, because its not
 		 * there when we run userspace.
 		 *
 		 * For now, disable this driver when using PTI.
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8a70d4d..f9b638e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2776,7 +2776,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 * processing loop coming after that the function, otherwise
 	 * phony regular samples may be generated in the sampling buffer
 	 * not marked with the EXACT tag. Another possibility is to have
-	 * one PEBS event and at least one non-PEBS event whic hoverflows
+	 * one PEBS event and at least one non-PEBS event which overflows
 	 * while PEBS has armed. In this case, bit 62 of GLOBAL_STATUS will
 	 * not be set, yet the overflow status bit for the PEBS counter will
 	 * be on Skylake.
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 2aef604..971dffe 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1313,7 +1313,7 @@ static __initconst const struct x86_pmu p4_pmu = {
 	.get_event_constraints	= x86_get_event_constraints,
 	/*
 	 * IF HT disabled we may need to use all
-	 * ARCH_P4_MAX_CCCR counters simulaneously
+	 * ARCH_P4_MAX_CCCR counters simultaneously
 	 * though leave it restricted at moment assuming
 	 * HT is on
 	 */
diff --git a/arch/x86/include/asm/agp.h b/arch/x86/include/asm/agp.h
index 62da760..cd7b143 100644
--- a/arch/x86/include/asm/agp.h
+++ b/arch/x86/include/asm/agp.h
@@ -9,7 +9,7 @@
  * Functions to keep the agpgart mappings coherent with the MMU. The
  * GART gives the CPU a physical alias of pages in memory. The alias
  * region is mapped uncacheable. Make sure there are no conflicting
- * mappings with different cachability attributes for the same
+ * mappings with different cacheability attributes for the same
  * page. This avoids data corruption on some CPUs.
  */
 
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 423b788..ebe8d2e 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_INTEL_PT_H
 
 #define PT_CPUID_LEAVES		2
-#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
+#define PT_CPUID_REGS_NUM	4 /* number of registers (eax, ebx, ecx, edx) */
 
 enum pt_capabilities {
 	PT_CAP_max_subleaf = 0,
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 675d84d..43fa081 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -8,7 +8,7 @@
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
  * address range. The attributes include:
- * Cachability   : UnCached, WriteCombining, WriteThrough, WriteBack
+ * Cacheability  : UnCached, WriteCombining, WriteThrough, WriteBack
  * Executability : eXecutable, NoteXecutable
  * Read/Write    : ReadOnly, ReadWrite
  * Presence      : NotPresent
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b439695..0908309 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Shared support code for AMD K8 northbridges and derivates.
+ * Shared support code for AMD K8 northbridges and derivatives.
  * Copyright 2006 Andi Kleen, SUSE Labs.
  */
 
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index abb8dea..241dda6 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1025,7 +1025,7 @@ static int apm_enable_power_management(int enable)
  *	status which gives the rough battery status, and current power
  *	source. The bat value returned give an estimate as a percentage
  *	of life and a status value for the battery. The estimated life
- *	if reported is a lifetime in secodnds/minutes at current power
+ *	if reported is a lifetime in seconds/minutes at current power
  *	consumption.
  */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a5..63e381a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -301,7 +301,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 *  The operating system must reload CR3 to cause the TLB to be flushed"
 	 *
 	 * As a result, boot_cpu_has(X86_FEATURE_PGE) in arch/x86/include/asm/tlbflush.h
-	 * should be false so that __flush_tlb_all() causes CR3 insted of CR4.PGE
+	 * should be false so that __flush_tlb_all() causes CR3 instead of CR4.PGE
 	 * to be modified.
 	 */
 	if (c->x86 == 5 && c->x86_model == 9) {
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991..55ffa84 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -142,7 +142,7 @@ static struct severity {
 		MASK(MCI_STATUS_OVER|MCI_UC_SAR, MCI_STATUS_UC|MCI_STATUS_AR)
 		),
 	MCESEV(
-		KEEP, "Non signalled machine check",
+		KEEP, "Non signaled machine check",
 		SER, BITCLR(MCI_STATUS_S)
 		),
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 28c8a23..a76694b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -799,7 +799,7 @@ void mtrr_ap_init(void)
 	 *
 	 * This routine is called in two cases:
 	 *
-	 *   1. very earily time of software resume, when there absolutely
+	 *   1. very early time of software resume, when there absolutely
 	 *      isn't mtrr entry changes;
 	 *
 	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 98c0e21..dbeaa84 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -397,7 +397,7 @@ void mon_event_count(void *info)
  * timer. Having 1s interval makes the calculation of bandwidth simpler.
  *
  * Although MBA's goal is to restrict the bandwidth to a maximum, there may
- * be a need to increase the bandwidth to avoid uncecessarily restricting
+ * be a need to increase the bandwidth to avoid unnecessarily restricting
  * the L2 <-> L3 traffic.
  *
  * Since MBA controls the L2 external bandwidth where as MBM measures the
@@ -480,7 +480,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	/*
 	 * Delta values are updated dynamically package wise for each
-	 * rdtgrp everytime the throttle MSR changes value.
+	 * rdtgrp every time the throttle MSR changes value.
 	 *
 	 * This is because (1)the increase in bandwidth is not perfectly
 	 * linear and only "approximately" linear even when the hardware
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2392f9f..01fd30e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2555,7 +2555,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 /*
  * This creates a directory mon_data which contains the monitored data.
  *
- * mon_data has one directory for each domain whic are named
+ * mon_data has one directory for each domain which are named
  * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
  * with L3 domain looks as below:
  * ./mon_data:
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index 94b3388..f469153 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -107,7 +107,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 *  - Write protect disabled
 	 *  - No task switch
 	 *  - Don't do FP software emulation.
-	 *  - Proctected mode enabled
+	 *  - Protected mode enabled
 	 */
 	movl	%cr0, %eax
 	andl	$~(X86_CR0_PG | X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %eax
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a4d9a26..c53271a 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -121,7 +121,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 *  - Write protect disabled
 	 *  - No task switch
 	 *  - Don't do FP software emulation.
-	 *  - Proctected mode enabled
+	 *  - Protected mode enabled
 	 */
 	movq	%cr0, %rax
 	andq	$~(X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %rax
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index dbd68f3..06db901 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -204,7 +204,7 @@ static void native_stop_other_cpus(int wait)
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
-		 * reqeust it. If wait is true, the machine hangs here if
+		 * request it. If wait is true, the machine hangs here if
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 3d3c761..50a4515 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -472,7 +472,7 @@ retry:
 	/*
 	 * Add the result to the previous adjustment value.
 	 *
-	 * The adjustement value is slightly off by the overhead of the
+	 * The adjustment value is slightly off by the overhead of the
 	 * sync mechanism (observed values are ~200 TSC cycles), but this
 	 * really depends on CPU, node distance and frequency. So
 	 * compensating for this is hard to get right. Experiments show
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f6225bf..fac1daa 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -272,7 +272,7 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		 * by whether the operand is a register or a memory location.
 		 * If operand is a register, return as many bytes as the operand
 		 * size. If operand is memory, return only the two least
-		 * siginificant bytes.
+		 * significant bytes.
 		 */
 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
 			*data_size = insn->opnd_bytes;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 80010f9..3e55674 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -727,7 +727,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	struct amd_svm_iommu_ir *ir;
 
 	/**
-	 * In some cases, the existing irte is updaed and re-set,
+	 * In some cases, the existing irte is updated and re-set,
 	 * so we need to check here if it's already been * added
 	 * to the ir_list.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bcca0b8..1e069aa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3537,7 +3537,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * snapshot restore (migration).
 	 *
 	 * In this flow, it is assumed that vmcs12 cache was
-	 * trasferred as part of captured nVMX state and should
+	 * transferred as part of captured nVMX state and should
 	 * therefore not be read from guest memory (which may not
 	 * exist on destination host yet).
 	 */
diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
index fe6246f..7ca6417 100644
--- a/arch/x86/math-emu/reg_ld_str.c
+++ b/arch/x86/math-emu/reg_ld_str.c
@@ -964,7 +964,7 @@ int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d)
 /* The return value (in eax) is zero if the result is exact,
    if bits are changed due to rounding, truncation, etc, then
    a non-zero value is returned */
-/* Overflow is signalled by a non-zero return value (in eax).
+/* Overflow is signaled by a non-zero return value (in eax).
    In the case of overflow, the returned significand always has the
    largest possible value */
 int FPU_round_to_int(FPU_REG *r, u_char tag)
diff --git a/arch/x86/math-emu/reg_round.S b/arch/x86/math-emu/reg_round.S
index 11a1f79..4a9fc3c 100644
--- a/arch/x86/math-emu/reg_round.S
+++ b/arch/x86/math-emu/reg_round.S
@@ -575,7 +575,7 @@ Normalise_result:
 #ifdef PECULIAR_486
 	/*
 	 * This implements a special feature of 80486 behaviour.
-	 * Underflow will be signalled even if the number is
+	 * Underflow will be signaled even if the number is
 	 * not a denormal after rounding.
 	 * This difference occurs only for masked underflow, and not
 	 * in the unmasked case.
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ea70b82..1c548ad 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1497,7 +1497,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * userspace task is trying to access some valid (from guest's point of
 	 * view) memory which is not currently mapped by the host (e.g. the
 	 * memory is swapped out). Note, the corresponding "page ready" event
-	 * which is injected when the memory becomes available, is delived via
+	 * which is injected when the memory becomes available, is delivered via
 	 * an interrupt mechanism and not a #PF exception
 	 * (see arch/x86/kernel/kvm.c: sysvec_kvm_asyncpf_interrupt()).
 	 *
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 742fbdf..fbf41dd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -756,7 +756,7 @@ void __init init_mem_mapping(void)
 
 #ifdef CONFIG_X86_64
 	if (max_pfn > max_low_pfn) {
-		/* can we preseve max_low_pfn ?*/
+		/* can we preserve max_low_pfn ?*/
 		max_low_pfn = max_pfn;
 	}
 #else
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 8873ed1..a2332ee 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -128,7 +128,7 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 /*
  * Called from the FPU code when creating a fresh set of FPU
  * registers.  This is called from a very specific context where
- * we know the FPU regstiers are safe for use and we can use PKRU
+ * we know the FPU registers are safe for use and we can use PKRU
  * directly.
  */
 void copy_init_pkru_to_fpregs(void)
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index fda4216..7850111 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -441,7 +441,7 @@ void __init efi_free_boot_services(void)
 		 * 1.4.4 with SGX enabled booting Linux via Fedora 24's
 		 * grub2-efi on a hard disk.  (And no, I don't know why
 		 * this happened, but Linux should still try to boot rather
-		 * panicing early.)
+		 * panicking early.)
 		 */
 		rm_size = real_mode_size_needed();
 		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 85f4638..994a229 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -27,7 +27,7 @@ static bool				lid_wake_on_close;
  * wake-on-close. This is implemented as standard by the XO-1.5 DSDT.
  *
  * We provide here a sysfs attribute that will additionally enable
- * wake-on-close behavior. This is useful (e.g.) when we oportunistically
+ * wake-on-close behavior. This is useful (e.g.) when we opportunistically
  * suspend with the display running; if the lid is then closed, we want to
  * wake up to turn the display off.
  *
diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 26d1f66..75e3319 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -131,7 +131,7 @@ void * __init prom_early_alloc(unsigned long size)
 		const size_t chunk_size = max(PAGE_SIZE, size);
 
 		/*
-		 * To mimimize the number of allocations, grab at least
+		 * To minimize the number of allocations, grab at least
 		 * PAGE_SIZE of memory (that's an arbitrary choice that's
 		 * fast enough on the platforms we care about while minimizing
 		 * wasted bootmem) and hand off chunks of it to callers.
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index db1378c..c9908bc 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -321,7 +321,7 @@ int hibernate_resume_nonboot_cpu_disable(void)
 
 /*
  * When bsp_check() is called in hibernate and suspend, cpu hotplug
- * is disabled already. So it's unnessary to handle race condition between
+ * is disabled already. So it's unnecessary to handle race condition between
  * cpumask query and cpu hotplug.
  */
 static int bsp_check(void)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 22fda7d..1be71ef 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -103,7 +103,7 @@ static void __init setup_real_mode(void)
 		*ptr += phys_base;
 	}
 
-	/* Must be perfomed *after* relocation. */
+	/* Must be performed *after* relocation. */
 	trampoline_header = (struct trampoline_header *)
 		__va(real_mode_header->trampoline_header);
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index cf2ade8..1e28c88 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2410,7 +2410,7 @@ int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
 	rmd.prot = prot;
 	/*
 	 * We use the err_ptr to indicate if there we are doing a contiguous
-	 * mapping or a discontigious mapping.
+	 * mapping or a discontiguous mapping.
 	 */
 	rmd.contiguous = !err_ptr;
 	rmd.no_translate = no_translate;
