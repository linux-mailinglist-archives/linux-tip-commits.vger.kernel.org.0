Return-Path: <linux-tip-commits+bounces-5559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E42AB8D7F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D1E188A091
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790AA25C820;
	Thu, 15 May 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvUc17Ya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EREtkZKc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2125B1F9;
	Thu, 15 May 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329443; cv=none; b=TXy1lCTj4x0uz8llAejhkxnv2lFbQLPaTMpZUT4rQ8OW6FlluT1C5fQgx8GqcxMVkm2fllBF2BIB0ghXsoJrb/JHvMZHOY6aNRxrd+B9LTKCyCsT3iby6HXHYLOqd7FNCnyg+eUKo2VHCVpPw3fcYjJq8gpSSNMA+sRPi3psB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329443; c=relaxed/simple;
	bh=6Kz4VSiCjJb/HSNc+VnwwibAoSNNY//SMH/U2PK2rCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ncqgVzNa0kv+MS1ucDw4eojzXs850Keu2PRn8Tv+HAsSmAUpf3EKfII7seQX4DXugDjbrbzt2HG4982Va7eFs59lvPwOfUlg0r8yAFU85219OUC73DtKmWqpDZpKL3/uKXyi/JQNP7Tuj4NiKdgplFBFDtjpgTbb20UjdOLoBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvUc17Ya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EREtkZKc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkjTD5N/ZmKXJfm+f5rKSHAmfIe+/ayEiKw6RJFXfWI=;
	b=nvUc17YaadWzJrjVCWj+2uWqpLulAua320Nryf1xZaxUup1/vxdOEtAGxbYDw4BqcU8f1I
	c5S++X9naC0PC1541VP9eTCwNMcEYMxlw6IEYwH7F9Pka+/rgLZTAbfV/Pw2hX0N9eyIgB
	nPq2aQf67TwvYrOfbhZlns8CA45lSmmFnbIorEL7VAVx4HkXAHKi3arjgzK67gUHcj/Efq
	CGwfhzqN2Qk4+EdXUjW390gZUk8m4aoUXyvJaXMCgnMU9uvuq1azzy1URZRIHfl7lB3O/2
	/Xw1XLlbx6CGpFvJ9gu8NhecY1NFIlXejbl6GcA0MO28ZOW2hWzeTzIZ+GepUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkjTD5N/ZmKXJfm+f5rKSHAmfIe+/ayEiKw6RJFXfWI=;
	b=EREtkZKcxlfu9CR+HcQOXRuLKqemYX+czrrec7ebUpjLZlVidVBFNYdgauRPeG0xJsqNct
	wzR+QYEvqT0vwjDA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Move CPUID(0x2) APIs into <cpuid/api.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-2-darwi@linutronix.de>
References: <20250508150240.172915-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732943859.406.5801084453238437516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     cdc8be31cb324a0c52529f192e39a44abcfff513
Gitweb:        https://git.kernel.org/tip/cdc8be31cb324a0c52529f192e39a44abcfff513
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:23:54 +02:00

x86/cpuid: Move CPUID(0x2) APIs into <cpuid/api.h>

Move all of the CPUID(0x2) APIs at <cpuid/leaf_0x2_api.h> into
<cpuid/api.h>, in order centralize all CPUID APIs into the latter.

While at it, separate the different CPUID leaf parsing APIs using
header comments like "CPUID(0xN) parsing: ".

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-2-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h              |  1 +-
 arch/x86/include/asm/cpuid/api.h          | 75 +++++++++++++++++++++-
 arch/x86/include/asm/cpuid/leaf_0x2_api.h | 73 +---------------------
 arch/x86/include/asm/cpuid/types.h        |  3 +-
 4 files changed, 75 insertions(+), 77 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 5858193..d5749b2 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -4,6 +4,5 @@
 #define _ASM_X86_CPUID_H
 
 #include <asm/cpuid/api.h>
-#include <asm/cpuid/leaf_0x2_api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index bf76a17..ff8891a 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -160,6 +160,10 @@ static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
 	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
 }
 
+/*
+ * Hypervisor-related APIs:
+ */
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {
@@ -208,7 +212,76 @@ static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
 }
 
 /*
- * CPUID(0x80000006) parsing helpers
+ * CPUID(0x2) parsing:
+ */
+
+/**
+ * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * @regs:	Output parameter
+ *
+ * Query CPUID leaf 0x2 and store its output in @regs.	Force set any
+ * invalid 1-byte descriptor returned by the hardware to zero (the NULL
+ * cache/TLB descriptor) before returning it to the caller.
+ *
+ * Use for_each_leaf_0x2_entry() to iterate over the register output in
+ * parsed form.
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
+ * for_each_leaf_0x2_entry() - Iterator for parsed leaf 0x2 descriptors
+ * @regs:   Leaf 0x2 register output, returned by cpuid_get_leaf_0x2_regs()
+ * @__ptr:  u8 pointer, for macro internal use only
+ * @entry:  Pointer to parsed descriptor information at each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide the parsed information for each descriptor through @entry.
+ *
+ * To handle cache-specific descriptors, switch on @entry->c_type.  For TLB
+ * descriptors, switch on @entry->t_type.
+ *
+ * Example usage for cache descriptors::
+ *
+ *	const struct leaf_0x2_table *entry;
+ *	union leaf_0x2_regs regs;
+ *	u8 *ptr;
+ *
+ *	cpuid_get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_entry(regs, ptr, entry) {
+ *		switch (entry->c_type) {
+ *			...
+ *		}
+ *	}
+ */
+#define for_each_leaf_0x2_entry(regs, __ptr, entry)				\
+	for (__ptr = &(regs).desc[1];						\
+	     __ptr < &(regs).desc[16] && (entry = &cpuid_0x2_table[*__ptr]);	\
+	     __ptr++)
+
+/*
+ * CPUID(0x80000006) parsing:
  */
 
 static inline bool cpuid_amd_hygon_has_l3_cache(void)
diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
deleted file mode 100644
index 09fa307..0000000
--- a/arch/x86/include/asm/cpuid/leaf_0x2_api.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_CPUID_LEAF_0x2_API_H
-#define _ASM_X86_CPUID_LEAF_0x2_API_H
-
-#include <asm/cpuid/api.h>
-#include <asm/cpuid/types.h>
-
-/**
- * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
- * @regs:	Output parameter
- *
- * Query CPUID leaf 0x2 and store its output in @regs.	Force set any
- * invalid 1-byte descriptor returned by the hardware to zero (the NULL
- * cache/TLB descriptor) before returning it to the caller.
- *
- * Use for_each_leaf_0x2_entry() to iterate over the register output in
- * parsed form.
- */
-static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
-{
-	cpuid_leaf(0x2, regs);
-
-	/*
-	 * All Intel CPUs must report an iteration count of 1.	In case
-	 * of bogus hardware, treat all returned descriptors as NULL.
-	 */
-	if (regs->desc[0] != 0x01) {
-		for (int i = 0; i < 4; i++)
-			regs->regv[i] = 0;
-		return;
-	}
-
-	/*
-	 * The most significant bit (MSB) of each register must be clear.
-	 * If a register is invalid, replace its descriptors with NULL.
-	 */
-	for (int i = 0; i < 4; i++) {
-		if (regs->reg[i].invalid)
-			regs->regv[i] = 0;
-	}
-}
-
-/**
- * for_each_leaf_0x2_entry() - Iterator for parsed leaf 0x2 descriptors
- * @regs:   Leaf 0x2 register output, returned by cpuid_get_leaf_0x2_regs()
- * @__ptr:  u8 pointer, for macro internal use only
- * @entry:  Pointer to parsed descriptor information at each iteration
- *
- * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
- * @regs.  Provide the parsed information for each descriptor through @entry.
- *
- * To handle cache-specific descriptors, switch on @entry->c_type.  For TLB
- * descriptors, switch on @entry->t_type.
- *
- * Example usage for cache descriptors::
- *
- *	const struct leaf_0x2_table *entry;
- *	union leaf_0x2_regs regs;
- *	u8 *ptr;
- *
- *	cpuid_get_leaf_0x2_regs(&regs);
- *	for_each_leaf_0x2_entry(regs, ptr, entry) {
- *		switch (entry->c_type) {
- *			...
- *		}
- *	}
- */
-#define for_each_leaf_0x2_entry(regs, __ptr, entry)				\
-	for (__ptr = &(regs).desc[1];						\
-	     __ptr < &(regs).desc[16] && (entry = &cpuid_0x2_table[*__ptr]);	\
-	     __ptr++)
-
-#endif /* _ASM_X86_CPUID_LEAF_0x2_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index c95fee6..8a00364 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -31,8 +31,7 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_TILE		0x1d
 
 /*
- * Types for CPUID(0x2) parsing
- * Check <asm/cpuid/leaf_0x2_api.h>
+ * Types for CPUID(0x2) parsing:
  */
 
 struct leaf_0x2_reg {

