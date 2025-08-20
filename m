Return-Path: <linux-tip-commits+bounces-6287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A4B2D907
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460E25C5D5A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686582EA179;
	Wed, 20 Aug 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="spU+bJot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bf8t6+uq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4E2E266E;
	Wed, 20 Aug 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682752; cv=none; b=ZlqYRZwMv82TdbmYo6jlGpJS9qr6CUl3sDTcJqBys2vCQO3lhuQqjzjrE9C//64yGsoHS8LfYo/r8yjFJk1APq0+j6LnZL4h43RD8K1APLrIlT2YTlj4YO/CYsk/d7LK7GXkGoHJTpUpd3m2Ic+/AL4nilPs7m8/VZ1tq+WLyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682752; c=relaxed/simple;
	bh=ZVf3r/AWfBrD3E3w+XG+3QbBLB82sSdbBDeOK/F6HTY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HGT8D1DBt8/9/4uaxacbP6CJ4nxpuQWCusHwguNL/PcoWG8l7SuAmsTTIEN/aI8aeo5DDo0q/zW53FzI+nN45ewAx0VMuWPj9On/GkQpe75oujWLc2QLjdeWiIywHUvGxq8XAq+yNOYNaM4KMjKKkA1b51WO9cp2HdnqL3mOezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=spU+bJot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bf8t6+uq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmLGdhit61PNt3JMnIpWgrqkN+xh5icSzH5K3FHnHfY=;
	b=spU+bJot5mLCs88jucWBUMgQD7PsVK5L0YcRO0B9fDl0R2PvLgGy7PVFqWQeE4DkaNgi+B
	AYhxZ5DIYs5xgr9gSAMxBTnZLTXREKHnAMDzeUFGM/AKu3A4RMTJioSr8oUIVy1s/+MRhf
	hkjGLFfbuSm5nU+yN/hMi+OMDa1exlHKQQSKvEtim8w9S608Gh3028EXAgtULrg4kWDaMn
	REiIfsm46aqnkik9X5JPKLW6CNiWFsnMeBnSiSPJm2eLbONaPsZCo2GNiIBHft6BWej0nU
	4MEEC/BXG9OQQFv/5xPvLv0+h+jzEjxSuisZd3Hhj/KuUA5Z4Ncm5iySB/91zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmLGdhit61PNt3JMnIpWgrqkN+xh5icSzH5K3FHnHfY=;
	b=bf8t6+uqC4pUCNwT8jR4iYnWWCi+0E98a8G6p9Lwygqux0iRUIhaguGrdwYrXzl6IvuBYO
	tGvxbdUmPKR35jCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/fred: Play nice with invoking
 asm_fred_entry_from_kvm() on non-FRED hardware
Cc: Sean Christopherson <seanjc@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103441.245417052@infradead.org>
References: <20250714103441.245417052@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568274704.1420.9821464549157098886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     deed19b9b28724bd32e85063c60718c0a6803906
Gitweb:        https://git.kernel.org/tip/deed19b9b28724bd32e85063c60718c0a68=
03906
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 06 Jun 2025 13:04:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:08 +02:00

x86/fred: Play nice with invoking asm_fred_entry_from_kvm() on non-FRED hardw=
are

Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
when FRED isn't fully enabled, e.g. when running with
CONFIG_X86_FRED=3Dy on non-FRED hardware.  This will allow forcing KVM
to always use the FRED entry points for 64-bit kernels, which in turn
will eliminate a rather gross non-CFI indirect call that KVM uses to
trampoline IRQs by doing IDT lookups.

The point of asm_fred_entry_from_kvm() is to bridge between C
(vmx:handle_external_interrupt_irqoff()) and more C
(__fred_entry_from_kvm()) while changing the calling context to appear
like an interrupt (pt_regs). Making the whole thing bound by C ABI.

All that remains for non-FRED hardware is to restore RSP (to undo the
redzone and alignment). However the trivial change would result in
code like:

  push %rbp
  mov %rsp, %rbp

  sub $REDZONE, %rsp
  and $MASK, %rsp

  PUSH_AND_CLEAR_REGS
   push %rbp

  POP_REGS
   pop %rbp <-- *objtool fail*

  mov %rbp, %rsp
  pop %rbp
  ret

And this will confuse objtool something wicked -- it gets confused by
the extra pop %rbp, not realizing the push and pop preserve the value.

Rather than trying to each objtool about this, recognise that since
the code is bound by C ABI on both ends and interrupts are not allowed
to change pt_regs (only exceptions are) it is sufficient to PUSH_REGS
in order to create pt_regs, but there is no reason to POP_REGS --
provided the callee-saved registers are preserved.

So avoid clearing callee-saved regs and skip POP_REGS.

[Original patch by Sean; much of this version by Josh; Changelog,
comments and final form by Peterz]

Originally-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103441.245417052@infradead.org
---
 arch/x86/entry/calling.h       | 11 +++++------
 arch/x86/entry/entry_64_fred.S | 33 ++++++++++++++++++++++++++-------
 arch/x86/kernel/asm-offsets.c  |  1 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9451968..77e2d92 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -99,7 +99,7 @@ For 32-bit we have the following conventions - kernel is bu=
ilt with
 	.endif
 .endm
=20
-.macro CLEAR_REGS clear_bp=3D1
+.macro CLEAR_REGS clear_callee=3D1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -113,20 +113,19 @@ For 32-bit we have the following conventions - kernel i=
s built with
 	xorl	%r9d,  %r9d	/* nospec r9  */
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
+	.if \clear_callee
 	xorl	%ebx,  %ebx	/* nospec rbx */
-	.if \clear_bp
 	xorl	%ebp,  %ebp	/* nospec rbp */
-	.endif
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
 	xorl	%r15d, %r15d	/* nospec r15 */
-
+	.endif
 .endm
=20
-.macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0 cle=
ar_bp=3D1 unwind_hint=3D1
+.macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0 cle=
ar_callee=3D1 unwind_hint=3D1
 	PUSH_REGS rdx=3D\rdx, rcx=3D\rcx, rax=3D\rax, save_ret=3D\save_ret unwind_h=
int=3D\unwind_hint
-	CLEAR_REGS clear_bp=3D\clear_bp
+	CLEAR_REGS clear_callee=3D\clear_callee
 .endm
=20
 .macro POP_REGS pop_rdi=3D1
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32..0d00ec8 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -112,18 +112,37 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rax				/* Return RIP */
 	push $0					/* Error code, 0 for IRQ/NMI */
=20
-	PUSH_AND_CLEAR_REGS clear_bp=3D0 unwind_hint=3D0
+	PUSH_AND_CLEAR_REGS clear_callee=3D0 unwind_hint=3D0
+
 	movq %rsp, %rdi				/* %rdi -> pt_regs */
+	/*
+	 * At this point: {rdi, rsi, rdx, rcx, r8, r9}, {r10, r11}, {rax, rdx}
+	 * are clobbered, which corresponds to: arguments, extra caller-saved
+	 * and return. All registers a C function is allowed to clobber.
+	 *
+	 * Notably, the callee-saved registers: {rbx, r12, r13, r14, r15}
+	 * are untouched, with the exception of rbp, which carries the stack
+	 * frame and will be restored before exit.
+	 *
+	 * Further calling another C function will not alter this state.
+	 */
 	call __fred_entry_from_kvm		/* Call the C entry point */
-	POP_REGS
-	ERETS
-1:
+
 	/*
-	 * Objtool doesn't understand what ERETS does, this hint tells it that
-	 * yes, we'll reach here and with what stack state. A save/restore pair
-	 * isn't strictly needed, but it's the simplest form.
+	 * When FRED, use ERETS to potentially clear NMIs, otherwise simply
+	 * restore the stack pointer.
+	 */
+	ALTERNATIVE "nop; nop; mov %rbp, %rsp", \
+	            __stringify(add $C_PTREGS_SIZE, %rsp; ERETS), \
+		    X86_FEATURE_FRED
+
+1:	/*
+	 * Objtool doesn't understand ERETS, and the cfi register state is
+	 * different from initial_func_cfi due to PUSH_REGS. Tell it the state
+	 * is similar to where UNWIND_HINT_SAVE is.
 	 */
 	UNWIND_HINT_RESTORE
+
 	pop %rbp
 	RET
=20
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6259b47..32ba599 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ static void __used common(void)
=20
 	BLANK();
 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
+	OFFSET(C_PTREGS_SIZE, pt_regs, orig_ax);
=20
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);

