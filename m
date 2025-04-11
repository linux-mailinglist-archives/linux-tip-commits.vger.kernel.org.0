Return-Path: <linux-tip-commits+bounces-4856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDEA858D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BBF7AEE05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD732C374C;
	Fri, 11 Apr 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjs5wVoq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0rwLdBv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4D2BEC5E;
	Fri, 11 Apr 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365720; cv=none; b=B09LwqylZYLngTASBQiY7zPCXQwgJArVwg4yzS3uVGaUHyLLPsHDLskV6bQOFy2V1WR5SotwEsZQXe9pvu91jbUOLdxOMr2bEbFyi3m8y5Cp0fkxGKQXTJf/lhHxM64CNEL2PG6Ffe+CzacgVporn6Y3js7Mfn75VlQQ/iS4Sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365720; c=relaxed/simple;
	bh=JyW3YogkqlYQ73+QKKB4eWHy8iXBbrKbng2z09H457c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m9H/iHKcZsFLsV88u/1n7mo5h3orJu0fc4p4j720ylH9ntTjc6W4ALSeOsu5+agGL0oMHiKTksgcM0qp8eXSSyeIIoWygyMxeY0M+j7ykCzWHA+O9dJRF1aodqeyMH9+FQdI9a2R+nGSopSHOdD/dzZFvTAO09agoHsC0GRyc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjs5wVoq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0rwLdBv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaWN3L7QWmUM9Rk68+TGsw6L49TgGbzbpZYE74peo7o=;
	b=wjs5wVoq3AnNkxZePphL2Vej3wcxBqrouhyXRoR4XsF57wGgegFi2lqevW8EhIKuTzWrQd
	cm78v1ePj3Rw+782QIufhy8RpZy4N1NJ2JLCShLk/2XnfG1r2HvBz/qzwc7o1lRkA2Hbdi
	m0T0zXG+fVdy8zNR38oEfMEz9EnaFzPhMGDQ7roy+TIx9cDuA7GG4qLjPHJoOUUtjgrIx9
	hdff3LD4p7tXUudE5eGi7Yv+KUBPCj2YCFLTSKIiW/daY6cEqyeUv+osXrT77faUkWDVEi
	0Jyk8CIogrnfLJbPQ+DqFKNOrtGbKTyqGcu5UyiDZ7fN4hezSHm6rrkgTVVsuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaWN3L7QWmUM9Rk68+TGsw6L49TgGbzbpZYE74peo7o=;
	b=Y0rwLdBvfyMFqKUHxDbKQe9aqh3jEOsnpCzUIDnsiSNEv4Jnv4e23YWb2WPqyTHY9lL+Et
	iRzszzKYMzqexVCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Simplify
 smp_text_poke_batch_process()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-34-mingo@kernel.org>
References: <20250411054105.2341982-34-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571530.31282.544228203771553647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     74e8e2bf950e8deb0965583e2130f0fb5a705085
Gitweb:        https://git.kernel.org/tip/74e8e2bf950e8deb0965583e2130f0fb5a705085
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Simplify smp_text_poke_batch_process()

This function is now using the text_poke_array state exclusively,
make that explicit by removing the redundant input parameters.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-34-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 43 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 97cb954..08ac3c7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2591,8 +2591,8 @@ out_put:
 
 /**
  * smp_text_poke_batch_process() -- update instructions on live kernel on SMP
- * @tp:			vector of instructions to patch
- * @nr_entries:		number of entries in the vector
+ * @text_poke_array.vec:		vector of instructions to patch
+ * @text_poke_array.nr_entries:	number of entries in the vector
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
@@ -2610,7 +2610,7 @@ out_put:
  *		  replacing opcode
  *	- sync cores
  */
-static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned int nr_entries)
+static void smp_text_poke_batch_process(void)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -2618,9 +2618,6 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 
 	lockdep_assert_held(&text_mutex);
 
-	WARN_ON_ONCE(tp != text_poke_array.vec);
-	WARN_ON_ONCE(nr_entries != text_poke_array.nr_entries);
-
 	/*
 	 * Corresponds to the implicit memory barrier in try_get_text_poke_array() to
 	 * ensure reading a non-zero refcount provides up to date text_poke_array data.
@@ -2640,16 +2637,16 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
-	 * nr_entries and handler are correctly ordered wrt. patching.
+	 * text_poke_array.nr_entries and handler are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++) {
-		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
-		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+	for (i = 0; i < text_poke_array.nr_entries; i++) {
+		text_poke_array.vec[i].old = *(u8 *)text_poke_addr(&text_poke_array.vec[i]);
+		text_poke(text_poke_addr(&text_poke_array.vec[i]), &int3, INT3_INSN_SIZE);
 	}
 
 	text_poke_sync();
@@ -2657,15 +2654,15 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
-	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		u8 old[POKE_MAX_OPCODE_SIZE+1] = { tp[i].old, };
+	for (do_sync = 0, i = 0; i < text_poke_array.nr_entries; i++) {
+		u8 old[POKE_MAX_OPCODE_SIZE+1] = { text_poke_array.vec[i].old, };
 		u8 _new[POKE_MAX_OPCODE_SIZE+1];
-		const u8 *new = tp[i].text;
-		int len = tp[i].len;
+		const u8 *new = text_poke_array.vec[i].text;
+		int len = text_poke_array.vec[i].len;
 
 		if (len - INT3_INSN_SIZE > 0) {
 			memcpy(old + INT3_INSN_SIZE,
-			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+			       text_poke_addr(&text_poke_array.vec[i]) + INT3_INSN_SIZE,
 			       len - INT3_INSN_SIZE);
 
 			if (len == 6) {
@@ -2674,7 +2671,7 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 				new = _new;
 			}
 
-			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+			text_poke(text_poke_addr(&text_poke_array.vec[i]) + INT3_INSN_SIZE,
 				  new + INT3_INSN_SIZE,
 				  len - INT3_INSN_SIZE);
 
@@ -2705,7 +2702,7 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 		 * The old instruction is recorded so that the event can be
 		 * processed forwards or backwards.
 		 */
-		perf_event_text_poke(text_poke_addr(&tp[i]), old, len, new, len);
+		perf_event_text_poke(text_poke_addr(&text_poke_array.vec[i]), old, len, new, len);
 	}
 
 	if (do_sync) {
@@ -2721,16 +2718,16 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
 	 */
-	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		u8 byte = tp[i].text[0];
+	for (do_sync = 0, i = 0; i < text_poke_array.nr_entries; i++) {
+		u8 byte = text_poke_array.vec[i].text[0];
 
-		if (tp[i].len == 6)
+		if (text_poke_array.vec[i].len == 6)
 			byte = 0x0f;
 
 		if (byte == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(text_poke_addr(&tp[i]), &byte, INT3_INSN_SIZE);
+		text_poke(text_poke_addr(&text_poke_array.vec[i]), &byte, INT3_INSN_SIZE);
 		do_sync++;
 	}
 
@@ -2859,7 +2856,7 @@ static bool text_poke_addr_ordered(void *addr)
 void smp_text_poke_batch_finish(void)
 {
 	if (text_poke_array.nr_entries) {
-		smp_text_poke_batch_process(text_poke_array.vec, text_poke_array.nr_entries);
+		smp_text_poke_batch_process();
 		text_poke_array.nr_entries = 0;
 	}
 }
@@ -2869,7 +2866,7 @@ static void smp_text_poke_batch_flush(void *addr)
 	lockdep_assert_held(&text_mutex);
 
 	if (text_poke_array.nr_entries == TP_ARRAY_NR_ENTRIES_MAX || !text_poke_addr_ordered(addr)) {
-		smp_text_poke_batch_process(text_poke_array.vec, text_poke_array.nr_entries);
+		smp_text_poke_batch_process();
 		text_poke_array.nr_entries = 0;
 	}
 }

