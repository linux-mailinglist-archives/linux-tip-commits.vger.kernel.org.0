Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC23433C506
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhCOSAU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 14:00:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCOSAP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 14:00:15 -0400
Date:   Mon, 15 Mar 2021 18:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615831213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mfXKU+sxtaVwSRLbt2aKhKWQQBz/7faKN8TJOzurlg=;
        b=wKFsx++v250oY8pimKnwIGexUSWCbvQiD4iG6SvN66v5sWYWlPGmJVLNR2CoObOTeVgpj3
        yULkJfj58DwX69VUFF8oP1Wvl3dGHFnKGfIObLIwI4Ah06bWFwp92OGXGsGVhxlsDoTqjw
        g6xThlFcS9PZihsKdYKxOi0Ep5RCqhrmmamjgQatWssfE3hYBdU8zzGnjUOimmUQ996+Qy
        PCxbrt9NZQsjBILpaMXQSVsGNoFoyrVEjguJimJZwAfWgoEBqIH35QMlDFtZrVqH1aCUDR
        ohxWXPvzYs3/bBBvhL0WeyLPT1XkEyekQkOZtvZWoR+78JYr0uLbQQREwH3qvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615831213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mfXKU+sxtaVwSRLbt2aKhKWQQBz/7faKN8TJOzurlg=;
        b=B/GPugthlqDnEOQ0c+/VpUOU5MaFJ44QVY5JOE4LirHQ4xtJmLsKns5/L93gF35DmHrojY
        fSh2EIzwu2T6G5Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86: Remove dynamic NOP selection
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210312115749.065275711@infradead.org>
References: <20210312115749.065275711@infradead.org>
MIME-Version: 1.0
Message-ID: <161583121254.398.3601139132767557886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6
Gitweb:        https://git.kernel.org/tip/a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 12 Mar 2021 12:32:54 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 16:24:59 +01:00

x86: Remove dynamic NOP selection

This ensures that a NOP is a NOP and not a random other instruction that
is also a NOP. It allows simplification of dynamic code patching that
wants to verify existing code before writing new instructions (ftrace,
jump_label, static_call, etc..).

Differentiating on NOPs is not a feature.

This pessimises 32bit (DONTCARE) and 32bit on 64bit CPUs (CARELESS).
32bit is not a performance target.

Everything x86_64 since AMD K10 (2007) and Intel IvyBridge (2012) is
fine with using NOPL (as opposed to prefix NOP). And per FEATURE_NOPL
being required for x86_64, all x86_64 CPUs can use NOPL. So stop
caring about NOPs, simplify things and get on with life.

[ The problem seems to be that some uarchs can only decode NOPL on a
single front-end port while others have severe decode penalties for
excessive prefixes. All modern uarchs can handle both, except Atom,
which has prefix penalties. ]

[ Also, much doubt you can actually measure any of this on normal
workloads. ]

After this, FEATURE_NOPL is unused except for required-features for
x86_64. FEATURE_K8 is only used for PTI.

 [ bp: Kernel build measurements showed ~0.3s slowdown on Sandybridge
   which is hardly a slowdown. Get rid of X86_FEATURE_K7, while at it. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com> # bpf
Acked-by: Linus Torvalds <torvalds@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20210312115749.065275711@infradead.org
---
 arch/x86/include/asm/cpufeatures.h   |   2 +-
 arch/x86/include/asm/jump_label.h    |  12 +--
 arch/x86/include/asm/nops.h          | 176 +++++++----------------
 arch/x86/include/asm/special_insns.h |   4 +-
 arch/x86/kernel/alternative.c        | 198 ++------------------------
 arch/x86/kernel/cpu/amd.c            |   5 +-
 arch/x86/kernel/ftrace.c             |   4 +-
 arch/x86/kernel/jump_label.c         |  32 +----
 arch/x86/kernel/kprobes/core.c       |   2 +-
 arch/x86/kernel/setup.c              |   1 +-
 arch/x86/kernel/static_call.c        |   4 +-
 arch/x86/net/bpf_jit_comp.c          |   8 +-
 12 files changed, 97 insertions(+), 351 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26..8afa318 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -84,7 +84,7 @@
 
 /* CPU types for specific tunings: */
 #define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
-#define X86_FEATURE_K7			( 3*32+ 5) /* "" Athlon */
+/* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
 #define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
 #define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant rate */
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 06c3cc2..5ce342b 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -6,12 +6,6 @@
 
 #define JUMP_LABEL_NOP_SIZE 5
 
-#ifdef CONFIG_X86_64
-# define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
-#else
-# define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
-#endif
-
 #include <asm/asm.h>
 #include <asm/nops.h>
 
@@ -23,7 +17,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".byte " __stringify(BYTES_NOP5) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
@@ -63,7 +57,7 @@ l_yes:
 	.long		\target - .Lstatic_jump_after_\@
 .Lstatic_jump_after_\@:
 	.else
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		BYTES_NOP5
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
@@ -75,7 +69,7 @@ l_yes:
 .macro STATIC_JUMP_IF_FALSE target, key, def
 .Lstatic_jump_\@:
 	.if \def
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		BYTES_NOP5
 	.else
 	/* Equivalent to "jmp.d32 \target" */
 	.byte		0xe9
diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index 12f12b5..c1e5e81 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -4,89 +4,58 @@
 
 /*
  * Define nops for use with alternative() and for tracing.
- *
- * *_NOP5_ATOMIC must be a single instruction.
  */
 
-#define NOP_DS_PREFIX 0x3e
+#ifndef CONFIG_64BIT
 
-/* generic versions from gas
-   1: nop
-   the following instructions are NOT nops in 64-bit mode,
-   for 64-bit mode use K8 or P6 nops instead
-   2: movl %esi,%esi
-   3: leal 0x00(%esi),%esi
-   4: leal 0x00(,%esi,1),%esi
-   6: leal 0x00000000(%esi),%esi
-   7: leal 0x00000000(,%esi,1),%esi
-*/
-#define GENERIC_NOP1 0x90
-#define GENERIC_NOP2 0x89,0xf6
-#define GENERIC_NOP3 0x8d,0x76,0x00
-#define GENERIC_NOP4 0x8d,0x74,0x26,0x00
-#define GENERIC_NOP5 GENERIC_NOP1,GENERIC_NOP4
-#define GENERIC_NOP6 0x8d,0xb6,0x00,0x00,0x00,0x00
-#define GENERIC_NOP7 0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
-#define GENERIC_NOP8 GENERIC_NOP1,GENERIC_NOP7
-#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
+/*
+ * Generic 32bit nops from GAS:
+ *
+ * 1: nop
+ * 2: movl %esi,%esi
+ * 3: leal 0x0(%esi),%esi
+ * 4: leal 0x0(%esi,%eiz,1),%esi
+ * 5: leal %ds:0x0(%esi,%eiz,1),%esi
+ * 6: leal 0x0(%esi),%esi
+ * 7: leal 0x0(%esi,%eiz,1),%esi
+ * 8: leal %ds:0x0(%esi,%eiz,1),%esi
+ *
+ * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
+ * nop instructions.
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x89,0xf6
+#define BYTES_NOP3	0x8d,0x76,0x00
+#define BYTES_NOP4	0x8d,0x74,0x26,0x00
+#define BYTES_NOP5	0x3e,BYTES_NOP4
+#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
+#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x3e,BYTES_NOP7
 
-/* Opteron 64bit nops
-   1: nop
-   2: osp nop
-   3: osp osp nop
-   4: osp osp osp nop
-*/
-#define K8_NOP1 GENERIC_NOP1
-#define K8_NOP2	0x66,K8_NOP1
-#define K8_NOP3	0x66,K8_NOP2
-#define K8_NOP4	0x66,K8_NOP3
-#define K8_NOP5	K8_NOP3,K8_NOP2
-#define K8_NOP6	K8_NOP3,K8_NOP3
-#define K8_NOP7	K8_NOP4,K8_NOP3
-#define K8_NOP8	K8_NOP4,K8_NOP4
-#define K8_NOP5_ATOMIC 0x66,K8_NOP4
+#else
 
-/* K7 nops
-   uses eax dependencies (arbitrary choice)
-   1: nop
-   2: movl %eax,%eax
-   3: leal (,%eax,1),%eax
-   4: leal 0x00(,%eax,1),%eax
-   6: leal 0x00000000(%eax),%eax
-   7: leal 0x00000000(,%eax,1),%eax
-*/
-#define K7_NOP1	GENERIC_NOP1
-#define K7_NOP2	0x8b,0xc0
-#define K7_NOP3	0x8d,0x04,0x20
-#define K7_NOP4	0x8d,0x44,0x20,0x00
-#define K7_NOP5	K7_NOP4,K7_NOP1
-#define K7_NOP6	0x8d,0x80,0,0,0,0
-#define K7_NOP7	0x8D,0x04,0x05,0,0,0,0
-#define K7_NOP8	K7_NOP7,K7_NOP1
-#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
+/*
+ * Generic 64bit nops from GAS:
+ *
+ * 1: nop
+ * 2: osp nop
+ * 3: nopl (%eax)
+ * 4: nopl 0x00(%eax)
+ * 5: nopl 0x00(%eax,%eax,1)
+ * 6: osp nopl 0x00(%eax,%eax,1)
+ * 7: nopl 0x00000000(%eax)
+ * 8: nopl 0x00000000(%eax,%eax,1)
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x66,BYTES_NOP1
+#define BYTES_NOP3	0x0f,0x1f,0x00
+#define BYTES_NOP4	0x0f,0x1f,0x40,0x00
+#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
+#define BYTES_NOP6	0x66,BYTES_NOP5
+#define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
 
-/* P6 nops
-   uses eax dependencies (Intel-recommended choice)
-   1: nop
-   2: osp nop
-   3: nopl (%eax)
-   4: nopl 0x00(%eax)
-   5: nopl 0x00(%eax,%eax,1)
-   6: osp nopl 0x00(%eax,%eax,1)
-   7: nopl 0x00000000(%eax)
-   8: nopl 0x00000000(%eax,%eax,1)
-   Note: All the above are assumed to be a single instruction.
-	There is kernel code that depends on this.
-*/
-#define P6_NOP1	GENERIC_NOP1
-#define P6_NOP2	0x66,0x90
-#define P6_NOP3	0x0f,0x1f,0x00
-#define P6_NOP4	0x0f,0x1f,0x40,0
-#define P6_NOP5	0x0f,0x1f,0x44,0x00,0
-#define P6_NOP6	0x66,0x0f,0x1f,0x44,0x00,0
-#define P6_NOP7	0x0f,0x1f,0x80,0,0,0,0
-#define P6_NOP8	0x0f,0x1f,0x84,0x00,0,0,0,0
-#define P6_NOP5_ATOMIC P6_NOP5
+#endif /* CONFIG_64BIT */
 
 #ifdef __ASSEMBLY__
 #define _ASM_MK_NOP(x) .byte x
@@ -94,54 +63,19 @@
 #define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
 #endif
 
-#if defined(CONFIG_MK7)
-#define ASM_NOP1 _ASM_MK_NOP(K7_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K7_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K7_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K7_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K7_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K7_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K7_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K7_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K7_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_P6_NOP)
-#define ASM_NOP1 _ASM_MK_NOP(P6_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(P6_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(P6_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(P6_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(P6_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(P6_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(P6_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(P6_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(P6_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_64)
-#define ASM_NOP1 _ASM_MK_NOP(K8_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K8_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K8_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K8_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K8_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K8_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K8_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K8_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K8_NOP5_ATOMIC)
-#else
-#define ASM_NOP1 _ASM_MK_NOP(GENERIC_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(GENERIC_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(GENERIC_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(GENERIC_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(GENERIC_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(GENERIC_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(GENERIC_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(GENERIC_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(GENERIC_NOP5_ATOMIC)
-#endif
+#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
+#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
+#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
+#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
+#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
+#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
+#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
+#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
-#define NOP_ATOMIC5 (ASM_NOP_MAX+1)	/* Entry for the 5-byte atomic NOP */
 
 #ifndef __ASSEMBLY__
-extern const unsigned char * const *ideal_nops;
-extern void arch_init_ideal_nops(void);
+extern const unsigned char * const x86_nops[];
 #endif
 
 #endif /* _ASM_X86_NOPS_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 1d3cbae..2acd6cb 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -214,7 +214,7 @@ static inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte " __stringify(NOP_DS_PREFIX) "; clflush %P0",
+	alternative_io(".byte 0x3e; clflush %P0",
 		       ".byte 0x66; clflush %P0",
 		       X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
@@ -225,7 +225,7 @@ static inline void clwb(volatile void *__p)
 	volatile struct { char x[64]; } *p = __p;
 
 	asm volatile(ALTERNATIVE_2(
-		".byte " __stringify(NOP_DS_PREFIX) "; clflush (%[pax])",
+		".byte 0x3e; clflush (%[pax])",
 		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
 		X86_FEATURE_CLFLUSHOPT,
 		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8d778e4..fcac875 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -74,186 +74,30 @@ do {									\
 	}								\
 } while (0)
 
-/*
- * Each GENERIC_NOPX is of X bytes, and defined as an array of bytes
- * that correspond to that nop. Getting from one nop to the next, we
- * add to the array the offset that is equal to the sum of all sizes of
- * nops preceding the one we are after.
- *
- * Note: The GENERIC_NOP5_ATOMIC is at the end, as it breaks the
- * nice symmetry of sizes of the previous nops.
- */
-#if defined(GENERIC_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char intelnops[] =
+const unsigned char x86nops[] =
 {
-	GENERIC_NOP1,
-	GENERIC_NOP2,
-	GENERIC_NOP3,
-	GENERIC_NOP4,
-	GENERIC_NOP5,
-	GENERIC_NOP6,
-	GENERIC_NOP7,
-	GENERIC_NOP8,
-	GENERIC_NOP5_ATOMIC
-};
-static const unsigned char * const intel_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	intelnops,
-	intelnops + 1,
-	intelnops + 1 + 2,
-	intelnops + 1 + 2 + 3,
-	intelnops + 1 + 2 + 3 + 4,
-	intelnops + 1 + 2 + 3 + 4 + 5,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	BYTES_NOP1,
+	BYTES_NOP2,
+	BYTES_NOP3,
+	BYTES_NOP4,
+	BYTES_NOP5,
+	BYTES_NOP6,
+	BYTES_NOP7,
+	BYTES_NOP8,
 };
-#endif
 
-#ifdef K8_NOP1
-static const unsigned char k8nops[] =
-{
-	K8_NOP1,
-	K8_NOP2,
-	K8_NOP3,
-	K8_NOP4,
-	K8_NOP5,
-	K8_NOP6,
-	K8_NOP7,
-	K8_NOP8,
-	K8_NOP5_ATOMIC
-};
-static const unsigned char * const k8_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k8nops,
-	k8nops + 1,
-	k8nops + 1 + 2,
-	k8nops + 1 + 2 + 3,
-	k8nops + 1 + 2 + 3 + 4,
-	k8nops + 1 + 2 + 3 + 4 + 5,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#if defined(K7_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char k7nops[] =
-{
-	K7_NOP1,
-	K7_NOP2,
-	K7_NOP3,
-	K7_NOP4,
-	K7_NOP5,
-	K7_NOP6,
-	K7_NOP7,
-	K7_NOP8,
-	K7_NOP5_ATOMIC
-};
-static const unsigned char * const k7_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k7nops,
-	k7nops + 1,
-	k7nops + 1 + 2,
-	k7nops + 1 + 2 + 3,
-	k7nops + 1 + 2 + 3 + 4,
-	k7nops + 1 + 2 + 3 + 4 + 5,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#ifdef P6_NOP1
-static const unsigned char p6nops[] =
-{
-	P6_NOP1,
-	P6_NOP2,
-	P6_NOP3,
-	P6_NOP4,
-	P6_NOP5,
-	P6_NOP6,
-	P6_NOP7,
-	P6_NOP8,
-	P6_NOP5_ATOMIC
-};
-static const unsigned char * const p6_nops[ASM_NOP_MAX+2] =
+const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 {
 	NULL,
-	p6nops,
-	p6nops + 1,
-	p6nops + 1 + 2,
-	p6nops + 1 + 2 + 3,
-	p6nops + 1 + 2 + 3 + 4,
-	p6nops + 1 + 2 + 3 + 4 + 5,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops,
+	x86nops + 1,
+	x86nops + 1 + 2,
+	x86nops + 1 + 2 + 3,
+	x86nops + 1 + 2 + 3 + 4,
+	x86nops + 1 + 2 + 3 + 4 + 5,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
 };
-#endif
-
-/* Initialize these to a safe default */
-#ifdef CONFIG_X86_64
-const unsigned char * const *ideal_nops = p6_nops;
-#else
-const unsigned char * const *ideal_nops = intel_nops;
-#endif
-
-void __init arch_init_ideal_nops(void)
-{
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_INTEL:
-		/*
-		 * Due to a decoder implementation quirk, some
-		 * specific Intel CPUs actually perform better with
-		 * the "k8_nops" than with the SDM-recommended NOPs.
-		 */
-		if (boot_cpu_data.x86 == 6 &&
-		    boot_cpu_data.x86_model >= 0x0f &&
-		    boot_cpu_data.x86_model != 0x1c &&
-		    boot_cpu_data.x86_model != 0x26 &&
-		    boot_cpu_data.x86_model != 0x27 &&
-		    boot_cpu_data.x86_model < 0x30) {
-			ideal_nops = k8_nops;
-		} else if (boot_cpu_has(X86_FEATURE_NOPL)) {
-			   ideal_nops = p6_nops;
-		} else {
-#ifdef CONFIG_X86_64
-			ideal_nops = k8_nops;
-#else
-			ideal_nops = intel_nops;
-#endif
-		}
-		break;
-
-	case X86_VENDOR_HYGON:
-		ideal_nops = p6_nops;
-		return;
-
-	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 > 0xf) {
-			ideal_nops = p6_nops;
-			return;
-		}
-
-		fallthrough;
-
-	default:
-#ifdef CONFIG_X86_64
-		ideal_nops = k8_nops;
-#else
-		if (boot_cpu_has(X86_FEATURE_K8))
-			ideal_nops = k8_nops;
-		else if (boot_cpu_has(X86_FEATURE_K7))
-			ideal_nops = k7_nops;
-		else
-			ideal_nops = intel_nops;
-#endif
-	}
-}
 
 /* Use this to add nops to a buffer, then text_poke the whole buffer. */
 static void __init_or_module add_nops(void *insns, unsigned int len)
@@ -262,7 +106,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 		unsigned int noplen = len;
 		if (noplen > ASM_NOP_MAX)
 			noplen = ASM_NOP_MAX;
-		memcpy(insns, ideal_nops[noplen], noplen);
+		memcpy(insns, x86_nops[noplen], noplen);
 		insns += noplen;
 		len -= noplen;
 	}
@@ -1302,13 +1146,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	default: /* assume NOP */
 		switch (len) {
 		case 2: /* NOP2 -- emulate as JMP8+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[len], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP8_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP32_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 347a956..2d11384 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -628,11 +628,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_init_amd_mc(c);
 
-#ifdef CONFIG_X86_32
-	if (c->x86 == 6)
-		set_cpu_cap(c, X86_FEATURE_K7);
-#endif
-
 	if (c->x86 >= 0xf)
 		set_cpu_cap(c, X86_FEATURE_K8);
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7edbd5e..1b3ce3b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -66,7 +66,7 @@ int ftrace_arch_code_modify_post_process(void)
 
 static const char *ftrace_nop_replace(void)
 {
-	return ideal_nops[NOP_ATOMIC5];
+	return x86_nops[5];
 }
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
@@ -377,7 +377,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);
+		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
 		if (ret < 0)
 			goto fail;
 	}
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 5ba8477..6a2eb62 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -28,10 +28,8 @@ static void bug_at(const void *ip, int line)
 }
 
 static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
+__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect, *code;
 	const void *addr, *dest;
 	int line;
@@ -41,10 +39,8 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, 
 
 	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
-	if (init) {
-		expect = default_nop; line = __LINE__;
-	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+	if (type == JUMP_LABEL_JMP) {
+		expect = x86_nops[5]; line = __LINE__;
 	} else {
 		expect = code; line = __LINE__;
 	}
@@ -53,7 +49,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, 
 		bug_at(addr, line);
 
 	if (type == JUMP_LABEL_NOP)
-		code = ideal_nop;
+		code = x86_nops[5];
 
 	return code;
 }
@@ -62,7 +58,7 @@ static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type, init);
+	const void *opcode = __jump_label_set_jump_code(entry, type);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -113,7 +109,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type, 0);
+	opcode = __jump_label_set_jump_code(entry, type);
 	text_poke_queue((void *)jump_entry_code(entry),
 			opcode, JUMP_LABEL_NOP_SIZE, NULL);
 	mutex_unlock(&text_mutex);
@@ -136,22 +132,6 @@ static enum {
 __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 				      enum jump_label_type type)
 {
-	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
-	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
 	if (jlstate == JL_STATE_UPDATE)
 		jump_label_transform(entry, type, 1);
 }
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cd..6356834 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -229,7 +229,7 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 		return 0UL;
 
 	if (faddr)
-		memcpy(buf, ideal_nops[NOP_ATOMIC5], 5);
+		memcpy(buf, x86_nops[5], 5);
 	else
 		buf[0] = kp->opcode;
 	return (unsigned long)buf;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176..3b4b9b2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -822,7 +822,6 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
-	arch_init_ideal_nops();
 	jump_label_init();
 	static_call_init();
 	early_ioremap_init();
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9442c41..ea028e7 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,7 +34,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void 
 		break;
 
 	case NOP:
-		code = ideal_nops[NOP_ATOMIC5];
+		code = x86_nops[5];
 		break;
 
 	case JMP:
@@ -66,7 +66,7 @@ static void __static_call_validate(void *insn, bool tail)
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, x86_nops[5], 5) ||
 		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0e..6aa29c4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -282,7 +282,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], cnt);
+	memcpy(prog, x86_nops[5], cnt);
 	prog += cnt;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
@@ -330,7 +330,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 				void *old_addr, void *new_addr,
 				const bool text_live)
 {
-	const u8 *nop_insn = ideal_nops[NOP_ATOMIC5];
+	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
 	u8 new_insn[X86_PATCH_SIZE];
 	u8 *prog;
@@ -560,7 +560,7 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
+	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	/* out: */
 
@@ -881,7 +881,7 @@ static int emit_nops(u8 **pprog, int len)
 			noplen = ASM_NOP_MAX;
 
 		for (i = 0; i < noplen; i++)
-			EMIT1(ideal_nops[noplen][i]);
+			EMIT1(x86_nops[noplen][i]);
 		len -= noplen;
 	}
 
