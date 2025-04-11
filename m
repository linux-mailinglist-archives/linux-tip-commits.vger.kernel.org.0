Return-Path: <linux-tip-commits+bounces-4860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F3A858EA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EED1BC2EDC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8D2D1F7A;
	Fri, 11 Apr 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elc5no+W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNPX2oWJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681C2D1F62;
	Fri, 11 Apr 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365725; cv=none; b=TnSaXb4GMPvTFJ7jfisMRYiAWjq++XfI1TvHa2/yMc30KJ1GdPDbyumNsLt141UzIMBNCasJ+Pdp9hwXSAFfEw3/Y1XnJO4g8hyLw2ZH2Twgkf5X0IS0NeSfmpeJ0lyUSIXcd5ZtKPQclHkHKRhhVFgPm/po9q1Wjw2b/9LVkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365725; c=relaxed/simple;
	bh=/nC/r/l9sxdhdBJjOPesHDcctOGzsl6TmNcp2LF/lWc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VxuI6tJvB6AP8FHI7Uen458Wx0BxbLpA0n61PGvtqRxYIx+1JJm/DCjKe9O9rRaNyGLDIh83JHVQNsr6kP1m91mfW0T8mhHbrpz+2zWFY2zs0aQdMNkaJS/LTalcl6HnDSYXKHvV6yibyruJBiPOAZGguus/KLMPkIItlfZ82kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elc5no+W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNPX2oWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cINCL9IrSwwNUKUd26WyxzAy/umD/y+50ARCjHppfm8=;
	b=elc5no+Wsr/GQu8aLvAg2igV5f1SvuWmIsskbkuMgIwBO7K3DQjyoNYfhXNXT73z48fN2B
	m5ks9QFRdXPxdsmQ5KKQciePNiMGcsxenmEP8ZxQe12S26OrupYpn3nYPfPKWyHmUyedMb
	sYwopuiUSb63m/dm60+8D7G+PJfNfQJeWUhnDNLXqcIuOmFJ86v9qA4hXRV/SUys9zCVUF
	SLrO9AOGnZwcjdKKYofeedlg9yrro5LMxqum5HklJhZFBRXdLQ6+etOpmDH/O5QTTd9naG
	JQoIP9sY984zdD5giug9tIGqK8BEIecurRHTh/zur0uvx5mNuX1fqbqj3It/FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cINCL9IrSwwNUKUd26WyxzAy/umD/y+50ARCjHppfm8=;
	b=SNPX2oWJTr/g8eOm0dH6NNmiE7pIel+EvnmZ3EYmJ8nZYgHJHMHEBi5VHVpde+MzQsXimf
	d5g80k2ok+jDa8CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Introduce 'struct
 smp_text_poke_array' and move tp_vec and tp_vec_nr to it
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-28-mingo@kernel.org>
References: <20250411054105.2341982-28-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572141.31282.468505243028881550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     6e7dc03aeeb52fb0147c03377e4f44fea780ef53
Gitweb:        https://git.kernel.org/tip/6e7dc03aeeb52fb0147c03377e4f44fea780ef53
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Introduce 'struct smp_text_poke_array' and move tp_vec and tp_vec_nr to it

struct text_poke_array is an equivalent structure to these global variables:

	static struct smp_text_poke_loc tp_vec[TP_VEC_MAX];
	static int tp_vec_nr;

Note that we intentionally mirror much of the naming of
'struct text_poke_int3_vec', which will further highlight
the unecessary layering going on in this code, and will
ease its removal.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-28-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4fa26a4..0af2203 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2467,14 +2467,21 @@ struct smp_text_poke_loc {
 };
 
 struct text_poke_int3_vec {
-	struct smp_text_poke_loc *vec;
 	int nr_entries;
+	struct smp_text_poke_loc *vec;
 };
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
 static struct text_poke_int3_vec int3_vec;
 
+#define TP_ARRAY_NR_ENTRIES_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
+
+static struct smp_text_poke_array {
+	int nr_entries;
+	struct smp_text_poke_loc vec[TP_ARRAY_NR_ENTRIES_MAX];
+} text_poke_array;
+
 static __always_inline
 struct text_poke_int3_vec *try_get_desc(void)
 {
@@ -2510,10 +2517,6 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
-static struct smp_text_poke_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
-
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_int3_vec *desc;
@@ -2538,7 +2541,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	if (!desc)
 		return 0;
 
-	WARN_ON_ONCE(desc->vec != tp_vec);
+	WARN_ON_ONCE(desc->vec != text_poke_array.vec);
 
 	/*
 	 * Discount the INT3. See smp_text_poke_batch_process().
@@ -2627,8 +2630,8 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 
 	lockdep_assert_held(&text_mutex);
 
-	WARN_ON_ONCE(tp != tp_vec);
-	WARN_ON_ONCE(nr_entries != tp_vec_nr);
+	WARN_ON_ONCE(tp != text_poke_array.vec);
+	WARN_ON_ONCE(nr_entries != text_poke_array.nr_entries);
 
 	int3_vec.vec = tp;
 	int3_vec.nr_entries = nr_entries;
@@ -2843,7 +2846,7 @@ static void text_poke_int3_loc_init(struct smp_text_poke_loc *tp, void *addr,
 }
 
 /*
- * We hard rely on the tp_vec being ordered; ensure this is so by flushing
+ * We hard rely on the text_poke_array.vec being ordered; ensure this is so by flushing
  * early if needed.
  */
 static bool text_poke_addr_ordered(void *addr)
@@ -2852,7 +2855,7 @@ static bool text_poke_addr_ordered(void *addr)
 
 	WARN_ON_ONCE(!addr);
 
-	if (!tp_vec_nr)
+	if (!text_poke_array.nr_entries)
 		return true;
 
 	/*
@@ -2861,7 +2864,7 @@ static bool text_poke_addr_ordered(void *addr)
 	 * is violated and we must first flush all pending patching
 	 * requests:
 	 */
-	tp = &tp_vec[tp_vec_nr-1];
+	tp = &text_poke_array.vec[text_poke_array.nr_entries-1];
 	if ((unsigned long)text_poke_addr(tp) > (unsigned long)addr)
 		return false;
 
@@ -2870,9 +2873,9 @@ static bool text_poke_addr_ordered(void *addr)
 
 void smp_text_poke_batch_finish(void)
 {
-	if (tp_vec_nr) {
-		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
-		tp_vec_nr = 0;
+	if (text_poke_array.nr_entries) {
+		smp_text_poke_batch_process(text_poke_array.vec, text_poke_array.nr_entries);
+		text_poke_array.nr_entries = 0;
 	}
 }
 
@@ -2880,9 +2883,9 @@ static void smp_text_poke_batch_flush(void *addr)
 {
 	lockdep_assert_held(&text_mutex);
 
-	if (tp_vec_nr == TP_VEC_MAX || !text_poke_addr_ordered(addr)) {
-		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
-		tp_vec_nr = 0;
+	if (text_poke_array.nr_entries == TP_ARRAY_NR_ENTRIES_MAX || !text_poke_addr_ordered(addr)) {
+		smp_text_poke_batch_process(text_poke_array.vec, text_poke_array.nr_entries);
+		text_poke_array.nr_entries = 0;
 	}
 }
 
@@ -2892,7 +2895,7 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
 
 	smp_text_poke_batch_flush(addr);
 
-	tp = &tp_vec[tp_vec_nr++];
+	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
 	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
 }
 
@@ -2912,9 +2915,9 @@ void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, cons
 	struct smp_text_poke_loc *tp;
 
 	/* Batch-patching should not be mixed with single-patching: */
-	WARN_ON_ONCE(tp_vec_nr != 0);
+	WARN_ON_ONCE(text_poke_array.nr_entries != 0);
 
-	tp = &tp_vec[tp_vec_nr++];
+	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
 	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
 
 	smp_text_poke_batch_finish();

