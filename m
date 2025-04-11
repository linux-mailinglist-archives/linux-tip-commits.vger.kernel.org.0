Return-Path: <linux-tip-commits+bounces-4881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D2A8590A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FF2189E7DF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616029AB04;
	Fri, 11 Apr 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qvJN/T1d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKRh3NiJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B429B214;
	Fri, 11 Apr 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365743; cv=none; b=Z8NwMRO4vORd62sCsI5QbOsh0TCrz+7Z14OJcWCLKa8h/obauXiqybg4iPN+QHU4XBhc2ZeY2dLDSKrSmZfL3K68p832FRzuBUwaoc5zp4H1DoAeY8ocIG3MEjQO5LdUYENvqgyMhEFBN60NZlawFxm92kfl2/LfLlHGDbxw+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365743; c=relaxed/simple;
	bh=d2j8JqGgCwmcZUfFuBnhj88PsErUTtS7Y1q4LDxXxwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H0RrCr8yjeYhcEJK/csV7lKj7znwk5kBLUwW+E7IBI2FeWGq216tauhEXVAEQbOIQEyppvO7uks5++HrHoGx+NCdddRXo/mKOfk5r/11/SJ7l6aEnQrzZq77+5H+vbkFtcvvN4H3Dz+IipxeXcRLL9z/6fntFEPrXt0xqwo9roQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qvJN/T1d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKRh3NiJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0k7Iaui3kZzdPNFKyepVMKjEfZLrX+KnaMDeZQebwGY=;
	b=qvJN/T1dC/CuP9UPx6NGu0GfYdbC/5IGKRbkBMDjxixtq5DT0RVCTzD2zEI/4cSPbfLFZa
	HOotxPD+eA5w7+gnvzk78AWeQEC9kp4eja3sVVlSZo4UC6T44fhm5P2hGRZtSmsBvw8yLy
	ayu7gBp5YqyKJD8Cxp8y1s60L1qzu/AUfG0+jsKqJPM0clK7C78+0MkERVXT0Gt05kvDMB
	JCkoFe47dRrWjtpqNeq5tsXtceOIh+Pb1iJejEtuOoAUevmB48GZj1YABkSWNtCxBN7TZr
	n9AlNML/LdqDgYCp4aFcfYPS15Bv5NP7Ua9iVv/6sK3AqtN/UqRs3ezLzrztpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0k7Iaui3kZzdPNFKyepVMKjEfZLrX+KnaMDeZQebwGY=;
	b=eKRh3NiJ0+/HGRCl6trS7EMHOiMnmnDlcp+W2aLThODbuSDcgbObrp+UeT3K1NenTl29/a
	fpkbKlICb1GzIvBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename
 'text_poke_bp_batch()' to 'smp_text_poke_batch_process()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-6-mingo@kernel.org>
References: <20250411054105.2341982-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573939.31282.2783999910189511914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     bee4fcfbc128c3ad604539f88307dc2c0fc6f843
Gitweb:        https://git.kernel.org/tip/bee4fcfbc128c3ad604539f88307dc2c0fc6f843
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_bp_batch()' to 'smp_text_poke_batch_process()'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-6-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9bd71c0..78024e5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2467,7 +2467,7 @@ struct text_poke_loc {
 	u8 len;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
-	/* see text_poke_bp_batch() */
+	/* see smp_text_poke_batch_process() */
 	u8 old;
 };
 
@@ -2540,7 +2540,7 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	/*
-	 * Discount the INT3. See text_poke_bp_batch().
+	 * Discount the INT3. See smp_text_poke_batch_process().
 	 */
 	ip = (void *) regs->ip - INT3_INSN_SIZE;
 
@@ -2602,7 +2602,7 @@ static struct text_poke_loc tp_vec[TP_VEC_MAX];
 static int tp_vec_nr;
 
 /**
- * text_poke_bp_batch() -- update instructions on live kernel on SMP
+ * smp_text_poke_batch_process() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
  * @nr_entries:		number of entries in the vector
  *
@@ -2622,7 +2622,7 @@ static int tp_vec_nr;
  *		  replacing opcode
  *	- sync cores
  */
-static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
+static void smp_text_poke_batch_process(struct text_poke_loc *tp, unsigned int nr_entries)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -2866,7 +2866,7 @@ static bool tp_order_fail(void *addr)
 static void text_poke_flush(void *addr)
 {
 	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
-		text_poke_bp_batch(tp_vec, tp_vec_nr);
+		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
 		tp_vec_nr = 0;
 	}
 }
@@ -2902,5 +2902,5 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 	struct text_poke_loc tp;
 
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
-	text_poke_bp_batch(&tp, 1);
+	smp_text_poke_batch_process(&tp, 1);
 }

