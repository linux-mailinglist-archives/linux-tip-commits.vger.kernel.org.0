Return-Path: <linux-tip-commits+bounces-6499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17DB463B0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FD8A66E7A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A968298CDC;
	Fri,  5 Sep 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKYmg3nC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v83Ap68Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9E28688E;
	Fri,  5 Sep 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100795; cv=none; b=D3NC6pVynnj1poQ544kclVQDndlZbjtEODY5TYan6ACkEZRfYQzUjhjBWJZqhvkJnXtDFreU0/e/Oh9moZF4K9TvW5qVq1SvfMpgRgplHYTpcqETu2i01swlQioXDsYwz7JXarlEu37xrMWOzfFBQ2yafilB0k5lLt2p65FBGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100795; c=relaxed/simple;
	bh=/h/y8anrSSCbPjQ2Ly3WeXkFW7hlqjjT4DDoD1Wzl5E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jzCzyBmZHkj6TBtgQzowOHmr7RjE2Qq2m2fZSpxOMfT7Bp7YlUpEP7UyT0iAIzN6AhnJIK+sTey/pQkQgJkNhpqtgzldWdWRpehqQxRiP9hK7VyD01wJsFecs+YFHRtXFV0WE9EfT5VIs7TlYzTmFHtbpebiyoeoKmVzJoQek1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKYmg3nC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v83Ap68Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Vw4FeJG3yxfazRNA9lFOOgnPWjTDudtXMxWXmhpK+xY=;
	b=nKYmg3nCzXvBAlkV+vqt3rsEWB19sgaC3TQ99DUh9HDJc65DWpEnaBWM745dzrDog1lXk8
	Lqfsca4Q9Q8NftbF2XTP0tnMw5vjCOdVU9KzZ2rbut35JmgUaCJufLtDJzPdkks08An5AY
	ppVoVugW1jwNUIScSbdzX8IZ0diD8KM5rGMhZ1PfONnXEFTzriUV6AHR5eVmJPblm8R1QL
	nJ9TsTtDSzQhg3A67E2/f9APzM5QmK2QknoQM5bnkpp7/XANSaIw8DZp/FFe3AMw7GTgsm
	8H9DajRpk8w8Q9W1DBP3DZ9wGmZO39Y9O3CxoCcvwBOSTQHVJr8t6UVuoHIYYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Vw4FeJG3yxfazRNA9lFOOgnPWjTDudtXMxWXmhpK+xY=;
	b=v83Ap68QmY96Kerfl/ip/LNAKWC3SZaCgkOLrqn9mDkMDpmUeWinVxmmrQX65t7CQ1WWmk
	i8wpItrCtxfgbxBg==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] x86/sme: Use percpu boolean to control WBINVD during kexec
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710079050.1920.14772951711723653211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     83214a775f33bc9d61c2c284f2ace3f854a4cddb
Gitweb:        https://git.kernel.org/tip/83214a775f33bc9d61c2c284f2ace3f854a=
4cddb
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:25 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:40 -07:00

x86/sme: Use percpu boolean to control WBINVD during kexec

TL;DR:

Prepare to unify how TDX and SME do cache flushing during kexec by
making a percpu boolean control whether to do the WBINVD.

-- Background --

On SME platforms, dirty cacheline aliases with and without encryption
bit can coexist, and the CPU can flush them back to memory in random
order.  During kexec, the caches must be flushed before jumping to the
new kernel otherwise the dirty cachelines could silently corrupt the
memory used by the new kernel due to different encryption property.

TDX also needs a cache flush during kexec for the same reason.  It would
be good to have a generic way to flush the cache instead of scattering
checks for each feature all around.

When SME is enabled, the kernel basically encrypts all memory including
the kernel itself and a simple memory write from the kernel could dirty
cachelines.  Currently, the kernel uses WBINVD to flush the cache for
SME during kexec in two places:

1) the one in stop_this_cpu() for all remote CPUs when the kexec-ing CPU
   stops them;
2) the one in the relocate_kernel() where the kexec-ing CPU jumps to the
   new kernel.

-- Solution --

Unlike SME, TDX can only dirty cachelines when it is used (i.e., when
SEAMCALLs are performed).  Since there are no more SEAMCALLs after the
aforementioned WBINVDs, leverage this for TDX.

To unify the approach for SME and TDX, use a percpu boolean to indicate
the cache may be in an incoherent state and needs flushing during kexec,
and set the boolean for SME.  TDX can then leverage it.

While SME could use a global flag (since it's enabled at early boot and
enabled on all CPUs), the percpu flag fits TDX better:

The percpu flag can be set when a CPU makes a SEAMCALL, and cleared when
another WBINVD on the CPU obviates the need for a kexec-time WBINVD.
Saving kexec-time WBINVD is valuable, because there is an existing
race[*] where kexec could proceed while another CPU is active.  WBINVD
could make this race worse, so it's worth skipping it when possible.

-- Side effect to SME --

Today the first WBINVD in the stop_this_cpu() is performed when SME is
*supported* by the platform, and the second WBINVD is done in
relocate_kernel() when SME is *activated* by the kernel.  Make things
simple by changing to do the second WBINVD when the platform supports
SME.  This allows the kernel to simply turn on this percpu boolean when
bringing up a CPU by checking whether the platform supports SME.

No other functional change intended.

[*] The aforementioned race:

During kexec native_stop_other_cpus() is called to stop all remote CPUs
before jumping to the new kernel.  native_stop_other_cpus() firstly
sends normal REBOOT vector IPIs to stop remote CPUs and waits them to
stop.  If that times out, it sends NMI to stop the CPUs that are still
alive.  The race happens when native_stop_other_cpus() has to send NMIs
and could potentially result in the system hang (for more information
please see [1]).

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/kvm/b963fcd60abe26c7ec5dc20b42f1a2ebbcc72397.17=
50934177.git.kai.huang@intel.com/ [1]
Link: https://lore.kernel.org/all/20250901160930.1785244-3-pbonzini%40redhat.=
com
---
 arch/x86/include/asm/kexec.h         |  4 ++--
 arch/x86/include/asm/processor.h     |  2 ++
 arch/x86/kernel/cpu/amd.c            | 17 +++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c   | 14 ++++++++++----
 arch/x86/kernel/process.c            | 24 +++++++++++-------------
 arch/x86/kernel/relocate_kernel_64.S | 13 ++++++++++---
 6 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 12cebbc..5cfb27f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -17,8 +17,8 @@
=20
 #include <linux/bits.h>
=20
-#define RELOC_KERNEL_PRESERVE_CONTEXT		BIT(0)
-#define RELOC_KERNEL_HOST_MEM_ENC_ACTIVE	BIT(1)
+#define RELOC_KERNEL_PRESERVE_CONTEXT	BIT(0)
+#define RELOC_KERNEL_CACHE_INCOHERENT	BIT(1)
=20
 #endif
=20
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index bde58f6..a24c780 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -731,6 +731,8 @@ void __noreturn stop_this_cpu(void *dummy);
 void microcode_check(struct cpuinfo_x86 *prev_info);
 void store_cpu_caps(struct cpuinfo_x86 *info);
=20
+DECLARE_PER_CPU(bool, cache_state_incoherent);
+
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
 	L1TF_MITIGATION_AUTO,
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a5ece6e..66a682b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -546,6 +546,23 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 =
*c)
 	u64 msr;
=20
 	/*
+	 * Mark using WBINVD is needed during kexec on processors that
+	 * support SME. This provides support for performing a successful
+	 * kexec when going from SME inactive to SME active (or vice-versa).
+	 *
+	 * The cache must be cleared so that if there are entries with the
+	 * same physical address, both with and without the encryption bit,
+	 * they don't race each other when flushed and potentially end up
+	 * with the wrong entry being committed to memory.
+	 *
+	 * Test the CPUID bit directly because with mem_encrypt=3Doff the
+	 * BSP will clear the X86_FEATURE_SME bit and the APs will not
+	 * see it set after that.
+	 */
+	if (c->extended_cpuid_level >=3D 0x8000001f && (cpuid_eax(0x8000001f) & BIT=
(0)))
+		__this_cpu_write(cache_state_incoherent, true);
+
+	/*
 	 * BIOS support is required for SME and SEV.
 	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
 	 *	      the SME physical address space reduction value.
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index 5cda8d8..dfb9109 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -29,6 +29,7 @@
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
+#include <asm/processor.h>
=20
 #ifdef CONFIG_ACPI
 /*
@@ -426,11 +427,11 @@ void __nocfi machine_kexec(struct kimage *image)
 		relocate_kernel_flags |=3D RELOC_KERNEL_PRESERVE_CONTEXT;
=20
 	/*
-	 * This must be done before load_segments() since if call depth tracking
-	 * is used then GS must be valid to make any function calls.
+	 * This must be done before load_segments() since it resets
+	 * GS to 0 and percpu data needs the correct GS to work.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		relocate_kernel_flags |=3D RELOC_KERNEL_HOST_MEM_ENC_ACTIVE;
+	if (this_cpu_read(cache_state_incoherent))
+		relocate_kernel_flags |=3D RELOC_KERNEL_CACHE_INCOHERENT;
=20
 	/*
 	 * The segment registers are funny things, they have both a
@@ -441,6 +442,11 @@ void __nocfi machine_kexec(struct kimage *image)
 	 *
 	 * Take advantage of this here by force loading the segments,
 	 * before the GDT is zapped with an invalid value.
+	 *
+	 * load_segments() resets GS to 0.  Don't make any function call
+	 * after here since call depth tracking uses percpu variables to
+	 * operate (relocate_kernel() is explicitly ignored by call depth
+	 * tracking).
 	 */
 	load_segments();
=20
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1b7960c..f2bbbee 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -89,6 +89,16 @@ DEFINE_PER_CPU(bool, __tss_limit_invalid);
 EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
=20
 /*
+ * The cache may be in an incoherent state and needs flushing during kexec.
+ * E.g., on SME/TDX platforms, dirty cacheline aliases with and without
+ * encryption bit(s) can coexist and the cache needs to be flushed before
+ * booting to the new kernel to avoid the silent memory corruption due to
+ * dirty cachelines with different encryption property being written back
+ * to the memory.
+ */
+DEFINE_PER_CPU(bool, cache_state_incoherent);
+
+/*
  * this gets called so that we can store lazy state into memory and copy the
  * current task into the new thread.
  */
@@ -827,19 +837,7 @@ void __noreturn stop_this_cpu(void *dummy)
 	disable_local_APIC();
 	mcheck_cpu_clear(c);
=20
-	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
-	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
-	 */
-	if (c->extended_cpuid_level >=3D 0x8000001f && (cpuid_eax(0x8000001f) & BIT=
(0)))
+	if (this_cpu_read(cache_state_incoherent))
 		wbinvd();
=20
 	/*
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_=
kernel_64.S
index 26e945f..11e20bb 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -198,14 +198,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
=20
 	/*
+	 * If the memory cache is in incoherent state, e.g., due to
+	 * memory encryption, do WBINVD to flush cache.
+	 *
 	 * If SME is active, there could be old encrypted cache line
 	 * entries that will conflict with the now unencrypted memory
 	 * used by kexec. Flush the caches before copying the kernel.
+	 *
+	 * Note SME sets this flag to true when the platform supports
+	 * SME, so the WBINVD is performed even SME is not activated
+	 * by the kernel.  But this has no harm.
 	 */
-	testb	$RELOC_KERNEL_HOST_MEM_ENC_ACTIVE, %r11b
-	jz .Lsme_off
+	testb	$RELOC_KERNEL_CACHE_INCOHERENT, %r11b
+	jz .Lnowbinvd
 	wbinvd
-.Lsme_off:
+.Lnowbinvd:
=20
 	call	swap_pages
=20

