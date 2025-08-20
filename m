Return-Path: <linux-tip-commits+bounces-6297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA5B2D930
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E541C46067
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F12EE27A;
	Wed, 20 Aug 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3m6xV8oQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyE876Zo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31D2EE26B;
	Wed, 20 Aug 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682763; cv=none; b=PCpeLrMc6HCGFS/HswOWOyk9uc8JkXBSMhwm9C7D6yoj56qt/53c6jTYslcfC0S4m6FzwhGREYKad10hVICjlQgS31H0SrcRsFhkbhJ67eN2egoL8z5AFibWUpdzPcP5hfGecug/9o66PJQZ6sZRRY+W+JI53cxsT6YFbwppPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682763; c=relaxed/simple;
	bh=bIGbfHCOwJ/OlKJavw4Bx89pamWWXPDTjyzAZWCG3MU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ganxQbL3NXR56Wo+UNHHTOYBcrglE2BKfaQnyOEwBg96lu/BeGZEkkj4Sj8NCuRg2LAQqNgaNlrqCOHIjZkGjzKoHXIE1+XPmS1e6lK6miimJe2asDMtJEYAFejq87nwbpVKVsBwSPmnDSuuOWPba7RNWzFe7MNCvA6G8kh0zfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3m6xV8oQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyE876Zo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4XK6Ec4y1c/VlmU37sHtP0PPTjqbRJxfhRERPzneyc=;
	b=3m6xV8oQC5It6ixZVfKcNRztKnwrdweGznOqaKASZXMZ6nBRecLcIZfk3XZP1RonXiVKlb
	jX0CtXr4ShKvqR32wOtmAUKuHKf/fDo596uynH6ut7hKHrDjqQAy02j9CGSw3CuP7Q+q8L
	veuhKigxJk4zgyjv9I1htLsy5C+uBfDCEZ3IDXiGsFpTzEVnP+nPh5ec9YsCP8fCdxBGeL
	5Gd79ylqvSs3glPIw0LUaSbu3MbrWpIaKSqEJ1mSBn2wKAJ7sxEddXYHh+HQlCR5rpXqA4
	0G42ZZmN7rDOHnJ1+BMgKpFbNrTJFYoGmcofwKK94DgNHj8YCuKiCBjeuzaGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4XK6Ec4y1c/VlmU37sHtP0PPTjqbRJxfhRERPzneyc=;
	b=JyE876Zo5woAaggymfZh95p3618ex6EfgGcBQvKV9Q/Z0IxQhLAOgwdLYoZvyw4AvF2lCF
	cn2wm1tFd+TPnCCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_2W
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.142923581@infradead.org>
References: <20250714103440.142923581@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275726.1420.11182748630752590196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     975e51783cfd0abc303817e8bf1ab2f630834c2a
Gitweb:        https://git.kernel.org/tip/975e51783cfd0abc303817e8bf1ab2f6308=
34c2a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:30:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:05 +02:00

KVM: x86: Introduce EM_ASM_2W

Replace the FASTOP2W instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.142923581@infradead.org
---
 arch/x86/kvm/emulate.c | 47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 7af30ef..05a97ec 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -335,6 +335,15 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_2(op##q, rdx, rax); break;) \
 	EM_ASM_END
=20
+/* 2-operand, word only (no byte op) */
+#define EM_ASM_2W(op) \
+	EM_ASM_START(op) \
+	case 1: break; \
+	case 2: __EM_ASM_2(op##w, ax, dx); break; \
+	case 4: __EM_ASM_2(op##l, eax, edx); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1064,7 +1073,7 @@ FASTOP1SRC2EX(idiv, idiv_ex);
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
=20
-FASTOP2W(imul);
+EM_ASM_2W(imul);
=20
 EM_ASM_1(not);
 EM_ASM_1(neg);
@@ -1079,12 +1088,12 @@ FASTOP2CL(shl);
 FASTOP2CL(shr);
 FASTOP2CL(sar);
=20
-FASTOP2W(bsf);
-FASTOP2W(bsr);
-FASTOP2W(bt);
-FASTOP2W(bts);
-FASTOP2W(btr);
-FASTOP2W(btc);
+EM_ASM_2W(bsf);
+EM_ASM_2W(bsr);
+EM_ASM_2W(bt);
+EM_ASM_2W(bts);
+EM_ASM_2W(btr);
+EM_ASM_2W(btc);
=20
 EM_ASM_2R(cmp, cmp_r);
=20
@@ -1093,7 +1102,7 @@ static int em_bsf_c(struct x86_emulate_ctxt *ctxt)
 	/* If src is zero, do not writeback, but update flags */
 	if (ctxt->src.val =3D=3D 0)
 		ctxt->dst.type =3D OP_NONE;
-	return fastop(ctxt, em_bsf);
+	return em_bsf(ctxt);
 }
=20
 static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
@@ -1101,7 +1110,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
 	/* If src is zero, do not writeback, but update flags */
 	if (ctxt->src.val =3D=3D 0)
 		ctxt->dst.type =3D OP_NONE;
-	return fastop(ctxt, em_bsr);
+	return em_bsr(ctxt);
 }
=20
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flag=
s)
@@ -3221,7 +3230,7 @@ static int em_xchg(struct x86_emulate_ctxt *ctxt)
 static int em_imul_3op(struct x86_emulate_ctxt *ctxt)
 {
 	ctxt->dst.val =3D ctxt->src2.val;
-	return fastop(ctxt, em_imul);
+	return em_imul(ctxt);
 }
=20
 static int em_cwd(struct x86_emulate_ctxt *ctxt)
@@ -4135,10 +4144,10 @@ static const struct group_dual group7 =3D { {
=20
 static const struct opcode group8[] =3D {
 	N, N, N, N,
-	F(DstMem | SrcImmByte | NoWrite,		em_bt),
-	F(DstMem | SrcImmByte | Lock | PageTable,	em_bts),
-	F(DstMem | SrcImmByte | Lock,			em_btr),
-	F(DstMem | SrcImmByte | Lock | PageTable,	em_btc),
+	I(DstMem | SrcImmByte | NoWrite,		em_bt),
+	I(DstMem | SrcImmByte | Lock | PageTable,	em_bts),
+	I(DstMem | SrcImmByte | Lock,			em_btr),
+	I(DstMem | SrcImmByte | Lock | PageTable,	em_btc),
 };
=20
 /*
@@ -4459,27 +4468,27 @@ static const struct opcode twobyte_table[256] =3D {
 	/* 0xA0 - 0xA7 */
 	I(Stack | Src2FS, em_push_sreg), I(Stack | Src2FS, em_pop_sreg),
 	II(ImplicitOps, em_cpuid, cpuid),
-	F(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
+	I(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
 	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
 	F(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
 	/* 0xA8 - 0xAF */
 	I(Stack | Src2GS, em_push_sreg), I(Stack | Src2GS, em_pop_sreg),
 	II(EmulateOnUD | ImplicitOps, em_rsm, rsm),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
 	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
 	F(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
-	GD(0, &group15), F(DstReg | SrcMem | ModRM, em_imul),
+	GD(0, &group15), I(DstReg | SrcMem | ModRM, em_imul),
 	/* 0xB0 - 0xB7 */
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable | SrcWrite, em_cmpxchg),
 	I(DstReg | SrcMemFAddr | ModRM | Src2SS, em_lseg),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock, em_btr),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock, em_btr),
 	I(DstReg | SrcMemFAddr | ModRM | Src2FS, em_lseg),
 	I(DstReg | SrcMemFAddr | ModRM | Src2GS, em_lseg),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),
 	/* 0xB8 - 0xBF */
 	N, N,
 	G(BitOp, group8),
-	F(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_btc),
+	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_btc),
 	I(DstReg | SrcMem | ModRM, em_bsf_c),
 	I(DstReg | SrcMem | ModRM, em_bsr_c),
 	D(DstReg | SrcMem8 | ModRM | Mov), D(DstReg | SrcMem16 | ModRM | Mov),

