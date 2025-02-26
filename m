Return-Path: <linux-tip-commits+bounces-3666-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B893A45E5F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB83B7275
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4B235347;
	Wed, 26 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBVRGAHb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tgntS3b4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29790222577;
	Wed, 26 Feb 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571491; cv=none; b=VAlVdr6WYx5pjeKbQHheZeK8fL3q5nhSFaIT9ESyRuO8DkkD01iAXx7JGSI876mhyi7wIBE8WeBWGtg8rSdkGrZaK/zQFXH7/w00LfePz7vPJsu4O7fEcnzinjc0K8mPpX1+VSciOcSmo1LrDOueg94LBgloPQQT1AFktbTPsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571491; c=relaxed/simple;
	bh=4mqSQweqk5Ke54tXJllzQ1r7XA3eLTrodB+gqRK4HPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RQa9h13pY/jWRHpeI906749NmZCKfqKMpwoffOyPeIryJYOsd/3BTPluhcnTGwC1TKxSt13bw4PU8HBAjFZcfO6lEKqX7XaV4eWAYcJXbPO0CQjY2l5h0NXxGYFnDq8R8Z/42FiNUUwlrK2VqEOtL7DFYg+deDOtbg3sfG/9HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBVRGAHb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tgntS3b4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kelAVk/r41IjFAA4RvwAdw98C/DFXsLx1YIW8j/x5g=;
	b=IBVRGAHbABdGj1uk3fJ99ahqHV07SuWeVhW/QkPo4lzC8MFSdaUebanD+6qmFYHkpHgtVX
	fTRBrNvoq4a8v/+f5eX4A1ZsLGgebREGcRIyVO466nvOj+QANq7cW4l14Wv8ypY+tKxeUp
	EPRb3HFXivUwkOC3UlmaHRTdyULE0HIbMS4YjCiY0u6yZoiOvJrv6UGgTkhjG5bYgw3tWk
	2VZHgAkN7GxbzkSrARD/GBadHi3FGsgRqVsOOoIJggHRqL/M2gqwNMpSBY21O74Wcn4+f4
	/I1snhx/UJUdhuTT4cUoq0nyMfsc9cPDXZxODPZte0fCXuh6wyiu9L4AlSVj2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kelAVk/r41IjFAA4RvwAdw98C/DFXsLx1YIW8j/x5g=;
	b=tgntS3b4z3z9q04sDtbo+WMBQg6278eXW+QxFTbRXUiDripWvnb+gBKo/MWc/he6CiIni/
	tO3pBzcY2QAXjNBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Decode 0xEA instructions as #UD
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.166774696@infradead.org>
References: <20250224124200.166774696@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148785.10177.16118220702526941186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2e044911be75ce3321c5b3d10205ac0b54f8cb92
Gitweb:        https://git.kernel.org/tip/2e044911be75ce3321c5b3d10205ac0b54f8cb92
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:22:10 +01:00

x86/traps: Decode 0xEA instructions as #UD

FineIBT will start using 0xEA as #UD. Normally '0xEA' is a 'bad',
invalid instruction for the CPU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

