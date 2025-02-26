Return-Path: <linux-tip-commits+bounces-3664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F7A45E5A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF63B6E62
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC37231A37;
	Wed, 26 Feb 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaB7Jhee";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dc2R5vLy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373C2222D7;
	Wed, 26 Feb 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571490; cv=none; b=sGKK6V6u4uoaFuoPlQTeRXv4q4bnCC5NOcV7W1Pi0Gqyg2qREX3q2DwwnStk7gaB1y1tYQvwnhQy6uXUKH2jVZu18jb+a0MPVxfa+b+lBJ8FrsMJgDuq/x8k4BYRKetsmHIMFfmf0we53xYZsJk0qhAN94ShsQEDfJYT/arYVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571490; c=relaxed/simple;
	bh=e6kJ5T03mz9ez78YmMmn9utF2tehfyh2ke+krkuZwJw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vi9Zm/cloVMpLphKbOLHUBiARad/jdpAo7//qw4odBPWU/dQA0dNmYzeFhTnmGvF+Y2WZGwRIzoNgcE29tgAdBCVviLPlOB14AGFDVFLH/pru6QD2/QWhhgo0O5Pv02uD3iGQY+7pHzvawzN9S8F+zFkjKTsFye+L0zULKbA90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaB7Jhee; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dc2R5vLy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl8Acc2EnzyMLDoylgL4eQjeco05YfcvVXP2tNh84KI=;
	b=XaB7JheeJX2bUxywCRDHH+53qW/zcSTRxW7YLRCw7Xf5BrpspMyAlkQUzGM8FGQmP5k4lD
	U3/mCYg/+ZfsjmXNL8LcI2H7pmy7DBx169c8c8Ed19ydOiMF3eMY1ghbB/4vs+BnAuOx8Y
	611Id1k6tTVMLqMK/Vygqf1SYK5KSnqKksXuJ5y/PWqhzq+oDdwRDs7h//BmQmESQ6Qwox
	27EPeOxSyv1L4QRG9P6kqbFe7FyZM7nlCDTJE/Gy4KtbAi12JwNJ/P/1tykHn1NAn1bxfI
	DzN5nz37LqP+KwwnlPZPi8DVlYTnSynLdUC26O0dmKAokgVm98Opx4MjHe80cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl8Acc2EnzyMLDoylgL4eQjeco05YfcvVXP2tNh84KI=;
	b=dc2R5vLy2IcQBY3hFsivHbQxjSIcAeG5+sxG0u32Sf8y8N8cZebkU2UOZ6NBPrGSLcRaMp
	TSBKeriVUUJq+TCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Allow custom fixups in handle_bug()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.275223080@infradead.org>
References: <20250224124200.275223080@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148711.10177.13546581674617919004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e33d805a1005bf7b8a5a53559c81a8e17f0b981b
Gitweb:        https://git.kernel.org/tip/e33d805a1005bf7b8a5a53559c81a8e17f0b981b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:22:39 +01:00

x86/traps: Allow custom fixups in handle_bug()

The normal fixup in handle_bug() is simply continuing at the next
instruction. However upcoming patches make this the wrong thing, so
allow handlers (specifically handle_cfi_failure()) to over-ride
regs->ip.

The callchain is such that the fixup needs to be done before it is
determined if the exception is fatal, as such, revert any changes in
that case.

Additionally, have handle_cfi_failure() remember the regs->ip value it
starts with for reporting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.275223080@infradead.org
---
 arch/x86/kernel/cfi.c   |  8 ++++----
 arch/x86/kernel/traps.c | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index f6905be..77086cf 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -67,16 +67,16 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
  */
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
-	unsigned long target;
+	unsigned long target, addr = regs->ip;
 	u32 type;
 
 	switch (cfi_mode) {
 	case CFI_KCFI:
-		if (!is_cfi_trap(regs->ip))
+		if (!is_cfi_trap(addr))
 			return BUG_TRAP_TYPE_NONE;
 
 		if (!decode_cfi_insn(regs, &target, &type))
-			return report_cfi_failure_noaddr(regs, regs->ip);
+			return report_cfi_failure_noaddr(regs, addr);
 
 		break;
 
@@ -90,7 +90,7 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 		return BUG_TRAP_TYPE_NONE;
 	}
 
-	return report_cfi_failure(regs, regs->ip, &target, type);
+	return report_cfi_failure(regs, addr, &target, type);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a02a51b..c169f3b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -287,11 +287,12 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
+	unsigned long addr = regs->ip;
 	bool handled = false;
 	int ud_type, ud_len;
 	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
+	ud_type = decode_bug(addr, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -339,8 +340,17 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		break;
 	}
 
-	if (handled)
-		regs->ip += ud_len;
+	/*
+	 * When continuing, and regs->ip hasn't changed, move it to the next
+	 * instruction. When not continuing execution, restore the instruction
+	 * pointer.
+	 */
+	if (handled) {
+		if (regs->ip == addr)
+			regs->ip += ud_len;
+	} else {
+		regs->ip = addr;
+	}
 
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();

