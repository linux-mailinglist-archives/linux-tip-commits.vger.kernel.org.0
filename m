Return-Path: <linux-tip-commits+bounces-4845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9883EA858C9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C25A1BC2F6D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAE298CA4;
	Fri, 11 Apr 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nucUQehg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M5ihWuaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1529CB54;
	Fri, 11 Apr 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365710; cv=none; b=SwClZVvRAdOwROXZE3fCQ3iBGw3LYyzGLQaAg79RijZOhZxZoMgMDmX2quj1VCMtE9Fz+rX6XmXCGovi/S42gB5jQL6E9nqsHd3Wty3plsZOa/pYGvCj0y1bvywu0yho2osvocUDGqW1Jl4oI5aUQe285cJ1MvEQzOQ30DtzpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365710; c=relaxed/simple;
	bh=KaLfDJWSnx/rQP4pvxGtQPza2e5Te8/Xw+t/3t2n7lc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uwunvKiKxdvp++Q06Z0j5xwdNsenQp5Wp8kpFPF7e3ALNcbE0wdG55cFxk0WyWaGupHpZ4JHCEiqJXJqSMshZyX/rMV1jl4peVRW5mPeG4+/NvkbjkGCACi6stGlJTeIkeKpIOXooqgCSuBwFEFHbAeHqQaORFowjrPXzMoLsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nucUQehg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M5ihWuaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVU6z3YGc9J2xJgjmnUslic6JobQcLLZri31mp8aEqE=;
	b=nucUQehgYHn89IzU12wH8bO71GFo7XnQOfAbv2FOlPnSFx+9xy8pjdwkHkkx6kUvz5yn13
	qwLnqlwXdJCvo4Z/7Od29bm7OZ4f6iZcvo3LSvwyb4ruYWUMCadqyCOhdps9RRgmGrqkH9
	4D54tk0O8VXOv87SBJAJQCJTLpedzq4/MmKqni0lQjoGQSmV7xstwrFhdnZmELAEItgx5J
	2uB1WqdhnIiBH1OD4FDcFplUhZDbUsI7LnRoTIcNd5TtfCvApn88y+AeLOgyhmp4+sRS0v
	Pxhe0NHvQWoAU+tPsd/CubI+vs5p8j9xw3m3Hg7V9w/P5+yex+/VKmjOX7P5cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVU6z3YGc9J2xJgjmnUslic6JobQcLLZri31mp8aEqE=;
	b=M5ihWuaVTtW7P4puFA/pVF/vkNa5OVoH35EPbmVS7DZgXpZxM2qCzTK2QPdRmUJbX/vnsh
	XdCSXtpkt9lxvpCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Standardize on 'tpl' local
 variable names for 'struct smp_text_poke_loc *'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-45-mingo@kernel.org>
References: <20250411054105.2341982-45-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570551.31282.17627435135978345603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     22b9662313034e42c780a9d6ebcc1811d47d359b
Gitweb:        https://git.kernel.org/tip/22b9662313034e42c780a9d6ebcc1811d47d359b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Standardize on 'tpl' local variable names for 'struct smp_text_poke_loc *'

There's no toilet paper in this code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-45-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f278655..c5abcf9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2493,9 +2493,9 @@ static __always_inline void put_text_poke_array(void)
 	raw_atomic_dec(refs);
 }
 
-static __always_inline void *text_poke_addr(const struct smp_text_poke_loc *tp)
+static __always_inline void *text_poke_addr(const struct smp_text_poke_loc *tpl)
 {
-	return _stext + tp->rel_addr;
+	return _stext + tpl->rel_addr;
 }
 
 static __always_inline int patch_cmp(const void *tpl_a, const void *tpl_b)
@@ -2509,7 +2509,7 @@ static __always_inline int patch_cmp(const void *tpl_a, const void *tpl_b)
 
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
-	struct smp_text_poke_loc *tp;
+	struct smp_text_poke_loc *tpl;
 	int ret = 0;
 	void *ip;
 
@@ -2538,20 +2538,20 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	 * Skip the binary search if there is a single member in the vector.
 	 */
 	if (unlikely(text_poke_array.nr_entries > 1)) {
-		tp = __inline_bsearch(ip, text_poke_array.vec, text_poke_array.nr_entries,
+		tpl = __inline_bsearch(ip, text_poke_array.vec, text_poke_array.nr_entries,
 				      sizeof(struct smp_text_poke_loc),
 				      patch_cmp);
-		if (!tp)
+		if (!tpl)
 			goto out_put;
 	} else {
-		tp = text_poke_array.vec;
-		if (text_poke_addr(tp) != ip)
+		tpl = text_poke_array.vec;
+		if (text_poke_addr(tpl) != ip)
 			goto out_put;
 	}
 
-	ip += tp->len;
+	ip += tpl->len;
 
-	switch (tp->opcode) {
+	switch (tpl->opcode) {
 	case INT3_INSN_OPCODE:
 		/*
 		 * Someone poked an explicit INT3, they'll want to handle it,
@@ -2564,16 +2564,16 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 		break;
 
 	case CALL_INSN_OPCODE:
-		int3_emulate_call(regs, (long)ip + tp->disp);
+		int3_emulate_call(regs, (long)ip + tpl->disp);
 		break;
 
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		int3_emulate_jmp(regs, (long)ip + tp->disp);
+		int3_emulate_jmp(regs, (long)ip + tpl->disp);
 		break;
 
 	case 0x70 ... 0x7f: /* Jcc */
-		int3_emulate_jcc(regs, tp->opcode & 0xf, (long)ip, tp->disp);
+		int3_emulate_jcc(regs, tpl->opcode & 0xf, (long)ip, tpl->disp);
 		break;
 
 	default:
@@ -2755,33 +2755,33 @@ static void smp_text_poke_batch_process(void)
 
 static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct smp_text_poke_loc *tp;
+	struct smp_text_poke_loc *tpl;
 	struct insn insn;
 	int ret, i = 0;
 
-	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
+	tpl = &text_poke_array.vec[text_poke_array.nr_entries++];
 
 	if (len == 6)
 		i = 1;
-	memcpy((void *)tp->text, opcode+i, len-i);
+	memcpy((void *)tpl->text, opcode+i, len-i);
 	if (!emulate)
 		emulate = opcode;
 
 	ret = insn_decode_kernel(&insn, emulate);
 	BUG_ON(ret < 0);
 
-	tp->rel_addr = addr - (void *)_stext;
-	tp->len = len;
-	tp->opcode = insn.opcode.bytes[0];
+	tpl->rel_addr = addr - (void *)_stext;
+	tpl->len = len;
+	tpl->opcode = insn.opcode.bytes[0];
 
 	if (is_jcc32(&insn)) {
 		/*
 		 * Map Jcc.d32 onto Jcc.d8 and use len to distinguish.
 		 */
-		tp->opcode = insn.opcode.bytes[1] - 0x10;
+		tpl->opcode = insn.opcode.bytes[1] - 0x10;
 	}
 
-	switch (tp->opcode) {
+	switch (tpl->opcode) {
 	case RET_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
@@ -2790,14 +2790,14 @@ static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len
 		 * next instruction can be padded with INT3.
 		 */
 		for (i = insn.length; i < len; i++)
-			BUG_ON(tp->text[i] != INT3_INSN_OPCODE);
+			BUG_ON(tpl->text[i] != INT3_INSN_OPCODE);
 		break;
 
 	default:
 		BUG_ON(len != insn.length);
 	}
 
-	switch (tp->opcode) {
+	switch (tpl->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
 		break;
@@ -2806,21 +2806,21 @@ static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
 	case 0x70 ... 0x7f: /* Jcc */
-		tp->disp = insn.immediate.value;
+		tpl->disp = insn.immediate.value;
 		break;
 
 	default: /* assume NOP */
 		switch (len) {
 		case 2: /* NOP2 -- emulate as JMP8+0 */
 			BUG_ON(memcmp(emulate, x86_nops[len], len));
-			tp->opcode = JMP8_INSN_OPCODE;
-			tp->disp = 0;
+			tpl->opcode = JMP8_INSN_OPCODE;
+			tpl->disp = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
 			BUG_ON(memcmp(emulate, x86_nops[len], len));
-			tp->opcode = JMP32_INSN_OPCODE;
-			tp->disp = 0;
+			tpl->opcode = JMP32_INSN_OPCODE;
+			tpl->disp = 0;
 			break;
 
 		default: /* unknown instruction */

