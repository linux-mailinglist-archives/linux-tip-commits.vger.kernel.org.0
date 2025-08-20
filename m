Return-Path: <linux-tip-commits+bounces-6300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FCB2D925
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC96A078B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB02DEA70;
	Wed, 20 Aug 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4paGCzZu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZbcKkWE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B32DD608;
	Wed, 20 Aug 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682814; cv=none; b=vFmr049xxsTt65HS6XLUfTELoRVCiydQBTZpiaf1/wU9Subd4Fw6dvd/qMmbOz1DlqUrkzsN30RnKV39rBq7vs9n0ikOuizU3s9vR1rhkcsTtEQyGknhpSET7xL0K7s883AboBW5pFUvIEabmTUpRgXwh//vkV9c/ua10z++WqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682814; c=relaxed/simple;
	bh=2CIc3f2A5uq61+fkOPrjcfh3YxbLhuliW4QrN3LVpwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D0wUx0nYjNyrfm/Nj7xnkxsSPgrHmgoOa+oYvNjAmIwe7k3X/lRvXjf+ASMwh39DZfv5OgXiX/jf8uXFrYvNslH9x7hB0/dRBtYWsWOZoG+4nHqBLoCkbIcompzajjFPPjkePW0LocnffRL6jReWpJkQg6EEBFapex7oOjTRXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4paGCzZu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZbcKkWE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwK+IJssjhYvlynSmUHIZBVaRcciKf2IHsQKsrvHKw=;
	b=4paGCzZudxh3ViRY//M1S3cgn6y8CmeSGEOuLOYlEiqSLEI0PFOMDRlol6XeP57piP73Et
	ScIHC9Wec051zkMcEXU29K8hdl1WibwiHA0MqJzvAKGTEWSjgTWowvUDMriqm29tW9JX6i
	w4y8Uz/cSsqciXqCfruS7h05C0Ca0UoltGc/xKlIdkaNcpZCkGv+XRSHE8BHGndOX1RXAO
	eQ5aJ8HWaPEXzYq4avDlCxVuQI/G4d7ZnjVd0yISY/e4+XWn2gpZGk6/EjoDLxu/77FRvP
	gVVYxbb9mWUYi2mp4EhwnvhZoaVCn8tACGciywPtDEgRc5aiDasrMhPC8iBo4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwK+IJssjhYvlynSmUHIZBVaRcciKf2IHsQKsrvHKw=;
	b=ZZbcKkWEKV1oPi4GRskH3Q+nkbDCK252jWhk3cDEDBylKRlutjavowhMoGIZE5bFyW4Y/3
	BwX40c5KJxj1FMAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] KVM: x86: Implement test_cc() in C
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103439.637049932@infradead.org>
References: <20250714103439.637049932@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568276176.1420.8431160984457501313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0cb6f1e436accba7882bb3115408d1474c1e14af
Gitweb:        https://git.kernel.org/tip/0cb6f1e436accba7882bb3115408d1474c1=
e14af
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 01 Dec 2023 18:53:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:04 +02:00

KVM: x86: Implement test_cc() in C

Current test_cc() uses the fastop infrastructure to test flags using
SETcc instructions. However, int3_emulate_jcc() already fully
implements the flags->CC mapping, use that.

Removes a pile of gnarly asm.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103439.637049932@infradead.org
---
 arch/x86/include/asm/text-patching.h | 20 ++++++++++------
 arch/x86/kvm/emulate.c               | 34 +--------------------------
 2 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text=
-patching.h
index 5337f1b..f2d142a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -178,9 +178,9 @@ void int3_emulate_ret(struct pt_regs *regs)
 }
=20
 static __always_inline
-void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigne=
d long disp)
+bool __emulate_cc(unsigned long flags, u8 cc)
 {
-	static const unsigned long jcc_mask[6] =3D {
+	static const unsigned long cc_mask[6] =3D {
 		[0] =3D X86_EFLAGS_OF,
 		[1] =3D X86_EFLAGS_CF,
 		[2] =3D X86_EFLAGS_ZF,
@@ -193,15 +193,21 @@ void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsi=
gned long ip, unsigned lo
 	bool match;
=20
 	if (cc < 0xc) {
-		match =3D regs->flags & jcc_mask[cc >> 1];
+		match =3D flags & cc_mask[cc >> 1];
 	} else {
-		match =3D ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
-			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		match =3D ((flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
 		if (cc >=3D 0xe)
-			match =3D match || (regs->flags & X86_EFLAGS_ZF);
+			match =3D match || (flags & X86_EFLAGS_ZF);
 	}
=20
-	if ((match && !invert) || (!match && invert))
+	return (match && !invert) || (!match && invert);
+}
+
+static __always_inline
+void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigne=
d long disp)
+{
+	if (__emulate_cc(regs->flags, cc))
 		ip +=3D disp;
=20
 	int3_emulate_jmp(regs, ip);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 1349e27..9526d69 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -26,6 +26,7 @@
 #include <asm/debugreg.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
+#include <asm/text-patching.h>
=20
 #include "x86.h"
 #include "tss.h"
@@ -416,31 +417,6 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_=
t fop);
 	ON64(FOP3E(op##q, rax, rdx, cl)) \
 	FOP_END
=20
-/* Special case for SETcc - 1 instruction per cc */
-#define FOP_SETCC(op) \
-	FOP_FUNC(op) \
-	#op " %al \n\t" \
-	FOP_RET(op)
-
-FOP_START(setcc)
-FOP_SETCC(seto)
-FOP_SETCC(setno)
-FOP_SETCC(setc)
-FOP_SETCC(setnc)
-FOP_SETCC(setz)
-FOP_SETCC(setnz)
-FOP_SETCC(setbe)
-FOP_SETCC(setnbe)
-FOP_SETCC(sets)
-FOP_SETCC(setns)
-FOP_SETCC(setp)
-FOP_SETCC(setnp)
-FOP_SETCC(setl)
-FOP_SETCC(setnl)
-FOP_SETCC(setle)
-FOP_SETCC(setnle)
-FOP_END;
-
 FOP_START(salc)
 FOP_FUNC(salc)
 "pushf; sbb %al, %al; popf \n\t"
@@ -1068,13 +1044,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
=20
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flag=
s)
 {
-	u8 rc;
-	void (*fop)(void) =3D (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
-
-	flags =3D (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=3Da"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(=
flags));
-	return rc;
+	return __emulate_cc(flags, condition & 0xf);
 }
=20
 static void fetch_register_operand(struct operand *op)

