Return-Path: <linux-tip-commits+bounces-4531-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE67A6F453
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1473A9AEF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A09255E47;
	Tue, 25 Mar 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GeYd3UGa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kk9Js/+X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841C19F111;
	Tue, 25 Mar 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902608; cv=none; b=mU8XPr5WIWOh+reILkBG8HatAkqhykyAukJvRZFQora2OtMDL8GpdMHNwb9kXGNjcCgbOb4Z42k0atvk+gbQaIU5cUdoaRtc8LofT9WU6OF1LEEblTCx5JKlayExoq1byMuZomO5QinKaUone3N6qny1D8/1A0RL4tbACoZGEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902608; c=relaxed/simple;
	bh=FHUiyVK61Z+ZufI9QgFm1YrVVHw4RRX9oYv2WVaS56U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CzLTfnOXCMVQrnRgl0XM78pYLalPeor82xqrubBf3XUouNOCVVdGI//ZPH/Wp38CQJa7MijlpkxndIyvXL8q/mt9ehuD1KKGaxlMDNQ2Y2URGp8T23bftjIWN4DBCRXXyhTMLIxy9Y6Kl7MQvQTCP3BL3qajoNsZVdMH4pHM1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GeYd3UGa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kk9Js/+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 11:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742902604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0dEfgZlBFKVpRfIOd62N5kE7OQkKpHmT+0YAAGUhJI=;
	b=GeYd3UGaqsnVVcpgMKd1cqAQrazAru3h/NY36UyUzkOYKQWP/FgznNl8S4NZVpDbIaD435
	uUIFpJwmbtPw/KFCRso74+ReGuDGL9aeZHxg0Bo2z50LFuAoaXnVg0Z64dzHbdluGVqy/N
	8wv+9OKvdsc8l+QxPaXTx3t7p42SlMKBdxvn4WxlQAS8TxC+mV2md0iV9wA3RYEaBGfgBv
	u4W8Xo/Cxijp88R8/9pAUyeoJLvpRO/NuTEga2x8f3RLOHjSJz0WA7ytFN2EpeAd3xAYf0
	/aeOXBcceC5/oLyMbnvDORYssFgIAvbaJMXenH8YBdt7j65/MaU5Q/EOwOFt3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742902604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0dEfgZlBFKVpRfIOd62N5kE7OQkKpHmT+0YAAGUhJI=;
	b=Kk9Js/+XQHBTgaCNj346JrbQnWif3NoD+2SgAek1Ip4YNS9XPkQjX/jBJC4ndtHln77O9Y
	gWUq9su0QX1xLLDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Document the
 text_poke_bp_batch() synchronization rules a bit more
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250325103047.GH36322@noisy.programming.kicks-ass.net>
References: <20250325103047.GH36322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174290260003.14745.15724435557527848007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     451283cd40bceccc02397d0e5b2b6eda6047b1ed
Gitweb:        https://git.kernel.org/tip/451283cd40bceccc02397d0e5b2b6eda6047b1ed
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Mar 2025 11:30:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 12:28:35 +01:00

x86/alternatives: Document the text_poke_bp_batch() synchronization rules a bit more

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250325103047.GH36322@noisy.programming.kicks-ass.net
---
 arch/x86/kernel/alternative.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 85089c7..5f44814 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2751,6 +2751,13 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 
 	/*
 	 * Remove and wait for refs to be zero.
+	 *
+	 * Notably, if after step-3 above the INT3 got removed, then the
+	 * text_poke_sync() will have serialized against any running INT3
+	 * handlers and the below spin-wait will not happen.
+	 *
+	 * IOW. unless the replacement instruction is INT3, this case goes
+	 * unused.
 	 */
 	for_each_possible_cpu(i) {
 		atomic_t *refs = per_cpu_ptr(&bp_refs, i);

