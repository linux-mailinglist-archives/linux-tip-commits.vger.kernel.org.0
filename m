Return-Path: <linux-tip-commits+bounces-4858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC9A858E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFDF189FA1F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A12BEC5E;
	Fri, 11 Apr 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjxiEDFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQOu/T5q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E02D1F48;
	Fri, 11 Apr 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365724; cv=none; b=KL7eXWIsfdWghDOVoTaM2MjqLcc84ecMoa2LI5lqhoXLax4cl9tK/iEJhEMWTyCiSDertVVbGix0ng15dFMn2SVpCKLPj6248IVDbxVTaBaaNOx7oxNzU91NnMefL+9mo6akwGCU0S7c3cwRjC19jzvUF9lGb8KjzE52kn41wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365724; c=relaxed/simple;
	bh=jJzbgpbS1zixbjhI+uBWESt/Se02umKXhvWpt+BSJDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=olgUPemSGU1nRNt+VU/7olxmCqcku5MuYpO80BOBxGJaH9+onbJVpaah9EIY9LshPs7wriNrCpXWwcd46cJAo27E3GwYJ/yuEzhDvOTCq3LNYIeYWVdsr0vQBZm5BxAuzbIccGk1BbGBXbm2jtEsuoVPga5EkSXylRNd4yw0EB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjxiEDFx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQOu/T5q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IHu79BMdA0jvVuTiiUBGt7jZjziLB1hlMbaxgyQXI8=;
	b=CjxiEDFxNglb+NDpML08LtIxEqYASyZs5q4XPww65LrnlTqTew0a1yZRqLU+10DZ3SH+Sv
	z512ZdowaiZkTwyxY8qIA82HG0eIaoy6cEOm38BdJwrL5zOL0v8b4QFO4vJYyhVMinZcTB
	wF5mj0kE0+xqts+HbrodQPHiDtfrD9DvsXnP7+w81twRl1ESTxGYryHzjZE51HgXiFSfvi
	NC1Rx6JADRLKpvcc9Vw3qwf3m+osKiMVWIV7YWpmPhtq64it/xyIIsS311lMmvZ+qUn+3W
	LaKkNcsL2PP4BUrOBHaDRbSLwrxtQ0LBjNf7bxJON8+KV5+F8aLOukpBdvx7VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IHu79BMdA0jvVuTiiUBGt7jZjziLB1hlMbaxgyQXI8=;
	b=zQOu/T5qJv56N8aWSUZ6NxC4oPSCvEOqv8f4ljiC/0L40+1WeGRWDJYLpT+QncBljAjYOH
	y/lzKW1XaRfWicBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'try_get_desc()' to
 'try_get_text_poke_array()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-30-mingo@kernel.org>
References: <20250411054105.2341982-30-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571956.31282.13107503301211335896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     46f3d9d329dec169c54a3b5b48deb1ba258689fc
Gitweb:        https://git.kernel.org/tip/46f3d9d329dec169c54a3b5b48deb1ba258689fc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Rename 'try_get_desc()' to 'try_get_text_poke_array()'

This better reflects what the underlying code is doing,
there's no 'descriptor' indirection anymore.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-30-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9937345..02f123c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2476,7 +2476,7 @@ static struct smp_text_poke_array {
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
 static __always_inline
-struct smp_text_poke_array *try_get_desc(void)
+struct smp_text_poke_array *try_get_text_poke_array(void)
 {
 	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
@@ -2530,7 +2530,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	 */
 	smp_rmb();
 
-	desc = try_get_desc();
+	desc = try_get_text_poke_array();
 	if (!desc)
 		return 0;
 
@@ -2627,7 +2627,7 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 	WARN_ON_ONCE(nr_entries != text_poke_array.nr_entries);
 
 	/*
-	 * Corresponds to the implicit memory barrier in try_get_desc() to
+	 * Corresponds to the implicit memory barrier in try_get_text_poke_array() to
 	 * ensure reading a non-zero refcount provides up to date text_poke_array data.
 	 */
 	for_each_possible_cpu(i)

