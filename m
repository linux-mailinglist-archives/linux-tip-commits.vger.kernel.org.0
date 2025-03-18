Return-Path: <linux-tip-commits+bounces-4306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9FA6735B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0999179A6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513D20C029;
	Tue, 18 Mar 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BgfVapvF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+89ArMM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2320C492;
	Tue, 18 Mar 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299219; cv=none; b=G/IKMjMYMhX1tgsymzARH6u5Dj3VBox6JEb7tCqRVSoVeIiqBOfvvtiC47EZRFhK/zibJ/glI8yiIRiwFgdlzKNmx5p35/xe+6GAPLa0UOeOWgyhfmACUtBH/IeoWTwiIuu3r0h/QQIsqS3jAZWFuqd+4IXqcaOOn1BpkJGPHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299219; c=relaxed/simple;
	bh=Vos73ZT0YYoNdmHFymxOsYmJWJuTG5GxULcSMSybty0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fzHU7eo/pfpdqXw9YDLJbkXDFJVrrUmpNl5gad2IoDfMj8wT3TxOZekkHqvjEEZilPXp2fyG9H87ThXWji9ECKhs66/zL3v7guyJOfYmYo8f2yarxmHQ0HTFyIlQGIYsnN4rypKHDPN2W7ztbesXwTiud/zf4CDxReYMouITuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BgfVapvF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+89ArMM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742299211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt/l8tTM2FqV6+hdnbr9hy4oXTEIM9H/oZHmt0b6e94=;
	b=BgfVapvFg4OtdPWqiRTSZ2i2axp56VT0NWLppXTyBY7v4Mmx0RwmblaP1iqicZDNY4pTxn
	i6IWtYD0mc5f9P3MH7M+QwBN8JNxICVbODn3PkvgHTAk0FXASItQsA1uRVdbLd7aYRKSj2
	BXQzYXXQxzCwhxCmJDIQgSBIO0yPRdgm4Yx5mjxPgwFed+fonWjYJEl39kTmcOk4mJLAuT
	e5Mocphc1lyyq6oAhA/vihmv6RJ0lOLXdINLRxHik2tfpRqQoZHo2syQfwWpCAeEBiVfMA
	bXl/t6VEM6Tb6seGhgSyDqGy/IijbO/7C25lhAgI6QPwFT3XqeeZH8kuS9COdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742299211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt/l8tTM2FqV6+hdnbr9hy4oXTEIM9H/oZHmt0b6e94=;
	b=s+89ArMMrxhreOonqcNm3nnOV/swcJ30oy1y7cjqFn5kaPxwBTPnB8uQJkbl86Rk3MPhP3
	HqUxvjNUaq86GJAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Refactor <asm/cpuid.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-2-mingo@kernel.org>
References: <20250317221824.3738853-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174229921017.14745.3477143339569781915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     02b63b33dfc9294cfbdef78b99f5e15ef9243e39
Gitweb:        https://git.kernel.org/tip/02b63b33dfc9294cfbdef78b99f5e15ef92=
43e39
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 17 Mar 2025 23:18:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 09:35:57 +01:00

x86/cpuid: Refactor <asm/cpuid.h>

In preparation for future commits where CPUID headers will be expanded,
refactor the CPUID header <asm/cpuid.h> into:

    asm/cpuid/
    =E2=94=9C=E2=94=80=E2=94=80 api.h
    =E2=94=94=E2=94=80=E2=94=80 types.h

Move the CPUID data structures into <asm/cpuid/types.h> and the access
APIs into <asm/cpuid/api.h>.  Let <asm/cpuid.h> be just an include of
<asm/cpuid/api.h> so that existing call sites do not break.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-2-mingo@kernel.org
---
 arch/x86/include/asm/cpuid.h       | 217 +----------------------------
 arch/x86/include/asm/cpuid/api.h   | 208 +++++++++++++++++++++++++++-
 arch/x86/include/asm/cpuid/types.h |  29 ++++-
 3 files changed, 238 insertions(+), 216 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index a92e4b0..d5749b2 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -1,223 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * CPUID-related helpers/definitions
- */
=20
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
=20
-#include <linux/build_bug.h>
-#include <linux/types.h>
-
-#include <asm/string.h>
-
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX =3D 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
-#define CPUID_LEAF_XSTATE	0x0d
-#define CPUID_LEAF_TSC		0x15
-#define CPUID_LEAF_FREQ		0x16
-#define CPUID_LEAF_TILE		0x1d
-
-#ifdef CONFIG_X86_32
-bool have_cpuid_p(void);
-#else
-static inline bool have_cpuid_p(void)
-{
-	return true;
-}
-#endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=3Da" (*eax),
-	      "=3Db" (*ebx),
-	      "=3Dc" (*ecx),
-	      "=3Dd" (*edx)
-	    : "0" (*eax), "2" (*ecx)
-	    : "memory");
-}
-
-#define native_cpuid_reg(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
-{								\
-	unsigned int eax =3D op, ebx, ecx =3D 0, edx;		\
-								\
-	native_cpuid(&eax, &ebx, &ecx, &edx);			\
-								\
-	return reg;						\
-}
-
-/*
- * Native CPUID functions returning a single datum.
- */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
-
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
-#else
-#define __cpuid			native_cpuid
-#endif
-
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
-{
-	*eax =3D op;
-	*ecx =3D 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
-{
-	*eax =3D op;
-	*ecx =3D count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return eax;
-}
-
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ebx;
-}
-
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return edx;
-}
-
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32=
 *regs)
-{
-	regs[CPUID_EAX] =3D leaf;
-	regs[CPUID_ECX] =3D subleaf;
-	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_=
EDX);
-}
-
-#define cpuid_subleaf(leaf, subleaf, regs) {		\
-	static_assert(sizeof(*(regs)) =3D=3D 16);		\
-	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
-}
-
-#define cpuid_leaf(leaf, regs) {			\
-	static_assert(sizeof(*(regs)) =3D=3D 16);		\
-	__cpuid_read(leaf, 0, (u32 *)(regs));		\
-}
-
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
-				    enum cpuid_regs_idx regidx, u32 *reg)
-{
-	u32 regs[4];
-
-	__cpuid_read(leaf, subleaf, regs);
-	*reg =3D regs[regidx];
-}
-
-#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
-	static_assert(sizeof(*(reg)) =3D=3D 4);			\
-	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
-}
-
-#define cpuid_leaf_reg(leaf, regidx, reg) {			\
-	static_assert(sizeof(*(reg)) =3D=3D 4);			\
-	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
-}
-
-static __always_inline bool cpuid_function_is_indexed(u32 function)
-{
-	switch (function) {
-	case 4:
-	case 7:
-	case 0xb:
-	case 0xd:
-	case 0xf:
-	case 0x10:
-	case 0x12:
-	case 0x14:
-	case 0x17:
-	case 0x18:
-	case 0x1d:
-	case 0x1e:
-	case 0x1f:
-	case 0x24:
-	case 0x8000001d:
-		return true;
-	}
-
-	return false;
-}
-
-#define for_each_possible_hypervisor_cpuid_base(function) \
-	for (function =3D 0x40000000; function < 0x40010000; function +=3D 0x100)
-
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leave=
s)
-{
-	uint32_t base, eax, signature[3];
-
-	for_each_possible_hypervisor_cpuid_base(base) {
-		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-
-		/*
-		 * This must not compile to "call memcmp" because it's called
-		 * from PVH early boot code before instrumentation is set up
-		 * and memcmp() itself may be instrumented.
-		 */
-		if (!__builtin_memcmp(sig, signature, 12) &&
-		    (leaves =3D=3D 0 || ((eax - base) >=3D leaves)))
-			return base;
-	}
-
-	return 0;
-}
+#include <asm/cpuid/api.h>
=20
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/ap=
i.h
new file mode 100644
index 0000000..4d1da9c
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_CPUID_API_H
+#define _ASM_X86_CPUID_API_H
+
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+#include <asm/cpuid/types.h>
+#include <asm/string.h>
+
+/*
+ * Raw CPUID accessors
+ */
+
+#ifdef CONFIG_X86_32
+bool have_cpuid_p(void);
+#else
+static inline bool have_cpuid_p(void)
+{
+	return true;
+}
+#endif
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=3Da" (*eax),
+	      "=3Db" (*ebx),
+	      "=3Dc" (*ecx),
+	      "=3Dd" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax =3D op, ebx, ecx =3D 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define __cpuid			native_cpuid
+#endif
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op,
+			 unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	*eax =3D op;
+	*ecx =3D 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(unsigned int op, int count,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	*eax =3D op;
+	*ecx =3D count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return edx;
+}
+
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32=
 *regs)
+{
+	regs[CPUID_EAX] =3D leaf;
+	regs[CPUID_ECX] =3D subleaf;
+	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_=
EDX);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	static_assert(sizeof(*(regs)) =3D=3D 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	static_assert(sizeof(*(regs)) =3D=3D 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg =3D regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	static_assert(sizeof(*(reg)) =3D=3D 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	static_assert(sizeof(*(reg)) =3D=3D 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
+static __always_inline bool cpuid_function_is_indexed(u32 function)
+{
+	switch (function) {
+	case 4:
+	case 7:
+	case 0xb:
+	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
+	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1d:
+	case 0x1e:
+	case 0x1f:
+	case 0x24:
+	case 0x8000001d:
+		return true;
+	}
+
+	return false;
+}
+
+#define for_each_possible_hypervisor_cpuid_base(function) \
+	for (function =3D 0x40000000; function < 0x40010000; function +=3D 0x100)
+
+static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leave=
s)
+{
+	uint32_t base, eax, signature[3];
+
+	for_each_possible_hypervisor_cpuid_base(base) {
+		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
+
+		/*
+		 * This must not compile to "call memcmp" because it's called
+		 * from PVH early boot code before instrumentation is set up
+		 * and memcmp() itself may be instrumented.
+		 */
+		if (!__builtin_memcmp(sig, signature, 12) &&
+		    (leaves =3D=3D 0 || ((eax - base) >=3D leaves)))
+			return base;
+	}
+
+	return 0;
+}
+
+#endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/=
types.h
new file mode 100644
index 0000000..724002a
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_TYPES_H
+#define _ASM_X86_CPUID_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * Types for raw CPUID access
+ */
+
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
+
+enum cpuid_regs_idx {
+	CPUID_EAX =3D 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
+
+#define CPUID_LEAF_MWAIT	0x5
+#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_XSTATE	0x0d
+#define CPUID_LEAF_TSC		0x15
+#define CPUID_LEAF_FREQ		0x16
+#define CPUID_LEAF_TILE		0x1d
+
+#endif /* _ASM_X86_CPUID_TYPES_H */

