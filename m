Return-Path: <linux-tip-commits+bounces-6290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0BB2D914
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F475C6585
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35B2EB5C8;
	Wed, 20 Aug 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/VQYcDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qveLbLPV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D2EB870;
	Wed, 20 Aug 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682758; cv=none; b=nGX2x++YMEr4Z62RY6ZRAMCb2yzv5oips6Ta9mg6hfftkbn3JccNlK5WNTtjVZcSOHd3cN4Gdrue+YVBHpeAQYG6TAlNXh91fJCxxPcFvJDyzpQnmZ9GD8/A7aFIIbKxnBHizFRgo6HnCAd90GHAqw8q5swF97FpTZ+7c1xP1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682758; c=relaxed/simple;
	bh=cfXgWowaBW3FnOOuec3P96IHA3qx70SVFS2WCX8LABw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G/gILJ0WSuiFCk/P6XxcOvB6I+uBoa6okESLD8P/BMb/Kpl96q19AO/oo4mz3S1kLXFn4296f5mX/ffIwPO4MFspGEKn1d4V8oVl5RPyqt/b8Ph8Gkcsg0RyWtstUuYeIsRQLwk+eluB0eWyN3r7vWqrerkA5rr3U3yNps1JERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/VQYcDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qveLbLPV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnOGf4GDYsHXKJjgeqrAGrBGOwizGCaOtpCBWKhr8Zs=;
	b=F/VQYcDYU6bi2I0dehsaE74tWLjtMj0Y7TclWoimIZlxT3BOutO+ghTHi5I3sCm260+yf1
	SBdTA5kTcwtz3VL4nQT2lstjytq7seOI1M0SklJ3AhaOTQS7WnRCugsD4q6xWHOTDpCYmW
	7L8iQgJS/PorFpcP6685VHt/9aQXplKKReaZ23s/vl+t557E44Unqz5dhYiKlulOYK072s
	4vPM2ptTQuTAU9P3GgtO08ONjvJB4VJJd3VU1MBxEwF5YthuB1t4mTTWytqcifjXHbC3oZ
	JGiPUsY3kbrrpspHzEKENBdb7C7eZWUyoVazF3+YJHalO6frlRN1F2JP9Wq+iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnOGf4GDYsHXKJjgeqrAGrBGOwizGCaOtpCBWKhr8Zs=;
	b=qveLbLPVjMJBgeNK/PUtTcQXcaSOefPZSgmrqWEwskvo5tEaLFCYJiPLs6yIewpQb6wO6F
	t4baFlHJIeSn1HCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Convert em_salc() to C
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.634145269@infradead.org>
References: <20250714103440.634145269@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275286.1420.7244880679755715095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     77892e1fef34db650aa3de4be1d27267ca7f1330
Gitweb:        https://git.kernel.org/tip/77892e1fef34db650aa3de4be1d27267ca7=
f1330
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 13:07:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:06 +02:00

KVM: x86: Convert em_salc() to C

Implement the SALC (Set AL if Carry) instruction in C.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.634145269@infradead.org
---
 arch/x86/kvm/emulate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 390b8a9..94008cd 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -529,11 +529,14 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop=
_t fop);
 	ON64(FOP3E(op##q, rax, rdx, cl)) \
 	FOP_END
=20
-FOP_START(salc)
-FOP_FUNC(salc)
-"pushf; sbb %al, %al; popf \n\t"
-FOP_RET(salc)
-FOP_END;
+static int em_salc(struct x86_emulate_ctxt *ctxt)
+{
+	/*
+	 * Set AL 0xFF if CF is set, or 0x00 when clear.
+	 */
+	ctxt->dst.val =3D 0xFF * !!(ctxt->eflags & X86_EFLAGS_CF);
+	return X86EMUL_CONTINUE;
+}
=20
 /*
  * XXX: inoutclob user must know where the argument is being expanded.
@@ -4423,7 +4426,7 @@ static const struct opcode opcode_table[256] =3D {
 	G(Src2CL | ByteOp, group2), G(Src2CL, group2),
 	I(DstAcc | SrcImmUByte | No64, em_aam),
 	I(DstAcc | SrcImmUByte | No64, em_aad),
-	F(DstAcc | ByteOp | No64, em_salc),
+	I(DstAcc | ByteOp | No64, em_salc),
 	I(DstAcc | SrcXLat | ByteOp, em_mov),
 	/* 0xD8 - 0xDF */
 	N, E(0, &escape_d9), N, E(0, &escape_db), N, E(0, &escape_dd), N, N,

