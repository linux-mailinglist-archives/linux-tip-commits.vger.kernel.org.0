Return-Path: <linux-tip-commits+bounces-7997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 674ADD1E28F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C313302B401
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2B3921D4;
	Wed, 14 Jan 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QT+43hZI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKbvrBeZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD8395271;
	Wed, 14 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387224; cv=none; b=B0tW10BdMKGEbQF8mH5LhIoUdKO3kg3PXa+unlkRwdwxrPgk69ZWzQZHM6trGI/OVWgX9MTgpcKhND79dbw8mY10wzRgUtzLvMxXknr0kN9wQyq4zlv7It8XpfPqfbl9X4NhgDdqj6UU8Rrzn1wwHuDnmOYimHrD3MSWUsRf5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387224; c=relaxed/simple;
	bh=RuC/ROjLX0nP/oLWRIvkr3Yn1qZnmGS8AKz+z3r9z2Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VfO+ygBk/I8XeSpCq8W9d9QONTAMgWfPSeNXwfKv5GAym2gUdZbFvSDLM3ggFSmyxXG41OhWe3hjhycZQzmKBH36BhUiLLtGDeyWqqNxEMMthwax630KI2fcBeUTKn9Frnz695e0D793ttS/eJCz+9t9AZ7W4xEFZnL3XV/Ftkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QT+43hZI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKbvrBeZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzqqzxxuYzVMTNRhREyYIq5cZj+I7ePCSvRUhK+pm9g=;
	b=QT+43hZIUOjsn4SfdXyX6l2yHpYRIE4JDsT88asRdlSo/kC6vR38/tcMcCwyTtc7DuGReW
	qkHnVom1fOn9i2JvD80xfRtVHF835e5LN5ZlAbPim6+8I4vdGN9wJD7EvJEmUt5Z4WPyaT
	gJf5aRONNW9W21r3T0eZexcB/bfIv3/nE2Lduyt3sMndyydlxlYMqfwNwckTnJ2kHpNKQy
	Apbzai5KO6phEbr6E+oDGxMx9y/v5cNplXHJbc6SQk3DubydAi7JY4+Dew0kNcbCbsFequ
	DAMIyzIElU0l7X+X35zftrOv8+qFBBZyTQGuN0Aw8me1Wx2Pyuexy8VHYnbK0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzqqzxxuYzVMTNRhREyYIq5cZj+I7ePCSvRUhK+pm9g=;
	b=kKbvrBeZmF9/feKwdpRptLRyxia/8FwqF7ODdMB3rurT/Lb64KxOzcBZ4bxkSD5RhfBSdH
	9LKcVPltYNNAFjDg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] x86/paravirt: Move thunk macros to paravirt_types.h
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-5-jgross@suse.com>
References: <20260105110520.21356-5-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721883.510.10822235763224457882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     b49c63eea526ecfd0321ecfd0dbf6e31c85b5592
Gitweb:        https://git.kernel.org/tip/b49c63eea526ecfd0321ecfd0dbf6e31c85=
b5592
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:03 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 15:24:05 +01:00

x86/paravirt: Move thunk macros to paravirt_types.h

The macros for generating PV-thunks are part of the generic paravirt
infrastructure, so they should be in paravirt_types.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-5-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h       | 68 +--------------------------
 arch/x86/include/asm/paravirt_types.h | 68 ++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index fd98263..1344d2f 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -581,74 +581,6 @@ bool __raw_callee_save___native_vcpu_is_preempted(long c=
pu);
=20
 #endif /* SMP && PARAVIRT_SPINLOCKS */
=20
-#ifdef CONFIG_X86_32
-/* save and restore all caller-save registers, except return value */
-#define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
-#define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
-#else
-/* save and restore all caller-save registers, except return value */
-#define PV_SAVE_ALL_CALLER_REGS						\
-	"push %rcx;"							\
-	"push %rdx;"							\
-	"push %rsi;"							\
-	"push %rdi;"							\
-	"push %r8;"							\
-	"push %r9;"							\
-	"push %r10;"							\
-	"push %r11;"
-#define PV_RESTORE_ALL_CALLER_REGS					\
-	"pop %r11;"							\
-	"pop %r10;"							\
-	"pop %r9;"							\
-	"pop %r8;"							\
-	"pop %rdi;"							\
-	"pop %rsi;"							\
-	"pop %rdx;"							\
-	"pop %rcx;"
-#endif
-
-/*
- * Generate a thunk around a function which saves all caller-save
- * registers except for the return value.  This allows C functions to
- * be called from assembler code where fewer than normal registers are
- * available.  It may also help code generation around calls from C
- * code if the common case doesn't use many registers.
- *
- * When a callee is wrapped in a thunk, the caller can assume that all
- * arg regs and all scratch registers are preserved across the
- * call. The return value in rax/eax will not be saved, even for void
- * functions.
- */
-#define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
-	extern typeof(func) __raw_callee_save_##func;			\
-									\
-	asm(".pushsection " section ", \"ax\";"				\
-	    ".globl " PV_THUNK_NAME(func) ";"				\
-	    ".type " PV_THUNK_NAME(func) ", @function;"			\
-	    ASM_FUNC_ALIGN						\
-	    PV_THUNK_NAME(func) ":"					\
-	    ASM_ENDBR							\
-	    FRAME_BEGIN							\
-	    PV_SAVE_ALL_CALLER_REGS					\
-	    "call " #func ";"						\
-	    PV_RESTORE_ALL_CALLER_REGS					\
-	    FRAME_END							\
-	    ASM_RET							\
-	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
-	    ".popsection")
-
-#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
-	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
-
-/* Get a reference to a callee-save function */
-#define PV_CALLEE_SAVE(func)						\
-	((struct paravirt_callee_save) { __raw_callee_save_##func })
-
-/* Promise that "func" already uses the right calling convention */
-#define __PV_IS_CALLEE_SAVE(func)			\
-	((struct paravirt_callee_save) { func })
-
 #ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index bd83528..0b60eab 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -512,5 +512,73 @@ unsigned long pv_native_read_cr2(void);
=20
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
=20
+#ifdef CONFIG_X86_32
+/* save and restore all caller-save registers, except return value */
+#define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
+#define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
+#else
+/* save and restore all caller-save registers, except return value */
+#define PV_SAVE_ALL_CALLER_REGS						\
+	"push %rcx;"							\
+	"push %rdx;"							\
+	"push %rsi;"							\
+	"push %rdi;"							\
+	"push %r8;"							\
+	"push %r9;"							\
+	"push %r10;"							\
+	"push %r11;"
+#define PV_RESTORE_ALL_CALLER_REGS					\
+	"pop %r11;"							\
+	"pop %r10;"							\
+	"pop %r9;"							\
+	"pop %r8;"							\
+	"pop %rdi;"							\
+	"pop %rsi;"							\
+	"pop %rdx;"							\
+	"pop %rcx;"
+#endif
+
+/*
+ * Generate a thunk around a function which saves all caller-save
+ * registers except for the return value.  This allows C functions to
+ * be called from assembler code where fewer than normal registers are
+ * available.  It may also help code generation around calls from C
+ * code if the common case doesn't use many registers.
+ *
+ * When a callee is wrapped in a thunk, the caller can assume that all
+ * arg regs and all scratch registers are preserved across the
+ * call. The return value in rax/eax will not be saved, even for void
+ * functions.
+ */
+#define PV_THUNK_NAME(func) "__raw_callee_save_" #func
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
+	extern typeof(func) __raw_callee_save_##func;			\
+									\
+	asm(".pushsection " section ", \"ax\";"				\
+	    ".globl " PV_THUNK_NAME(func) ";"				\
+	    ".type " PV_THUNK_NAME(func) ", @function;"			\
+	    ASM_FUNC_ALIGN						\
+	    PV_THUNK_NAME(func) ":"					\
+	    ASM_ENDBR							\
+	    FRAME_BEGIN							\
+	    PV_SAVE_ALL_CALLER_REGS					\
+	    "call " #func ";"						\
+	    PV_RESTORE_ALL_CALLER_REGS					\
+	    FRAME_END							\
+	    ASM_RET							\
+	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
+	    ".popsection")
+
+#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+
+/* Get a reference to a callee-save function */
+#define PV_CALLEE_SAVE(func)						\
+	((struct paravirt_callee_save) { __raw_callee_save_##func })
+
+/* Promise that "func" already uses the right calling convention */
+#define __PV_IS_CALLEE_SAVE(func)			\
+	((struct paravirt_callee_save) { func })
+
 #endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */

