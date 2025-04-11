Return-Path: <linux-tip-commits+bounces-4838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A01A858B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8633B1C31
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F8298CD0;
	Fri, 11 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12d+aPRP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlsMMLNF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526829AAF5;
	Fri, 11 Apr 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365703; cv=none; b=nqUGYrnZdRfcCcfuQKt26Y+qHLrmklwOcykO6abOjpEvCIWTAJwgDXbGMH7o0VLac8Y8b+M4A4rOkgWmOkR1Rzh3+0BWXgRKq5sXcwB70SAnWqynyCQvzKY3YNfKYoIE32DmEIcgEae9rrZvCikgungNocdBKwwfcPIDsWlv1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365703; c=relaxed/simple;
	bh=y0Aj07hI1AwTTXvBZ2+Pm6q5UQjMb97rrhqe02sbzU4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B88AhPxO6NtlmPgNuAi5dWdVU/iRh8R+NsEYi3zRgwnc8hCvj+HIV2kAZnIgS+lCI1fmjVKj8SL8l64qQs3n/Z2lsxXASlKRyMSvYWOzVh6Qxb45CF40jklkZVZRhzrd9h+m2t2u90KA+wFUs0va6c6LrUVLCuMPmGTCabWSKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=12d+aPRP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlsMMLNF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uknnqc/WeDv49tP/CFVhGBHh6JcPnzIDVWx3iDUwvPI=;
	b=12d+aPRPZcIvciqTkIw8tXO0lfI83JrUuZIdKr1+tWvE/vGazBciTNJqK3jycgKW6C9/5D
	XSlcb/UJ+4iuRpiU+76HQ0I0JCkdQkagmUJWp3iPl8W1cxgRgEyE+nRit2jPsWVkImd6DU
	SNOvY19bM7ECXZsSvvzWM9NlBNoLTdK+gcn+95Peclv36N6HeTo5B3PCZUbLXXHzlb9wJ9
	mm7iTL9FDY9NW1UNrFhAFDXHGpzYRis6ORmuHwaXxDTDWFu8IRegPrQlK88/JZYi1DSK5p
	lkcE7Ye7WICuqcsiOtWhU+tcbQjvUznqYORNcihHDhBokChGliBB03BhwvROJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uknnqc/WeDv49tP/CFVhGBHh6JcPnzIDVWx3iDUwvPI=;
	b=KlsMMLNFIC2YhekrBQLrmLyqqLuRWpbaBDPdVph9iv7MWgVXwHmOi1oP8Tz8beqk3cl5bh
	00Gn800XNGK9+FDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'apply_relocation()'
 to 'text_poke_apply_relocation()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-52-mingo@kernel.org>
References: <20250411054105.2341982-52-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436569823.31282.8633267618944104333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     023f42dd59203be8ad2fc0574af32d3b4ad041ec
Gitweb:        https://git.kernel.org/tip/023f42dd59203be8ad2fc0574af32d3b4ad041ec
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:41:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Rename 'apply_relocation()' to 'text_poke_apply_relocation()'

Join the text_poke_*() API namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-52-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 6 +++---
 arch/x86/kernel/callthunks.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index a45ac8a..5337f1b 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -15,7 +15,7 @@
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
-extern void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
+extern void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ee6f87..231b2ac 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -340,7 +340,7 @@ static void __apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen,
 	}
 }
 
-void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
+void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
 	__apply_relocation(buf, instr, instrlen, repl, repl_len);
 	optimize_nops(instr, buf, instrlen);
@@ -496,7 +496,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
 
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
@@ -1981,7 +1981,7 @@ __visible noinline void __init __alt_reloc_selftest(void *arg)
 static noinline void __init alt_reloc_selftest(void)
 {
 	/*
-	 * Tests apply_relocation().
+	 * Tests text_poke_apply_relocation().
 	 *
 	 * This has a relative immediate (CALL) in a place other than the first
 	 * instruction and additionally on x86_64 we get a RIP-relative LEA:
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index d86d7d6..a951333 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -185,7 +185,7 @@ static void *patch_dest(void *dest, bool direct)
 	u8 *pad = dest - tsize;
 
 	memcpy(insn_buff, skl_call_thunk_template, tsize);
-	apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
+	text_poke_apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
 
 	/* Already patched? */
 	if (!bcmp(pad, insn_buff, tsize))
@@ -294,7 +294,7 @@ static bool is_callthunk(void *addr)
 	pad = (void *)(dest - tmpl_size);
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
+	text_poke_apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
@@ -312,7 +312,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 		return 0;
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
+	text_poke_apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog += tmpl_size;

