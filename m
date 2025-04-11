Return-Path: <linux-tip-commits+bounces-4885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C2A8590D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27AF189BC78
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95A2746EA;
	Fri, 11 Apr 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ue6pSSaM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/HYAsbjW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFD272F69;
	Fri, 11 Apr 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365745; cv=none; b=NZI6N3S8lVbJZ78blm/L5Nsx/vAG6+qmYD1Tp8bVQeP8DcyB/DC/MQJai5Q6YkQRCy+p07t169B97AIDbuYzvQuCzqS2US3JHeaz4HKzgEKFdidzWF0L10q/LNXKDB58DFALoapjRqEQ+RtyL7R+ANZRmSgZNt9xgdp5MGzX0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365745; c=relaxed/simple;
	bh=JhYW7z0zxiHPpuCa+3UaRRpB2VjuBimP+Yy1ZtswGog=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ggpk1dQl4cbqIgxYvhWRI0eb8thU48CiajJMDg905J6BgCTCqvoRooqQS/0+l+V9QjisoiLsaO6fjKFr7LJKRTWe32WTTj03IfNi8tcYQB2f3metNOZwsbYUlNOdoODURxe1AaGKc1DWCLSHY6E5G4jDNTkKaSajf73OyaoD3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ue6pSSaM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/HYAsbjW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YPafZvy2couG+QRyjFsTX086XFSmq3adrRaAlAhS1c=;
	b=ue6pSSaMyepfn8HjxGJhML5G1gyFa7QXecVDiBNSjni1jRXiL24srA+apTTmvqLUG7yXbW
	lEXTcIIMgLzkwl3N6Ewt+r+Tk2bmBfcrnk/OAg+ydtBJNJ2/Teie0KIZOg1XIoraBwwiUe
	QFAmgCtLBYINPERGtFoCzE/pYoymwwrSy7jCw/5NQb/51/REP60e1WbVxbdP16stMUsBsL
	XuriXraxxQ55fi1KwTlJjDwMgsvxzxjDV7ET/q0NxVCI+NPUHN/07Ph3yZwMw/rQZomOwM
	P4IRwTTuwRrSpAYT9iwld1I2fDO1HIYjpb3qlps6TBZU4jTV3N7kJcPNZ/fGcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YPafZvy2couG+QRyjFsTX086XFSmq3adrRaAlAhS1c=;
	b=/HYAsbjWx2jq16SR8VN8H8UfdvDyMV33GZyF+pXRD7ISR3BiE/H1yZ/lVjJWKgsHq7ItAZ
	Ebgb2OcgtmylDbBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Document the
 text_poke_bp_batch() synchronization rules a bit more
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Brian Gerst <brgerst@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-3-mingo@kernel.org>
References: <20250411054105.2341982-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574137.31282.13712711664375542779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     d60e4b2410e1b9f7c5ca347c78c6b07175c2e873
Gitweb:        https://git.kernel.org/tip/d60e4b2410e1b9f7c5ca347c78c6b07175c2e873
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Document the text_poke_bp_batch() synchronization rules a bit more

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250411054105.2341982-3-mingo@kernel.org
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

