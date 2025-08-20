Return-Path: <linux-tip-commits+bounces-6295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1AB2D91F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01985E0314
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10582EF664;
	Wed, 20 Aug 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBr8XW2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FIJJYAiD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719E2EBB8C;
	Wed, 20 Aug 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682761; cv=none; b=nqoNedxUGnkC6uM4KnrnvuHSTVtj0GKBZCsfWPlhH64W2ugES5UB/BFm7VrcgnuRpiiZOxLmOZK1GgiI3wYtg6+7VycJ75crpHhEKT3LixbvtUKuA2IaINY01DO1McNOIxO+XECKJGftWF8OCFTBrO533kdd3REvK2jnC+3q2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682761; c=relaxed/simple;
	bh=8ZZsPy324zl1mKmVt7SwzqdHcA/J+S9fdOfVKnYCOPM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jOJXX2gq6sRp5rWZY0qYgy+AwZfh7J6nh+Nd9TaYAgYEZa8Hq6jPbhzytAm+WwacJ2ls2b0PqFaTla00bRYGYjhee2RsUwVFGBTTCU2QtlCbPSiO9HfNcIOLBX0SGJ1qV18WDmLUmOgOjgjNXvPaW4iFQkOskSx9aAj211EmKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBr8XW2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FIJJYAiD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENRvQYUNV/N5zjRvSpyUk4z9cys29cAONeVD8hic7ho=;
	b=sBr8XW2uVbI8IQQU3tIfkbw3PqUu9GFHSaZiCU0/ehiEil9mVC20BfN9jkXOo/3ksNiNlF
	u1pY/FruWZVHhygVpbB98g4lN9WrV+BVhbF0lUI5guMEpoHNw79k5r2XB6LxUkVWbdrkJb
	BH+3HA6IltvXx41pM8K7Cljwky4uSCUj0g6VhPlP5QEJKrXgUBaBlXyorqqMpKEdCD+Ec2
	GPcoA7CwnbuvjsGLn4T7CKDyCVgDdtvTlwBDqy7Y2DvD9fqDcWsWrceCxzIpfpTGYj9Yvn
	F0i5wQDI1AVW82CumMfbs54X2PrvpOLtfj7qz74bNI97uwMt4AfecZZ/FqiVJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENRvQYUNV/N5zjRvSpyUk4z9cys29cAONeVD8hic7ho=;
	b=FIJJYAiDfR5OT7oRLFz794DBowVoWip6NWQsqM7JKrCUp5ecH9DV9JvdSBymHqDf92Mb4m
	w9IzSXJyTvb8SbDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Introduce EM_ASM_2CL
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.251039692@infradead.org>
References: <20250714103440.251039692@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275617.1420.14221081669385274315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     67e944aff63cb6b9c236d9cc2b4d870aeefd306f
Gitweb:        https://git.kernel.org/tip/67e944aff63cb6b9c236d9cc2b4d870aeef=
d306f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 26 Apr 2025 12:34:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:06 +02:00

KVM: x86: Introduce EM_ASM_2CL

Replace the FASTOP2CL instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.251039692@infradead.org
---
 arch/x86/kvm/emulate.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 05a97ec..9a78540 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -344,6 +344,15 @@ static int em_##op(struct x86_emulate_ctxt *ctxt) \
 	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
 	EM_ASM_END
=20
+/* 2-operand, using "a" (dst) and CL (src2) */
+#define EM_ASM_2CL(op) \
+	EM_ASM_START(op) \
+	case 1: __EM_ASM_2(op##b, al, cl); break; \
+	case 2: __EM_ASM_2(op##w, ax, cl); break; \
+	case 4: __EM_ASM_2(op##l, eax, cl); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rax, cl); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1080,13 +1089,13 @@ EM_ASM_1(neg);
 EM_ASM_1(inc);
 EM_ASM_1(dec);
=20
-FASTOP2CL(rol);
-FASTOP2CL(ror);
-FASTOP2CL(rcl);
-FASTOP2CL(rcr);
-FASTOP2CL(shl);
-FASTOP2CL(shr);
-FASTOP2CL(sar);
+EM_ASM_2CL(rol);
+EM_ASM_2CL(ror);
+EM_ASM_2CL(rcl);
+EM_ASM_2CL(rcr);
+EM_ASM_2CL(shl);
+EM_ASM_2CL(shr);
+EM_ASM_2CL(sar);
=20
 EM_ASM_2W(bsf);
 EM_ASM_2W(bsr);
@@ -4079,14 +4088,14 @@ static const struct opcode group1A[] =3D {
 };
=20
 static const struct opcode group2[] =3D {
-	F(DstMem | ModRM, em_rol),
-	F(DstMem | ModRM, em_ror),
-	F(DstMem | ModRM, em_rcl),
-	F(DstMem | ModRM, em_rcr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_shr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_sar),
+	I(DstMem | ModRM, em_rol),
+	I(DstMem | ModRM, em_ror),
+	I(DstMem | ModRM, em_rcl),
+	I(DstMem | ModRM, em_rcr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_shr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_sar),
 };
=20
 static const struct opcode group3[] =3D {

