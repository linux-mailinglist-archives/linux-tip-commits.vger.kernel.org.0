Return-Path: <linux-tip-commits+bounces-90-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01050822BB3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jan 2024 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356E11F2243B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jan 2024 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4918C34;
	Wed,  3 Jan 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NReO9xmf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leFnGpvq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1B18C2F;
	Wed,  3 Jan 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jan 2024 10:58:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704279505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47Zo+lWVGVxD/PdXeE6Hhy5cvXgwiizxSJnqsjkAUDo=;
	b=NReO9xmflFSq/WNRlHFRMO1N1QijqqDNdmCuKjVb707actXeaf+hr+FmT6aNvQv6ZnyhsU
	Nu9f+5uOQPjK+df3OabWTJCMrWMpmKhXdbw4Hmj3XTM0ufZ3jG/iVpkYeS7PPxuuNPYYZT
	Cln/kibR+k+rjTdu8QO8resj5+4c8OgzsVLJhSqZ/XmKiMrd6r2qi9rXFe4kqKqUcG+K4D
	/p8Dzg1oUO57qaPzSraTlWgwVbPMCQeQiK2fwG7N8xZRxVquYHbYwSu3vdfzoJOSTrQnAP
	9vL0NY5Gli9M1dKpjbiNR+FhE2pW/Er4piQudfFlvTeGPojVkDpKDOLtDgbPtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704279505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47Zo+lWVGVxD/PdXeE6Hhy5cvXgwiizxSJnqsjkAUDo=;
	b=leFnGpvqKXnCpmednRA60Z19gGxORbSC9EiEnb90I3PcjQUkJsf7vn6t2k10pym4UsMvO+
	c5rcmzifvEQh0SAA==
From: "tip-bot2 for Bjorn Helgaas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] arch/x86: Fix typos
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240103004011.1758650-1-helgaas@kernel.org>
References: <20240103004011.1758650-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170427950464.398.4071869590314729544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     54aa699e8094efb7d7675fefbc03dfce24f98456
Gitweb:        https://git.kernel.org/tip/54aa699e8094efb7d7675fefbc03dfce24f98456
Author:        Bjorn Helgaas <bhelgaas@google.com>
AuthorDate:    Tue, 02 Jan 2024 18:40:11 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Jan 2024 11:46:22 +01:00

arch/x86: Fix typos

Fix typos, most reported by "codespell arch/x86".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240103004011.1758650-1-helgaas@kernel.org
---
 arch/x86/boot/compressed/Makefile            | 2 +-
 arch/x86/boot/compressed/mem.c               | 2 +-
 arch/x86/coco/tdx/tdx.c                      | 2 +-
 arch/x86/crypto/aesni-intel_asm.S            | 2 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     | 2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 2 +-
 arch/x86/crypto/sha512-avx-asm.S             | 2 +-
 arch/x86/crypto/sha512-ssse3-asm.S           | 2 +-
 arch/x86/events/amd/brs.c                    | 2 +-
 arch/x86/events/amd/core.c                   | 2 +-
 arch/x86/events/intel/core.c                 | 2 +-
 arch/x86/hyperv/hv_apic.c                    | 2 +-
 arch/x86/hyperv/irqdomain.c                  | 2 +-
 arch/x86/hyperv/ivm.c                        | 2 +-
 arch/x86/include/asm/amd_nb.h                | 2 +-
 arch/x86/include/asm/extable_fixup_types.h   | 2 +-
 arch/x86/include/asm/fpu/types.h             | 2 +-
 arch/x86/include/asm/iosf_mbi.h              | 2 +-
 arch/x86/include/asm/kvm_host.h              | 2 +-
 arch/x86/include/asm/nospec-branch.h         | 4 ++--
 arch/x86/include/asm/pgtable_64.h            | 2 +-
 arch/x86/include/asm/uv/uv_hub.h             | 2 +-
 arch/x86/include/asm/vdso/gettimeofday.h     | 2 +-
 arch/x86/include/asm/xen/interface_64.h      | 2 +-
 arch/x86/include/uapi/asm/amd_hsmp.h         | 2 +-
 arch/x86/kernel/alternative.c                | 2 +-
 arch/x86/kernel/amd_gart_64.c                | 2 +-
 arch/x86/kernel/apic/Makefile                | 2 +-
 arch/x86/kernel/apic/apic.c                  | 2 +-
 arch/x86/kernel/apic/vector.c                | 4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c              | 2 +-
 arch/x86/kernel/fpu/core.c                   | 2 +-
 arch/x86/kernel/head_64.S                    | 4 ++--
 arch/x86/kernel/hpet.c                       | 4 ++--
 arch/x86/kernel/kvm.c                        | 2 +-
 arch/x86/kernel/kvmclock.c                   | 2 +-
 arch/x86/kernel/ldt.c                        | 6 +++---
 arch/x86/kernel/process.c                    | 2 +-
 arch/x86/kernel/sev-shared.c                 | 2 +-
 arch/x86/kvm/cpuid.c                         | 2 +-
 arch/x86/kvm/mmu/mmu.c                       | 4 ++--
 arch/x86/kvm/mmu/tdp_iter.c                  | 2 +-
 arch/x86/kvm/svm/svm.c                       | 2 +-
 arch/x86/kvm/vmx/nested.c                    | 2 +-
 arch/x86/kvm/vmx/vmx.c                       | 2 +-
 arch/x86/kvm/x86.c                           | 6 +++---
 arch/x86/lib/delay.c                         | 2 +-
 arch/x86/mm/init_64.c                        | 6 +++---
 arch/x86/mm/pat/memtype.c                    | 2 +-
 arch/x86/mm/pat/set_memory.c                 | 4 ++--
 arch/x86/mm/pti.c                            | 2 +-
 arch/x86/mm/tlb.c                            | 2 +-
 arch/x86/net/bpf_jit_comp.c                  | 2 +-
 arch/x86/net/bpf_jit_comp32.c                | 2 +-
 arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
 arch/x86/platform/pvh/head.S                 | 2 +-
 arch/x86/platform/uv/uv_nmi.c                | 2 +-
 arch/x86/platform/uv/uv_time.c               | 2 +-
 arch/x86/realmode/init.c                     | 2 +-
 arch/x86/xen/mmu_pv.c                        | 2 +-
 60 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 71fc531..f19c038 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -53,7 +53,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
-# sev.c indirectly inludes inat-table.h which is generated during
+# sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index b3c3a4b..dbba332 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -8,7 +8,7 @@
 
 /*
  * accept_memory() and process_unaccepted_memory() called from EFI stub which
- * runs before decompresser and its early_tdx_detect().
+ * runs before decompressor and its early_tdx_detect().
  *
  * Enumerate TDX directly from the early users.
  */
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1b5d17a..4f06e67 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -886,7 +886,7 @@ void __init tdx_early_init(void)
 	 * there.
 	 *
 	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
-	 * implemented seperately in the low level startup ASM code.
+	 * implemented separately in the low level startup ASM code.
 	 * Until that is in place, disable parallel bringup for TDX.
 	 */
 	x86_cpuinit.parallel_bringup = false;
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 187f913..411d8c8 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -666,7 +666,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 
 .ifc \operation, dec
 	movdqa	%xmm1, %xmm3
-	pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+	pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
 
 	mov	\PLAIN_CYPH_LEN, %r10
 	add	%r13, %r10
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 74dd230..8c9749e 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -747,7 +747,7 @@ VARIABLE_OFFSET = 16*8
 
 .if  \ENC_DEC ==  DEC
         vmovdqa	%xmm1, %xmm3
-        pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+        pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
 
         mov	\PLAIN_CYPH_LEN, %r10
         add	%r13, %r10
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 81ce0f4..bbcff1f 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -184,7 +184,7 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc1,crc1
 	xor     crc2,crc2
 
-	# Fall thruogh into top of crc array (crc_128)
+	# Fall through into top of crc array (crc_128)
 
 	################################################################
 	## 3) CRC Array:
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index d902b8e..5bfce4b 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -84,7 +84,7 @@ frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
-# WK_2(t) points to 1 of 2 qwords at frame.WK depdending on t being odd/even
+# WK_2(t) points to 1 of 2 qwords at frame.WK depending on t being odd/even
 
 # Input message (arg1)
 #define MSG(i)    8*i(msg)
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index 65be301..30a2c47 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -82,7 +82,7 @@ frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
-# WK_2(t) points to 1 of 2 qwords at frame.WK depdending on t being odd/even
+# WK_2(t) points to 1 of 2 qwords at frame.WK depending on t being odd/even
 
 # Input message (arg1)
 #define MSG(i)    8*i(msg)
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index ed30871..780acd3 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -125,7 +125,7 @@ int amd_brs_hw_config(struct perf_event *event)
 	 * Where X is the number of taken branches due to interrupt
 	 * skid. Skid is large.
 	 *
-	 * Where Y is the occurences of the event while BRS is
+	 * Where Y is the occurrences of the event while BRS is
 	 * capturing the lbr_nr entries.
 	 *
 	 * By using retired taken branches, we limit the impact on the
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e249765..25ad6fd 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1184,7 +1184,7 @@ static void amd_put_event_constraints_f17h(struct cpu_hw_events *cpuc,
  * period of each one and given that the BRS saturates, it would not be possible
  * to guarantee correlated content for all events. Therefore, in situations
  * where multiple events want to use BRS, the kernel enforces mutual exclusion.
- * Exclusion is enforced by chosing only one counter for events using BRS.
+ * Exclusion is enforced by choosing only one counter for events using BRS.
  * The event scheduling logic will then automatically multiplex the
  * events and ensure that at most one event is actively using BRS.
  *
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794..fdfcd51 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4027,7 +4027,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 /*
  * Currently, the only caller of this function is the atomic_switch_perf_msrs().
- * The host perf conext helps to prepare the values of the real hardware for
+ * The host perf context helps to prepare the values of the real hardware for
  * a set of msrs that need to be switched atomically in a vmx transaction.
  *
  * For example, the pseudocode needed to add a new msr should look like:
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 97bfe5f..5fc4554 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -209,7 +209,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 
 		/*
 		 * This particular version of the IPI hypercall can
-		 * only target upto 64 CPUs.
+		 * only target up to 64 CPUs.
 		 */
 		if (vcpu >= 64)
 			goto do_ex_hypercall;
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 42c70d2..3215a4a 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -212,7 +212,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 * This interrupt is already mapped. Let's unmap first.
 		 *
 		 * We don't use retarget interrupt hypercalls here because
-		 * Microsoft Hypervisor doens't allow root to change the vector
+		 * Microsoft Hypervisor doesn't allow root to change the vector
 		 * or specify VPs outside of the set that is initially used
 		 * during mapping.
 		 */
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 02e5523..7dcbf15 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -144,7 +144,7 @@ void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
 	/* Tell the hypervisor what went wrong. */
 	val |= GHCB_SEV_TERM_REASON(set, reason);
 
-	/* Request Guest Termination from Hypvervisor */
+	/* Request Guest Termination from Hypervisor */
 	wr_ghcb_msr(val);
 	VMGEXIT();
 
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index ed0eaf6..5c37944 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -104,7 +104,7 @@ static inline bool amd_gart_present(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return false;
 
-	/* GART present only on Fam15h, upto model 0fh */
+	/* GART present only on Fam15h, up to model 0fh */
 	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
 	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
 		return true;
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 991e31c..fe63120 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -4,7 +4,7 @@
 
 /*
  * Our IMM is signed, as such it must live at the top end of the word. Also,
- * since C99 hex constants are of ambigious type, force cast the mask to 'int'
+ * since C99 hex constants are of ambiguous type, force cast the mask to 'int'
  * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
  */
 #define EX_DATA_TYPE_MASK		((int)0x000000FF)
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb81007..f1fadc3 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -415,7 +415,7 @@ struct fpu_state_perm {
 	 *
 	 * This master permission field is only to be used when
 	 * task.fpu.fpstate based checks fail to validate whether the task
-	 * is allowed to expand it's xfeatures set which requires to
+	 * is allowed to expand its xfeatures set which requires to
 	 * allocate a larger sized fpstate buffer.
 	 *
 	 * Do not access this field directly.  Use the provided helper
diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index a1911fe..af7541c 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -111,7 +111,7 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
  * This function will block all kernel access to the PMIC I2C bus, so that the
  * P-Unit can safely access the PMIC over the shared I2C bus.
  *
- * Note on these systems the i2c-bus driver will request a sempahore from the
+ * Note on these systems the i2c-bus driver will request a semaphore from the
  * P-Unit for exclusive access to the PMIC bus when i2c drivers are accessing
  * it, but this does not appear to be sufficient, we still need to avoid making
  * certain P-Unit requests during the access window to avoid problems.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d703698..6711da0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1652,7 +1652,7 @@ struct kvm_x86_ops {
 	/* Whether or not a virtual NMI is pending in hardware. */
 	bool (*is_vnmi_pending)(struct kvm_vcpu *vcpu);
 	/*
-	 * Attempt to pend a virtual NMI in harware.  Returns %true on success
+	 * Attempt to pend a virtual NMI in hardware.  Returns %true on success
 	 * to allow using static_call_ret0 as the fallback.
 	 */
 	bool (*set_vnmi_pending)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b9..262e655 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -49,7 +49,7 @@
  * but there is still a cushion vs. the RSB depth. The algorithm does not
  * claim to be perfect and it can be speculated around by the CPU, but it
  * is considered that it obfuscates the problem enough to make exploitation
- * extremly difficult.
+ * extremely difficult.
  */
 #define RET_DEPTH_SHIFT			5
 #define RSB_RET_STUFF_LOOPS		16
@@ -208,7 +208,7 @@
 
 /*
  * Abuse ANNOTATE_RETPOLINE_SAFE on a NOP to indicate UNRET_END, should
- * eventually turn into it's own annotation.
+ * eventually turn into its own annotation.
  */
 .macro VALIDATE_UNRET_END
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index a629b1b..24af25b 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -203,7 +203,7 @@ static inline void native_pgd_clear(pgd_t *pgd)
  * F (2) in swp entry is used to record when a pagetable is
  * writeprotected by userfaultfd WP support.
  *
- * E (3) in swp entry is used to rememeber PG_anon_exclusive.
+ * E (3) in swp entry is used to remember PG_anon_exclusive.
  *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 5fa76c2..ea877fd 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -653,7 +653,7 @@ static inline int uv_blade_to_node(int blade)
 	return uv_socket_to_node(blade);
 }
 
-/* Blade number of current cpu. Numnbered 0 .. <#blades -1> */
+/* Blade number of current cpu. Numbered 0 .. <#blades -1> */
 static inline int uv_numa_blade_id(void)
 {
 	return uv_hub_info->numa_blade_id;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index c81858d..923053f 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -321,7 +321,7 @@ static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
 	/*
-	 * Due to the MSB/Sign-bit being used as invald marker (see
+	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
 	 */
 	u64 delta = (cycles - last) & S64_MAX;
diff --git a/arch/x86/include/asm/xen/interface_64.h b/arch/x86/include/asm/xen/interface_64.h
index c599ec2..c10f279 100644
--- a/arch/x86/include/asm/xen/interface_64.h
+++ b/arch/x86/include/asm/xen/interface_64.h
@@ -61,7 +61,7 @@
  *   RING1 -> RING3 kernel mode.
  *   RING2 -> RING3 kernel mode.
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
  *      orb   $3,1*8(%rsp)
  *      iretq
diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
index fce2268..e5d182c 100644
--- a/arch/x86/include/uapi/asm/amd_hsmp.h
+++ b/arch/x86/include/uapi/asm/amd_hsmp.h
@@ -238,7 +238,7 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
 	/*
 	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
 	 * input: args[0] = DIMM address[7:0]
-	 * output: args[0] = temperature in degree celcius[31:21] + update rate in ms[16:8] +
+	 * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
 	 * DIMM address[7:0]
 	 */
 	{1, 1, HSMP_GET},
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be393..0c7fc2b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1896,7 +1896,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
  * Note that the caller must ensure that if the modified code is part of a
  * module, the module would not be removed during poking. This can be achieved
  * by registering a module notifier, and ordering module removal and patching
- * trough a mutex.
+ * through a mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 56a917d..2ae98f7 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -776,7 +776,7 @@ int __init gart_iommu_init(void)
 				iommu_size >> PAGE_SHIFT);
 	/*
 	 * Tricky. The GART table remaps the physical memory range,
-	 * so the CPU wont notice potential aliases and if the memory
+	 * so the CPU won't notice potential aliases and if the memory
 	 * is remapped to UC later on, we might surprise the PCI devices
 	 * with a stray writeout of a cacheline. So play it sure and
 	 * do an explicit, full-scale wbinvd() _after_ having marked all
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 2ee867d..3bf0487 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -4,7 +4,7 @@
 #
 
 # Leads to non-deterministic coverage that is not a function of syscall inputs.
-# In particualr, smp_apic_timer_interrupt() is called in random places.
+# In particular, smp_apic_timer_interrupt() is called in random places.
 KCOV_INSTRUMENT		:= n
 
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o init.o
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 41093cf..4667bc4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -782,7 +782,7 @@ bool __init apic_needs_pit(void)
 
 	/*
 	 * If interrupt delivery mode is legacy PIC or virtual wire without
-	 * configuration, the local APIC timer wont be set up. Make sure
+	 * configuration, the local APIC timer won't be set up. Make sure
 	 * that the PIT is initialized.
 	 */
 	if (apic_intr_mode == APIC_PIC ||
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 319448d..185738c 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -738,8 +738,8 @@ int __init arch_probe_nr_irqs(void)
 void lapic_assign_legacy_vector(unsigned int irq, bool replace)
 {
 	/*
-	 * Use assign system here so it wont get accounted as allocated
-	 * and moveable in the cpu hotplug check and it prevents managed
+	 * Use assign system here so it won't get accounted as allocated
+	 * and movable in the cpu hotplug check and it prevents managed
 	 * irq reservation from touching it.
 	 */
 	irq_matrix_assign_system(vector_matrix, ISA_IRQ_VECTOR(irq), replace);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df..b65ab21 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -581,7 +581,7 @@ err_out:
  *
  * Flush any outstanding enqueued EADD operations and perform EINIT.  The
  * Launch Enclave Public Key Hash MSRs are rewritten as necessary to match
- * the enclave's MRSIGNER, which is caculated from the provided sigstruct.
+ * the enclave's MRSIGNER, which is calculated from the provided sigstruct.
  *
  * Return:
  * - 0:		Success.
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a21a4d0..520deb4 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  * Must be invoked from KVM after a VMEXIT before enabling interrupts when
  * XFD write emulation is disabled. This is required because the guest can
  * freely modify XFD and the state at VMEXIT is not guaranteed to be the
- * same as the state on VMENTER. So software state has to be udpated before
+ * same as the state on VMENTER. So software state has to be updated before
  * any operation which depends on it can take place.
  *
  * Note: It can be invoked unconditionally even when write emulation is
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1f79d80..d8d5d22 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -205,9 +205,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Switch to new page-table
 	 *
 	 * For the boot CPU this switches to early_top_pgt which still has the
-	 * indentity mappings present. The secondary CPUs will switch to the
+	 * identity mappings present. The secondary CPUs will switch to the
 	 * init_top_pgt here, away from the trampoline_pgd and unmap the
-	 * indentity mapped ranges.
+	 * identity mapped ranges.
 	 */
 	movq	%rax, %cr3
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 41eecf1..8ff2bf9 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -707,7 +707,7 @@ static void __init hpet_select_clockevents(void)
 
 	hpet_base.nr_clockevents = 0;
 
-	/* No point if MSI is disabled or CPU has an Always Runing APIC Timer */
+	/* No point if MSI is disabled or CPU has an Always Running APIC Timer */
 	if (hpet_msi_disable || boot_cpu_has(X86_FEATURE_ARAT))
 		return;
 
@@ -965,7 +965,7 @@ static bool __init mwait_pc10_supported(void)
  * and per CPU timer interrupts.
  *
  * The probability that this problem is going to be solved in the
- * forseeable future is close to zero, so the kernel has to be cluttered
+ * foreseeable future is close to zero, so the kernel has to be cluttered
  * with heuristics to keep up with the ever growing amount of hardware and
  * firmware trainwrecks. Hopefully some day hardware people will understand
  * that the approach of "This can be fixed in software" is not sustainable.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 0ddb3bd..8b57e02 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -942,7 +942,7 @@ static void __init kvm_init_platform(void)
 		 * Reset the host's shared pages list related to kernel
 		 * specific page encryption status settings before we load a
 		 * new kernel by kexec. Reset the page encryption status
-		 * during early boot intead of just before kexec to avoid SMP
+		 * during early boot instead of just before kexec to avoid SMP
 		 * races during kvm_pv_guest_cpu_reboot().
 		 * NOTE: We cannot reset the complete shared pages list
 		 * here as we need to retain the UEFI/OVMF firmware
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index fb8f521..a95d090 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -42,7 +42,7 @@ static int __init parse_no_kvmclock_vsyscall(char *arg)
 }
 early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 
-/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+/* Aligned to page sizes to match what's mapped via vsyscalls to userspace */
 #define HVC_BOOT_ARRAY_SIZE \
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index adc67f9..7a814b4 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -7,7 +7,7 @@
  * This handles calls from both 32bit and 64bit mode.
  *
  * Lock order:
- *	contex.ldt_usr_sem
+ *	context.ldt_usr_sem
  *	  mmap_lock
  *	    context.lock
  */
@@ -49,7 +49,7 @@ void load_mm_ldt(struct mm_struct *mm)
 	/*
 	 * Any change to mm->context.ldt is followed by an IPI to all
 	 * CPUs with the mm active.  The LDT will not be freed until
-	 * after the IPI is handled by all such CPUs.  This means that,
+	 * after the IPI is handled by all such CPUs.  This means that
 	 * if the ldt_struct changes before we return, the values we see
 	 * will be safe, and the new values will be loaded before we run
 	 * any user code.
@@ -685,7 +685,7 @@ SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
 	}
 	/*
 	 * The SYSCALL_DEFINE() macros give us an 'unsigned long'
-	 * return type, but tht ABI for sys_modify_ldt() expects
+	 * return type, but the ABI for sys_modify_ldt() expects
 	 * 'int'.  This cast gives us an int-sized value in %rax
 	 * for the return code.  The 'unsigned' is necessary so
 	 * the compiler does not try to sign-extend the negative
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e83..ab49ade 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -477,7 +477,7 @@ void native_tss_update_io_bitmap(void)
 	/*
 	 * Make sure that the TSS limit is covering the IO bitmap. It might have
 	 * been cut down by a VMEXIT to 0x67 which would cause a subsequent I/O
-	 * access from user space to trigger a #GP because tbe bitmap is outside
+	 * access from user space to trigger a #GP because the bitmap is outside
 	 * the TSS limit.
 	 */
 	refresh_tss_limit();
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915..1d24ec6 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -96,7 +96,7 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 	/* Tell the hypervisor what went wrong. */
 	val |= GHCB_SEV_TERM_REASON(set, reason);
 
-	/* Request Guest Termination from Hypvervisor */
+	/* Request Guest Termination from Hypervisor */
 	sev_es_wr_ghcb_msr(val);
 	VMGEXIT();
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dda6fc4..42d3f47 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -105,7 +105,7 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
 
 		/*
 		 * If the index isn't significant, use the first entry with a
-		 * matching function.  It's userspace's responsibilty to not
+		 * matching function.  It's userspace's responsibility to not
 		 * provide "duplicate" entries in all cases.
 		 */
 		if (!(e->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX) || e->index == index)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c57e181..0b1f991 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -987,7 +987,7 @@ static void pte_list_desc_remove_entry(struct kvm *kvm,
 
 	/*
 	 * The head descriptor is empty.  If there are no tail descriptors,
-	 * nullify the rmap head to mark the list as emtpy, else point the rmap
+	 * nullify the rmap head to mark the list as empty, else point the rmap
 	 * head at the next descriptor, i.e. the new head.
 	 */
 	if (!head_desc->more)
@@ -6544,7 +6544,7 @@ void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
 	kvm_tdp_mmu_try_split_huge_pages(kvm, memslot, start, end, target_level, false);
 
 	/*
-	 * A TLB flush is unnecessary at this point for the same resons as in
+	 * A TLB flush is unnecessary at this point for the same reasons as in
 	 * kvm_mmu_slot_try_split_huge_pages().
 	 */
 }
diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index bd30ebf..04c247b 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -146,7 +146,7 @@ static bool try_step_up(struct tdp_iter *iter)
  * Step to the next SPTE in a pre-order traversal of the paging structure.
  * To get to the next SPTE, the iterator either steps down towards the goal
  * GFN, if at a present, non-last-level SPTE, or over to a SPTE mapping a
- * highter GFN.
+ * higher GFN.
  *
  * The basic algorithm is as follows:
  * 1. If the current SPTE is a non-last-level SPTE, step down into the page
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7121463..7097954 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4741,7 +4741,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 * Emulation is possible for SEV guests if and only if a prefilled
 	 * buffer containing the bytes of the intercepted instruction is
 	 * available. SEV guest memory is encrypted with a guest specific key
-	 * and cannot be decrypted by KVM, i.e. KVM would read cyphertext and
+	 * and cannot be decrypted by KVM, i.e. KVM would read ciphertext and
 	 * decode garbage.
 	 *
 	 * If KVM is NOT trying to simply skip an instruction, inject #UD if
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c5ec0ef..65826fe 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6561,7 +6561,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 		 * code was changed such that flag signals vmcs12 should
 		 * be copied into eVMCS in guest memory.
 		 *
-		 * To preserve backwards compatability, allow user
+		 * To preserve backwards compatibility, allow user
 		 * to set this flag even when there is no VMXON region.
 		 */
 		if (kvm_state->flags & ~KVM_STATE_NESTED_EVMCS)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be20a60..e0f86f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1809,7 +1809,7 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 		 * do generate error codes with bits 31:16 set, and so KVM's
 		 * ABI lets userspace shove in arbitrary 32-bit values.  Drop
 		 * the upper bits to avoid VM-Fail, losing information that
-		 * does't really exist is preferable to killing the VM.
+		 * doesn't really exist is preferable to killing the VM.
 		 */
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, (u16)ex->error_code);
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c92407..b43b37c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10165,7 +10165,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
  *
  * But, if a VM-Exit occurs during instruction execution, and KVM does NOT skip
  * the instruction or inject an exception, then KVM can incorrecty inject a new
- * asynchrounous event if the event became pending after the CPU fetched the
+ * asynchronous event if the event became pending after the CPU fetched the
  * instruction (in the guest).  E.g. if a page fault (#PF, #NPF, EPT violation)
  * occurs and is resolved by KVM, a coincident NMI, SMI, IRQ, etc... can be
  * injected on the restarted instruction instead of being deferred until the
@@ -10186,7 +10186,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	int r;
 
 	/*
-	 * Process nested events first, as nested VM-Exit supercedes event
+	 * Process nested events first, as nested VM-Exit supersedes event
 	 * re-injection.  If there's an event queued for re-injection, it will
 	 * be saved into the appropriate vmc{b,s}12 fields on nested VM-Exit.
 	 */
@@ -10884,7 +10884,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		/*
 		 * Assert that vCPU vs. VM APICv state is consistent.  An APICv
 		 * update must kick and wait for all vCPUs before toggling the
-		 * per-VM state, and responsing vCPUs must wait for the update
+		 * per-VM state, and responding vCPUs must wait for the update
 		 * to complete before servicing KVM_REQ_APICV_UPDATE.
 		 */
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 0e65d00..23f81ca 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -128,7 +128,7 @@ static void delay_halt_mwaitx(u64 unused, u64 cycles)
 
 	delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
 	/*
-	 * Use cpu_tss_rw as a cacheline-aligned, seldomly accessed per-cpu
+	 * Use cpu_tss_rw as a cacheline-aligned, seldom accessed per-cpu
 	 * variable as the monitor target.
 	 */
 	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae..a0dffac 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	/* free a pte talbe */
+	/* free a pte table */
 	free_pagetable(pmd_page(*pmd), 0);
 	spin_lock(&init_mm.page_table_lock);
 	pmd_clear(pmd);
@@ -1031,7 +1031,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	/* free a pmd talbe */
+	/* free a pmd table */
 	free_pagetable(pud_page(*pud), 0);
 	spin_lock(&init_mm.page_table_lock);
 	pud_clear(pud);
@@ -1049,7 +1049,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	/* free a pud talbe */
+	/* free a pud table */
 	free_pagetable(p4d_page(*p4d), 0);
 	spin_lock(&init_mm.page_table_lock);
 	p4d_clear(p4d);
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index de10800..0904d7e 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -14,7 +14,7 @@
  * memory ranges: uncached, write-combining, write-through, write-protected,
  * and the most commonly used and default attribute: write-back caching.
  *
- * PAT support supercedes and augments MTRR support in a compatible fashion: MTRR is
+ * PAT support supersedes and augments MTRR support in a compatible fashion: MTRR is
  * a hardware interface to enumerate a limited number of physical memory ranges
  * and set their caching attributes explicitly, programmed into the CPU via MSRs.
  * Even modern CPUs have MTRRs enabled - but these are typically not touched
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f12..e9b448d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1621,7 +1621,7 @@ repeat:
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
-		 * after all we're only going to change it's attributes
+		 * after all we're only going to change its attributes
 		 * not the memory it points to
 		 */
 		new_pte = pfn_pte(pfn, new_prot);
@@ -2447,7 +2447,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 	/*
 	 * The typical sequence for unmapping is to find a pte through
 	 * lookup_address_in_pgd() (ideally, it should never return NULL because
-	 * the address is already mapped) and change it's protections. As pfn is
+	 * the address is already mapped) and change its protections. As pfn is
 	 * the *target* of a mapping, it's not useful while unmapping.
 	 */
 	struct cpa_data cpa = {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5dd7339..669ba1c 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -6,7 +6,7 @@
  *
  *	https://github.com/IAIK/KAISER
  *
- * The original work was written by and and signed off by for the Linux
+ * The original work was written by and signed off by for the Linux
  * kernel by:
  *
  *   Signed-off-by: Richard Fellner <richard.fellner@student.tugraz.at>
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95..5768d38 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -355,7 +355,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
 
 	/*
 	 * Validate that it is not running on an SMT sibling as this would
-	 * make the excercise pointless because the siblings share L1D. If
+	 * make the exercise pointless because the siblings share L1D. If
 	 * it runs on a SMT sibling, notify it with SIGBUS on return to
 	 * user/guest
 	 */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9a..75ae6e5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2143,7 +2143,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 		} else {
 			/* Only copy the arguments on-stack to current
 			 * 'stack_size' and ignore the regs, used to
-			 * prepare the arguments on-stack for orign call.
+			 * prepare the arguments on-stack for origin call.
 			 */
 			if (for_call_origin) {
 				nr_regs += arg_regs;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c..b18ce19 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1194,7 +1194,7 @@ struct jit_context {
 #define PROLOGUE_SIZE 35
 
 /*
- * Emit prologue code for BPF program and check it's size.
+ * Emit prologue code for BPF program and check its size.
  * bpf_tail_call helper will skip it while jumping into another program.
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth)
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 761f368..84ba715 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -6,7 +6,7 @@
  * Copyright(c) 2015 Bryan O'Donoghue <pure.logic@nexus-software.ie>
  *
  * IMR self test. The purpose of this module is to run a set of tests on the
- * IMR API to validate it's sanity. We check for overlapping, reserved
+ * IMR API to validate its sanity. We check for overlapping, reserved
  * addresses and setup/teardown sanity.
  *
  */
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a0..bc27be4 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -41,7 +41,7 @@
  *             Bit 8 (TF) must be cleared. Other bits are all unspecified.
  *
  * All other processor registers and flag bits are unspecified. The OS is in
- * charge of setting up it's own stack, GDT and IDT.
+ * charge of setting up its own stack, GDT and IDT.
  */
 
 #define PVH_GDT_ENTRY_CS	1
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index e03207d..5c50e55 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -741,7 +741,7 @@ static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
 	this_cpu_write(uv_cpu_nmi.state, UV_NMI_STATE_DUMP_DONE);
 }
 
-/* Trigger a slave CPU to dump it's state */
+/* Trigger a slave CPU to dump its state */
 static void uv_nmi_trigger_dump(int cpu)
 {
 	int retry = uv_nmi_trigger_delay;
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index ff5afc8..3712afc 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -270,7 +270,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
  * Read the RTC.
  *
  * Starting with HUB rev 2.0, the UV RTC register is replicated across all
- * cachelines of it's own page.  This allows faster simultaneous reads
+ * cachelines of its own page.  This allows faster simultaneous reads
  * from a given socket.
  */
 static u64 uv_read_rtc(struct clocksource *cs)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 788e555..f9bc444 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -61,7 +61,7 @@ void __init reserve_real_mode(void)
 		set_real_mode_mem(mem);
 
 	/*
-	 * Unconditionally reserve the entire fisrt 1M, see comment in
+	 * Unconditionally reserve the entire first 1M, see comment in
 	 * setup_arch().
 	 */
 	memblock_reserve(0, SZ_1M);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b683055..72af496 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -34,7 +34,7 @@
  * would need to validate the whole pagetable before going on.
  * Naturally, this is quite slow.  The solution is to "pin" a
  * pagetable, which enforces all the constraints on the pagetable even
- * when it is not actively in use.  This menas that Xen can be assured
+ * when it is not actively in use.  This means that Xen can be assured
  * that it is still valid when you do load it into %cr3, and doesn't
  * need to revalidate it.
  *

