Return-Path: <linux-tip-commits+bounces-4865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BAA858FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4F9A7C2C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F282E3360;
	Fri, 11 Apr 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NatCnKnJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jc45SYOV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF02D3A99;
	Fri, 11 Apr 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365729; cv=none; b=n06G9+9n4n3x3xt7GRzcM//9MBt8Suf4kp9AjaFTSZSzM0waOumhmi5MFbLfZrrHb6fpKdoxOJz+NaiQxID0reTdihwMldal+xADkzwrBb7NFMCuZEkOLQ57ulg5WkpoSPfh7SF6wMyOly6VvvtszdD2N+tqxCjlTurM0IET2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365729; c=relaxed/simple;
	bh=zd39uqbnJpfLq5zVGVTH4k/rj6XR3qrhmiONfXHtzFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZLekZbVzxsBfzBz3nGUiCpxsYMYN+q0PWyQBgErvEhwwqF/X9esSgj8WdgAnvnmvToxdFSQ8KB+178PJun5LLpc2a+6pahqXXb8NCYr9ZSOqCxIDYV8X/MUQSga97u+SQwEXEfQeO56J4iE2tGB88Jt6s/Ip0gw+TXlXpa49cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NatCnKnJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jc45SYOV; arc=none smtp.client-ip=193.142.43.55
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
	bh=6Z0FUsx9VLmhLop6gD71+3ZgaTfueVme7v2YdT+3Z2U=;
	b=NatCnKnJ9rjr0SwjDvQ6DvB1BSSgelx9IZLGuCZvcn8NZnbTTTgr7hQVG9ZKqEu54+Oi+s
	kNAyXWKEgzpiv0TQNJJFJObKzMWRLGQeiIE9xqbEx+4KWNE+eSM7O7fi6mVMCE/4kHAeyS
	okCLYv1lKgcCwnah3iqzA9MnNLbLMuTifLfTPZkbf/oE888ve4R0YHheCdC5OxmR7M7Qgt
	P+8GaPjhWxsZYSeAP52rT30Z0XgwWvbWo2v1kCHYrlrQdUcyd3r44aE6La5f5z0qrqhAzL
	mJFbcC40Zcj432jjn2u8lGGq7XAmTobaXKRxuNNnejM9UcpvMHv2gy8i3sl9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z0FUsx9VLmhLop6gD71+3ZgaTfueVme7v2YdT+3Z2U=;
	b=Jc45SYOVL4xHtkfve7Scy2WJ17G8S0D8BsmY9XjDThlz2inY0IlJW8VhqAKhGdi93IdxPc
	WhmEIyJZ6IHEEYBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove the 'addr == NULL
 means forced-flush' hack from =?utf-8?q?smp=5Ftext=5Fpoke=5Fbatch=5Ff?=
 =?utf-8?q?inish=28=29/smp=5Ftext=5Fpoke=5Fbatch=5Fflush=28=29/text=5Fpoke?=
 =?utf-8?q?=5Faddr=5Fordered=28=29?=
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-24-mingo@kernel.org>
References: <20250411054105.2341982-24-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572515.31282.14486079052605438703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     eaa24c9177c8c765ec9b9ccab392ac07ae8acda0
Gitweb:        https://git.kernel.org/tip/eaa24c9177c8c765ec9b9ccab392ac07ae8acda0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Remove the 'addr == NULL means forced-flush' hack from smp_text_poke_batch_finish()/smp_text_poke_batch_flush()/text_poke_addr_ordered()

There's this weird hack used by smp_text_poke_batch_finish() to indicate
a 'forced flush':

	smp_text_poke_batch_flush(NULL);

Just open-code the vector-flush in a straightforward fashion:

	smp_text_poke_batch_process(tp_vec, tp_vec_nr);
	tp_vec_nr = 0;

And get rid of !addr hack from text_poke_addr_ordered().

Leave a WARN_ON_ONCE(), just in case some external code learned
to rely on this behavior.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-24-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c5801b4..16a41e2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2845,12 +2845,11 @@ static bool text_poke_addr_ordered(void *addr)
 {
 	struct smp_text_poke_loc *tp;
 
+	WARN_ON_ONCE(!addr);
+
 	if (!tp_vec_nr)
 		return true;
 
-	if (!addr) /* force */
-		return false;
-
 	/*
 	 * If the last current entry's address is higher than the
 	 * new entry's address we'd like to add, then ordering
@@ -2864,6 +2863,14 @@ static bool text_poke_addr_ordered(void *addr)
 	return true;
 }
 
+void smp_text_poke_batch_finish(void)
+{
+	if (tp_vec_nr) {
+		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
+		tp_vec_nr = 0;
+	}
+}
+
 static void smp_text_poke_batch_flush(void *addr)
 {
 	lockdep_assert_held(&text_mutex);
@@ -2874,11 +2881,6 @@ static void smp_text_poke_batch_flush(void *addr)
 	}
 }
 
-void smp_text_poke_batch_finish(void)
-{
-	smp_text_poke_batch_flush(NULL);
-}
-
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct smp_text_poke_loc *tp;

