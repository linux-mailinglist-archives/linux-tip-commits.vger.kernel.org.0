Return-Path: <linux-tip-commits+bounces-6294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D3B2D920
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BC85E1505
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926C2EF670;
	Wed, 20 Aug 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ivJhyIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7A/T5Z9o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72252ECD23;
	Wed, 20 Aug 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682761; cv=none; b=IbN+qXkvyTFPu1P8A4v3sJBpXl73mP63+t4OWWWpurHJpYyA2VX4u3wioyCSpk+ezmdD1cY2R/n1nBw1aYRxKX24H8feJp+WJEP/OZrH5IydhlxNzuX0fq+a8TWTR0YjdAautaDGvgUAi0UaYTdpF2iC0ym0bSvqodBZp6B4QL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682761; c=relaxed/simple;
	bh=7lm7/Hgzb8QebnlLdzNDe74DKDJDPjWEde452HGpY/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZbfyIMN2rSJrRGXXad/BB+MprErpBE0NZH1ekGgHnQ8u/IT5Ns+8VpXs8my5Bax9Rd2ed25Wce9XJFwtryH5hZ2wJNix47Uxgk2CznfRgjGrggA6JzUybybr1+SbyVX3b6yIws+Vsx1awh73PB2Q5zmBTUKzChc7pt6deyNTYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ivJhyIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7A/T5Z9o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0neGdeG/lZjKaPF7glNESARr/gVEa5RXwjG39ecgMbI=;
	b=3ivJhyIGfd98c+UI+FT9cNEDUjHXYBpqCyixYgxY4XomsdcnD+i746SDjLJo9yqnqV37CB
	zld9pI6LxTlB+XeRelTf3aB8d0rwNtIYdU77MCfzwNh7OETqDZD6Auxto6/FhmbqZfthax
	oNIWekExY6rhpt/JTiBA+zKQUU90+7FWMa3sxUQ7E+QSHQVWEpP2zPjgcZbkx9BQtopmK1
	JjVSxkLWIqjbW5yPDHhfHV9p26ghI3cscYdIDiqLwzMjTZjiU9EoOAdP39e2lBj4DlXqR+
	VDD2WbISDiUd8+L1C95R0NfBZweMrS9QUuRDLY/38qGefUPQIsO5tZpMMoom3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0neGdeG/lZjKaPF7glNESARr/gVEa5RXwjG39ecgMbI=;
	b=7A/T5Z9o8IG/MfYMiiiP5OnStAflpThmL6U//SW2sPQjYzxWGCA8UEtzjTFuE5PLTQTm7H
	HZJjHO9tha+x49Dg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_3WCL
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.513865075@infradead.org>
References: <20250714103440.513865075@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275391.1420.13712155174498779791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2d82acd7d6a7eba2ed2bf84ab7440c1ad7c27958
Gitweb:        https://git.kernel.org/tip/2d82acd7d6a7eba2ed2bf84ab7440c1ad7c=
27958
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:47:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:06 +02:00

KVM: x86: Introduce EM_ASM_3WCL

Replace the FASTOP3WCL instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.513865075@infradead.org
---
 arch/x86/kvm/emulate.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index beac2f4..390b8a9 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -302,6 +302,9 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 #define __EM_ASM_2(op, dst, src) \
 		__EM_ASM(#op " %%" #src ", %%" #dst " \n\t")
=20
+#define __EM_ASM_3(op, dst, src, src2) \
+		__EM_ASM(#op " %%" #src2 ", %%" #src ", %%" #dst " \n\t")
+
 #define EM_ASM_END \
 	} \
 	ctxt->eflags =3D (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK); \
@@ -371,6 +374,16 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_2(op##q, rax, cl); break;) \
 	EM_ASM_END
=20
+/* 3-operand, using "a" (dst), "d" (src) and CL (src2) */
+#define EM_ASM_3WCL(op) \
+	EM_ASM_START(op) \
+	case 1: break; \
+	case 2: __EM_ASM_3(op##w, ax, dx, cl); break; \
+	case 4: __EM_ASM_3(op##l, eax, edx, cl); break; \
+	ON64(case 8: __EM_ASM_3(op##q, rax, rdx, cl); break;) \
+	EM_ASM_END
+
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1097,8 +1110,8 @@ EM_ASM_1SRC2(imul, imul_ex);
 EM_ASM_1SRC2EX(div, div_ex);
 EM_ASM_1SRC2EX(idiv, idiv_ex);
=20
-FASTOP3WCL(shld);
-FASTOP3WCL(shrd);
+EM_ASM_3WCL(shld);
+EM_ASM_3WCL(shrd);
=20
 EM_ASM_2W(imul);
=20
@@ -4496,14 +4509,14 @@ static const struct opcode twobyte_table[256] =3D {
 	I(Stack | Src2FS, em_push_sreg), I(Stack | Src2FS, em_pop_sreg),
 	II(ImplicitOps, em_cpuid, cpuid),
 	I(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
-	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
-	F(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
+	I(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
+	I(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
 	/* 0xA8 - 0xAF */
 	I(Stack | Src2GS, em_push_sreg), I(Stack | Src2GS, em_pop_sreg),
 	II(EmulateOnUD | ImplicitOps, em_rsm, rsm),
 	I(DstMem | SrcReg | ModRM | BitOp | Lock | PageTable, em_bts),
-	F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
-	F(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
+	I(DstMem | SrcReg | Src2ImmByte | ModRM, em_shrd),
+	I(DstMem | SrcReg | Src2CL | ModRM, em_shrd),
 	GD(0, &group15), I(DstReg | SrcMem | ModRM, em_imul),
 	/* 0xB0 - 0xB7 */
 	I2bv(DstMem | SrcReg | ModRM | Lock | PageTable | SrcWrite, em_cmpxchg),

