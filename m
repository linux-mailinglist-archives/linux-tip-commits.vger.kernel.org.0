Return-Path: <linux-tip-commits+bounces-4873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09CA85914
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F85B9A353B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB958238C03;
	Fri, 11 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9YeOZYx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvpxh6tL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709B234247;
	Fri, 11 Apr 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365737; cv=none; b=auL1G7OesScDVLgjoCMRIERyOAj2r673QYeuu5akv1OpiKM3UR8Mjs0GfdSqRRv1eu/p9jGTbiRJ8AAswq1/hVyP9JoAAWgqU6EO6RK/Aj+ofaxS/EY+gIlNL3/UzfGgI6tUu2M58whQvsa2mSeVq1QL3pcV3ZDMHCFPtFGPEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365737; c=relaxed/simple;
	bh=3zawJcPn49RRaBSs3D3RKG6Kj0jQk99wtEoz9ekWm7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A74e0YRP4xSwWzor0S2pVbJGEQgDnZqOqmQBBJwqwXn0/9wGm6T5yyNCWbWGecXZ1IomOZR6DRQ0uYydHcDcYHegyafnhIF4pxDwy9K4BnZWd7rrcNYOSYgD3iM7wpQh+KQEeBhL7GbdhV07h+Oe6V5DmU02blCxcpz3VjyWJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9YeOZYx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvpxh6tL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmxDzJ8j2w6TaFyLJrxe/LhQwpUsLpW1gyJi/oH4Olg=;
	b=A9YeOZYxyiUjupIdj3mcFItuS5GU9cjtG2bwM9qaIJVslSfsnW79SEkciEwG3gyW/Mk1/f
	KBRs0fPRa/+YlEtQ9B3YIDFZ2ZTXFj0Y+GjEMBM5Pc1TJBilDrLRfCkf0PnYi4TTdbjcln
	MAYm+oFsbTIyWTyLz+aFIK5nq5eMDsgcUpJG6U2it/lhwZcle1Zub1MOsI9YAFXb7dMmVc
	AvkUwxmDQbLbTLip8+9e3rlQdG762ukf70Rbvu8E8XPzbHOLV7N776PTlqKarIfg4AwJ1a
	WsFHcOZFz2GFMWcggMtuF0bJU9ShF4f3uUT45CHw6vKVxc+Z43mLdeZCq1qVgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmxDzJ8j2w6TaFyLJrxe/LhQwpUsLpW1gyJi/oH4Olg=;
	b=kvpxh6tLPvAJm9ws4AZ1d1mu7kKn0VzB4IMVt7raWJaVRKCCo5iAhyr2LgeXlrQZ3y5JkK
	yODXIfZuuAXeYNBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'text_poke_flush()'
 to 'smp_text_poke_batch_flush()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-15-mingo@kernel.org>
References: <20250411054105.2341982-15-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573301.31282.7381025958179353167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     aedb60c2c66c82be7cceb89e2b1a0d491bb7ca2f
Gitweb:        https://git.kernel.org/tip/aedb60c2c66c82be7cceb89e2b1a0d491bb7ca2f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_flush()' to 'smp_text_poke_batch_flush()'

This name is actually actively confusing, because the simple text_poke*()
APIs use MM-switching based code patching, while text_poke_flush()
is part of the INT3 based text_poke_int3_*() machinery that is an
additional layer of functionality on top of regular text_poke*() functionality.

Rename it to smp_text_poke_batch_flush() to make it clear which layer
it belongs to.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-15-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0ee43aa..6c8bf2f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2858,7 +2858,7 @@ static bool tp_order_fail(void *addr)
 	return false;
 }
 
-static void text_poke_flush(void *addr)
+static void smp_text_poke_batch_flush(void *addr)
 {
 	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
 		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
@@ -2868,14 +2868,14 @@ static void text_poke_flush(void *addr)
 
 void text_poke_finish(void)
 {
-	text_poke_flush(NULL);
+	smp_text_poke_batch_flush(NULL);
 }
 
 void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc *tp;
 
-	text_poke_flush(addr);
+	smp_text_poke_batch_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
 	text_poke_loc_init(tp, addr, opcode, len, emulate);

