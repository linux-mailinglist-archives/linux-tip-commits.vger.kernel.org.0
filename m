Return-Path: <linux-tip-commits+bounces-6291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1BB2D904
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9FBA06E30
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B32EB853;
	Wed, 20 Aug 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aerk1MHm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnDL0Oz8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571352EB852;
	Wed, 20 Aug 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682758; cv=none; b=W7nHR/+TsqU/UN4WSeoAgimq28uD72btVyBLbYIDONEtlIO4dHvg1obysB5uzjK5GQUMJURELAiNLEMT7WxLusq1aT3z808oNKqlz44/Ckqn7CH1OgFrvC2gTSkIXSxGcj6SsMJ6FfWWPhfy8PkS0EQ5YSwZbKBq07lzbAL1ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682758; c=relaxed/simple;
	bh=bty+XU4Kdvla7lt56q58ZRYbSV0bimxdt2s+EwIferg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iSlkjNwxh2tNCOJpJFGzoqq5w5xgt6IACdilJnSBQRH96f+FOMVhO5x9asKd96aYDABeYGDTJr9+aelmoC4NKdayvLK+Q1V2ryPDu9AdZZMD60/5pXDI+6zc4+1NdIxOFYZ+KXdHGPqsvko5KYAmlIOHvk4/dkDrLSfAq2DpIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aerk1MHm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnDL0Oz8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX9Skq/AyRtStz24DZUMYKBP669EhN/xIHdTtm//5xk=;
	b=aerk1MHmEXVamYPd9Bn9W89ElVyk1/hEhzvVevgvuh2l9Uy2VASFSuKB68gMXXL5L+i5oQ
	FROA8lOQ6v51riHg72ntLTz/FzS+alTfqIUmK3YBDhyuDt6OvEAh+49IsuAppl+8kkaAYu
	xAtUnS/v9bNTIr0ohPCSTogePxqilCUl7VT6/5nwCeOf+QfhyWDm/7NYHkBA1hXsEfOYP+
	HHAyqlh+iFiWjARtbCq/zHen0S1A9T63stZWABxL1Bdz5tRIPeZcgyYUtj6pJAoHuw2kdc
	BskJakmkSy8E0ks3Y+bSgluNJACtr7eeMNWBl/+K8Qz6xSxOzoFBfKb5kTe52Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX9Skq/AyRtStz24DZUMYKBP669EhN/xIHdTtm//5xk=;
	b=gnDL0Oz8gv7MYKblcEYuXZcerbgzvYwUllQuuoIY+HtF9kXMYZ6Qt+wLY2FWzsfJ20s8p3
	MSZzJKQxoQ5t41DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Remove fastops
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.751192860@infradead.org>
References: <20250714103440.751192860@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275171.1420.3641567946644980282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a1d34a444ce8c9a6ec4376247f80f0b777c6d3fe
Gitweb:        https://git.kernel.org/tip/a1d34a444ce8c9a6ec4376247f80f0b777c=
6d3fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:55:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:07 +02:00

KVM: x86: Remove fastops

No more FASTOPs, remove the remains.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.751192860@infradead.org
---
 arch/x86/kvm/emulate.c | 172 +----------------------------------------
 1 file changed, 1 insertion(+), 171 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 94008cd..796d0c6 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -167,7 +167,6 @@
 #define Unaligned   ((u64)2 << 41)  /* Explicitly unaligned (e.g. MOVDQU) */
 #define Avx         ((u64)3 << 41)  /* Advanced Vector Extensions */
 #define Aligned16   ((u64)4 << 41)  /* Aligned to 16 byte boundary (e.g. FXS=
AVE) */
-#define Fastop      ((u64)1 << 44)  /* Use opcode::u.fastop */
 #define NoWrite     ((u64)1 << 45)  /* No writeback */
 #define SrcWrite    ((u64)1 << 46)  /* Write back src operand */
 #define NoMod	    ((u64)1 << 47)  /* Mod field is ignored */
@@ -203,7 +202,6 @@ struct opcode {
 		const struct escape *esc;
 		const struct instr_dual *idual;
 		const struct mode_dual *mdual;
-		void (*fastop)(struct fastop *fake);
 	} u;
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 };
@@ -383,152 +381,6 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_3(op##q, rax, rdx, cl); break;) \
 	EM_ASM_END
=20
-
-/*
- * fastop functions have a special calling convention:
- *
- * dst:    rax        (in/out)
- * src:    rdx        (in/out)
- * src2:   rcx        (in)
- * flags:  rflags     (in/out)
- * ex:     rsi        (in:fastop pointer, out:zero if exception)
- *
- * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
- * different operand sizes can be reached by calculation, rather than a jump
- * table (which would be bigger than the code).
- *
- * The 16 byte alignment, considering 5 bytes for the RET thunk, 3 for ENDBR
- * and 1 for the straight line speculation INT3, leaves 7 bytes for the
- * body of the function.  Currently none is larger than 4.
- */
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
-
-#define FASTOP_SIZE	16
-
-#define __FOP_FUNC(name) \
-	".align " __stringify(FASTOP_SIZE) " \n\t" \
-	".type " name ", @function \n\t" \
-	name ":\n\t" \
-	ASM_ENDBR \
-	IBT_NOSEAL(name)
-
-#define FOP_FUNC(name) \
-	__FOP_FUNC(#name)
-
-#define __FOP_RET(name) \
-	"11: " ASM_RET \
-	".size " name ", .-" name "\n\t"
-
-#define FOP_RET(name) \
-	__FOP_RET(#name)
-
-#define __FOP_START(op, align) \
-	extern void em_##op(struct fastop *fake); \
-	asm(".pushsection .text, \"ax\" \n\t" \
-	    ".global em_" #op " \n\t" \
-	    ".align " __stringify(align) " \n\t" \
-	    "em_" #op ":\n\t"
-
-#define FOP_START(op) __FOP_START(op, FASTOP_SIZE)
-
-#define FOP_END \
-	    ".popsection")
-
-#define __FOPNOP(name) \
-	__FOP_FUNC(name) \
-	__FOP_RET(name)
-
-#define FOPNOP() \
-	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
-
-#define FOP1E(op,  dst) \
-	__FOP_FUNC(#op "_" #dst) \
-	"10: " #op " %" #dst " \n\t" \
-	__FOP_RET(#op "_" #dst)
-
-#define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %%esi)
-
-#define FASTOP1(op) \
-	FOP_START(op) \
-	FOP1E(op##b, al) \
-	FOP1E(op##w, ax) \
-	FOP1E(op##l, eax) \
-	ON64(FOP1E(op##q, rax))	\
-	FOP_END
-
-/* 1-operand, using src2 (for MUL/DIV r/m) */
-#define FASTOP1SRC2(op, name) \
-	FOP_START(name) \
-	FOP1E(op, cl) \
-	FOP1E(op, cx) \
-	FOP1E(op, ecx) \
-	ON64(FOP1E(op, rcx)) \
-	FOP_END
-
-/* 1-operand, using src2 (for MUL/DIV r/m), with exceptions */
-#define FASTOP1SRC2EX(op, name) \
-	FOP_START(name) \
-	FOP1EEX(op, cl) \
-	FOP1EEX(op, cx) \
-	FOP1EEX(op, ecx) \
-	ON64(FOP1EEX(op, rcx)) \
-	FOP_END
-
-#define FOP2E(op,  dst, src)	   \
-	__FOP_FUNC(#op "_" #dst "_" #src) \
-	#op " %" #src ", %" #dst " \n\t" \
-	__FOP_RET(#op "_" #dst "_" #src)
-
-#define FASTOP2(op) \
-	FOP_START(op) \
-	FOP2E(op##b, al, dl) \
-	FOP2E(op##w, ax, dx) \
-	FOP2E(op##l, eax, edx) \
-	ON64(FOP2E(op##q, rax, rdx)) \
-	FOP_END
-
-/* 2 operand, word only */
-#define FASTOP2W(op) \
-	FOP_START(op) \
-	FOPNOP() \
-	FOP2E(op##w, ax, dx) \
-	FOP2E(op##l, eax, edx) \
-	ON64(FOP2E(op##q, rax, rdx)) \
-	FOP_END
-
-/* 2 operand, src is CL */
-#define FASTOP2CL(op) \
-	FOP_START(op) \
-	FOP2E(op##b, al, cl) \
-	FOP2E(op##w, ax, cl) \
-	FOP2E(op##l, eax, cl) \
-	ON64(FOP2E(op##q, rax, cl)) \
-	FOP_END
-
-/* 2 operand, src and dest are reversed */
-#define FASTOP2R(op, name) \
-	FOP_START(name) \
-	FOP2E(op##b, dl, al) \
-	FOP2E(op##w, dx, ax) \
-	FOP2E(op##l, edx, eax) \
-	ON64(FOP2E(op##q, rdx, rax)) \
-	FOP_END
-
-#define FOP3E(op,  dst, src, src2) \
-	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
-	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
-	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
-
-/* 3-operand, word-only, src2=3Dcl */
-#define FASTOP3WCL(op) \
-	FOP_START(op) \
-	FOPNOP() \
-	FOP3E(op##w, ax, dx, cl) \
-	FOP3E(op##l, eax, edx, cl) \
-	ON64(FOP3E(op##q, rax, rdx, cl)) \
-	FOP_END
-
 static int em_salc(struct x86_emulate_ctxt *ctxt)
 {
 	/*
@@ -4052,7 +3904,6 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 #define MD(_f, _m) { .flags =3D ((_f) | ModeDual), .u.mdual =3D (_m) }
 #define E(_f, _e) { .flags =3D ((_f) | Escape | ModRM), .u.esc =3D (_e) }
 #define I(_f, _e) { .flags =3D (_f), .u.execute =3D (_e) }
-#define F(_f, _e) { .flags =3D (_f) | Fastop, .u.fastop =3D (_e) }
 #define II(_f, _e, _i) \
 	{ .flags =3D (_f)|Intercept, .u.execute =3D (_e), .intercept =3D x86_interc=
ept_##_i }
 #define IIP(_f, _e, _i, _p) \
@@ -5158,24 +5009,6 @@ static void fetch_possible_mmx_operand(struct operand =
*op)
 		kvm_read_mmx_reg(op->addr.mm, &op->mm_val);
 }
=20
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
-{
-	ulong flags =3D (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
-
-	if (!(ctxt->d & ByteOp))
-		fop +=3D __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
-
-	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
-	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
-	    : "c"(ctxt->src2.val));
-
-	ctxt->eflags =3D (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
-	if (!fop) /* exception is returned in fop variable */
-		return emulate_de(ctxt);
-	return X86EMUL_CONTINUE;
-}
-
 void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 {
 	/* Clear fields that are set conditionally but read without a guard. */
@@ -5340,10 +5173,7 @@ special_insn:
 		ctxt->eflags &=3D ~X86_EFLAGS_RF;
=20
 	if (ctxt->execute) {
-		if (ctxt->d & Fastop)
-			rc =3D fastop(ctxt, ctxt->fop);
-		else
-			rc =3D ctxt->execute(ctxt);
+		rc =3D ctxt->execute(ctxt);
 		if (rc !=3D X86EMUL_CONTINUE)
 			goto done;
 		goto writeback;

