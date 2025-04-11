Return-Path: <linux-tip-commits+bounces-4862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F72A858EB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76F44C4F58
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34C2D3A6B;
	Fri, 11 Apr 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXBONRZ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDpOlCVB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C752D1F5C;
	Fri, 11 Apr 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365726; cv=none; b=bkbx+mSaicKGj4+xlYHmUtRbxxi1JvR9a70IF6Bb0ON/ooAEZcoNoNmAw2MJfCkt8rMpuv6KWkgA/gvkG1gUVYwjAUx0YxTVz7SLmmGI4NB7IhJrWisQ6yx3IYB6RurDlMUpAU75hlLJHP8fNc8yiljoL7LlM2BSiLFsMYzYPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365726; c=relaxed/simple;
	bh=dyG55u4vs+pQkAjlfFmzxZlmO+5ja6Rne7Q0cs1N5TQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UHVeXaIGnXXna5MpzpsJPKq4yrJr15SH/buIRewuvxrePsjCyapv7H6oKup5BIfIpgYelfjvPC/F8khw5HX+y73LGPCy0G4/35FdHGtILmT7H/56FCq0BZj0RHd9gINay4GtcPcuA6zn0wtJ5HDBzCfMDA5wK8SpwBLMmuDagTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXBONRZ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDpOlCVB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev1xuSmUqWKXHxLGhWs+/C9YopdjBniFsVGyUJhKJik=;
	b=XXBONRZ7dWYcCSBgqLzPeUJbdG/W+2EMFooePe2tm6Rngpb6RvDeNDSsHzqd9sggNAfeiE
	70EGjsyLNj1rNkKle98V6gWezDYkN3FBxfGQjp4En/49Jedr3zh3fOVzrBIVA1mh3yBQo1
	dif1kI78SIjW0wHPBA1C/Nfj3k9g6vyHQiq1EORFFoMf/zgJjtOsigkqNz/EdH/io2YHVs
	rkpggn1eAHDrf7TWsmYWvBwn+ihmQBHj/CoJFZoIy94ARMit3bWMVxrl2GQeiKXamFKiJV
	7zFTkRrVlzzbaDpvi2lel+xWlVWStHQyerotCY9L+gy6X/RLTFnU6tlerwFmdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev1xuSmUqWKXHxLGhWs+/C9YopdjBniFsVGyUJhKJik=;
	b=UDpOlCVBaqrpGupsxrk6BIKT151r0Od/wbSy0XFHeLuUU6MY8tnenLDQv3DTxyBnavWJYf
	cinLEpBLBgD85JBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Remove the tp_vec indirection
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-29-mingo@kernel.org>
References: <20250411054105.2341982-29-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572063.31282.4569282365567218610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     0494b16b9caed22ff78adb84cedb7460532eb3f0
Gitweb:        https://git.kernel.org/tip/0494b16b9caed22ff78adb84cedb7460532eb3f0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Remove the tp_vec indirection

At this point we are always working out of an uptodate
text_poke_array, there's no need for smp_text_poke_int3_handler()
to read via the int3_vec indirection - remove it.

This simplifies the code:

   1 file changed, 5 insertions(+), 15 deletions(-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-29-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0af2203..9937345 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2466,15 +2466,6 @@ struct smp_text_poke_loc {
 	u8 old;
 };
 
-struct text_poke_int3_vec {
-	int nr_entries;
-	struct smp_text_poke_loc *vec;
-};
-
-static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
-
-static struct text_poke_int3_vec int3_vec;
-
 #define TP_ARRAY_NR_ENTRIES_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
 
 static struct smp_text_poke_array {
@@ -2482,15 +2473,17 @@ static struct smp_text_poke_array {
 	struct smp_text_poke_loc vec[TP_ARRAY_NR_ENTRIES_MAX];
 } text_poke_array;
 
+static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
+
 static __always_inline
-struct text_poke_int3_vec *try_get_desc(void)
+struct smp_text_poke_array *try_get_desc(void)
 {
 	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
 	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return &int3_vec;
+	return &text_poke_array;
 }
 
 static __always_inline void put_desc(void)
@@ -2519,7 +2512,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
-	struct text_poke_int3_vec *desc;
+	struct smp_text_poke_array *desc;
 	struct smp_text_poke_loc *tp;
 	int ret = 0;
 	void *ip;
@@ -2529,7 +2522,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * int3_vec with non-zero refcount:
+	 * text_poke_array with non-zero refcount:
 	 *
 	 *	text_poke_array_refs = 1		INT3
 	 *	WMB			RMB
@@ -2633,12 +2626,9 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 	WARN_ON_ONCE(tp != text_poke_array.vec);
 	WARN_ON_ONCE(nr_entries != text_poke_array.nr_entries);
 
-	int3_vec.vec = tp;
-	int3_vec.nr_entries = nr_entries;
-
 	/*
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
-	 * ensure reading a non-zero refcount provides up to date int3_vec data.
+	 * ensure reading a non-zero refcount provides up to date text_poke_array data.
 	 */
 	for_each_possible_cpu(i)
 		atomic_set_release(per_cpu_ptr(&text_poke_array_refs, i), 1);

