Return-Path: <linux-tip-commits+bounces-6293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72AB2D91B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893215C47A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8AC2EBB8D;
	Wed, 20 Aug 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8pbYtER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WClWbnu+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085302DE6F8;
	Wed, 20 Aug 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682759; cv=none; b=MUhHI0JcW7ce/BtA2B+ifaqGxbLHc30S1MFCDcyt8WA6/pjWhrY1hktPkBMXjUH6N4khvFm2maRRPxNeCLGgSHN20WUeJ/ilpk23hPeEOVAJjjVnycmzTVOUDzq21Nz6txFSqUD6iY5/d1drun4pqgY11AdgaB/sHlKPNj9fHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682759; c=relaxed/simple;
	bh=LwVnr6vUZJ8PLHSoHLAKty2YLacWj0jo5spgQMUcZG4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I7JkL27NLu5yjY4Bw2tHbtuDiZwvsHfseg4Y9qc0lFSOl1T3vBQ0zbXlM7fk2r629wlyUA0IIudwbe8ZkmYh2DBpMVlucm4Xko8riDOFtvb8VNH2pFyaanB2iI50QgW71q541KX/FNyLoumdMpnP+EKycXJw1ZoW2qLoG/6NVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8pbYtER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WClWbnu+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYo62e/cP5QggUAJrtNNFVUGB+agCgJS0s1HyWx6D98=;
	b=b8pbYtERKrcKCeE/7RBd6vq8q/fQQE9/hqL4NtuYET/9fioAnKoBk0okQGALCnyUiLY30T
	9Ri701b4wRdHh5xhXVrUoKF/Abkp5H/1kN/VD33OZUEd4xuzcicYFwnTaUn0Neyt9WdM6x
	660jN7T5XsQhyS324HxZqqIT0NKU1N5HEi2+jpYEsqh2cf+Ph3s02Xpcm5Jtp2ZovxgTst
	NnNeQFAwF4NHzFdvpcUJl19GUW42LBgCCz6gIX6sZMzx4vPBI8XARF4Yt6dMLwJGH3syU/
	/jBR+sTwUDIj/zuFxU1RLR22aIAUoqI6AhJv63O2AgwiwYjY9DW0ncNU/0od4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYo62e/cP5QggUAJrtNNFVUGB+agCgJS0s1HyWx6D98=;
	b=WClWbnu+yKxEiDRgnUn+gXmDoW0NfgG91JrgV8HBeV/4GM5jqISN7jAnRYiboGFzgXfayW
	P+Vyv29nr6o5cbAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_1SRC2
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.394654786@infradead.org>
References: <20250714103440.394654786@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275506.1420.5011504304600644034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     af4fe07aa1e07610d3208a85210b896c87e2105e
Gitweb:        https://git.kernel.org/tip/af4fe07aa1e07610d3208a85210b896c87e=
2105e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:40:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:06 +02:00

KVM: x86: Introduce EM_ASM_1SRC2

Replace the FASTOP1SRC2*() instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.394654786@infradead.org
---
 arch/x86/kvm/emulate.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9a78540..beac2f4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -317,6 +317,24 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
 	EM_ASM_END
=20
+/* 1-operand, using "c" (src2) */
+#define EM_ASM_1SRC2(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_1(op##b, cl); break; \
+	case 2: __EM_ASM_1(op##w, cx); break; \
+	case 4: __EM_ASM_1(op##l, ecx); break; \
+	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
+	EM_ASM_END
+
+/* 1-operand, using "c" (src2) with exception */
+#define EM_ASM_1SRC2EX(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_1_EX(op##b, cl); break; \
+	case 2: __EM_ASM_1_EX(op##w, cx); break; \
+	case 4: __EM_ASM_1_EX(op##l, ecx); break; \
+	ON64(case 8: __EM_ASM_1_EX(op##q, rcx); break;) \
+	EM_ASM_END
+
 /* 2-operand, using "a" (dst), "d" (src) */
 #define EM_ASM_2(op) \
 	EM_ASM_START(op) \
@@ -1074,10 +1092,10 @@ EM_ASM_2(cmp);
 EM_ASM_2(test);
 EM_ASM_2(xadd);
=20
-FASTOP1SRC2(mul, mul_ex);
-FASTOP1SRC2(imul, imul_ex);
-FASTOP1SRC2EX(div, div_ex);
-FASTOP1SRC2EX(idiv, idiv_ex);
+EM_ASM_1SRC2(mul, mul_ex);
+EM_ASM_1SRC2(imul, imul_ex);
+EM_ASM_1SRC2EX(div, div_ex);
+EM_ASM_1SRC2EX(idiv, idiv_ex);
=20
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
@@ -4103,10 +4121,10 @@ static const struct opcode group3[] =3D {
 	I(DstMem | SrcImm | NoWrite, em_test),
 	I(DstMem | SrcNone | Lock, em_not),
 	I(DstMem | SrcNone | Lock, em_neg),
-	F(DstXacc | Src2Mem, em_mul_ex),
-	F(DstXacc | Src2Mem, em_imul_ex),
-	F(DstXacc | Src2Mem, em_div_ex),
-	F(DstXacc | Src2Mem, em_idiv_ex),
+	I(DstXacc | Src2Mem, em_mul_ex),
+	I(DstXacc | Src2Mem, em_imul_ex),
+	I(DstXacc | Src2Mem, em_div_ex),
+	I(DstXacc | Src2Mem, em_idiv_ex),
 };
=20
 static const struct opcode group4[] =3D {

