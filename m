Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F135D377E6A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 10:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEJIoP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 04:44:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEJIoI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 04:44:08 -0400
Date:   Mon, 10 May 2021 08:43:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620636182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nys1jAreiu3CdKkrLoQOVvK7YXn0I0GzsTQrv5BvemQ=;
        b=4Ma9zzsosjT8DA7qEThlzKg6G/1ZpJ/kEXOMGJOlv/maQcvlkt+OALz6HwEIxO7UWU7/ig
        FG6URxi+YNQFoksVzw7fxms0891k2N9PGKVrAjm3v2Nthx2ZbdcWCYH1yPSuExtoRwSTuf
        KeJJgQV4JsILMKSdcgsSelbdVrFmG36RvfgsiUBYZrsBh6D+Xa56yRWGBOARsXc653FzGr
        Kf7019pp2Gr9o5SfF7pH4E73UOrWlbY4BCbZXaCYpeymMPxscXndwv2iKdy3FKCmIALVro
        WpxuzOCsBuIxIbC1p/tnwJpYw4blwc8VbHV89Ymewetlx2h7MDf7UN77ykm/BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620636182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nys1jAreiu3CdKkrLoQOVvK7YXn0I0GzsTQrv5BvemQ=;
        b=eYBIXE7kQ0KTH/pDNiD54QxbfFtb5Sd/rGRJMc9vbacD6RTeN6v9CvJ/uRzVAoySpa4xVZ
        1tNEk0LlHyAJVlAA==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210427111636.1207-4-brijesh.singh@amd.com>
References: <20210427111636.1207-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <162063618188.29796.3869848582559910364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     059e5c321a65657877924256ea8ad9c0df257b45
Gitweb:        https://git.kernel.org/tip/059e5c321a65657877924256ea8ad9c0df257b45
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Tue, 27 Apr 2021 06:16:36 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 10 May 2021 07:51:38 +02:00

x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG

The SYSCFG MSR continued being updated beyond the K8 family; drop the K8
name from it.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20210427111636.1207-4-brijesh.singh@amd.com
---
 Documentation/virt/kvm/amd-memory-encryption.rst | 2 +-
 Documentation/x86/amd-memory-encryption.rst      | 6 +++---
 arch/x86/include/asm/msr-index.h                 | 6 +++---
 arch/x86/kernel/cpu/amd.c                        | 4 ++--
 arch/x86/kernel/cpu/mtrr/cleanup.c               | 2 +-
 arch/x86/kernel/cpu/mtrr/generic.c               | 4 ++--
 arch/x86/kernel/mmconf-fam10h_64.c               | 2 +-
 arch/x86/kvm/svm/svm.c                           | 4 ++--
 arch/x86/kvm/x86.c                               | 2 +-
 arch/x86/mm/mem_encrypt_identity.c               | 6 +++---
 arch/x86/pci/amd_bus.c                           | 2 +-
 arch/x86/realmode/rm/trampoline_64.S             | 4 ++--
 drivers/edac/amd64_edac.c                        | 2 +-
 tools/arch/x86/include/asm/msr-index.h           | 6 +++---
 14 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 5ec8a19..5c081c8 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -22,7 +22,7 @@ to SEV::
 		  [ecx]:
 			Bits[31:0]  Number of encrypted guests supported simultaneously
 
-If support for SEV is present, MSR 0xc001_0010 (MSR_K8_SYSCFG) and MSR 0xc001_0015
+If support for SEV is present, MSR 0xc001_0010 (MSR_AMD64_SYSCFG) and MSR 0xc001_0015
 (MSR_K7_HWCR) can be used to determine if it can be enabled::
 
 	0xc001_0010:
diff --git a/Documentation/x86/amd-memory-encryption.rst b/Documentation/x86/amd-memory-encryption.rst
index c48d452..a1940eb 100644
--- a/Documentation/x86/amd-memory-encryption.rst
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -53,7 +53,7 @@ CPUID function 0x8000001f reports information related to SME::
 			   system physical addresses, not guest physical
 			   addresses)
 
-If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
+If support for SME is present, MSR 0xc00100010 (MSR_AMD64_SYSCFG) can be used to
 determine if SME is enabled and/or to enable memory encryption::
 
 	0xc0010010:
@@ -79,7 +79,7 @@ The state of SME in the Linux kernel can be documented as follows:
 	  The CPU supports SME (determined through CPUID instruction).
 
 	- Enabled:
-	  Supported and bit 23 of MSR_K8_SYSCFG is set.
+	  Supported and bit 23 of MSR_AMD64_SYSCFG is set.
 
 	- Active:
 	  Supported, Enabled and the Linux kernel is actively applying
@@ -89,7 +89,7 @@ The state of SME in the Linux kernel can be documented as follows:
 SME can also be enabled and activated in the BIOS. If SME is enabled and
 activated in the BIOS, then all memory accesses will be encrypted and it will
 not be necessary to activate the Linux memory encryption support.  If the BIOS
-merely enables SME (sets bit 23 of the MSR_K8_SYSCFG), then Linux can activate
+merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG), then Linux can activate
 memory encryption by default (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y) or
 by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
 not enable SME, then Linux will not be able to activate memory encryption, even
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 742d89a..211ba33 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -537,9 +537,9 @@
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
 #define MSR_K8_TOP_MEM2			0xc001001d
-#define MSR_K8_SYSCFG			0xc0010010
-#define MSR_K8_SYSCFG_MEM_ENCRYPT_BIT	23
-#define MSR_K8_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_K8_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_AMD64_SYSCFG		0xc0010010
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT	23
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT)
 #define MSR_K8_INT_PENDING_MSG		0xc0010055
 /* C1E active bits in int pending message */
 #define K8_INTP_C1E_ACTIVE_MASK		0x18000000
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384..0adb034 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -593,8 +593,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 */
 	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
 		/* Check if memory encryption is enabled */
-		rdmsrl(MSR_K8_SYSCFG, msr);
-		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+		rdmsrl(MSR_AMD64_SYSCFG, msr);
+		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			goto clear_all;
 
 		/*
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 0c3b372..b5f4304 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -836,7 +836,7 @@ int __init amd_special_default_mtrr(void)
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
 	/* In case some hypervisor doesn't pass SYSCFG through: */
-	if (rdmsr_safe(MSR_K8_SYSCFG, &l, &h) < 0)
+	if (rdmsr_safe(MSR_AMD64_SYSCFG, &l, &h) < 0)
 		return 0;
 	/*
 	 * Memory between 4GB and top of mem is forced WB by this magic bit.
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index b90f3f4..5581082 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -53,13 +53,13 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
-	rdmsr(MSR_K8_SYSCFG, lo, hi);
+	rdmsr(MSR_AMD64_SYSCFG, lo, hi);
 	if (lo & K8_MTRRFIXRANGE_DRAM_MODIFY) {
 		pr_err(FW_WARN "MTRR: CPU %u: SYSCFG[MtrrFixDramModEn]"
 		       " not cleared by BIOS, clearing this bit\n",
 		       smp_processor_id());
 		lo &= ~K8_MTRRFIXRANGE_DRAM_MODIFY;
-		mtrr_wrmsr(MSR_K8_SYSCFG, lo, hi);
+		mtrr_wrmsr(MSR_AMD64_SYSCFG, lo, hi);
 	}
 }
 
diff --git a/arch/x86/kernel/mmconf-fam10h_64.c b/arch/x86/kernel/mmconf-fam10h_64.c
index b5cb49e..c94dec6 100644
--- a/arch/x86/kernel/mmconf-fam10h_64.c
+++ b/arch/x86/kernel/mmconf-fam10h_64.c
@@ -95,7 +95,7 @@ static void get_fam10h_pci_mmconf_base(void)
 		return;
 
 	/* SYS_CFG */
-	address = MSR_K8_SYSCFG;
+	address = MSR_AMD64_SYSCFG;
 	rdmsrl(address, val);
 
 	/* TOP_MEM2 is not enabled? */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b649f92..433e8e4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -858,8 +858,8 @@ static __init void svm_adjust_mmio_mask(void)
 		return;
 
 	/* If memory encryption is not enabled, use existing mask */
-	rdmsrl(MSR_K8_SYSCFG, msr);
-	if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+	rdmsrl(MSR_AMD64_SYSCFG, msr);
+	if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 		return;
 
 	enc_bit = cpuid_ebx(0x8000001f) & 0x3f;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6eda283..853c40e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3402,7 +3402,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_LASTBRANCHTOIP:
 	case MSR_IA32_LASTINTFROMIP:
 	case MSR_IA32_LASTINTTOIP:
-	case MSR_K8_SYSCFG:
+	case MSR_AMD64_SYSCFG:
 	case MSR_K8_TSEG_ADDR:
 	case MSR_K8_TSEG_MASK:
 	case MSR_VM_HSAVE_PA:
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 04aba7e..a9639f6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -529,7 +529,7 @@ void __init sme_enable(struct boot_params *bp)
 		/*
 		 * No SME if Hypervisor bit is set. This check is here to
 		 * prevent a guest from trying to enable SME. For running as a
-		 * KVM guest the MSR_K8_SYSCFG will be sufficient, but there
+		 * KVM guest the MSR_AMD64_SYSCFG will be sufficient, but there
 		 * might be other hypervisors which emulate that MSR as non-zero
 		 * or even pass it through to the guest.
 		 * A malicious hypervisor can still trick a guest into this
@@ -542,8 +542,8 @@ void __init sme_enable(struct boot_params *bp)
 			return;
 
 		/* For SME, check the SYSCFG MSR */
-		msr = __rdmsr(MSR_K8_SYSCFG);
-		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+		msr = __rdmsr(MSR_AMD64_SYSCFG);
+		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index ae744b6..dd40d3f 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -284,7 +284,7 @@ static int __init early_root_info_init(void)
 
 	/* need to take out [4G, TOM2) for RAM*/
 	/* SYS_CFG */
-	address = MSR_K8_SYSCFG;
+	address = MSR_AMD64_SYSCFG;
 	rdmsrl(address, val);
 	/* TOP_MEM2 is enabled? */
 	if (val & (1<<21)) {
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 84c5d1b..cc8391f 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -123,9 +123,9 @@ SYM_CODE_START(startup_32)
 	 */
 	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
-	movl	$MSR_K8_SYSCFG, %ecx
+	movl	$MSR_AMD64_SYSCFG, %ecx
 	rdmsr
-	bts	$MSR_K8_SYSCFG_MEM_ENCRYPT_BIT, %eax
+	bts	$MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT, %eax
 	jc	.Ldone
 
 	/*
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9fa4dfc..f0d8f60 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3083,7 +3083,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
 
 	/* Check first whether TOP_MEM2 is enabled: */
-	rdmsrl(MSR_K8_SYSCFG, msr_val);
+	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
 	if (msr_val & BIT(21)) {
 		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
 		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 4502935..c60b09e 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -533,9 +533,9 @@
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
 #define MSR_K8_TOP_MEM2			0xc001001d
-#define MSR_K8_SYSCFG			0xc0010010
-#define MSR_K8_SYSCFG_MEM_ENCRYPT_BIT	23
-#define MSR_K8_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_K8_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_AMD64_SYSCFG		0xc0010010
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT	23
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT)
 #define MSR_K8_INT_PENDING_MSG		0xc0010055
 /* C1E active bits in int pending message */
 #define K8_INTP_C1E_ACTIVE_MASK		0x18000000
