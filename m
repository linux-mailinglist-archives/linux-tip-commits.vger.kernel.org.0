Return-Path: <linux-tip-commits+bounces-7990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C4D1E268
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F3E2300EB8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A408394499;
	Wed, 14 Jan 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lucrkduN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="diwpq/ZA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BD393DF9;
	Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387218; cv=none; b=JftplexTUgueWChHJJxlvuOmmrBAPg6HHKQj14WL+vPkqH6MZCorA9VRS2MzF+80M2mdHVNgYjbWt8P+YJ+ECj+xBDJmjNv0ewBnTl1gk/iOrFfht3AQp5JCCDhQIjYJAbPB/R3wVOQN8sD7/CcyKYGZAvykIf9sbqV6MxZm7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387218; c=relaxed/simple;
	bh=lODBBxjU02hRwzCa0Hzx7ulyo1HEuC3Zmu7vVW8wn0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ArbRjH3R77byND6qUBQnYAXkx6XlyRY/NKT+0rc0C5OXSJ6Y1/LldJOSoLRls81XlPkkLSelRyWoSIc+zGXUIqaS3vkqRLPQLrq7u4MoUvsEPQgqeMZVntPWFuLblfHFnqfc9SnV6x8j4StDmaWRePPZw9dnasn4Af86+6kmUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lucrkduN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=diwpq/ZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhOeg/yMqjGJfhb2MeN1iKxJSJmE6aoDIQ1IHoA1FiQ=;
	b=lucrkduNu6A2fDFlggCk/R7D+GKTkOTb4xdQuJxWFS5RzYkf4gjtW51+dpaKjVOPxM3QPM
	pU4F3x3HMqy6EciRwWy8f+EbkXUYKsP6hpeGwct8eHymuhqLyWl3yQIM97m+0fdLc9H5kw
	V/YKtnTX0tJ+xSt61ZRvFl/Lhamjo4Uj1ITCpdY/m4jfM78NsEOmTD1hJPv9Ho/H/KPMKk
	NFC2byIstLXFDFIYFd0IZFC1sc3PSMPJZrnJcEcgLQ9h3hZlpC8/22KSCXU3QVDDB3mXrn
	mIa2lARJxaVnp1XXBJzpK0B1GUg1Td+RV+bYjRZxHmTaVRXBFPVVpyImpPp32A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhOeg/yMqjGJfhb2MeN1iKxJSJmE6aoDIQ1IHoA1FiQ=;
	b=diwpq/ZAHoyCj07AnL+m31IGSXlztxiahBoP1ztGRSCGAHD116S2yhOa6dl7cTgDoBUauu
	zAJM5gdzlYtP3NDw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] x86/paravirt: Introduce new paravirt-base.h header
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-14-jgross@suse.com>
References: <20260105110520.21356-14-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720955.510.7093655202132540123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     f01b4f4a60191fa2a78931e2a3986983ec4f5334
Gitweb:        https://git.kernel.org/tip/f01b4f4a60191fa2a78931e2a3986983ec4=
f5334
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:12 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 18:58:28 +01:00

x86/paravirt: Introduce new paravirt-base.h header

Move the pv_info related definitions and the declarations of the global
paravirt function primitives into a new header file paravirt-base.h.

Use that header instead of paravirt_types.h in ptrace.h.

Additionally, this is a preparation to reduce the include hell with paravirt
enabled.

  [ bp: Massage commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105110520.21356-14-jgross@suse.com
---
 arch/x86/include/asm/paravirt-base.h  | 29 ++++++++++++++++++++++++++-
 arch/x86/include/asm/paravirt.h       |  4 +++-
 arch/x86/include/asm/paravirt_types.h | 23 +---------------------
 arch/x86/include/asm/ptrace.h         |  2 +-
 4 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-base.h

diff --git a/arch/x86/include/asm/paravirt-base.h b/arch/x86/include/asm/para=
virt-base.h
new file mode 100644
index 0000000..3827ea2
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-base.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_X86_PARAVIRT_BASE_H
+#define _ASM_X86_PARAVIRT_BASE_H
+
+/*
+ * Wrapper type for pointers to code which uses the non-standard
+ * calling convention.  See PV_CALL_SAVE_REGS_THUNK below.
+ */
+struct paravirt_callee_save {
+	void *func;
+};
+
+struct pv_info {
+#ifdef CONFIG_PARAVIRT_XXL
+	u16 extra_user_64bit_cs;  /* __USER_CS if none */
+#endif
+	const char *name;
+};
+
+void default_banner(void);
+extern struct pv_info pv_info;
+unsigned long paravirt_ret0(void);
+#ifdef CONFIG_PARAVIRT_XXL
+u64 _paravirt_ident_64(u64);
+#endif
+#define paravirt_nop	((void *)nop_func)
+
+#endif /* _ASM_X86_PARAVIRT_BASE_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b69e75a..62399f5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -4,6 +4,9 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
=20
+#ifndef __ASSEMBLER__
+#include <asm/paravirt-base.h>
+#endif
 #include <asm/paravirt_types.h>
=20
 #ifdef CONFIG_PARAVIRT
@@ -601,7 +604,6 @@ static __always_inline unsigned long arch_local_irq_save(=
void)
 #undef PVOP_VCALL4
 #undef PVOP_CALL4
=20
-extern void default_banner(void);
 void native_pv_lock_init(void) __init;
=20
 #else  /* __ASSEMBLER__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index 0b60eab..d7c38e5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
=20
+#include <asm/paravirt-base.h>
 #include <asm/desc_defs.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
@@ -18,23 +19,6 @@ struct cpumask;
 struct flush_tlb_info;
 struct vm_area_struct;
=20
-/*
- * Wrapper type for pointers to code which uses the non-standard
- * calling convention.  See PV_CALL_SAVE_REGS_THUNK below.
- */
-struct paravirt_callee_save {
-	void *func;
-};
-
-/* general info */
-struct pv_info {
-#ifdef CONFIG_PARAVIRT_XXL
-	u16 extra_user_64bit_cs;  /* __USER_CS if none */
-#endif
-
-	const char *name;
-};
-
 #ifdef CONFIG_PARAVIRT_XXL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
@@ -226,7 +210,6 @@ struct paravirt_patch_template {
 	struct pv_lock_ops	lock;
 } __no_randomize_layout;
=20
-extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
=20
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
@@ -497,17 +480,13 @@ extern struct paravirt_patch_template pv_ops;
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
=20
-unsigned long paravirt_ret0(void);
 #ifdef CONFIG_PARAVIRT_XXL
-u64 _paravirt_ident_64(u64);
 unsigned long pv_native_save_fl(void);
 void pv_native_irq_disable(void);
 void pv_native_irq_enable(void);
 unsigned long pv_native_read_cr2(void);
 #endif
=20
-#define paravirt_nop	((void *)nop_func)
-
 #endif	/* __ASSEMBLER__ */
=20
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 35d062a..7bb7bd9 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -172,7 +172,7 @@ struct pt_regs {
 #endif /* !__i386__ */
=20
 #ifdef CONFIG_PARAVIRT
-#include <asm/paravirt_types.h>
+#include <asm/paravirt-base.h>
 #endif
=20
 #include <asm/proto.h>

