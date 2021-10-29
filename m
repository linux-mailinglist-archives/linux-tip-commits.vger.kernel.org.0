Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7343F860
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhJ2IF1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhJ2IF0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E069C061570;
        Fri, 29 Oct 2021 01:02:58 -0700 (PDT)
Date:   Fri, 29 Oct 2021 08:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+qYG66x9+rmf0tQbhMsEy+x02y9Lori5OZHmyOIF70=;
        b=X9NXYTrAAcdk9F3PjxeGvcoSlG2sfIo438QG8ZWpCSitfyTB9c9+f0h0oyEX8Uewdj6i4s
        l0/4FZvtBYb7fjcmlvbCwg0UZXyVjuQEz4zok6VV3owFcwANGgSIm65Thlqa7IACbLRB+b
        5BOA0VO2CzD++8o+W72BuGTf7lABdaGsx0b2pBGSG0geHu2h0lR5JZeJ5SAjFaB24m/16D
        /5V9EYZtPXex1PW2hds0kuNJ7jFr1rrncnsflj09ehc1FKF1FyWcZbKOJYap+msMzUoXKX
        Rm++sVbqYGAqfnF7J5vPatBfs8+sPAu7sD+0FqQliZPUSr71uov38BIImfTVyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+qYG66x9+rmf0tQbhMsEy+x02y9Lori5OZHmyOIF70=;
        b=80zrXCmsT4PrDExicFvr1NYgeq2a4SfM63sJimKC43lP9HzCNQim13G+kK7ziRDbPtLQFQ
        m/1XRvkDyyzHgXBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] bpf,x86: Simplify computing label offsets
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.552304864@infradead.org>
References: <20211026120310.552304864@infradead.org>
MIME-Version: 1.0
Message-ID: <163549457616.626.8987265279707976612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dceba0817ca329868a15e2e1dd46eb6340b69206
Gitweb:        https://git.kernel.org/tip/dceba0817ca329868a15e2e1dd46eb6340b69206
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:29 +02:00

bpf,x86: Simplify computing label offsets

Take an idea from the 32bit JIT, which uses the multi-pass nature of
the JIT to compute the instruction offsets on a prior pass in order to
compute the relative jump offsets on a later pass.

Application to the x86_64 JIT is slightly more involved because the
offsets depend on program variables (such as callee_regs_used and
stack_depth) and hence the computed offsets need to be kept in the
context of the JIT.

This removes, IMO quite fragile, code that hard-codes the offsets and
tries to compute the length of variable parts of it.

Convert both emit_bpf_tail_call_*() functions which have an out: label
at the end. Additionally emit_bpt_tail_call_direct() also has a poke
table entry, for which it computes the offset from the end (and thus
already relies on the previous pass to have computed addrs[i]), also
convert this to be a forward based offset.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.552304864@infradead.org
---
 arch/x86/net/bpf_jit_comp.c | 123 +++++++++++------------------------
 1 file changed, 42 insertions(+), 81 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7c03af6..b5c5fb4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -224,6 +224,14 @@ static void jit_fill_hole(void *area, unsigned int size)
 
 struct jit_context {
 	int cleanup_addr; /* Epilogue code offset */
+
+	/*
+	 * Program specific offsets of labels in the code; these rely on the
+	 * JIT doing at least 2 passes, recording the position on the first
+	 * pass, only to generate the correct offset on the second pass.
+	 */
+	int tail_call_direct_label;
+	int tail_call_indirect_label;
 };
 
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -379,22 +387,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
-static int get_pop_bytes(bool *callee_regs_used)
-{
-	int bytes = 0;
-
-	if (callee_regs_used[3])
-		bytes += 2;
-	if (callee_regs_used[2])
-		bytes += 2;
-	if (callee_regs_used[1])
-		bytes += 2;
-	if (callee_regs_used[0])
-		bytes += 1;
-
-	return bytes;
-}
-
 /*
  * Generate the following code:
  *
@@ -410,29 +402,12 @@ static int get_pop_bytes(bool *callee_regs_used)
  * out:
  */
 static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth)
+					u32 stack_depth, u8 *ip,
+					struct jit_context *ctx)
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
-	u8 *prog = *pprog;
-	int pop_bytes = 0;
-	int off1 = 42;
-	int off2 = 31;
-	int off3 = 9;
-
-	/* count the additional bytes used for popping callee regs from stack
-	 * that need to be taken into account for each of the offsets that
-	 * are used for bailing out of the tail call
-	 */
-	pop_bytes = get_pop_bytes(callee_regs_used);
-	off1 += pop_bytes;
-	off2 += pop_bytes;
-	off3 += pop_bytes;
-
-	if (stack_depth) {
-		off1 += 7;
-		off2 += 7;
-		off3 += 7;
-	}
+	u8 *prog = *pprog, *start = *pprog;
+	int offset;
 
 	/*
 	 * rdi - pointer to ctx
@@ -447,8 +422,9 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 (off1 + RETPOLINE_RCX_BPF_JIT_SIZE) /* Number of bytes to jump */
-	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
+
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -456,8 +432,9 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 (off2 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JA, OFFSET2);                   /* ja out */
+
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                    /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
 
@@ -470,12 +447,11 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	 *	goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
-#define OFFSET3 (off3 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JE, OFFSET3);                   /* je out */
 
-	*pprog = prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog = *pprog;
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JE, offset);                    /* je out */
+
+	pop_callee_regs(&prog, callee_regs_used);
 
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
@@ -495,38 +471,18 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	RETPOLINE_RCX_BPF_JIT();
 
 	/* out: */
+	ctx->tail_call_indirect_label = prog - start;
 	*pprog = prog;
 }
 
 static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
-				      u8 **pprog, int addr, u8 *image,
-				      bool *callee_regs_used, u32 stack_depth)
+				      u8 **pprog, u8 *ip,
+				      bool *callee_regs_used, u32 stack_depth,
+				      struct jit_context *ctx)
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
-	u8 *prog = *pprog;
-	int pop_bytes = 0;
-	int off1 = 20;
-	int poke_off;
-
-	/* count the additional bytes used for popping callee regs to stack
-	 * that need to be taken into account for jump offset that is used for
-	 * bailing out from of the tail call when limit is reached
-	 */
-	pop_bytes = get_pop_bytes(callee_regs_used);
-	off1 += pop_bytes;
-
-	/*
-	 * total bytes for:
-	 * - nop5/ jmpq $off
-	 * - pop callee regs
-	 * - sub rsp, $val if depth > 0
-	 * - pop rax
-	 */
-	poke_off = X86_PATCH_SIZE + pop_bytes + 1;
-	if (stack_depth) {
-		poke_off += 7;
-		off1 += 7;
-	}
+	u8 *prog = *pprog, *start = *pprog;
+	int offset;
 
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -534,28 +490,30 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
-	EMIT2(X86_JA, off1);                          /* ja out */
+
+	offset = ctx->tail_call_direct_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                        /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
 
-	poke->tailcall_bypass = image + (addr - poke_off - X86_PATCH_SIZE);
+	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
-	poke->tailcall_target = image + (addr - X86_PATCH_SIZE);
+	poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
 	poke->bypass_addr = (u8 *)poke->tailcall_target + X86_PATCH_SIZE;
 
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
-	*pprog = prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog = *pprog;
+	pop_callee_regs(&prog, callee_regs_used);
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
+
 	/* out: */
+	ctx->tail_call_direct_label = prog - start;
 
 	*pprog = prog;
 }
@@ -1411,13 +1369,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, addrs[i], image,
+							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth);
+							  bpf_prog->aux->stack_depth,
+							  ctx);
 			else
 				emit_bpf_tail_call_indirect(&prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth);
+							    bpf_prog->aux->stack_depth,
+							    image + addrs[i - 1],
+							    ctx);
 			break;
 
 			/* cond jump */
