Return-Path: <linux-tip-commits+bounces-6296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5AB2D910
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB823A55F3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F92F0C70;
	Wed, 20 Aug 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2Q1ceKn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AE6Lbzvh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE2EE26D;
	Wed, 20 Aug 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682762; cv=none; b=U+T23Mbj6fxfu1no9fqYEXo/UsrK/h1xBd2NhTVbJ+I0+v1VxnkWnt/68odQf6GyQxYe7XGNGA7wLtNkD9Cav1PNAzYdw8a0QKddnE66NErVR6n1PxVZfEUuqv1l5FUGW4gk5UlMOgLPD4mpkB/gMZUrw6cR1OVD0nlqYRk2PMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682762; c=relaxed/simple;
	bh=z4Bco/EApdlO5NjXjFnapez10Bk3uJ1UsgJU6qU2hKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dtlfssGplChCsYb9hd5w9BgB1rrCYRSLYtN9MnwztXZp2SknZeGWWABz7H5HOsz93lSw5sZ6T2p9Tz75YO3/4SWmlf3UChkfmgmqfH5tLqAgZ1WTuV84WOXMvLhibtEnQDMxF9UMl4qrrLRJhxK5CrmKK2UeVh8i/hbrBdjBep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2Q1ceKn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AE6Lbzvh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3TGEKO8wmgjyCyq1ReQd3oevuFwu31cYkFRaHKnJvg=;
	b=G2Q1ceKnK3v8RTCGkm2Kewak+eR0ro9VUryaEZzJacxWiyezxJVgc5U7ZzpvQBEAChRAi6
	zBaKBzP6Nzco6uoxXD0OLj/sA2BphHDy6eJAmPB/9ZLdh6qol5hwj4qR/H2r6U77U5coKG
	2b3VWsXYC+R9D0FmMLAs+kA3MP9ETpa2upnAg4C4NY1Tzr2R/sK4JG8APnIWy8809VuTFS
	1oV54X8WWcrG9qC+7YnezMKmBoKWaWrvcTGvgeJGTV/F3VDEDDi7luIwZaX+mwpNTCQ3rv
	tVA4ZZWJQy/onhFHhZYZLR+U8P+wMuOG4wB2sNqqYkfQTIEKgch5krtOUoOevg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3TGEKO8wmgjyCyq1ReQd3oevuFwu31cYkFRaHKnJvg=;
	b=AE6Lbzvhw2utIWqm4Dw/4+LEHeyJ9L5PIaj/6dmeEL496tQ4Hq8SGBnuzPAqF5GlaTdg6q
	oFnO+2O1mtWZ9bBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_2R
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.024933524@infradead.org>
References: <20250714103440.024933524@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275833.1420.2447057313197360538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2df2b52c98db03c10ebe93fa270b1e2baf47f8a0
Gitweb:        https://git.kernel.org/tip/2df2b52c98db03c10ebe93fa270b1e2baf4=
7f8a0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:52:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:05 +02:00

KVM: x86: Introduce EM_ASM_2R

Replace the FASTOP2R instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.024933524@infradead.org
---
 arch/x86/kvm/emulate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index ec4793f..7af30ef 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -326,6 +326,15 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
 	EM_ASM_END
=20
+/* 2-operand, reversed */
+#define EM_ASM_2R(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_2(op##b, dl, al); break; \
+	case 2: __EM_ASM_2(op##w, dx, ax); break; \
+	case 4: __EM_ASM_2(op##l, edx, eax); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rdx, rax); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1077,8 +1086,7 @@ FASTOP2W(bts);
 FASTOP2W(btr);
 FASTOP2W(btc);
=20
-
-FASTOP2R(cmp, cmp_r);
+EM_ASM_2R(cmp, cmp_r);
=20
 static int em_bsf_c(struct x86_emulate_ctxt *ctxt)
 {
@@ -4336,12 +4344,12 @@ static const struct opcode opcode_table[256] =3D {
 	I2bv(DstAcc | SrcMem | Mov | MemAbs, em_mov),
 	I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable, em_mov),
 	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
-	F2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
+	I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
 	/* 0xA8 - 0xAF */
 	I2bv(DstAcc | SrcImm | NoWrite, em_test),
 	I2bv(SrcAcc | DstDI | Mov | String, em_mov),
 	I2bv(SrcSI | DstAcc | Mov | String, em_mov),
-	F2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
+	I2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
 	/* 0xB0 - 0xB7 */
 	X8(I(ByteOp | DstReg | SrcImm | Mov, em_mov)),
 	/* 0xB8 - 0xBF */

