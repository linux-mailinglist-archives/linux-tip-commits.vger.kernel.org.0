Return-Path: <linux-tip-commits+bounces-4866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C4A858F6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70CF19E0BC9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FC2E337B;
	Fri, 11 Apr 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDD41a9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zizYxReT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DE2D4B5C;
	Fri, 11 Apr 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365729; cv=none; b=BbjvJjktr3JelIzscbAGnXTkMI6E8UQUFMEokUGRoWMwBazJd31EPybxcGPPIYpF+K0y0BT2wK5DmD30onKD7e1fKiB8XFItXZhWhPeHo3DI06L7q7gYd13+BXTo9uCNCaEA9TX2kZNraj0HVQbFiQ9gt/XRGAooGctrWy2ppQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365729; c=relaxed/simple;
	bh=1RX4km+uJc5cx9OZlPwrKn2ZakbyPev1nJ+Mqggcxn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GetpNKX5V6MnJKYWRcHTRmTFnxwdT1UL/6rwYcNK5hSSqMaarsjnh2hzT0+f0m5wtAelWxqO03xNSQSN+YZu4HkDMqErbYSPwsKAzGXaiALTLDDHcyljLFQXpgb4imbB+Su0qCxfBG8QP/gOh6Om4qccCE8qyFTsO/Nw3Efrsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDD41a9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zizYxReT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jme46Zd3LUXPipEj8J4uheco0gq1seSMc4F3cq97sac=;
	b=GDD41a9jy+JOixtt82kN6SbiRwN9fxeEGzytHoCYik3InppAcdJHarTkOBOwa2MCaIWATK
	4NnuCH6AQBVgSdv/DCj6p+VVQd79TyVqDRBmboMTNsDrBuEHjqFJOMBq7hm72eo8SWK9Rs
	uCQby22Ypbt9nLJ56zooz27heyzxbVnYwEqftvh4k+Muo6YRNaC+e+/4mWDk9jRNM4dXXH
	+cid+abDJdww3qDHs/EY4kXvQR+pMek5a7XM5BFDExPjTHfLoLoyAmANYOjTOreOL3/ws7
	YF+0ee+FpfrOQ/xcBl7Ydq7f/IcGxp3FTU3HG3rWKcFtGT1mQl8Hh7XYwinr9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jme46Zd3LUXPipEj8J4uheco0gq1seSMc4F3cq97sac=;
	b=zizYxReT5vOtG7jwgYEKN/lkTKsz4NCO5/lUxquEHR2NFWAyD0oSj+rXaoLj0KkdfCk5UT
	tgxrsY6tpokznaDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Use non-inverted logic
 instead of 'tp_order_fail()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-23-mingo@kernel.org>
References: <20250411054105.2341982-23-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572595.31282.18239171836859680345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     2d0cf10a1eb60deded109c2357326a5ca44e3845
Gitweb:        https://git.kernel.org/tip/2d0cf10a1eb60deded109c2357326a5ca44e3845
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Use non-inverted logic instead of 'tp_order_fail()'

tp_order_fail() uses inverted logic: it returns true in case something
is false, which is only a plus at the IOCCC.

Instead rename it to regular parity as 'text_poke_addr_ordered()',
and adjust the code accordingly.

Also add a comment explaining how the address ordering should be
understood.

No change in functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-23-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c53eb3b..c5801b4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2841,28 +2841,34 @@ static void text_poke_int3_loc_init(struct smp_text_poke_loc *tp, void *addr,
  * We hard rely on the tp_vec being ordered; ensure this is so by flushing
  * early if needed.
  */
-static bool tp_order_fail(void *addr)
+static bool text_poke_addr_ordered(void *addr)
 {
 	struct smp_text_poke_loc *tp;
 
 	if (!tp_vec_nr)
-		return false;
+		return true;
 
 	if (!addr) /* force */
-		return true;
+		return false;
 
-	tp = &tp_vec[tp_vec_nr - 1];
+	/*
+	 * If the last current entry's address is higher than the
+	 * new entry's address we'd like to add, then ordering
+	 * is violated and we must first flush all pending patching
+	 * requests:
+	 */
+	tp = &tp_vec[tp_vec_nr-1];
 	if ((unsigned long)text_poke_addr(tp) > (unsigned long)addr)
-		return true;
+		return false;
 
-	return false;
+	return true;
 }
 
 static void smp_text_poke_batch_flush(void *addr)
 {
 	lockdep_assert_held(&text_mutex);
 
-	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
+	if (tp_vec_nr == TP_VEC_MAX || !text_poke_addr_ordered(addr)) {
 		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
 		tp_vec_nr = 0;
 	}

