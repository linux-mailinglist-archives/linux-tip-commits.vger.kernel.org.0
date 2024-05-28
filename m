Return-Path: <linux-tip-commits+bounces-1298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE48D20F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FAC1F22694
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBD171E4D;
	Tue, 28 May 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TUbOuNvT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVeWY8wC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03416B756;
	Tue, 28 May 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911989; cv=none; b=Y/2YkLm46r79fTMH4siRzSFSCxKO4lHSs7Eqs2ng6WqB4vXCye2xp2TSnrWto8pbKwp8+liZCGSMKXdY/sZwRsLhOxjNFm6EhLpOeY9MoELD/HAreOx1syRwqNtZSnC3nq+lYTnV3wNw41wEI/JoBCBo45GjMt0I9S9Kl6kffR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911989; c=relaxed/simple;
	bh=DhIfZGXpFkTnSQN9ozYGobE0H9IoaCgYiEPDoXa8uRE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uo7SpzLWf+5/v1mQxOsnT7xANWqSP50UiSive28lLIjNUdog+WfwInoE1i/eznt1Ywy46dniBqFFUtP8GdMC09XVhuBtmCnPnfInG4DU3qVz7x5LYndLCBD11rj1Ao9n2pDt+pPiqy+7aNsx7jOt3mKuIk21h/ke6FKSgQFrvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TUbOuNvT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVeWY8wC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 15:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716911985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uTue3ICIOzN3qiBq0niLEHBR0hUOJEe1It4kEDJYHdo=;
	b=TUbOuNvT3CYqzCO06HASMkm8iZOdfAyySl2zCZzPbBwxHE0PhwlXTELAnSEkzgFuKfP99B
	eDynvgyJKg0IlwOUnsIus08okgdMD7mQJDIh6Qr6eaf0CeaEr/BgRWFjefM3W1H6ec4GTW
	aiIo0qDhY0VzSzEEvDe16xY3lMEDviYoXwxWK6kxslcm9Dw5z0zs4nrb/way01Wsg94hku
	1RlLN7mToDopHG4sfisYpXPgV7qdu0hfknoHxqV1BbK2IdkeQ2uCEFVAPOHvj6YNz896MS
	4omJHjhsXSOXDw/TwdOCxrHtAISVk028chJ1saPeqXIOfBnNgIaHmcwSUqJ09Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716911985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uTue3ICIOzN3qiBq0niLEHBR0hUOJEe1It4kEDJYHdo=;
	b=OVeWY8wCv+my6C+f5u6H1u9xYm9aCgu+wolTZ+BEySBkZT2dUVxLmP/GoX6NSRTFzCUR1v
	rHLD5bXj2QUT1+AA==
From: "tip-bot2 for Alison Schofield" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/pconfig: Remove unused MKTME pconfig code
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691198453.10875.12885607105066021946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     079544ec60fcba3f32e4b513442cc131211c8e22
Gitweb:        https://git.kernel.org/tip/079544ec60fcba3f32e4b513442cc131211c8e22
Author:        Alison Schofield <alison.schofield@intel.com>
AuthorDate:    Mon, 06 May 2024 21:24:22 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 08:45:17 -07:00

x86/pconfig: Remove unused MKTME pconfig code

Code supporting Intel PCONFIG targets was an early piece of enabling
for MKTME (Multi-Key Total Memory Encryption).

Since MKTME feature enablement did not follow into the kernel, remove
the unused PCONFIG code.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/4ddff30d466785b4adb1400f0518783012835141.1715054189.git.alison.schofield%40intel.com
---
 arch/x86/include/asm/intel_pconfig.h | 65 +---------------------
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel_pconfig.c  | 84 +---------------------------
 3 files changed, 1 insertion(+), 150 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_pconfig.h
 delete mode 100644 arch/x86/kernel/cpu/intel_pconfig.c

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
deleted file mode 100644
index 994638e..0000000
--- a/arch/x86/include/asm/intel_pconfig.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#ifndef	_ASM_X86_INTEL_PCONFIG_H
-#define	_ASM_X86_INTEL_PCONFIG_H
-
-#include <asm/asm.h>
-#include <asm/processor.h>
-
-enum pconfig_target {
-	INVALID_TARGET	= 0,
-	MKTME_TARGET	= 1,
-	PCONFIG_TARGET_NR
-};
-
-int pconfig_target_supported(enum pconfig_target target);
-
-enum pconfig_leaf {
-	MKTME_KEY_PROGRAM	= 0,
-	PCONFIG_LEAF_INVALID,
-};
-
-#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
-
-/* Defines and structure for MKTME_KEY_PROGRAM of PCONFIG instruction */
-
-/* mktme_key_program::keyid_ctrl COMMAND, bits [7:0] */
-#define MKTME_KEYID_SET_KEY_DIRECT	0
-#define MKTME_KEYID_SET_KEY_RANDOM	1
-#define MKTME_KEYID_CLEAR_KEY		2
-#define MKTME_KEYID_NO_ENCRYPT		3
-
-/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
-#define MKTME_AES_XTS_128	(1 << 8)
-
-/* Return codes from the PCONFIG MKTME_KEY_PROGRAM */
-#define MKTME_PROG_SUCCESS	0
-#define MKTME_INVALID_PROG_CMD	1
-#define MKTME_ENTROPY_ERROR	2
-#define MKTME_INVALID_KEYID	3
-#define MKTME_INVALID_ENC_ALG	4
-#define MKTME_DEVICE_BUSY	5
-
-/* Hardware requires the structure to be 256 byte aligned. Otherwise #GP(0). */
-struct mktme_key_program {
-	u16 keyid;
-	u32 keyid_ctrl;
-	u8 __rsvd[58];
-	u8 key_field_1[64];
-	u8 key_field_2[64];
-} __packed __aligned(256);
-
-static inline int mktme_key_program(struct mktme_key_program *key_program)
-{
-	unsigned long rax = MKTME_KEY_PROGRAM;
-
-	if (!pconfig_target_supported(MKTME_TARGET))
-		return -ENXIO;
-
-	asm volatile(PCONFIG
-		: "=a" (rax), "=b" (key_program)
-		: "0" (rax), "1" (key_program)
-		: "memory", "cc");
-
-	return rax;
-}
-
-#endif	/* _ASM_X86_INTEL_PCONFIG_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a02bba0..5857a0f 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_PROC_FS)			+= proc.o
 
 obj-$(CONFIG_IA32_FEAT_CTL)		+= feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
-obj-y					+= intel.o intel_pconfig.o tsx.o
+obj-y					+= intel.o tsx.o
 obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
diff --git a/arch/x86/kernel/cpu/intel_pconfig.c b/arch/x86/kernel/cpu/intel_pconfig.c
deleted file mode 100644
index 5be2b17..0000000
--- a/arch/x86/kernel/cpu/intel_pconfig.c
+++ /dev/null
@@ -1,84 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel PCONFIG instruction support.
- *
- * Copyright (C) 2017 Intel Corporation
- *
- * Author:
- *	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
- */
-#include <linux/bug.h>
-#include <linux/limits.h>
-
-#include <asm/cpufeature.h>
-#include <asm/intel_pconfig.h>
-
-#define	PCONFIG_CPUID			0x1b
-
-#define PCONFIG_CPUID_SUBLEAF_MASK	((1 << 12) - 1)
-
-/* Subleaf type (EAX) for PCONFIG CPUID leaf (0x1B) */
-enum {
-	PCONFIG_CPUID_SUBLEAF_INVALID	= 0,
-	PCONFIG_CPUID_SUBLEAF_TARGETID	= 1,
-};
-
-/* Bitmask of supported targets */
-static u64 targets_supported __read_mostly;
-
-int pconfig_target_supported(enum pconfig_target target)
-{
-	/*
-	 * We would need to re-think the implementation once we get > 64
-	 * PCONFIG targets. Spec allows up to 2^32 targets.
-	 */
-	BUILD_BUG_ON(PCONFIG_TARGET_NR >= 64);
-
-	if (WARN_ON_ONCE(target >= 64))
-		return 0;
-	return targets_supported & (1ULL << target);
-}
-
-static int __init intel_pconfig_init(void)
-{
-	int subleaf;
-
-	if (!boot_cpu_has(X86_FEATURE_PCONFIG))
-		return 0;
-
-	/*
-	 * Scan subleafs of PCONFIG CPUID leaf.
-	 *
-	 * Subleafs of the same type need not to be consecutive.
-	 *
-	 * Stop on the first invalid subleaf type. All subleafs after the first
-	 * invalid are invalid too.
-	 */
-	for (subleaf = 0; subleaf < INT_MAX; subleaf++) {
-		struct cpuid_regs regs;
-
-		cpuid_count(PCONFIG_CPUID, subleaf,
-				&regs.eax, &regs.ebx, &regs.ecx, &regs.edx);
-
-		switch (regs.eax & PCONFIG_CPUID_SUBLEAF_MASK) {
-		case PCONFIG_CPUID_SUBLEAF_INVALID:
-			/* Stop on the first invalid subleaf */
-			goto out;
-		case PCONFIG_CPUID_SUBLEAF_TARGETID:
-			/* Mark supported PCONFIG targets */
-			if (regs.ebx < 64)
-				targets_supported |= (1ULL << regs.ebx);
-			if (regs.ecx < 64)
-				targets_supported |= (1ULL << regs.ecx);
-			if (regs.edx < 64)
-				targets_supported |= (1ULL << regs.edx);
-			break;
-		default:
-			/* Unknown CPUID.PCONFIG subleaf: ignore */
-			break;
-		}
-	}
-out:
-	return 0;
-}
-arch_initcall(intel_pconfig_init);

