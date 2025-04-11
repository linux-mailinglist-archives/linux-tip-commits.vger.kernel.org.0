Return-Path: <linux-tip-commits+bounces-4842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8470A858B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C124C171E7F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC129C349;
	Fri, 11 Apr 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bfONl26x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCjMuZl/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC29B22A;
	Fri, 11 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365706; cv=none; b=AVjCaeyinwloysbEZEgB2o6x5MsX2lEOuOlwCtkxKbgsNsPTY7xMjKtz90ErsyUUTcwlT4neJXPBYvhB51Ywv7jSHepcBiEanq6swCSWEf39yVSkVkY9yrqAF0nId07HOK/3DuRLDoRCAf7p+PP30Q+s+aTfCvT2jHCc5pzDXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365706; c=relaxed/simple;
	bh=sIs1X+HgjtqVfFCy270Ah7tkSQusIICi9NW3ffJkm8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nQAkB1jBWx+tg38irY0Yoz9r1b06jjI5ncBJCFgLACNDcPdb4ejRZlmBo95F7QMjGUMCi9Y2eZBj4b+PMB0c95d8upH9+6oZUps4yyImvnJrC1JqzawnvCWAlkKM3hjBJ4eFMvgOmwyVPVxo6U9RYZgnI/7iL5dqzhzLRzBblus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bfONl26x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCjMuZl/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljUMMSOZ3RB2FLlleuND0VV8bb1rvsQgh0M2xpiw+rw=;
	b=bfONl26xiD9DEDhG8MKUGCeLYQ7bVBR+FNJTOoltFJbo7bqBFjfTuP2KRbYUdf20RSaYKB
	C8ARyclEZEtPYScSt1wij8W1FN9EKdfkHnzR+Yk/OxiKY+YQcYEeKB8pbaUdFryvGO9412
	TYqV504+XC5sXN2pQa9Zb9kK5+lqWFYuD0vDg6cKMeuglm4niVhh0pK5DFpeEK7lO/DHof
	N53bdXYgqHpcQUtZ3lUxlFdCiCXte0OE0FLuVe7u9iYbJHzRqyDlCwflHYNlTspCA8WAUA
	HPtUZzdJEc2bUWuWyzbhQwIbVkkokMB3ZPsjBxPbvK/rumWmvx2QLl+ta6zHUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljUMMSOZ3RB2FLlleuND0VV8bb1rvsQgh0M2xpiw+rw=;
	b=yCjMuZl/Jgu8Z6islvxQplRdHNFuewhdSvOiCyXPAJF+INkcGKUtTCya6Tt6gxMq1wrME1
	XE11oQoPAl6FHsBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Move declarations of
 vmlinux.lds.S defined section symbols to <asm/alternative.h>
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-49-mingo@kernel.org>
References: <20250411054105.2341982-49-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570097.31282.7563580379273077780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     b1bb39185df6f5ddafcb912304b73e70c6b70c5f
Gitweb:        https://git.kernel.org/tip/b1bb39185df6f5ddafcb912304b73e70c6b70c5f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:41:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Move declarations of vmlinux.lds.S defined section symbols to <asm/alternative.h>

Move it from the middle of a .c file next to the similar declarations
of __alt_instructions[] et al.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-49-mingo@kernel.org
---
 arch/x86/include/asm/alternative.h | 6 ++++++
 arch/x86/kernel/alternative.c      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4a37a8b..ef84739 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -82,6 +82,12 @@ struct alt_instr {
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 
+extern s32 __retpoline_sites[], __retpoline_sites_end[];
+extern s32 __return_sites[],	__return_sites_end[];
+extern s32 __cfi_sites[],	__cfi_sites_end[];
+extern s32 __ibt_endbr_seal[],	__ibt_endbr_seal_end[];
+extern s32 __smp_locks[],	__smp_locks_end[];
+
 /*
  * Debug flag that can be tested to see whether alternative
  * instructions were patched in already:
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index eb3be5d..cd828c2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -149,12 +149,6 @@ static void add_nop(u8 *buf, unsigned int len)
 		*buf = INT3_INSN_OPCODE;
 }
 
-extern s32 __retpoline_sites[], __retpoline_sites_end[];
-extern s32 __return_sites[], __return_sites_end[];
-extern s32 __cfi_sites[], __cfi_sites_end[];
-extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
-extern s32 __smp_locks[], __smp_locks_end[];
-
 /*
  * Matches NOP and NOPL, not any of the other possible NOPs.
  */

