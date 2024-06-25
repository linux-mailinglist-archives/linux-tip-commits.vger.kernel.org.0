Return-Path: <linux-tip-commits+bounces-1544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5145916D0C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A5285BFD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611CB174EE1;
	Tue, 25 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRvqxWhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhI0BWvY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F5173322;
	Tue, 25 Jun 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329234; cv=none; b=OpcrZQI6LBGGX2fizSZTuh6OGjHdO7AAyiWgn0l3Vo758DRPtGngzzrrNF5zkmK5+NQuSSus6CRX19p4bhd8G+fv98xdvRz03uSHYs8AydeYprAsxN+l5IcS9LVseuf6qTMu+lOE1O8amZM/qE+3vWNyvQ1KFGAh1sGX/naK66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329234; c=relaxed/simple;
	bh=6EH7p9alZX+5wnydXocoj5Jt84R4i4VN+pENZqXbz4U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I386V8WaZaZSatYfkUI+A/WBg8xOzf3+ELKfNfPcoXtw9P73zLZrQQwUEDNQToE2U2Q8CyCIM54ptIT6hEX5lVNgVG5ALHpfZa0mL93QhdDguP1nyN9n/NJY/SJTl2KSkoUSpdFDC+rsGptpSAs0Fr5tdW1DQnGWMx5PcV43j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRvqxWhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhI0BWvY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:27:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719329229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEX4bPRoR5kYGe15vix8CtNecNa5l7a7A6K3LHEL9PY=;
	b=vRvqxWhzJ+MfGO4lGHTdx6D998q8w/w3RpmMRq6E9KaiGPWdz2UWeQF3hfW4OM0/WGoqAl
	v6E4UVix9Hv8KasWujSbiReS310bxK7nNipqNCbrdfO3vb8E8HM8+lFbVeRsHiEOAmDKh7
	XBO3tIDJeyvyGwVnZV0owy+YB6ZB6QpbN5SXZVtltuWYAKIq6jxNR7SeF8Vc8ED6t3Tx4T
	l+G7kozfQxdKBqZMnXVieLa6SLay3ZlcPGqnQIFhh/g4z82Aj0ZgWCXDMs2XLHKyTBNoPZ
	bkLP4cRsPJ51SaxSTXqOwdbVYsykSenoEKVTfcIoKQI9bjFCg0KF+MrBU9GmeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719329229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEX4bPRoR5kYGe15vix8CtNecNa5l7a7A6K3LHEL9PY=;
	b=GhI0BWvYadJ2w1kgaPLv25vqgxRrMX0PUJ31to/DrK5VzLrSZdGsA/auLzCcQPbcXXJGNh
	oq63bF/IYY7vByAg==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Introduce VMware hypercall API
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-2-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171932922889.2215.9978824624971986422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     34bf25e820ae1ab38f9cd88834843ba76678a2fd
Gitweb:        https://git.kernel.org/tip/34bf25e820ae1ab38f9cd88834843ba76678a2fd
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:43 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 17:01:33 +02:00

x86/vmware: Introduce VMware hypercall API

Introduce a vmware_hypercall family of functions. It is a common implementation
to be used by the VMware guest code and virtual device drivers in architecture
independent manner.

The API consists of vmware_hypercallX and vmware_hypercall_hb_{out,in}
set of functions analogous to KVM's hypercall API. Architecture-specific
implementation is hidden inside.

It will simplify future enhancements in VMware hypercalls such as SEV-ES and
TDX related changes without needs to modify a caller in device drivers code.

Current implementation extends an idea from

  bac7b4e84323 ("x86/vmware: Update platform detection code for VMCALL/VMMCALL hypercalls")

to have a slow, but safe path vmware_hypercall_slow() earlier during the boot
when alternatives are not yet applied.  The code inherits VMWARE_CMD logic from
the commit mentioned above.

Move common macros from vmware.c to vmware.h.

  [ bp: Fold in a fix:
    https://lore.kernel.org/r/20240625083348.2299-1-alexey.makhalov@broadcom.com ]

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-2-alexey.makhalov@broadcom.com
---
 arch/x86/include/asm/vmware.h | 279 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c  |  70 +++++++-
 2 files changed, 327 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index ac9fc51..724c8b9 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -7,26 +7,277 @@
 #include <linux/stringify.h>
 
 /*
- * The hypercall definitions differ in the low word of the %edx argument
- * in the following way: the old port base interface uses the port
- * number to distinguish between high- and low bandwidth versions.
+ * VMware hypercall ABI.
+ *
+ * - Low bandwidth (LB) hypercalls (I/O port based, vmcall and vmmcall)
+ * have up to 6 input and 6 output arguments passed and returned using
+ * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
+ * %esi (arg4), %edi (arg5).
+ * The following input arguments must be initialized by the caller:
+ * arg0 - VMWARE_HYPERVISOR_MAGIC
+ * arg2 - Hypercall command
+ * arg3 bits [15:0] - Port number, LB and direction flags
+ *
+ * - High bandwidth (HB) hypercalls are I/O port based only. They have
+ * up to 7 input and 7 output arguments passed and returned using
+ * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
+ * %esi (arg4), %edi (arg5), %ebp (arg6).
+ * The following input arguments must be initialized by the caller:
+ * arg0 - VMWARE_HYPERVISOR_MAGIC
+ * arg1 - Hypercall command
+ * arg3 bits [15:0] - Port number, HB and direction flags
+ *
+ * For compatibility purposes, x86_64 systems use only lower 32 bits
+ * for input and output arguments.
+ *
+ * The hypercall definitions differ in the low word of the %edx (arg3)
+ * in the following way: the old I/O port based interface uses the port
+ * number to distinguish between high- and low bandwidth versions, and
+ * uses IN/OUT instructions to define transfer direction.
  *
  * The new vmcall interface instead uses a set of flags to select
  * bandwidth mode and transfer direction. The flags should be loaded
- * into %dx by any user and are automatically replaced by the port
- * number if the VMWARE_HYPERVISOR_PORT method is used.
- *
- * In short, new driver code should strictly use the new definition of
- * %dx content.
+ * into arg3 by any user and are automatically replaced by the port
+ * number if the I/O port method is used.
+ */
+
+#define VMWARE_HYPERVISOR_HB		BIT(0)
+#define VMWARE_HYPERVISOR_OUT		BIT(1)
+
+#define VMWARE_HYPERVISOR_PORT		0x5658
+#define VMWARE_HYPERVISOR_PORT_HB	(VMWARE_HYPERVISOR_PORT | \
+					 VMWARE_HYPERVISOR_HB)
+
+#define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
+
+#define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_GETHZ		45
+#define VMWARE_CMD_GETVCPU_INFO		68
+#define VMWARE_CMD_STEALCLOCK		91
+
+#define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
+#define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
+
+extern unsigned long vmware_hypercall_slow(unsigned long cmd,
+					   unsigned long in1, unsigned long in3,
+					   unsigned long in4, unsigned long in5,
+					   u32 *out1, u32 *out2, u32 *out3,
+					   u32 *out4, u32 *out5);
+
+/*
+ * The low bandwidth call. The low word of %edx is presumed to have OUT bit
+ * set. The high word of %edx may contain input data from the caller.
  */
+#define VMWARE_HYPERCALL					\
+	ALTERNATIVE_2("movw %[port], %%dx\n\t"			\
+		      "inl (%%dx), %%eax",			\
+		      "vmcall", X86_FEATURE_VMCALL,		\
+		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+static inline
+unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
+					     NULL, NULL, NULL, NULL, NULL);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
+				u32 *out1, u32 *out2)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
+					     out1, out2, NULL, NULL, NULL);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
+				u32 *out1, u32 *out2, u32 *out3)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
+					     out1, out2, out3, NULL, NULL);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, u32 *out2)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
+					     NULL, out2, NULL, NULL, NULL);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
+				unsigned long in3, u32 *out2,
+				u32 *out3, u32 *out4, u32 *out5)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, in3, 0, 0,
+					     NULL, out2, out3, out4, out5);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
+		  "=D" (*out5)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, u32 *out1,
+				u32 *out2, u32 *out3)
+{
+	unsigned long out0;
+
+	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
+		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
+					     out1, out2, out3, NULL, NULL);
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+#ifdef CONFIG_X86_64
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
+/*
+ * High bandwidth calls are not supported on encrypted memory guests.
+ * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
+ * low bandwidth hypercall if memory encryption is set.
+ * This assumption simplifies HB hypercall implementation to just I/O port
+ * based approach without alternative patching.
+ */
+static inline
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      u32 *out1)
+{
+	unsigned long out0;
+
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], %%" _ASM_BP "\n\t"
+		"rep outsb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
 
-/* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    0x5658
-#define VMWARE_HYPERVISOR_PORT_HB 0x5659
+static inline
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     u32 *out1)
+{
+	unsigned long out0;
 
-/* Current vmcall / vmmcall version */
-#define VMWARE_HYPERVISOR_HB   BIT(0)
-#define VMWARE_HYPERVISOR_OUT  BIT(1)
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], %%" _ASM_BP "\n\t"
+		"rep insb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
+#undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d0..faf7068 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -41,17 +41,9 @@
 
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
-#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
-#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
-#define VMWARE_HYPERVISOR_MAGIC	0x564D5868
-
-#define VMWARE_CMD_GETVERSION    10
-#define VMWARE_CMD_GETHZ         45
-#define VMWARE_CMD_GETVCPU_INFO  68
 #define VMWARE_CMD_LEGACY_X2APIC  3
 #define VMWARE_CMD_VCPU_RESERVED 31
-#define VMWARE_CMD_STEALCLOCK    91
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -110,6 +102,68 @@ struct vmware_steal_time {
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
+unsigned long vmware_hypercall_slow(unsigned long cmd,
+				    unsigned long in1, unsigned long in3,
+				    unsigned long in4, unsigned long in5,
+				    u32 *out1, u32 *out2, u32 *out3,
+				    u32 *out4, u32 *out5)
+{
+	unsigned long out0, rbx, rcx, rdx, rsi, rdi;
+
+	switch (vmware_hypercall_mode) {
+	case CPUID_VMWARE_FEATURES_ECX_VMCALL:
+		asm_inline volatile ("vmcall"
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
+				: "a" (VMWARE_HYPERVISOR_MAGIC),
+				"b" (in1),
+				"c" (cmd),
+				"d" (in3),
+				"S" (in4),
+				"D" (in5)
+				: "cc", "memory");
+		break;
+	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:
+		asm_inline volatile ("vmmcall"
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
+				: "a" (VMWARE_HYPERVISOR_MAGIC),
+				"b" (in1),
+				"c" (cmd),
+				"d" (in3),
+				"S" (in4),
+				"D" (in5)
+				: "cc", "memory");
+		break;
+	default:
+		asm_inline volatile ("movw %[port], %%dx; inl (%%dx), %%eax"
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
+				: [port] "i" (VMWARE_HYPERVISOR_PORT),
+				"a" (VMWARE_HYPERVISOR_MAGIC),
+				"b" (in1),
+				"c" (cmd),
+				"d" (in3),
+				"S" (in4),
+				"D" (in5)
+				: "cc", "memory");
+		break;
+	}
+
+	if (out1)
+		*out1 = rbx;
+	if (out2)
+		*out2 = rcx;
+	if (out3)
+		*out3 = rdx;
+	if (out4)
+		*out4 = rsi;
+	if (out5)
+		*out5 = rdi;
+
+	return out0;
+}
+
 static inline int __vmware_platform(void)
 {
 	uint32_t eax, ebx, ecx, edx;

