Return-Path: <linux-tip-commits+bounces-1538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F215916D02
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D571F2BFE1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480816F91E;
	Tue, 25 Jun 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3RwFrVR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9eeHAKg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBF14A60F;
	Tue, 25 Jun 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329230; cv=none; b=Vd4BR7ZJke0qQvVJzanW3IeM7etGVGG9Z+//WnPyLU/gRRWeLe3R1XYMn7K7EopY5Au6iQz5G4y815V1rT9pIbaz3iqvkv0T/jEokowb8z9LjnZiYzSH4ORh1WNqvF/uh8IvaNSLH67pTVh/A9JU0y1qvwTHTblg9iQX7erLMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329230; c=relaxed/simple;
	bh=YYKZoBcqzPR+I4O8i2JbIyq0TisXSxurHFrv2dDU75E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ei8FXxtRouIxPbrnShleru+hZYYZpxVie35lH/UTK4EJmOllX2idookKztBStbhp9VMBue89C3kMFc1SqLth8bJ2KQwdk5+ejnWl63kn5RJ7Lmf8gmgRnAlxKZ+qOZvlj7Okcuaju/ojW4q/JnSKwmqotQMzeQbGFUWHDhXu4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3RwFrVR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9eeHAKg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:27:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPtSFEVpDKTcQ6RV32LP/qqvNIfbnrK77Y0aMwyTSpE=;
	b=M3RwFrVRC2ifoa5MHBo/b+RKVSCCdIxFUmY97eYNnUFC1GrqVv/Vsd+VoWee3kNRKxG3S7
	jmSaAmS1y11SvY6fFqowbkvpLcQntjweFEyumpJlqCc+A1MQ1I1w7CzGKs7mqX9oD5eK5K
	jMPHkRFWV5w9Ch+kKCyy+Yjp6YGnY16QXRalbRnZyrT2ITOXD2nhCYaTUQ8Z8cKpal3Fnm
	VOAb9CorzicUg/maQCfLWtTbeGiYM5oib1JhHJK7QkthwIL+JHyeHC07iExFj4361THBfN
	vfFI3QjkqHnDkXTl9D3udIucSbpqoYQR/spQUWVStiAHNdVzszIa63sXrYVTAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPtSFEVpDKTcQ6RV32LP/qqvNIfbnrK77Y0aMwyTSpE=;
	b=h9eeHAKgg+COhubLdUrir/NorjiLMSumt5EEcVOk0O/lTzEJN1rjPqLIcj1lqYaf45/4Ld
	Id9oWc/7N85vIABg==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Add TDX hypercall support
Cc: Tim Merrifield <tim.merrifield@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-9-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-9-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171932922642.2215.6851322784816204708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     57b7b6acb41b51087ceb40c562efe392ec8c9677
Gitweb:        https://git.kernel.org/tip/57b7b6acb41b51087ceb40c562efe392ec8c9677
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:50 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 17:15:48 +02:00

x86/vmware: Add TDX hypercall support

VMware hypercalls use I/O port, VMCALL or VMMCALL instructions.  Add a call to
__tdx_hypercall() in order to support TDX guests.

No change in high bandwidth hypercalls, as only low bandwidth ones are supported
for TDX guests.

  [ bp: Massage, clear on-stack struct tdx_module_args variable. ]

Co-developed-by: Tim Merrifield <tim.merrifield@broadcom.com>
Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-9-alexey.makhalov@broadcom.com
---
 arch/x86/include/asm/vmware.h | 45 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/vmware.c  | 52 ++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index d83444f..c9cf43d 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -18,6 +18,12 @@
  * arg2 - Hypercall command
  * arg3 bits [15:0] - Port number, LB and direction flags
  *
+ * - Low bandwidth TDX hypercalls (x86_64 only) are similar to LB
+ * hypercalls. They also have up to 6 input and 6 output on registers
+ * arguments, with different argument to register mapping:
+ * %r12 (arg0), %rbx (arg1), %r13 (arg2), %rdx (arg3),
+ * %rsi (arg4), %rdi (arg5).
+ *
  * - High bandwidth (HB) hypercalls are I/O port based only. They have
  * up to 7 input and 7 output arguments passed and returned using
  * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
@@ -54,6 +60,12 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+/*
+ * Hypercall command mask:
+ *   bits [6:0] command, range [0, 127]
+ *   bits [19:16] sub-command, range [0, 15]
+ */
+#define VMWARE_CMD_MASK			0xf007fU
 
 #define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
 #define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
@@ -64,6 +76,15 @@ extern unsigned long vmware_hypercall_slow(unsigned long cmd,
 					   u32 *out1, u32 *out2, u32 *out3,
 					   u32 *out4, u32 *out5);
 
+#define VMWARE_TDX_VENDOR_LEAF 0x1af7e4909ULL
+#define VMWARE_TDX_HCALL_FUNC  1
+
+extern unsigned long vmware_tdx_hypercall(unsigned long cmd,
+					  unsigned long in1, unsigned long in3,
+					  unsigned long in4, unsigned long in5,
+					  u32 *out1, u32 *out2, u32 *out3,
+					  u32 *out4, u32 *out5);
+
 /*
  * The low bandwidth call. The low word of %edx is presumed to have OUT bit
  * set. The high word of %edx may contain input data from the caller.
@@ -79,6 +100,10 @@ unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
+					    NULL, NULL, NULL, NULL, NULL);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
 					     NULL, NULL, NULL, NULL, NULL);
@@ -100,6 +125,10 @@ unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
+					    out1, out2, NULL, NULL, NULL);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
 					     out1, out2, NULL, NULL, NULL);
@@ -121,6 +150,10 @@ unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
+					    out1, out2, out3, NULL, NULL);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
 					     out1, out2, out3, NULL, NULL);
@@ -143,6 +176,10 @@ unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5,
+					    NULL, out2, NULL, NULL, NULL);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
 					     NULL, out2, NULL, NULL, NULL);
@@ -167,6 +204,10 @@ unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, 0, 0,
+					    NULL, out2, out3, out4, out5);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, in3, 0, 0,
 					     NULL, out2, out3, out4, out5);
@@ -191,6 +232,10 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5,
+					    out1, out2, out3, NULL, NULL);
+
 	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
 		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
 					     out1, out2, out3, NULL, NULL);
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index fc1b3f6..00189cd 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -489,6 +489,58 @@ static bool __init vmware_legacy_x2apic_available(void)
 		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+/*
+ * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
+ * we remap those registers to %r12 and %r13, respectively.
+ */
+unsigned long vmware_tdx_hypercall(unsigned long cmd,
+				   unsigned long in1, unsigned long in3,
+				   unsigned long in4, unsigned long in5,
+				   u32 *out1, u32 *out2, u32 *out3,
+				   u32 *out4, u32 *out5)
+{
+	struct tdx_module_args args = {};
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE)) {
+		pr_warn_once("Incorrect usage\n");
+		return ULONG_MAX;
+	}
+
+	if (cmd & ~VMWARE_CMD_MASK) {
+		pr_warn_once("Out of range command %lx\n", cmd);
+		return ULONG_MAX;
+	}
+
+	args.rbx = in1;
+	args.rdx = in3;
+	args.rsi = in4;
+	args.rdi = in5;
+	args.r10 = VMWARE_TDX_VENDOR_LEAF;
+	args.r11 = VMWARE_TDX_HCALL_FUNC;
+	args.r12 = VMWARE_HYPERVISOR_MAGIC;
+	args.r13 = cmd;
+	/* CPL */
+	args.r15 = 0;
+
+	__tdx_hypercall(&args);
+
+	if (out1)
+		*out1 = args.rbx;
+	if (out2)
+		*out2 = args.r13;
+	if (out3)
+		*out3 = args.rdx;
+	if (out4)
+		*out4 = args.rsi;
+	if (out5)
+		*out5 = args.rdi;
+
+	return args.r12;
+}
+EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
 					struct pt_regs *regs)

