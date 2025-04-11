Return-Path: <linux-tip-commits+bounces-4870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED2A85910
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FC29A28AE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4F234243;
	Fri, 11 Apr 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSCuTR5W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TwIjeiE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E7234237;
	Fri, 11 Apr 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365735; cv=none; b=U9DhCSSjwIZ8ZXF/brhh/q/36WSCvmFDPWcYnAsjPZLj54KxcDJB7QnEZstE17Eykjo5ZbPpImvJUuuwJoVyqEhfNceXwIxNVr2eEgcd9mQ/4LEOn4yj2XYhlVcNgpE9YWMS2Bh7CysWjO5Oqe/k9p1Ze366j5ErqDTMeerQyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365735; c=relaxed/simple;
	bh=UyVA3yin/g1jJXGwjK6q2dI/yj1MOR6/jSQYyOpbWL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j35Ij5MHwV7uv/sT10x08DUvqkkulytNpX2U3+Z4zjjTp//Y9z5rT9n8w/1oMyRBQ02B6DakFSxoOlL7akLDS/A+vLetEV00nDT0OxxxXUbYbdg8cy0+QFu1sGX9M9UPY3H1XXSOR/43ZaJjxm4Kb245xy+mSbgBelGwZfgPG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSCuTR5W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TwIjeiE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnXAfDJUk6cnWD37Nf0+jK04oSFpmDrrO+rfsHdgdWA=;
	b=vSCuTR5W0pJ+7N6Qfuw4ugIwZ+SHK28lywEE/UyTTCaesXiTlOL1r9oL4VyOyIOl0x/rSK
	MPWGiflBEmTx/gfGWBbd/q1E1bQQ3v5SH5JHRWl4n6leypTST25h/4PQuSTsdTDA/U+h7S
	HL45B8SBymrEjtYxC0fdi0Exz/OgB/Vaa/ZP9V0rCGnqD4TNe8gB+ww1sf5/NZSrQlEqmw
	xgEJ+5C44XQiZVjVzltC1cgMwX9CMRckleifk6bvSZNARQtU/9CTgZTFDovAjUw/xRi6bp
	MzDZ+g39NTVM5V7QJhXfewb69uiw7TJNCm8Cx5GUfjfwfnEtL7tQH2okXg45VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnXAfDJUk6cnWD37Nf0+jK04oSFpmDrrO+rfsHdgdWA=;
	b=8TwIjeiEphZ2sYnEB02LHSaTAGRTT9s1re7Q05wTxUmJ7f89W8tZaJydgmSpaivbMIPSuh
	kSJFygdYDA79vHDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename
 'text_poke_loc_init()' to 'text_poke_int3_loc_init()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-18-mingo@kernel.org>
References: <20250411054105.2341982-18-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573101.31282.13509779361975572074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     fb802d639340d041e32d48057c7f15175a57c2de
Gitweb:        https://git.kernel.org/tip/fb802d639340d041e32d48057c7f15175a57c2de
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_loc_init()' to 'text_poke_int3_loc_init()'

This name is actively confusing as well, because the simple text_poke*()
APIs use MM-switching based code patching, while text_poke_loc_init()
is part of the INT3 based text_poke_int3_*() machinery that is an
additional layer of functionality on top of regular text_poke*() functionality.

Rename it to text_poke_int3_loc_init() to make it clear which layer
it belongs to.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-18-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6865296..ebfd364 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2762,7 +2762,7 @@ static void smp_text_poke_batch_process(struct text_poke_loc *tp, unsigned int n
 	}
 }
 
-static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+static void text_poke_int3_loc_init(struct text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
@@ -2878,7 +2878,7 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
 	smp_text_poke_batch_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
-	text_poke_loc_init(tp, addr, opcode, len, emulate);
+	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
 }
 
 /**
@@ -2896,6 +2896,6 @@ void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, cons
 {
 	struct text_poke_loc tp;
 
-	text_poke_loc_init(&tp, addr, opcode, len, emulate);
+	text_poke_int3_loc_init(&tp, addr, opcode, len, emulate);
 	smp_text_poke_batch_process(&tp, 1);
 }

