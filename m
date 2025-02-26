Return-Path: <linux-tip-commits+bounces-3642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C32A45C45
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5293A944C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D5270ECE;
	Wed, 26 Feb 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WInhrX0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tmdw7nDl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129926B08C;
	Wed, 26 Feb 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567266; cv=none; b=CdV5MjCbYZA5RgFqSrQ+Oq7hk6aJpoSUyqwHdrhGUlOzfDPVuOQp8FROi9gRjO0q1CuuBIJ7MNDXypMJXp1LmLCGY3jKec0e1/UbairpLA2xVvkbdXN4GQPmxRnWX9NQHexoHEMtmfbwoNf2mZ9wRMXEsYfVFG8DDSRAXEg8nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567266; c=relaxed/simple;
	bh=0C3SRP/SJCUFIWtehUq63auo8FGU921ckejeqTGEtaY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K5YCO3mXjPJUTwE2VIGo56VLNR0ZZ8WWMKM8YKkH/2tgbnHJKz0DB28xRPJuW3j93jkQmNrtONBEnuFiiwRJ62q4mfm2zr3E2wMm3NEaZkB2Cs6qNHvOs7rGo4B4hGJpacTEWSWc9/V7RydBcsWyg8kcOYuCpqjHEdJ2yIYQQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WInhrX0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tmdw7nDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SFG8pUhSaiCNHBY/Y3L8KZpNmy+cxcslLAGrttOBe0=;
	b=WInhrX0FdFxeTKK6Em+h03FAIqGTcg8bd1qlyJsSeb5m5NgS/nXwuCCrdsCLa2GKNDyB4p
	hGFgEvxaOiCEUtP5YK9W3wV0zCiDad/axvX3z40aZ1obApP1bid96wBnuSqt+gy/jGnuQY
	i4lT8C5FIMaLVU2hMtSoko5e2rQPDpyyfKdLQv6Qn1mroZwesASnHuunO2pmcM+QOSwayg
	4nxck/Gkm64HE0XYqfJUvvCb/XmnjWWoXchSiSRIgpWRlx1Al5D0v8w9aF7QTyUMxnSR44
	C5pRsU6r8WV2s/VVSbwXHeptxz8uMiCwqu5/b7eCmljkPoSxCBqNiI/MHpg0Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SFG8pUhSaiCNHBY/Y3L8KZpNmy+cxcslLAGrttOBe0=;
	b=Tmdw7nDlPMBf2AJscfyhm/nr2Tep1dQTBBkOnHGxkrvhmGuxECQYTXvYImXtDZVlvKcQyk
	tRoy+9ooij6+2SCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Decode 0xEA #UD
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.166774696@infradead.org>
References: <20250224124200.166774696@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726215.10177.5379269621524406320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     dbf3638d81bf009568de02bde9dc5fda9769e672
Gitweb:        https://git.kernel.org/tip/dbf3638d81bf009568de02bde9dc5fda9769e672
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:54 +01:00

x86/traps: Decode 0xEA #UD

FineIBT will start using 0xEA as #UD

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.166774696@infradead.org
---
 arch/x86/include/asm/bug.h |  1 +
 arch/x86/kernel/traps.c    | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 1a5e4b3..bc8a2ca 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -25,6 +25,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
+#define BUG_EA			0xffea
 
 #ifdef CONFIG_GENERIC_BUG
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 05b86c0..a02a51b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -96,6 +96,7 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
  * If it's a UD1, further decode to determine its use:
  *
+ * FineIBT:      ea                      (bad)
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
@@ -113,6 +114,10 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
+	if (v == 0xea) {
+		*len = addr - start;
+		return BUG_EA;
+	}
 	if (v != OPCODE_ESCAPE)
 		return BUG_NONE;
 
@@ -309,10 +314,16 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 
 	switch (ud_type) {
 	case BUG_UD2:
-		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += ud_len;
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+			handled = true;
+			break;
+		}
+		fallthrough;
+
+	case BUG_EA:
+		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
+			break;
 		}
 		break;
 
@@ -328,6 +339,9 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		break;
 	}
 
+	if (handled)
+		regs->ip += ud_len;
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();

