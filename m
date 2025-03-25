Return-Path: <linux-tip-commits+bounces-4517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B2AA6ECBD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BCF165BA9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84994259CB1;
	Tue, 25 Mar 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWomz/Zm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1ahghLh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3F258CD2;
	Tue, 25 Mar 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895400; cv=none; b=ffKrBamvvEu0/90/A4WVNfp1yppsugjoUpC2qf3dIdZMaVfFeVHaOxjy72ltvG/kgjN1o336XgKnRNR6YDmuuPLdcOeZJ3dlQmaTIV3HdhXAC/rEBWXGM0+EeZubMI7innoJEm0uhfCOc3fLyykYvFJXZBFg/e/7mfByO6xhJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895400; c=relaxed/simple;
	bh=8E5uvYj6591b+e1itvfJv6K5bw/JI9M05B7hoeyJpzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L5Jtu890juzc9a+xN5qSfoWvYRE5vvTpPb5rHCraD/5FB0iNWDb3Kj40HsZfYIIRsZX9MG7bZih5B19Q0KDef5ceHV6Tfz7WD9WvbNRK6ryDLQ3Res+U9k0Iz09PYhhCvCLmbZjn38oU0Qz5x11wrMCwxNxka/B59H6nYdrtMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWomz/Zm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1ahghLh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+/ShWuf6XaTl06BNSe4FcsmSnRBtKqOGAV3aTee27o=;
	b=RWomz/ZmEURqyDloaHeXx3cHr0SNN8PryLoLCaS9MlO1BepdbIwdDez+DTAaEPpdM7BxKU
	qpjxpa9vvUaobovjAgf4305Vfkztygjq7rQQwlLixNcOtOQwnGV1wzaLMXWDpzhYXcf8Jk
	fpkeTlw80w7aHYkVagNRxJUPk/9E+uIeThsx1r+/EEcsnoSqCHtTZ9WjJn8nvKTRJjoSGF
	ww1OmpUL5Wp653saNJMvTwXNc7ey7nNuWpk+g9FYPnTWnBG55gLSPzKJaeougqkBR/RqVG
	f7WnP8nZ7MS5rro8DkWwLgQXXDaVrjp4oPo4RoILJcbbuOxJmzBV1mkVC6+DxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+/ShWuf6XaTl06BNSe4FcsmSnRBtKqOGAV3aTee27o=;
	b=k1ahghLhCJUj/N6eM1UcyEfUorrB3En2OPEAvsnJr7XYgD+Q5YcVI6lf2E+x9BI4t0grrO
	5WlQhPc7u4jq3hAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Introduce and use CPUID leaf 0x2 parsing helpers
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-4-darwi@linutronix.de>
References: <20250324133324.23458-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539591.14745.1940490304633626580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fe78079ec07fd48a19abcfeac74bc97e07171fb6
Gitweb:        https://git.kernel.org/tip/fe78079ec07fd48a19abcfeac74bc97e07171fb6
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:32:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:06 +01:00

x86/cpu: Introduce and use CPUID leaf 0x2 parsing helpers

Introduce CPUID leaf 0x2 parsing helpers at <asm/cpuid/leaf_0x2_api.h>.
This allows sharing the leaf 0x2's output validation and iteration logic
across both x86/cpu intel.c and cacheinfo.c.

Start by converting intel.c to the new API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-4-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h              |  1 +-
 arch/x86/include/asm/cpuid/leaf_0x2_api.h | 65 ++++++++++++++++++++++-
 arch/x86/include/asm/cpuid/types.h        | 16 +++++-
 arch/x86/kernel/cpu/intel.c               | 23 ++------
 4 files changed, 88 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index d5749b2..5858193 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -4,5 +4,6 @@
 #define _ASM_X86_CPUID_H
 
 #include <asm/cpuid/api.h>
+#include <asm/cpuid/leaf_0x2_api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
new file mode 100644
index 0000000..4c845fc
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_LEAF_0x2_API_H
+#define _ASM_X86_CPUID_LEAF_0x2_API_H
+
+#include <asm/cpuid/api.h>
+#include <asm/cpuid/types.h>
+
+/**
+ * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * @regs:	Output parameter
+ *
+ * Query CPUID leaf 0x2 and store its output in @regs.	Force set any
+ * invalid 1-byte descriptor returned by the hardware to zero (the NULL
+ * cache/TLB descriptor) before returning it to the caller.
+ *
+ * Use for_each_leaf_0x2_desc() to iterate over the returned output.
+ */
+static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
+{
+	cpuid_leaf(0x2, regs);
+
+	/*
+	 * All Intel CPUs must report an iteration count of 1.	In case
+	 * of bogus hardware, treat all returned descriptors as NULL.
+	 */
+	if (regs->desc[0] != 0x01) {
+		for (int i = 0; i < 4; i++)
+			regs->regv[i] = 0;
+		return;
+	}
+
+	/*
+	 * The most significant bit (MSB) of each register must be clear.
+	 * If a register is invalid, replace its descriptors with NULL.
+	 */
+	for (int i = 0; i < 4; i++) {
+		if (regs->reg[i].invalid)
+			regs->regv[i] = 0;
+	}
+}
+
+/**
+ * for_each_leaf_0x2_desc() - Iterator for CPUID leaf 0x2 descriptors
+ * @regs:	Leaf 0x2 output, as returned by cpuid_get_leaf_0x2_regs()
+ * @desc:	Pointer to the returned descriptor for each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide each descriptor through @desc.
+ *
+ * Note that the first byte is skipped as it is not a descriptor.
+ *
+ * Sample usage::
+ *
+ *	union leaf_0x2_regs regs;
+ *	u8 *desc;
+ *
+ *	cpuid_get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_desc(regs, desc) {
+ *		// Handle *desc value
+ *	}
+ */
+#define for_each_leaf_0x2_desc(regs, desc)				\
+	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
+
+#endif /* _ASM_X86_CPUID_LEAF_0x2_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 8582e27..753f6c4 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -29,4 +29,20 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_FREQ		0x16
 #define CPUID_LEAF_TILE		0x1d
 
+/*
+ * Types for CPUID(0x2) parsing
+ * Check <asm/cpuid/leaf_0x2_api.h>
+ */
+
+struct leaf_0x2_reg {
+		u32		: 31,
+			invalid	: 1;
+};
+
+union leaf_0x2_regs {
+	struct leaf_0x2_reg	reg[4];
+	u32			regv[4];
+	u8			desc[16];
+};
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0570d4d..aeb7d6d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -16,6 +16,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
@@ -778,27 +779,15 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	u32 regs[4];
-	u8 *desc = (u8 *)regs;
+	union leaf_0x2_regs regs;
+	u8 *desc;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-	/* Intel CPUs must report an iteration count of 1 */
-	if (desc[0] != 0x01)
-		return;
-
-	/* If a register's bit 31 is set, it is an unknown format */
-	for (int i = 0; i < 4; i++) {
-		if (regs[i] & (1 << 31))
-			regs[i] = 0;
-	}
-
-	/* Skip the first byte as it is not a descriptor */
-	for (int i = 1; i < 16; i++)
-		intel_tlb_lookup(desc[i]);
+	cpuid_get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_desc(regs, desc)
+		intel_tlb_lookup(*desc);
 }
 
 static const struct cpu_dev intel_cpu_dev = {

