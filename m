Return-Path: <linux-tip-commits+bounces-4331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08912A68A8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D6E19C7D3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0600254AED;
	Wed, 19 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sdlYj2oq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZw7BjLj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFD25486B;
	Wed, 19 Mar 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382210; cv=none; b=FF0qU+selElPx6LFNPOI19Sl05OZA6jA1cKxh9w02q5iR9+e9VKc1kuHMOjom13gqd8iqZ/0Uc+vOKY6KROSRAo+0h+3Fqpm7vO0EAKmFqUjIeZ3cQN25GJxIF47QvimIBuT0xdivPAn+28CYMFLonKb2XIAOT4I24+viv8Uf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382210; c=relaxed/simple;
	bh=BZtvG9n5WUPlps4+b6ABFn69JQ3KgdX0NX/4F5+N9yQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TpSEvJoQeZYuHd654KBbuzcTg2+1K9DAxlOm5zSx17/1rZTWRnZk+KaxzZeAkPUeoW3AtpPUGTwXyA226RHuyxbesQ2bcyIG/D4LBehs2uyZKZHAuOaPm+xyP0/hy3UFbPvkZ6HJ99ogvzEOogfszRjTwDmN1quzG7MQU3opIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sdlYj2oq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZw7BjLj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kOtrPcBpUWIG6b9fdANe63RwMF3KurBS70IpwWJJeI=;
	b=sdlYj2oqjUY8qJIvAuC6mU+1TAGQm65U6BZNp3LPj8zFcrXm8A/CWPmpGEF075JQli8fRi
	YWYS6Dm78dhh5YsbCuu+fUQ/WSmSLSTNHq+kukcNPUKvtzGfVoZr2fY1lALwyq1t7MibWQ
	h1Snq3dyeRi5cOWirrx3LCOWjJpVeM4bY6SJVdFArDKaa0xPfhv9jiTB1Es24qx4uaWS15
	pogu7VPS8EgMBQPQRKINcaz/jI+O64/8a2oWjDai0ZOXSOczJ/SZHFS2xkqGQuaBpZGCMk
	jfIqPcBQpraOP8iu1bmbZTCNSpNOgegU4VSaPwk6dZU79tg25arIwrVCCfGJLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kOtrPcBpUWIG6b9fdANe63RwMF3KurBS70IpwWJJeI=;
	b=zZw7BjLjpR1kk0vtFotnfRPNBXFXh2xKJbl0hOSI7m4Wi/rJmgvXM8JMIqLqrn6yD8Ct0U
	OH3cFcNe/K+4SqCA==
From: "tip-bot2 for Thomas Huth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-UAPI headers
Cc: Thomas Huth <thuth@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314071013.1575167-38-thuth@redhat.com>
References: <20250314071013.1575167-38-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238220057.14745.4412519272430156548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     24a295e4ef1ca8e97d8b7015e1887b6e83e1c8be
Gitweb:        https://git.kernel.org/tip/24a295e4ef1ca8e97d8b7015e1887b6e83e1c8be
Author:        Thomas Huth <thuth@redhat.com>
AuthorDate:    Wed, 19 Mar 2025 11:30:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:47:30 +01:00

x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-UAPI headers

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.

This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with UAPI headers that
rather should use __ASSEMBLER__ instead. So let's standardize on
the __ASSEMBLER__ macro that is provided by the compilers now.

This is mostly a mechanical patch (done with a simple "sed -i"
statement), with some manual tweaks in <asm/frame.h>, <asm/hw_irq.h>
and <asm/setup.h> that mentioned this macro in comments with some
missing underscores.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314071013.1575167-38-thuth@redhat.com
---
 arch/x86/boot/boot.h                        |  4 ++--
 arch/x86/entry/vdso/extable.h               |  2 +-
 arch/x86/include/asm/alternative.h          |  6 +++---
 arch/x86/include/asm/asm.h                  | 10 +++++-----
 arch/x86/include/asm/boot.h                 |  2 +-
 arch/x86/include/asm/cpufeature.h           |  4 ++--
 arch/x86/include/asm/cpumask.h              |  4 ++--
 arch/x86/include/asm/current.h              |  4 ++--
 arch/x86/include/asm/desc_defs.h            |  4 ++--
 arch/x86/include/asm/dwarf2.h               |  2 +-
 arch/x86/include/asm/fixmap.h               |  4 ++--
 arch/x86/include/asm/frame.h                | 10 +++++-----
 arch/x86/include/asm/fred.h                 |  4 ++--
 arch/x86/include/asm/fsgsbase.h             |  4 ++--
 arch/x86/include/asm/ftrace.h               |  8 ++++----
 arch/x86/include/asm/hw_irq.h               |  4 ++--
 arch/x86/include/asm/ibt.h                  | 12 ++++++------
 arch/x86/include/asm/idtentry.h             |  6 +++---
 arch/x86/include/asm/inst.h                 |  2 +-
 arch/x86/include/asm/irqflags.h             | 10 +++++-----
 arch/x86/include/asm/jump_label.h           |  4 ++--
 arch/x86/include/asm/kasan.h                |  2 +-
 arch/x86/include/asm/kexec.h                |  4 ++--
 arch/x86/include/asm/linkage.h              |  6 +++---
 arch/x86/include/asm/mem_encrypt.h          |  4 ++--
 arch/x86/include/asm/msr.h                  |  4 ++--
 arch/x86/include/asm/nops.h                 |  2 +-
 arch/x86/include/asm/nospec-branch.h        |  6 +++---
 arch/x86/include/asm/orc_types.h            |  4 ++--
 arch/x86/include/asm/page.h                 |  4 ++--
 arch/x86/include/asm/page_32.h              |  4 ++--
 arch/x86/include/asm/page_32_types.h        |  4 ++--
 arch/x86/include/asm/page_64.h              |  4 ++--
 arch/x86/include/asm/page_64_types.h        |  2 +-
 arch/x86/include/asm/page_types.h           |  4 ++--
 arch/x86/include/asm/paravirt.h             | 14 +++++++-------
 arch/x86/include/asm/paravirt_types.h       |  4 ++--
 arch/x86/include/asm/percpu.h               |  4 ++--
 arch/x86/include/asm/pgtable-2level_types.h |  4 ++--
 arch/x86/include/asm/pgtable-3level_types.h |  4 ++--
 arch/x86/include/asm/pgtable-invert.h       |  4 ++--
 arch/x86/include/asm/pgtable.h              | 12 ++++++------
 arch/x86/include/asm/pgtable_32.h           |  4 ++--
 arch/x86/include/asm/pgtable_32_areas.h     |  2 +-
 arch/x86/include/asm/pgtable_64.h           |  6 +++---
 arch/x86/include/asm/pgtable_64_types.h     |  4 ++--
 arch/x86/include/asm/pgtable_types.h        | 10 +++++-----
 arch/x86/include/asm/prom.h                 |  4 ++--
 arch/x86/include/asm/pti.h                  |  4 ++--
 arch/x86/include/asm/ptrace.h               |  4 ++--
 arch/x86/include/asm/purgatory.h            |  4 ++--
 arch/x86/include/asm/pvclock-abi.h          |  4 ++--
 arch/x86/include/asm/realmode.h             |  4 ++--
 arch/x86/include/asm/segment.h              |  8 ++++----
 arch/x86/include/asm/setup.h                |  6 +++---
 arch/x86/include/asm/setup_data.h           |  4 ++--
 arch/x86/include/asm/shared/tdx.h           |  4 ++--
 arch/x86/include/asm/shstk.h                |  4 ++--
 arch/x86/include/asm/signal.h               |  8 ++++----
 arch/x86/include/asm/smap.h                 |  6 +++---
 arch/x86/include/asm/smp.h                  |  4 ++--
 arch/x86/include/asm/tdx.h                  |  4 ++--
 arch/x86/include/asm/thread_info.h          | 12 ++++++------
 arch/x86/include/asm/unwind_hints.h         |  4 ++--
 arch/x86/include/asm/vdso/getrandom.h       |  4 ++--
 arch/x86/include/asm/vdso/gettimeofday.h    |  4 ++--
 arch/x86/include/asm/vdso/processor.h       |  4 ++--
 arch/x86/include/asm/vdso/vsyscall.h        |  4 ++--
 arch/x86/include/asm/xen/interface.h        | 10 +++++-----
 arch/x86/include/asm/xen/interface_32.h     |  4 ++--
 arch/x86/include/asm/xen/interface_64.h     |  4 ++--
 arch/x86/math-emu/control_w.h               |  2 +-
 arch/x86/math-emu/exception.h               |  6 +++---
 arch/x86/math-emu/fpu_emu.h                 |  6 +++---
 arch/x86/math-emu/status_w.h                |  6 +++---
 arch/x86/realmode/rm/realmode.h             |  4 ++--
 arch/x86/realmode/rm/wakeup.h               |  2 +-
 tools/arch/x86/include/asm/asm.h            |  8 ++++----
 tools/arch/x86/include/asm/nops.h           |  2 +-
 tools/arch/x86/include/asm/orc_types.h      |  4 ++--
 tools/arch/x86/include/asm/pvclock-abi.h    |  4 ++--
 81 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 0f24f7e..38f17a1 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -16,7 +16,7 @@
 
 #define STACK_SIZE	1024	/* Minimum number of bytes for stack */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stdarg.h>
 #include <linux/types.h>
@@ -327,6 +327,6 @@ void probe_cards(int unsafe);
 /* video-vesa.c */
 void vesa_store_edid(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* BOOT_BOOT_H */
diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
index b56f6b0..baba612 100644
--- a/arch/x86/entry/vdso/extable.h
+++ b/arch/x86/entry/vdso/extable.h
@@ -7,7 +7,7 @@
  * vDSO uses a dedicated handler the addresses are relative to the overall
  * exception table, not each individual entry.
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
 	ASM_VDSO_EXTABLE_HANDLE from to
 
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6bf1970..69f25e6 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -15,7 +15,7 @@
 #define ALT_DIRECT_CALL(feature) ((ALT_FLAG_DIRECT_CALL << ALT_FLAGS_SHIFT) | (feature))
 #define ALT_CALL_ALWAYS		ALT_DIRECT_CALL(X86_FEATURE_ALWAYS)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stddef.h>
 
@@ -277,7 +277,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 void BUG_func(void);
 void nop_func(void);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_SMP
 	.macro LOCK_PREFIX
@@ -360,6 +360,6 @@ void nop_func(void);
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 	newinstr_yes, ft_flags
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_ALTERNATIVE_H */
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 975ae7a..cc28815 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_ASM_H
 #define _ASM_X86_ASM_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
@@ -113,7 +113,7 @@
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef __pic__
 static __always_inline __pure void *rip_rel_ptr(void *p)
 {
@@ -144,7 +144,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 # include <asm/extable_fixup_types.h>
 
 /* Exception table entry */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
@@ -164,7 +164,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 #  define _ASM_NOKPROBE(entry)
 # endif
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 
 # define DEFINE_EXTABLE_TYPE_REG \
 	".macro extable_type_reg type:req reg:req\n"						\
@@ -232,7 +232,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_DEFAULT)
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3e5b111..3f02ff6 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -74,7 +74,7 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
 extern const unsigned long kernel_total_size;
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index fe6994f..893cbca 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor.h>
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 
 #include <asm/asm.h>
 #include <linux/bitops.h>
@@ -137,5 +137,5 @@ t_no:
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index 4acfd57..70f6b60 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_CPUMASK_H
 #define _ASM_X86_CPUMASK_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 
 extern void setup_cpu_local_masks(void);
@@ -34,5 +34,5 @@ static __always_inline void arch_cpumask_clear_cpu(int cpu, struct cpumask *dstp
 
 #define arch_cpu_is_offline(cpu)	unlikely(!arch_cpu_online(cpu))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_CPUMASK_H */
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index dea7d8b..cc4a3f7 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -5,7 +5,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/cache.h>
 #include <asm/percpu.h>
@@ -27,6 +27,6 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_CURRENT_H */
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index d440a65..7e6b931 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -58,7 +58,7 @@
 
 #define DESC_USER		(_DESC_DPL(3))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -166,7 +166,7 @@ struct desc_ptr {
 	unsigned long address;
 } __attribute__((packed)) ;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* Boot IDT definitions */
 #define	BOOT_IDT_ENTRIES	32
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 430fca1..302e11b 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_DWARF2_H
 #define _ASM_X86_DWARF2_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb..4519c9f 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -31,7 +31,7 @@
 /* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
 #define FIXMAP_PMD_TOP	507
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/kernel.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
@@ -196,5 +196,5 @@ void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 void __early_set_fixmap(enum fixed_addresses idx,
 			phys_addr_t phys, pgprot_t flags);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_FIXMAP_H */
diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index fb42659..0ab6507 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro FRAME_BEGIN
 	push %_ASM_BP
@@ -51,7 +51,7 @@
 .endm
 #endif /* CONFIG_X86_64 */
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #define FRAME_BEGIN				\
 	"push %" _ASM_BP "\n"			\
@@ -82,18 +82,18 @@ static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
 
 #endif /* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define FRAME_OFFSET __ASM_SEL(4, 8)
 
 #else /* !CONFIG_FRAME_POINTER */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
 .endm
 
-#else /* !__ASSEMBLY */
+#else /* !__ASSEMBLER__ */
 
 #define ENCODE_FRAME_POINTER
 
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 25ca00b..2a29e52 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -32,7 +32,7 @@
 #define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
 #define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
@@ -113,6 +113,6 @@ static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) {
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* ASM_X86_FRED_H */
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 9e7e8ca..02f2395 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_FSGSBASE_H
 #define _ASM_FSGSBASE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_64
 
@@ -80,6 +80,6 @@ extern unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 
 #endif /* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f226524..93156ac 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -22,7 +22,7 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __fentry__(void);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
@@ -106,11 +106,11 @@ struct dyn_arch_ftrace {
 };
 
 #endif /*  CONFIG_DYNAMIC_FTRACE */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer);
@@ -154,6 +154,6 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
 #endif /* !COMPILE_OFFSETS */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index edebf10..162ebd7 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,7 +16,7 @@
 
 #include <asm/irq_vectors.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/percpu.h>
 #include <linux/profile.h>
@@ -128,6 +128,6 @@ extern char spurious_entries_start[];
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
 
-#endif /* !ASSEMBLY_ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_HW_IRQ_H */
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 9423a29..28d8452 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -21,7 +21,7 @@
 
 #define HAS_KERNEL_IBT	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_64
 #define ASM_ENDBR	"endbr64\n\t"
@@ -82,7 +82,7 @@ extern __noendbr bool is_endbr(u32 *val);
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_64
 #define ENDBR	endbr64
@@ -90,13 +90,13 @@ extern __noendbr void ibt_restore(u64 save);
 #define ENDBR	endbr32
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* !IBT */
 
 #define HAS_KERNEL_IBT	0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ASM_ENDBR
 #define IBT_NOSEAL(name)
@@ -108,11 +108,11 @@ static inline bool is_endbr(u32 *val) { return false; }
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define ENDBR
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ad5c68f..a4ec27c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,7 +7,7 @@
 
 #define IDT_ALIGN	(8 * (1 + HAS_KERNEL_IBT))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/entry-common.h>
 #include <linux/hardirq.h>
 
@@ -474,7 +474,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 		idt_install_sysvec(vector, asm_##function);		\
 }
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 /*
  * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
@@ -579,7 +579,7 @@ SYM_CODE_START(spurious_entries_start)
 SYM_CODE_END(spurious_entries_start)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The actual entry points. Note that DECLARE_IDTENTRY*() serves two
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index 438ccd4..e48a00b 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -6,7 +6,7 @@
 #ifndef X86_ASM_INST_H
 #define X86_ASM_INST_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define REG_NUM_INVALID		100
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b..abb8374 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor-flags.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/nospec-branch.h>
 
@@ -79,7 +79,7 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 static __always_inline unsigned long arch_local_save_flags(void)
@@ -133,10 +133,10 @@ static __always_inline unsigned long arch_local_irq_save(void)
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PARAVIRT_XXL */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static __always_inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & X86_EFLAGS_IF);
@@ -154,6 +154,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 3f1c1d6..61dd1de 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -7,7 +7,7 @@
 #include <asm/asm.h>
 #include <asm/nops.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stringify.h>
 #include <linux/types.h>
@@ -55,6 +55,6 @@ l_yes:
 
 extern int arch_jump_entry_size(struct jump_entry *entry);
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index de75306..d7e33c7 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -23,7 +23,7 @@
 					(1ULL << (__VIRTUAL_MASK_SHIFT - \
 						  KASAN_SHADOW_SCALE_SHIFT)))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index e3589d6..5432457 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -13,7 +13,7 @@
 # define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -217,6 +217,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void);
 #define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 4835c67..b51d8a4 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -38,7 +38,7 @@
 #define ASM_FUNC_ALIGN		__stringify(__FUNC_ALIGN)
 #define SYM_F_ALIGN		__FUNC_ALIGN
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
@@ -50,7 +50,7 @@
 #endif
 #endif /* CONFIG_MITIGATION_RETPOLINE */
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
@@ -62,7 +62,7 @@
 #endif
 #endif /* CONFIG_MITIGATION_RETPOLINE */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_PADDING) the
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index f922b68..1530ee3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -10,7 +10,7 @@
 #ifndef __X86_MEM_ENCRYPT_H__
 #define __X86_MEM_ENCRYPT_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/init.h>
 #include <linux/cc_platform.h>
@@ -114,6 +114,6 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 0018535..9397a31 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -4,7 +4,7 @@
 
 #include "msr-index.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
 #include <asm/errno.h>
@@ -397,5 +397,5 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 	return wrmsr_safe_regs(regs);
 }
 #endif  /* CONFIG_SMP */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_MSR_H */
diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index 1c1b755..cd94221 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -82,7 +82,7 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern const unsigned char * const x86_nops[];
 #endif
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 44c6076..804b66a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -176,7 +176,7 @@
 	add	$(BITS_PER_LONG/8), %_ASM_SP;		\
 	lfence;
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
@@ -334,7 +334,7 @@
 #define CLEAR_BRANCH_HISTORY_VMEXIT
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
@@ -603,6 +603,6 @@ static __always_inline void mds_idle_clear_cpu_buffers(void)
 		mds_clear_cpu_buffers();
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 46d7e06..e0125af 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -45,7 +45,7 @@
 #define ORC_TYPE_REGS			3
 #define ORC_TYPE_REGS_PARTIAL		4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/byteorder.h>
 
 /*
@@ -73,6 +73,6 @@ struct orc_entry {
 #endif
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index c9fe207..9265f2f 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -14,7 +14,7 @@
 #include <asm/page_32.h>
 #endif	/* CONFIG_X86_64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct page;
 
@@ -84,7 +84,7 @@ static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
 	return __canonical_address(vaddr, vaddr_bits) == vaddr;
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 580d71a..0c62370 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -4,7 +4,7 @@
 
 #include <asm/page_32_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __phys_addr_nodebug(x)	((x) - PAGE_OFFSET)
 #ifdef CONFIG_DEBUG_VIRTUAL
@@ -26,6 +26,6 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 25c3265..a9b62e0 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -63,7 +63,7 @@
  */
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
@@ -75,6 +75,6 @@ extern int sysctl_legacy_va_layout;
 extern void find_low_pfn_range(void);
 extern void setup_bootmem_allocator(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PAGE_32_DEFS_H */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index b5279f5..d3aab6f 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -4,7 +4,7 @@
 
 #include <asm/page_64_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -95,7 +95,7 @@ static __always_inline unsigned long task_size_max(void)
 }
 #endif	/* CONFIG_X86_5LEVEL */
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 # define __HAVE_ARCH_GATE_AREA 1
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 06ef254..1faa8f8 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PAGE_64_DEFS_H
 #define _ASM_X86_PAGE_64_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/kaslr.h>
 #endif
 
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 9746889..9f77bf0 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -43,7 +43,7 @@
 #define IOREMAP_MAX_ORDER       (PMD_SHIFT)
 #endif	/* CONFIG_X86_64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 extern phys_addr_t physical_mask;
@@ -66,6 +66,6 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn);
 
 extern void initmem_init(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif	/* _ASM_X86_PAGE_DEFS_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 38a632a..bed346b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,7 +6,7 @@
 
 #include <asm/paravirt_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct mm_struct;
 #endif
 
@@ -15,7 +15,7 @@ struct mm_struct;
 #include <asm/asm.h>
 #include <asm/nospec-branch.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -715,7 +715,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
-#else  /* __ASSEMBLY__ */
+#else  /* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
@@ -735,18 +735,18 @@ void native_pv_lock_init(void) __init;
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline void native_pv_lock_init(void)
 {
 }
 #endif
 #endif /* !CONFIG_PARAVIRT */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
@@ -764,5 +764,5 @@ static inline void paravirt_set_cap(void)
 {
 }
 #endif
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 127a372..6291202 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_PARAVIRT
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 #include <asm/desc_defs.h>
@@ -525,7 +525,7 @@ unsigned long pv_native_read_cr2(void);
 
 #define paravirt_nop	((void *)nop_func)
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
 
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 462d071..105db2d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -10,7 +10,7 @@
 # define __percpu_rel
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CONFIG_SMP
 # define __percpu		%__percpu_seg:
@@ -588,7 +588,7 @@ do {									\
 /* We can use this directly for local CPU (faster). */
 DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 4a12c27..6642542 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PGTABLE_2LEVEL_DEFS_H
 #define _ASM_X86_PGTABLE_2LEVEL_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 typedef unsigned long	pteval_t;
@@ -16,7 +16,7 @@ typedef union {
 	pteval_t pte;
 	pteval_t pte_low;
 } pte_t;
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	0
 
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 8091134..9d5b257 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_DEFS_H
 #define _ASM_X86_PGTABLE_3LEVEL_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 typedef u64	pteval_t;
@@ -25,7 +25,7 @@ typedef union {
 	};
 	pmdval_t pmd;
 } pmd_t;
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 
diff --git a/arch/x86/include/asm/pgtable-invert.h b/arch/x86/include/asm/pgtable-invert.h
index a0c1525..e12e52a 100644
--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PGTABLE_INVERT_H
 #define _ASM_PGTABLE_INVERT_H 1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * A clear pte value is special, and doesn't get inverted.
@@ -36,6 +36,6 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
 	return val;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10a..7bd6bd6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -15,7 +15,7 @@
 		     cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS)))	\
 	 : (prot))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
@@ -973,7 +973,7 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 }
 #endif  /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 
 #ifdef CONFIG_X86_32
@@ -982,7 +982,7 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 # include <asm/pgtable_64.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/mm_types.h>
 #include <linux/mmdebug.h>
 #include <linux/log2.h>
@@ -1233,12 +1233,12 @@ static inline int pgd_none(pgd_t pgd)
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define KERNEL_PGD_BOUNDARY	pgd_index(PAGE_OFFSET)
 #define KERNEL_PGD_PTRS		(PTRS_PER_PGD - KERNEL_PGD_BOUNDARY)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern int direct_gbpages;
 void init_mem_mapping(void);
@@ -1812,6 +1812,6 @@ bool arch_is_platform_page(u64 paddr);
 	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
 	set_pgd(pgdp, pgd); \
 })
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7d4ad89..b612cc5 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -13,7 +13,7 @@
  * This file contains the functions and defines necessary to modify and use
  * the i386 page table tree.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <linux/threads.h>
 #include <asm/paravirt.h>
@@ -45,7 +45,7 @@ do {						\
 	flush_tlb_one_kernel((vaddr));		\
 } while (0)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * This is used to calculate the .brk reservation for initial pagetables.
diff --git a/arch/x86/include/asm/pgtable_32_areas.h b/arch/x86/include/asm/pgtable_32_areas.h
index b635541..921148b 100644
--- a/arch/x86/include/asm/pgtable_32_areas.h
+++ b/arch/x86/include/asm/pgtable_32_areas.h
@@ -13,7 +13,7 @@
  */
 #define VMALLOC_OFFSET	(8 * 1024 * 1024)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern bool __vmalloc_start_set; /* set once high_memory is set */
 #endif
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index d1426b6..b89f8f1 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -5,7 +5,7 @@
 #include <linux/const.h>
 #include <asm/pgtable_64_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This file contains the functions and defines necessary to modify and use
@@ -270,7 +270,7 @@ static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 
 #include <asm/pgtable-invert.h>
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
@@ -291,5 +291,5 @@ L3_START_KERNEL = pud_index(__START_KERNEL_map)
 	i = i + 1 ;					\
 	.endr
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PGTABLE_64_H */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index ec68f83..5bb782d 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -4,7 +4,7 @@
 
 #include <asm/sparsemem.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <asm/kaslr.h>
 
@@ -44,7 +44,7 @@ static inline bool pgtable_l5_enabled(void)
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	0
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index c90e9c5..b2ed819 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -166,7 +166,7 @@
  * to have the WB mode at index 0 (all bits clear). This is the default
  * right now and likely would break too much if changed.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 enum page_cache_mode {
 	_PAGE_CACHE_MODE_WB       = 0,
 	_PAGE_CACHE_MODE_WC       = 1,
@@ -241,7 +241,7 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
 #define __PAGE_KERNEL_ENC_WP	(__PAGE_KERNEL_WP | _ENC)
@@ -264,7 +264,7 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 /*
  * early identity mapping  pte attrib macros.
@@ -283,7 +283,7 @@ enum page_cache_mode {
 # include <asm/pgtable_64_types.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -582,6 +582,6 @@ extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
 					  unsigned long page_flags);
 extern int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 					    unsigned long numpages);
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 365798c..5d0dbab 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -8,7 +8,7 @@
 
 #ifndef _ASM_X86_PROM_H
 #define _ASM_X86_PROM_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/of.h>
 #include <linux/types.h>
@@ -33,5 +33,5 @@ static inline void x86_flattree_get_config(void) { }
 
 extern char cmd_line[COMMAND_LINE_SIZE];
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index ab167c9..88d0a1a 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
@@ -11,5 +11,5 @@ extern void pti_finalize(void);
 static inline void pti_check_boottime_disable(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PTI_H */
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5a83fbd..50f7546 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -6,7 +6,7 @@
 #include <asm/page_types.h>
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef __i386__
 
 struct pt_regs {
@@ -469,5 +469,5 @@ extern int do_set_thread_area(struct task_struct *p, int idx,
 # define do_set_thread_area_64(p, s, t)	(0)
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_PTRACE_H */
diff --git a/arch/x86/include/asm/purgatory.h b/arch/x86/include/asm/purgatory.h
index 5528e93..2fee5e9 100644
--- a/arch/x86/include/asm/purgatory.h
+++ b/arch/x86/include/asm/purgatory.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_PURGATORY_H
 #define _ASM_X86_PURGATORY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/purgatory.h>
 
 extern void purgatory(void);
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* _ASM_PURGATORY_H */
diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/asm/pvclock-abi.h
index 1436226..b9fece5 100644
--- a/arch/x86/include/asm/pvclock-abi.h
+++ b/arch/x86/include/asm/pvclock-abi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PVCLOCK_ABI_H
 #define _ASM_X86_PVCLOCK_ABI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * These structs MUST NOT be changed.
@@ -44,5 +44,5 @@ struct pvclock_wall_clock {
 #define PVCLOCK_GUEST_STOPPED	(1 << 1)
 /* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
 #define PVCLOCK_COUNTS_FROM_ZERO (1 << 2)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PVCLOCK_ABI_H */
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 87e5482..f607081 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -9,7 +9,7 @@
 #define TH_FLAGS_SME_ACTIVE_BIT		0
 #define TH_FLAGS_SME_ACTIVE		BIT(TH_FLAGS_SME_ACTIVE_BIT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/io.h>
@@ -95,6 +95,6 @@ void reserve_real_mode(void);
 void load_trampoline_pgtable(void);
 void init_real_mode(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ARCH_X86_REALMODE_H */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c..77d8f49 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -233,7 +233,7 @@
 #define VDSO_CPUNODE_BITS		12
 #define VDSO_CPUNODE_MASK		0xfff
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Helper functions to store/load CPU and node numbers */
 
@@ -265,7 +265,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 		*node = (p >> VDSO_CPUNODE_BITS);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef __KERNEL__
 
@@ -286,7 +286,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
  */
 #define XEN_EARLY_IDT_HANDLER_SIZE (8 + ENDBR_INSN_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern const char early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
 extern void early_ignore_irq(void);
@@ -350,7 +350,7 @@ static inline void __loadsegment_fs(unsigned short value)
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SEGMENT_H */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a8d676b..ad9212d 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -27,7 +27,7 @@
 #define OLD_CL_ADDRESS		0x020	/* Relative to real mode data */
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cache.h>
 
 #include <asm/bootparam.h>
@@ -142,7 +142,7 @@ extern bool builtin_cmdline_added __ro_after_init;
 #define builtin_cmdline_added 0
 #endif
 
-#else  /* __ASSEMBLY */
+#else  /* __ASSEMBLER__ */
 
 .macro __RESERVE_BRK name, size
 	.pushsection .bss..brk, "aw"
@@ -154,6 +154,6 @@ SYM_DATA_END(__brk_\name)
 
 #define RESERVE_BRK(name, size) __RESERVE_BRK name, size
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/include/asm/setup_data.h b/arch/x86/include/asm/setup_data.h
index 77c5111..7bb16f8 100644
--- a/arch/x86/include/asm/setup_data.h
+++ b/arch/x86/include/asm/setup_data.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/setup_data.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct pci_setup_rom {
 	struct setup_data data;
@@ -27,6 +27,6 @@ struct efi_setup_data {
 	u64 reserved[8];
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_DATA_H */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fcbbef4..a28ff6b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -106,7 +106,7 @@
 #define TDX_PS_1G	2
 #define TDX_PS_NR	(TDX_PS_1G + 1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_attributes.h>
 
@@ -177,5 +177,5 @@ static __always_inline u64 hcall_func(u64 exit_reason)
         return exit_reason;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 4cb77e0..ba6f2fe 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_SHSTK_H
 #define _ASM_X86_SHSTK_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 struct task_struct;
@@ -37,6 +37,6 @@ static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 4a4043c..c72d461 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_SIGNAL_H
 #define _ASM_X86_SIGNAL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/linkage.h>
 
 /* Most things should be clean enough to redefine this at will, if care
@@ -28,9 +28,9 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #include <uapi/asm/signal.h>
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __ARCH_HAS_SA_RESTORER
 
@@ -101,5 +101,5 @@ struct pt_regs;
 
 #endif /* !__i386__ */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_SIGNAL_H */
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 2de1e5a..daea94c 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -13,7 +13,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define ASM_CLAC \
 	ALTERNATIVE "", "clac", X86_FEATURE_SMAP
@@ -21,7 +21,7 @@
 #define ASM_STAC \
 	ALTERNATIVE "", "stac", X86_FEATURE_SMAP
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 static __always_inline void clac(void)
 {
@@ -61,6 +61,6 @@ static __always_inline void smap_restore(unsigned long flags)
 #define ASM_STAC \
 	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SMAP_H */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index bcfa002..0c1c680 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_SMP_H
 #define _ASM_X86_SMP_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
@@ -171,7 +171,7 @@ extern void nmi_selftest(void);
 extern unsigned int smpboot_control;
 extern unsigned long apic_mmio_base;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* Control bits for startup_64 */
 #define STARTUP_READ_APICID	0x80000000
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16da..65394aa 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -30,7 +30,7 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
 
@@ -126,5 +126,5 @@ static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a55c214..9282465 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -54,7 +54,7 @@
  * - this struct should fit entirely inside of one cache line
  * - this struct shares the supervisor stack pages
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct task_struct;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
@@ -73,7 +73,7 @@ struct thread_info {
 	.flags		= 0,			\
 }
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #include <asm/asm-offsets.h>
 
@@ -161,7 +161,7 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Walks up the stack frames to make sure that the specified object is
@@ -213,7 +213,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 }
 
-#endif  /* !__ASSEMBLY__ */
+#endif  /* !__ASSEMBLER__ */
 
 /*
  * Thread-synchronous status.
@@ -224,7 +224,7 @@ static inline int arch_within_stack_frames(const void * const stack,
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
 
@@ -242,6 +242,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 
 extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 85cc57c..8f4579c 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -5,7 +5,7 @@
 
 #include "orc_types.h"
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro UNWIND_HINT_END_OF_STACK
 	UNWIND_HINT type=UNWIND_HINT_TYPE_END_OF_STACK
@@ -88,6 +88,6 @@
 #define UNWIND_HINT_RESTORE \
 	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index 2bf9c0e..785f8ed 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_GETRANDOM_H
 #define __ASM_VDSO_GETRANDOM_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/unistd.h>
 
@@ -37,6 +37,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void
 	return &vdso_rng_data;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 375a34b..428f3f4 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <uapi/linux/time.h>
 #include <asm/vgtod.h>
@@ -350,6 +350,6 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, 
 }
 #define vdso_calc_ns vdso_calc_ns
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 2cbce97..c9b2ba7 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_PROCESSOR_H
 #define __ASM_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static __always_inline void rep_nop(void)
@@ -22,6 +22,6 @@ struct getcpu_cache;
 
 notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 37b4a70..72aedeb 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -9,7 +9,7 @@
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
@@ -36,6 +36,6 @@ struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
index baca0b0..a078a2b 100644
--- a/arch/x86/include/asm/xen/interface.h
+++ b/arch/x86/include/asm/xen/interface.h
@@ -72,7 +72,7 @@
 #endif
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* Explicitly size integers that represent pfns in the public interface
  * with Xen so that on ARM we can have one ABI that works for 32 and 64
  * bit guests. */
@@ -137,7 +137,7 @@ DEFINE_GUEST_HANDLE(xen_ulong_t);
 #define TI_SET_DPL(_ti, _dpl)	((_ti)->flags |= (_dpl))
 #define TI_SET_IF(_ti, _if)	((_ti)->flags |= ((!!(_if))<<2))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct trap_info {
     uint8_t       vector;  /* exception vector                              */
     uint8_t       flags;   /* 0-3: privilege level; 4: clear event enable?  */
@@ -186,7 +186,7 @@ struct arch_shared_info {
 	uint32_t wc_sec_hi;
 #endif
 };
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_X86_32
 #include <asm/xen/interface_32.h>
@@ -196,7 +196,7 @@ struct arch_shared_info {
 
 #include <asm/pvclock-abi.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * The following is all CPU context. Note that the fpu_ctxt block is filled
  * in by FXSAVE if the CPU has feature FXSR; otherwise FSAVE is used.
@@ -376,7 +376,7 @@ struct xen_pmu_arch {
 	} c;
 };
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 /*
  * Prefix forces emulation of some non-trapping instructions.
diff --git a/arch/x86/include/asm/xen/interface_32.h b/arch/x86/include/asm/xen/interface_32.h
index dc40578..74d9768 100644
--- a/arch/x86/include/asm/xen/interface_32.h
+++ b/arch/x86/include/asm/xen/interface_32.h
@@ -44,7 +44,7 @@
  */
 #define __HYPERVISOR_VIRT_START 0xF5800000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct cpu_user_regs {
     uint32_t ebx;
@@ -85,7 +85,7 @@ typedef struct xen_callback xen_callback_t;
 
 #define XEN_CALLBACK(__cs, __eip)				\
 	((struct xen_callback){ .cs = (__cs), .eip = (unsigned long)(__eip) })
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 /*
diff --git a/arch/x86/include/asm/xen/interface_64.h b/arch/x86/include/asm/xen/interface_64.h
index c10f279..38a19ed 100644
--- a/arch/x86/include/asm/xen/interface_64.h
+++ b/arch/x86/include/asm/xen/interface_64.h
@@ -77,7 +77,7 @@
 #define VGCF_in_syscall  (1<<_VGCF_in_syscall)
 #define VGCF_IN_SYSCALL  VGCF_in_syscall
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct iret_context {
     /* Top of stack (%rsp at point of hypercall). */
@@ -143,7 +143,7 @@ typedef unsigned long xen_callback_t;
 #define XEN_CALLBACK(__cs, __rip)				\
 	((unsigned long)(__rip))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 #endif /* _ASM_X86_XEN_INTERFACE_64_H */
diff --git a/arch/x86/math-emu/control_w.h b/arch/x86/math-emu/control_w.h
index 60f4dcc..93cbc89 100644
--- a/arch/x86/math-emu/control_w.h
+++ b/arch/x86/math-emu/control_w.h
@@ -11,7 +11,7 @@
 #ifndef _CONTROLW_H_
 #define _CONTROLW_H_
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	_Const_(x)	$##x
 #else
 #define	_Const_(x)	x
diff --git a/arch/x86/math-emu/exception.h b/arch/x86/math-emu/exception.h
index 75230b9..59961d3 100644
--- a/arch/x86/math-emu/exception.h
+++ b/arch/x86/math-emu/exception.h
@@ -10,7 +10,7 @@
 #ifndef _EXCEPTION_H_
 #define _EXCEPTION_H_
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	Const_(x)	$##x
 #else
 #define	Const_(x)	x
@@ -37,7 +37,7 @@
 #define PRECISION_LOST_UP    Const_((EX_Precision | SW_C1))
 #define PRECISION_LOST_DOWN  Const_(EX_Precision)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef DEBUG
 #define	EXCEPTION(x)	{ printk("exception in %s at line %d\n", \
@@ -46,6 +46,6 @@
 #define	EXCEPTION(x)	FPU_exception(x)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _EXCEPTION_H_ */
diff --git a/arch/x86/math-emu/fpu_emu.h b/arch/x86/math-emu/fpu_emu.h
index 0c12222..def569c 100644
--- a/arch/x86/math-emu/fpu_emu.h
+++ b/arch/x86/math-emu/fpu_emu.h
@@ -20,7 +20,7 @@
  */
 #define PECULIAR_486
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include "fpu_asm.h"
 #define	Const(x)	$##x
 #else
@@ -68,7 +68,7 @@
 
 #define FPU_Exception   Const(0x80000000)	/* Added to tag returns. */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include "fpu_system.h"
 
@@ -213,6 +213,6 @@ asmlinkage int FPU_round(FPU_REG *arg, unsigned int extent, int dummy,
 #include "fpu_proto.h"
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _FPU_EMU_H_ */
diff --git a/arch/x86/math-emu/status_w.h b/arch/x86/math-emu/status_w.h
index b77bafe..f642957 100644
--- a/arch/x86/math-emu/status_w.h
+++ b/arch/x86/math-emu/status_w.h
@@ -13,7 +13,7 @@
 
 #include "fpu_emu.h"		/* for definition of PECULIAR_486 */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	Const__(x)	$##x
 #else
 #define	Const__(x)	x
@@ -37,7 +37,7 @@
 
 #define SW_Exc_Mask     Const__(0x27f)	/* Status word exception bit mask */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define COMP_A_gt_B	1
 #define COMP_A_eq_B	2
@@ -63,6 +63,6 @@ static inline void setcc(int cc)
 #  define clear_C1()
 #endif /* PECULIAR_486 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _STATUS_H_ */
diff --git a/arch/x86/realmode/rm/realmode.h b/arch/x86/realmode/rm/realmode.h
index c76041a..867e55f 100644
--- a/arch/x86/realmode/rm/realmode.h
+++ b/arch/x86/realmode/rm/realmode.h
@@ -2,7 +2,7 @@
 #ifndef ARCH_X86_REALMODE_RM_REALMODE_H
 #define ARCH_X86_REALMODE_RM_REALMODE_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * 16-bit ljmpw to the real_mode_seg
@@ -12,7 +12,7 @@
  */
 #define LJMPW_RM(to)	.byte 0xea ; .word (to), real_mode_seg
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Signature at the end of the realmode region
diff --git a/arch/x86/realmode/rm/wakeup.h b/arch/x86/realmode/rm/wakeup.h
index 0e4fd08..3b6d8fa 100644
--- a/arch/x86/realmode/rm/wakeup.h
+++ b/arch/x86/realmode/rm/wakeup.h
@@ -7,7 +7,7 @@
 #ifndef ARCH_X86_KERNEL_ACPI_RM_WAKEUP_H
 #define ARCH_X86_KERNEL_ACPI_RM_WAKEUP_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 /* This must match data at wakeup.S */
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index 3ad3da9..dbe39b4 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_ASM_H
 #define _ASM_X86_ASM_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
@@ -123,7 +123,7 @@
 #ifdef __KERNEL__
 
 /* Exception table entry */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
@@ -154,7 +154,7 @@
 #  define _ASM_NOKPROBE(entry)
 # endif
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
@@ -186,7 +186,7 @@
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 
diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
index 1c1b755..cd94221 100644
--- a/tools/arch/x86/include/asm/nops.h
+++ b/tools/arch/x86/include/asm/nops.h
@@ -82,7 +82,7 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern const unsigned char * const x86_nops[];
 #endif
 
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 46d7e06..e0125af 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -45,7 +45,7 @@
 #define ORC_TYPE_REGS			3
 #define ORC_TYPE_REGS_PARTIAL		4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/byteorder.h>
 
 /*
@@ -73,6 +73,6 @@ struct orc_entry {
 #endif
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/tools/arch/x86/include/asm/pvclock-abi.h b/tools/arch/x86/include/asm/pvclock-abi.h
index 1436226..b9fece5 100644
--- a/tools/arch/x86/include/asm/pvclock-abi.h
+++ b/tools/arch/x86/include/asm/pvclock-abi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PVCLOCK_ABI_H
 #define _ASM_X86_PVCLOCK_ABI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * These structs MUST NOT be changed.
@@ -44,5 +44,5 @@ struct pvclock_wall_clock {
 #define PVCLOCK_GUEST_STOPPED	(1 << 1)
 /* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
 #define PVCLOCK_COUNTS_FROM_ZERO (1 << 2)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PVCLOCK_ABI_H */

