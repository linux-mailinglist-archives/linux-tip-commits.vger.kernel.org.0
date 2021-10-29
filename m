Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039F43F85F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhJ2IF0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhJ2IFZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:25 -0400
Date:   Fri, 29 Oct 2021 08:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WoQ8OHw8JjO/6cw7OH4ZBpdaSCugXeB4fG8VmGvB4c=;
        b=xI7UKaoZwMT/X3FdcfSVHBCH3Bol/ndJFw8uI4vdHzdbzmopf7plisNWNYZBI7sAcpkS11
        gTDg5PdV2Mlwj3ZPRmiksqyArkY24DjLNknXww6Bt6LntI87PeeEYMDzactq9spHm6Ci2o
        7u/ofvDI/5kV/ovvlzB5KnijtNLPSoP1xymnpwJHKjvdy1jkM3IN/Bvt4J9RjqNlj9oQwm
        f99TpdPYRP67xDR3Z8BdeVGfDWHUk3E9PQjYVDGi4y0WTI6X7E0gZvdYZStV/LNDUG1hQv
        KhE0ecqX0v9PaGXpvnFLsEX3Tu+ZRTIubZJKUr3AyMXX8AZWq2ezEW9+QmUQ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WoQ8OHw8JjO/6cw7OH4ZBpdaSCugXeB4fG8VmGvB4c=;
        b=tdsapU+WQuVcX1t/r/WIRQGMo7t+dRBuDQIAGmzfuQbxDSzt2af/9B6LZtPerUd1g/k4Ue
        AcYLeLxdrkLxWIBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.614772675@infradead.org>
References: <20211026120310.614772675@infradead.org>
MIME-Version: 1.0
Message-ID: <163549457532.626.11035640160523319073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     87c87ecd00c54ecd677798cb49ef27329e0fab41
Gitweb:        https://git.kernel.org/tip/87c87ecd00c54ecd677798cb49ef27329e0fab41
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:29 +02:00

bpf,x86: Respect X86_FEATURE_RETPOLINE*

Current BPF codegen doesn't respect X86_FEATURE_RETPOLINE* flags and
unconditionally emits a thunk call, this is sub-optimal and doesn't
match the regular, compiler generated, code.

Update the i386 JIT to emit code equal to what the compiler emits for
the regular kernel text (IOW. a plain THUNK call).

Update the x86_64 JIT to emit code similar to the result of compiler
and kernel rewrites as according to X86_FEATURE_RETPOLINE* flags.
Inlining RETPOLINE_AMD (lfence; jmp *%reg) and !RETPOLINE (jmp *%reg),
while doing a THUNK call for RETPOLINE.

This removes the hard-coded retpoline thunks and shrinks the generated
code. Leaving a single retpoline thunk definition in the kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.614772675@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 59 +---------------------------
 arch/x86/net/bpf_jit_comp.c          | 46 ++++++++++-----------
 arch/x86/net/bpf_jit_comp32.c        | 22 ++++++++--
 3 files changed, 41 insertions(+), 86 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e22aedb..cc74dc5 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -316,63 +316,4 @@ static inline void mds_idle_clear_cpu_buffers(void)
 
 #endif /* __ASSEMBLY__ */
 
-/*
- * Below is used in the eBPF JIT compiler and emits the byte sequence
- * for the following assembly:
- *
- * With retpolines configured:
- *
- *    callq do_rop
- *  spec_trap:
- *    pause
- *    lfence
- *    jmp spec_trap
- *  do_rop:
- *    mov %rcx,(%rsp) for x86_64
- *    mov %edx,(%esp) for x86_32
- *    retq
- *
- * Without retpolines configured:
- *
- *    jmp *%rcx for x86_64
- *    jmp *%edx for x86_32
- */
-#ifdef CONFIG_RETPOLINE
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	17
-#  define RETPOLINE_RCX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT4(0x48, 0x89, 0x0C, 0x24); /* mov %rcx,(%rsp) */	\
-	EMIT1(0xC3);             /* retq */			\
-} while (0)
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-do {								\
-	EMIT1_off32(0xE8, 7);	 /* call do_rop */		\
-	/* spec_trap: */					\
-	EMIT2(0xF3, 0x90);       /* pause */			\
-	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
-	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
-	/* do_rop: */						\
-	EMIT3(0x89, 0x14, 0x24); /* mov %edx,(%esp) */		\
-	EMIT1(0xC3);             /* ret */			\
-} while (0)
-# endif
-#else /* !CONFIG_RETPOLINE */
-# ifdef CONFIG_X86_64
-#  define RETPOLINE_RCX_BPF_JIT_SIZE	2
-#  define RETPOLINE_RCX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE1);       /* jmp *%rcx */
-# else /* !CONFIG_X86_64 */
-#  define RETPOLINE_EDX_BPF_JIT()				\
-	EMIT2(0xFF, 0xE2)        /* jmp *%edx */
-# endif
-#endif
-
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b5c5fb4..39c8025 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -387,6 +387,25 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
+#define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
+
+static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+{
+	u8 *prog = *pprog;
+
+#ifdef CONFIG_RETPOLINE
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		EMIT_LFENCE();
+		EMIT2(0xFF, 0xE0 + reg);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+	} else
+#endif
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
 /*
  * Generate the following code:
  *
@@ -468,7 +487,7 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	RETPOLINE_RCX_BPF_JIT();
+	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -1179,8 +1198,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
 			if (boot_cpu_has(X86_FEATURE_XMM2))
-				/* Emit 'lfence' */
-				EMIT3(0x0F, 0xAE, 0xE8);
+				EMIT_LFENCE();
 			break;
 
 			/* ST: *(u8*)(dst_reg + off) = imm */
@@ -2084,24 +2102,6 @@ cleanup:
 	return ret;
 }
 
-static int emit_fallback_jump(u8 **pprog)
-{
-	u8 *prog = *pprog;
-	int err = 0;
-
-#ifdef CONFIG_RETPOLINE
-	/* Note that this assumes the the compiler uses external
-	 * thunks for indirect calls. Both clang and GCC use the same
-	 * naming convention for external thunks.
-	 */
-	err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
-#else
-	EMIT2(0xFF, 0xE2);	/* jmp rdx */
-#endif
-	*pprog = prog;
-	return err;
-}
-
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 {
 	u8 *jg_reloc, *prog = *pprog;
@@ -2123,9 +2123,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 		if (err)
 			return err;
 
-		err = emit_fallback_jump(&prog);	/* jmp thunk/indirect */
-		if (err)
-			return err;
+		emit_indirect_jump(&prog, 2 /* rdx */, prog);
 
 		*pprog = prog;
 		return 0;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 3bfda5f..da9b7cf 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -15,6 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-prototypes.h>
 #include <linux/bpf.h>
 
 /*
@@ -1267,6 +1268,21 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
 	*pprog = prog;
 }
 
+static int emit_jmp_edx(u8 **pprog, u8 *ip)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+#ifdef CONFIG_RETPOLINE
+	EMIT1_off32(0xE9, (u8 *)__x86_indirect_thunk_edx - (ip + 5));
+#else
+	EMIT2(0xFF, 0xE2);
+#endif
+	*pprog = prog;
+
+	return cnt;
+}
+
 /*
  * Generate the following code:
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
@@ -1280,7 +1296,7 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
  *   goto *(prog->bpf_func + prologue_size);
  * out:
  */
-static void emit_bpf_tail_call(u8 **pprog)
+static void emit_bpf_tail_call(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
@@ -1362,7 +1378,7 @@ static void emit_bpf_tail_call(u8 **pprog)
 	 * eax == ctx (1st arg)
 	 * edx == prog->bpf_func + prologue_size
 	 */
-	RETPOLINE_EDX_BPF_JIT();
+	cnt += emit_jmp_edx(&prog, ip + cnt);
 
 	if (jmp_label1 == -1)
 		jmp_label1 = cnt;
@@ -2122,7 +2138,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			break;
 		}
 		case BPF_JMP | BPF_TAIL_CALL:
-			emit_bpf_tail_call(&prog);
+			emit_bpf_tail_call(&prog, image + addrs[i - 1]);
 			break;
 
 		/* cond jump */
