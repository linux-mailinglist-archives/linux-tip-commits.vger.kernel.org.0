Return-Path: <linux-tip-commits+bounces-6299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46312B2D8F2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FC5B60D84
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A972FC869;
	Wed, 20 Aug 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZYH+c4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSZJisu9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF22F1FE4;
	Wed, 20 Aug 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682765; cv=none; b=lzDOx9bKOhrEQngfHDN/gsvffLwpM04RSpjVOVCXL80DsjM2D1medxit1iECpNQJ2mZbsbRZdQrykHhpJzBPx5NWTGtxn7glZYhR36CW+NdyoJP5jlMEymw5AtF+qtZkNC7ogjgKhfWG45dDypdQVsUvkQyEAjLR12/QWXBswDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682765; c=relaxed/simple;
	bh=Gzhm3+arwrDtY8QcN7uE+ht1IxeKJP5bhtijT+Fawjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W2PqavOlbd5QwagKSUhN0b/1MlkgIO6kcVimgRWIILQEFFMX88jR3DqfTKZpo4smwhaMQPnmyoO61DOL9wJarmi6LRWlao8SBX8lKfB58dxHiNIzar/MnBBhYKtvSvYtEp+//PS5pkGP4t71uoR+z4gcfgppypS2hJgceB2OINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZYH+c4N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSZJisu9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzvsIpMe54AcrHsL8A3N15WOZhSwwG023skI9WaDnBU=;
	b=ZZYH+c4Ntzu+Jmti+tQk3EnyoJQIaY4yBaHQBgbR2cEHgMXZiyjvmH1J06vuR8wepVFgdL
	rRccnoBGic7s5ZCe6G28t9rKqiYxrbR54dVs6CR5rBKHDZlf3+oFM1JpJhSW1HNBsDHpLF
	U1IQ5HNCWeqdgc4OSHPyFNCGMCgO5sqN9pUFdcgwxiAfdX853XXVSmGBLmM2ZqPxfuDYhS
	SAmuVziH20Plb2WG3wOYrSYGJyGLTnyanXoxeAwvRUztp6cinyn1K0oyycCXwm8+zZJvDA
	eeLG13uPYt9ZLVhLTaPDI95WUtVBwQEtgQY4UxUg2lo5JRj3T/l8hj7ysHXTww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzvsIpMe54AcrHsL8A3N15WOZhSwwG023skI9WaDnBU=;
	b=VSZJisu99ljICNZwOZXRAcXQBi+tSbgtlj2F29HC4jJ2B8HRlIMhuyEcbslbqibzoL2hii
	286ES+BBWz3v7NCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_1
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103439.773781574@infradead.org>
References: <20250714103439.773781574@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568276069.1420.17005855031298781305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6204aea36b74cd2001a142e92e492e301597eafb
Gitweb:        https://git.kernel.org/tip/6204aea36b74cd2001a142e92e492e30159=
7eafb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 11:51:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:05 +02:00

KVM: x86: Introduce EM_ASM_1

Replace fastops with C based stubs. There are a bunch of problems with
the current fastop infrastructure, most all related to their special
calling convention, which bypasses the normal C-ABI.

There are two immediate problems with this at present:

 - it relies on RET preserving EFLAGS; whereas C-ABI does not.

 - it circumvents compiler based control-flow-integrity checking
   because its all asm magic.

The first is a problem for some mitigations where the
x86_indirect_return_thunk needs to include non-trivial work that
clobbers EFLAGS (eg. the Skylake call depth tracking thing).

The second is a problem because it presents a 'naked' indirect call on
kCFI builds, making it a prime target for control flow hijacking.

Additionally, given that a large chunk of virtual machine performance
relies on absolutely avoiding vmexit these days, this emulation stuff
just isn't that critical for performance anymore.

As such, replace the fastop calls with normal C functions using the
'execute' member.

As noted by Paolo: this code was performance critical for pre-Westmere
(2010) and only when running big real mode code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103439.773781574@infradead.org
---
 arch/x86/kvm/emulate.c | 71 +++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9526d69..5b8a1ad 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -267,11 +267,56 @@ static void invalidate_registers(struct x86_emulate_ctx=
t *ctxt)
 		     X86_EFLAGS_PF|X86_EFLAGS_CF)
=20
 #ifdef CONFIG_X86_64
-#define ON64(x) x
+#define ON64(x...) x
 #else
-#define ON64(x)
+#define ON64(x...)
 #endif
=20
+#define EM_ASM_START(op) \
+static int em_##op(struct x86_emulate_ctxt *ctxt) \
+{ \
+	unsigned long flags =3D (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF; \
+	int bytes =3D 1, ok =3D 1; \
+	if (!(ctxt->d & ByteOp)) \
+		bytes =3D ctxt->dst.bytes; \
+	switch (bytes) {
+
+#define __EM_ASM(str) \
+		asm("push %[flags]; popf \n\t" \
+		    "10: " str \
+		    "pushf; pop %[flags] \n\t" \
+		    "11: \n\t" \
+		    : "+a" (ctxt->dst.val), \
+		      "+d" (ctxt->src.val), \
+		      [flags] "+D" (flags), \
+		      "+S" (ok) \
+		    : "c" (ctxt->src2.val))
+
+#define __EM_ASM_1(op, dst) \
+		__EM_ASM(#op " %%" #dst " \n\t")
+
+#define __EM_ASM_1_EX(op, dst) \
+		__EM_ASM(#op " %%" #dst " \n\t" \
+			 _ASM_EXTABLE_TYPE_REG(10b, 11f, EX_TYPE_ZERO_REG, %%esi))
+
+#define __EM_ASM_2(op, dst, src) \
+		__EM_ASM(#op " %%" #src ", %%" #dst " \n\t")
+
+#define EM_ASM_END \
+	} \
+	ctxt->eflags =3D (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK); \
+	return !ok ? emulate_de(ctxt) : X86EMUL_CONTINUE; \
+}
+
+/* 1-operand, using "a" (dst) */
+#define EM_ASM_1(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_1(op##b, al); break; \
+	case 2: __EM_ASM_1(op##w, ax); break; \
+	case 4: __EM_ASM_1(op##l, eax); break; \
+	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1002,10 +1047,10 @@ FASTOP3WCL(shrd);
=20
 FASTOP2W(imul);
=20
-FASTOP1(not);
-FASTOP1(neg);
-FASTOP1(inc);
-FASTOP1(dec);
+EM_ASM_1(not);
+EM_ASM_1(neg);
+EM_ASM_1(inc);
+EM_ASM_1(dec);
=20
 FASTOP2CL(rol);
 FASTOP2CL(ror);
@@ -4021,8 +4066,8 @@ static const struct opcode group2[] =3D {
 static const struct opcode group3[] =3D {
 	F(DstMem | SrcImm | NoWrite, em_test),
 	F(DstMem | SrcImm | NoWrite, em_test),
-	F(DstMem | SrcNone | Lock, em_not),
-	F(DstMem | SrcNone | Lock, em_neg),
+	I(DstMem | SrcNone | Lock, em_not),
+	I(DstMem | SrcNone | Lock, em_neg),
 	F(DstXacc | Src2Mem, em_mul_ex),
 	F(DstXacc | Src2Mem, em_imul_ex),
 	F(DstXacc | Src2Mem, em_div_ex),
@@ -4030,14 +4075,14 @@ static const struct opcode group3[] =3D {
 };
=20
 static const struct opcode group4[] =3D {
-	F(ByteOp | DstMem | SrcNone | Lock, em_inc),
-	F(ByteOp | DstMem | SrcNone | Lock, em_dec),
+	I(ByteOp | DstMem | SrcNone | Lock, em_inc),
+	I(ByteOp | DstMem | SrcNone | Lock, em_dec),
 	N, N, N, N, N, N,
 };
=20
 static const struct opcode group5[] =3D {
-	F(DstMem | SrcNone | Lock,		em_inc),
-	F(DstMem | SrcNone | Lock,		em_dec),
+	I(DstMem | SrcNone | Lock,		em_inc),
+	I(DstMem | SrcNone | Lock,		em_dec),
 	I(SrcMem | NearBranch | IsBranch,       em_call_near_abs),
 	I(SrcMemFAddr | ImplicitOps | IsBranch, em_call_far),
 	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
@@ -4237,7 +4282,7 @@ static const struct opcode opcode_table[256] =3D {
 	/* 0x38 - 0x3F */
 	F6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(F(DstReg, em_inc)), X8(F(DstReg, em_dec)),
+	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */

