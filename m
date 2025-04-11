Return-Path: <linux-tip-commits+bounces-4855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895BA858DF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DA017C2BB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2502C3749;
	Fri, 11 Apr 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOkAbLpl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ln3dhyd+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D92BE7DE;
	Fri, 11 Apr 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365720; cv=none; b=BklJrqm4Q/k5Z79Dld0M8AOOCLZR0Vkm285UjjA60Ou4TCpNgtYXJOtROP3GOntSNXhjlYbuPvC8P/s35VaY6Iz7YZ4fsBWwlMdaTmtKf+z0OliSI5k99XOGqTBtNRexy+I9iuM79w8uvR8Ul/q90zwP9MI5kH5eqHU8kD24duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365720; c=relaxed/simple;
	bh=YzgPHOX863ReKIAEO7qbl6FpZjcS6qAi33/rAryjhdw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xwj5rMJknIzxxBViUjU9Z4c3y1LTDJZZ5Kl67QbEfCj5wrJ1zdpHlFQraYUCCB9skEqbRZVGoPuNSsrlLYr+M/pX0GTlcu3QUQDkfOZOvPoBjKjlGkJNcV66wPqSiPAchJQ8roLgTKB9+O4yPLMp/RGpeHMzIzpEJurf85EswJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EOkAbLpl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ln3dhyd+; arc=none smtp.client-ip=193.142.43.55
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
	bh=gpRvrqeyM/p1S/zdbcPa8lNE1VjmgZcBdsuW5wLowxM=;
	b=EOkAbLpl8t/3G/0im87/IlvknP42wCTMhiOSv6hDTN0iBqLMPZgUD2uxMfWHYo+07e/hjf
	3kHY38k3OGZoHTzpaXYPyVn5HIbCkNEvinpP0n2mc/hQniS69Z00t4zPrYgAJItbJoD87+
	j5HopLuIbfNcXBn1XYLyC+7pogJeYuc7ZRWlCpmlC6BAEGkcv9TipnTnJciDyYH1dTtnma
	TTSx1O2ue9fRRQMkcsTkK017h4HTybEFVt2Frev8vGrkmkdOOFMVvj3ybtzlm3IXJ3b+g4
	0L9dx8qOSb6sco+H+z/w9hbEHzSvLqTcTqsQrVtRDS4iDqKfYYmGlxHlh5Qcag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpRvrqeyM/p1S/zdbcPa8lNE1VjmgZcBdsuW5wLowxM=;
	b=ln3dhyd+cf0D7u96anrhT1vvGbyAoI6Mqx6ADJms5vZPgfDy5Q+ei0Hq08eytH3pRP7gI7
	dwMamY97uI9WGMDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Simplify
 smp_text_poke_int3_handler()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-33-mingo@kernel.org>
References: <20250411054105.2341982-33-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571596.31282.1695068736976491029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     8e35752f0c334ee3eb2bf075ac0bdb243ad25fac
Gitweb:        https://git.kernel.org/tip/8e35752f0c334ee3eb2bf075ac0bdb243ad25fac
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Simplify smp_text_poke_int3_handler()

Remove the 'desc' local variable indirection and use
text_poke_array directly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-33-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index edc18be..97cb954 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2511,7 +2511,6 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
-	struct smp_text_poke_array *desc;
 	struct smp_text_poke_loc *tp;
 	int ret = 0;
 	void *ip;
@@ -2531,9 +2530,6 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 
 	if (!try_get_text_poke_array())
 		return 0;
-	desc = &text_poke_array;
-
-	WARN_ON_ONCE(desc->vec != text_poke_array.vec);
 
 	/*
 	 * Discount the INT3. See smp_text_poke_batch_process().
@@ -2543,14 +2539,14 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	/*
 	 * Skip the binary search if there is a single member in the vector.
 	 */
-	if (unlikely(desc->nr_entries > 1)) {
-		tp = __inline_bsearch(ip, desc->vec, desc->nr_entries,
+	if (unlikely(text_poke_array.nr_entries > 1)) {
+		tp = __inline_bsearch(ip, text_poke_array.vec, text_poke_array.nr_entries,
 				      sizeof(struct smp_text_poke_loc),
 				      patch_cmp);
 		if (!tp)
 			goto out_put;
 	} else {
-		tp = desc->vec;
+		tp = text_poke_array.vec;
 		if (text_poke_addr(tp) != ip)
 			goto out_put;
 	}

