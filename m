Return-Path: <linux-tip-commits+bounces-4869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E4A858FB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E87B18994A7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5F4234239;
	Fri, 11 Apr 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zloMFzdd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHhQoy9o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D02D3A66;
	Fri, 11 Apr 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365734; cv=none; b=QBArMZhNYOs+PNEU8a4Ibm5ABh8pJ7IxC7ItwuiZJ5bzu5fSprhFOAqNcswyyDIMXf2XnDoZ1WzVIYhcBVjfl5hbvIqbVM2BpoLXuiofSefU96Xw3vm++EpirIiEDZpCsFKZClMUyUL+B0Zz0L51aSb3Z5/DtrEjba/HcsqOq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365734; c=relaxed/simple;
	bh=cwv8h2CT31HvmOd6Cs2t7RKZPUicCfeFcP5OaJR3jVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Flg9km6kUS3LB9e3pfbiSpzGM7LrMhe7Sob+mwWukpJgpKSN5+lfGateDMrZHUL0qlDMvbDq1mFHpGsyz2TDzRGdTc2pHSltmo5wVLyftr+I1YhHQk2BnApudrqxJ0uJQwKCEFQ5xsuJ9o29p7GrWMFG4+zOZqP1u8SXgPvBp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zloMFzdd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHhQoy9o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOQEDvs0WdGc05jPRemAaXxmJFAt98r5VkWISDiWI/c=;
	b=zloMFzdd2zoLz99ez540IaEL79GLKjPM9Y/OfYfl1OqpF6W+IYOw/60M15ue1BFHVbuPe9
	ePSA4aLSyVjaVxoqsCBoUFSoYGrJOq5bf9+FlQxK7beao+qI1Vw0dpN/aJXwxAwyYn4iWH
	cWsR+0KGO/7N15JmSKI+C5lzDzaTy59zu5H8VcnnrZVsZN36tSa5+wLdEcZwWDgzOCmokE
	OGX3ONTUifcayIWPhFkQGvHqdcfiAcP1cwqF5huKL03v1Yg1ZdbNXBQhTNbNsa/1uEArWT
	i0mQBNLm0sXodbbSJ3EX84PrKiSQ+lGDHWBx1rm7BTkIfIgaWI7m5F42RZPHQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOQEDvs0WdGc05jPRemAaXxmJFAt98r5VkWISDiWI/c=;
	b=vHhQoy9o9OQObWh072Hqx0kABTMKoYMadoAgAwH+6WJ/6N8R3z33Tj7rQGuelXJb/CaWdX
	xAuiU8y/0iAqw4CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'struct
 text_poke_loc' to 'struct smp_text_poke_loc'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-19-mingo@kernel.org>
References: <20250411054105.2341982-19-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572820.31282.13660489179368249679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a81d43c46e6e89fef1961147c5f3faca31f6b84e
Gitweb:        https://git.kernel.org/tip/a81d43c46e6e89fef1961147c5f3faca31f6b84e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'struct text_poke_loc' to 'struct smp_text_poke_loc'

Make it clear that this structure is part of the INT3 based
SMP patching facility, not the regular text_poke*() MM-switch
based facility.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-19-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebfd364..9abb8f0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2455,7 +2455,7 @@ void text_poke_sync(void)
  * this thing. When len == 6 everything is prefixed with 0x0f and we map
  * opcode to Jcc.d8, using len to distinguish.
  */
-struct text_poke_loc {
+struct smp_text_poke_loc {
 	/* addr := _stext + rel_addr */
 	s32 rel_addr;
 	s32 disp;
@@ -2467,7 +2467,7 @@ struct text_poke_loc {
 };
 
 struct text_poke_int3_vec {
-	struct text_poke_loc *vec;
+	struct smp_text_poke_loc *vec;
 	int nr_entries;
 };
 
@@ -2494,14 +2494,14 @@ static __always_inline void put_desc(void)
 	raw_atomic_dec(refs);
 }
 
-static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
+static __always_inline void *text_poke_addr(struct smp_text_poke_loc *tp)
 {
 	return _stext + tp->rel_addr;
 }
 
 static __always_inline int patch_cmp(const void *key, const void *elt)
 {
-	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
+	struct smp_text_poke_loc *tp = (struct smp_text_poke_loc *) elt;
 
 	if (key < text_poke_addr(tp))
 		return -1;
@@ -2513,7 +2513,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_int3_vec *desc;
-	struct text_poke_loc *tp;
+	struct smp_text_poke_loc *tp;
 	int ret = 0;
 	void *ip;
 
@@ -2544,7 +2544,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	 */
 	if (unlikely(desc->nr_entries > 1)) {
 		tp = __inline_bsearch(ip, desc->vec, desc->nr_entries,
-				      sizeof(struct text_poke_loc),
+				      sizeof(struct smp_text_poke_loc),
 				      patch_cmp);
 		if (!tp)
 			goto out_put;
@@ -2592,8 +2592,8 @@ out_put:
 	return ret;
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
-static struct text_poke_loc tp_vec[TP_VEC_MAX];
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
+static struct smp_text_poke_loc tp_vec[TP_VEC_MAX];
 static int tp_vec_nr;
 
 /**
@@ -2617,7 +2617,7 @@ static int tp_vec_nr;
  *		  replacing opcode
  *	- sync cores
  */
-static void smp_text_poke_batch_process(struct text_poke_loc *tp, unsigned int nr_entries)
+static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned int nr_entries)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -2762,7 +2762,7 @@ static void smp_text_poke_batch_process(struct text_poke_loc *tp, unsigned int n
 	}
 }
 
-static void text_poke_int3_loc_init(struct text_poke_loc *tp, void *addr,
+static void text_poke_int3_loc_init(struct smp_text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
@@ -2843,7 +2843,7 @@ static void text_poke_int3_loc_init(struct text_poke_loc *tp, void *addr,
  */
 static bool tp_order_fail(void *addr)
 {
-	struct text_poke_loc *tp;
+	struct smp_text_poke_loc *tp;
 
 	if (!tp_vec_nr)
 		return false;
@@ -2873,7 +2873,7 @@ void smp_text_poke_batch_finish(void)
 
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct text_poke_loc *tp;
+	struct smp_text_poke_loc *tp;
 
 	smp_text_poke_batch_flush(addr);
 
@@ -2894,7 +2894,7 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct text_poke_loc tp;
+	struct smp_text_poke_loc tp;
 
 	text_poke_int3_loc_init(&tp, addr, opcode, len, emulate);
 	smp_text_poke_batch_process(&tp, 1);

