Return-Path: <linux-tip-commits+bounces-6298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87DB2D91A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA75168323E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5752F5330;
	Wed, 20 Aug 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKKEVQyb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgr5/QV2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8B2F0C5E;
	Wed, 20 Aug 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682764; cv=none; b=dXfZopYycKoTFFDFvsrVnjs6uxOYw/ekV2hjaywLpZYAVMTxt7hxrUZuEZceep0VOo5zljXcMw69hyBsp2O05m65+IcU4Gq6wQt+yExX6pkM3U5R25p8xQxCNQ+I33p4fc7jChb5ssKT7p35lZokj2SlafuXMf2V/vx/0uRawps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682764; c=relaxed/simple;
	bh=YVnINwtnyDS6h3OyffyU8Ydb2SpXcblbDZXjLtDk3nc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mR1rvPUtDEm9QE5x30V4noAqgsCWFXqZqYyswn0+5fJBD2DeAKi4CheSHEYQ7jV+3QoEdCv3LEORUjvNf88HeCai8OMSNxRYLYuimfytHjgvyN/K0qcdIoGtGRVx55yVhvTE2cwEqDr2yd+m0y0wvVJPJpbGtAZ1XUh+yB0bVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKKEVQyb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgr5/QV2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jT/EsUUbupyRAm2joZhctQll+58xtkbro+RaKVwquvA=;
	b=yKKEVQybbRH1GbDHbWM4mxt5V1iimRpLPpn1lQo8Z0T8NMxw87ov17GmrYZUo9hwPZdSBn
	xE7MVqDYwFvlViWsAXvWAy7WdCwYfZAvraLKvNie9SJPMCqa4R9mzqhSswmjBRBem1/Xn0
	+U2VyTqLP7TmFzqCh9+Sz4MlDwDLX0VFVNvgS4ccrCzB490hhxDMqdCqtQEqWA+BgQvu83
	RhNgHb4yjcksKZ77ujo+ScA0nh6ma3oRj6WPKljAZg/pAsiE/s8e7Y34EqCW6uC+TSkf5a
	ZWAUMFJ9kuRCa92wf65V2X1/jFlBnuhxPhU1gpL+jf6umzpEzyDMl4sRHCvNvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jT/EsUUbupyRAm2joZhctQll+58xtkbro+RaKVwquvA=;
	b=cgr5/QV23dpd5b0GTIPVc17uE/VcL1bslqZ5JVjXFwHgrlwhwSpkdlOPbhLNvBZbWH5/WW
	ac2tuROdFzzsyuDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_2
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103439.903697475@infradead.org>
References: <20250714103439.903697475@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275950.1420.4691442244255656768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b26deb0cad4af9f522496fd25dc3ebca759e65a4
Gitweb:        https://git.kernel.org/tip/b26deb0cad4af9f522496fd25dc3ebca759=
e65a4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:25:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:05 +02:00

KVM: x86: Introduce EM_ASM_2

Replace the FASTOP2 instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103439.903697475@infradead.org
---
 arch/x86/kvm/emulate.c | 85 ++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5b8a1ad..ec4793f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -317,6 +317,15 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
 	EM_ASM_END
=20
+/* 2-operand, using "a" (dst), "d" (src) */
+#define EM_ASM_2(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_2(op##b, al, dl); break; \
+	case 2: __EM_ASM_2(op##w, ax, dx); break; \
+	case 4: __EM_ASM_2(op##l, eax, edx); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1027,15 +1036,16 @@ static int read_descriptor(struct x86_emulate_ctxt *c=
txt,
 	return rc;
 }
=20
-FASTOP2(add);
-FASTOP2(or);
-FASTOP2(adc);
-FASTOP2(sbb);
-FASTOP2(and);
-FASTOP2(sub);
-FASTOP2(xor);
-FASTOP2(cmp);
-FASTOP2(test);
+EM_ASM_2(add);
+EM_ASM_2(or);
+EM_ASM_2(adc);
+EM_ASM_2(sbb);
+EM_ASM_2(and);
+EM_ASM_2(sub);
+EM_ASM_2(xor);
+EM_ASM_2(cmp);
+EM_ASM_2(test);
+EM_ASM_2(xadd);
=20
 FASTOP1SRC2(mul, mul_ex);
 FASTOP1SRC2(imul, imul_ex);
@@ -1067,7 +1077,6 @@ FASTOP2W(bts);
 FASTOP2W(btr);
 FASTOP2W(btc);
=20
-FASTOP2(xadd);
=20
 FASTOP2R(cmp, cmp_r);
=20
@@ -2304,7 +2313,7 @@ static int em_cmpxchg(struct x86_emulate_ctxt *ctxt)
 	ctxt->dst.val =3D reg_read(ctxt, VCPU_REGS_RAX);
 	ctxt->src.orig_val =3D ctxt->src.val;
 	ctxt->src.val =3D ctxt->dst.orig_val;
-	fastop(ctxt, em_cmp);
+	em_cmp(ctxt);
=20
 	if (ctxt->eflags & X86_EFLAGS_ZF) {
 		/* Success: write back to memory; no update of EAX */
@@ -3069,7 +3078,7 @@ static int em_das(struct x86_emulate_ctxt *ctxt)
 	ctxt->src.type =3D OP_IMM;
 	ctxt->src.val =3D 0;
 	ctxt->src.bytes =3D 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
 	ctxt->eflags &=3D ~(X86_EFLAGS_AF | X86_EFLAGS_CF);
 	if (cf)
 		ctxt->eflags |=3D X86_EFLAGS_CF;
@@ -3095,7 +3104,7 @@ static int em_aam(struct x86_emulate_ctxt *ctxt)
 	ctxt->src.type =3D OP_IMM;
 	ctxt->src.val =3D 0;
 	ctxt->src.bytes =3D 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
=20
 	return X86EMUL_CONTINUE;
 }
@@ -3113,7 +3122,7 @@ static int em_aad(struct x86_emulate_ctxt *ctxt)
 	ctxt->src.type =3D OP_IMM;
 	ctxt->src.val =3D 0;
 	ctxt->src.bytes =3D 1;
-	fastop(ctxt, em_or);
+	em_or(ctxt);
=20
 	return X86EMUL_CONTINUE;
 }
@@ -3998,9 +4007,9 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 #define I2bvIP(_f, _e, _i, _p) \
 	IIP((_f) | ByteOp, _e, _i, _p), IIP(_f, _e, _i, _p)
=20
-#define F6ALU(_f, _e) F2bv((_f) | DstMem | SrcReg | ModRM, _e),		\
-		F2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
-		F2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
+#define I6ALU(_f, _e) I2bv((_f) | DstMem | SrcReg | ModRM, _e),		\
+		I2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
+		I2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
=20
 static const struct opcode group7_rm0[] =3D {
 	N,
@@ -4038,14 +4047,14 @@ static const struct opcode group7_rm7[] =3D {
 };
=20
 static const struct opcode group1[] =3D {
-	F(Lock, em_add),
-	F(Lock | PageTable, em_or),
-	F(Lock, em_adc),
-	F(Lock, em_sbb),
-	F(Lock | PageTable, em_and),
-	F(Lock, em_sub),
-	F(Lock, em_xor),
-	F(NoWrite, em_cmp),
+	I(Lock, em_add),
+	I(Lock | PageTable, em_or),
+	I(Lock, em_adc),
+	I(Lock, em_sbb),
+	I(Lock | PageTable, em_and),
+	I(Lock, em_sub),
+	I(Lock, em_xor),
+	I(NoWrite, em_cmp),
 };
=20
 static const struct opcode group1A[] =3D {
@@ -4064,8 +4073,8 @@ static const struct opcode group2[] =3D {
 };
=20
 static const struct opcode group3[] =3D {
-	F(DstMem | SrcImm | NoWrite, em_test),
-	F(DstMem | SrcImm | NoWrite, em_test),
+	I(DstMem | SrcImm | NoWrite, em_test),
+	I(DstMem | SrcImm | NoWrite, em_test),
 	I(DstMem | SrcNone | Lock, em_not),
 	I(DstMem | SrcNone | Lock, em_neg),
 	F(DstXacc | Src2Mem, em_mul_ex),
@@ -4258,29 +4267,29 @@ static const struct instr_dual instr_dual_8d =3D {
=20
 static const struct opcode opcode_table[256] =3D {
 	/* 0x00 - 0x07 */
-	F6ALU(Lock, em_add),
+	I6ALU(Lock, em_add),
 	I(ImplicitOps | Stack | No64 | Src2ES, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2ES, em_pop_sreg),
 	/* 0x08 - 0x0F */
-	F6ALU(Lock | PageTable, em_or),
+	I6ALU(Lock | PageTable, em_or),
 	I(ImplicitOps | Stack | No64 | Src2CS, em_push_sreg),
 	N,
 	/* 0x10 - 0x17 */
-	F6ALU(Lock, em_adc),
+	I6ALU(Lock, em_adc),
 	I(ImplicitOps | Stack | No64 | Src2SS, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2SS, em_pop_sreg),
 	/* 0x18 - 0x1F */
-	F6ALU(Lock, em_sbb),
+	I6ALU(Lock, em_sbb),
 	I(ImplicitOps | Stack | No64 | Src2DS, em_push_sreg),
 	I(ImplicitOps | Stack | No64 | Src2DS, em_pop_sreg),
 	/* 0x20 - 0x27 */
-	F6ALU(Lock | PageTable, em_and), N, N,
+	I6ALU(Lock | PageTable, em_and), N, N,
 	/* 0x28 - 0x2F */
-	F6ALU(Lock, em_sub), N, I(ByteOp | DstAcc | No64, em_das),
+	I6ALU(Lock, em_sub), N, I(ByteOp | DstAcc | No64, em_das),
 	/* 0x30 - 0x37 */
-	F6ALU(Lock, em_xor), N, N,
+	I6ALU(Lock, em_xor), N, N,
 	/* 0x38 - 0x3F */
-	F6ALU(NoWrite, em_cmp), N, N,
+	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
 	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
 	/* 0x50 - 0x57 */
@@ -4306,7 +4315,7 @@ static const struct opcode opcode_table[256] =3D {
 	G(DstMem | SrcImm, group1),
 	G(ByteOp | DstMem | SrcImm | No64, group1),
 	G(DstMem | SrcImmByte, group1),
-	F2bv(DstMem | SrcReg | ModRM | NoWrite, em_test),
+	I2bv(DstMem | SrcReg | ModRM | NoWrite, em_test),
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable, em_xchg),
 	/* 0x88 - 0x8F */
 	I2bv(DstMem | SrcReg | ModRM | Mov | PageTable, em_mov),
@@ -4329,7 +4338,7 @@ static const struct opcode opcode_table[256] =3D {
 	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
 	F2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
 	/* 0xA8 - 0xAF */
-	F2bv(DstAcc | SrcImm | NoWrite, em_test),
+	I2bv(DstAcc | SrcImm | NoWrite, em_test),
 	I2bv(SrcAcc | DstDI | Mov | String, em_mov),
 	I2bv(SrcSI | DstAcc | Mov | String, em_mov),
 	F2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
@@ -4467,7 +4476,7 @@ static const struct opcode twobyte_table[256] =3D {
 	I(DstReg | SrcMem | ModRM, em_bsr_c),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),
 	/* 0xC0 - 0xC7 */
-	F2bv(DstMem | SrcReg | ModRM | SrcWrite | Lock, em_xadd),
+	I2bv(DstMem | SrcReg | ModRM | SrcWrite | Lock, em_xadd),
 	N, ID(0, &instr_dual_0f_c3),
 	N, N, N, GD(0, &group9),
 	/* 0xC8 - 0xCF */

