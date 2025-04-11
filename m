Return-Path: <linux-tip-commits+bounces-4877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01EA85918
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5287B9A5753
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF224DC51;
	Fri, 11 Apr 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZHHgI/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JB4XLmMs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BD238C0A;
	Fri, 11 Apr 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365739; cv=none; b=bf33yUmHQO9eTGvXS6i50Ir/uZVWZcpy7vvrz3rDPfHiwbHdVv+cqlGuC3kkCm1KWdXaOTeoJMd4kVzuM9BwU4pKN48nkFNFBvxttVfhexgVYXGDdwVZDYmtFuR8cj0r1XhGWWiBKVjJ1yTkdXfYo7q7o+obrRX28qkoXu8oBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365739; c=relaxed/simple;
	bh=j56QIgwDWL3stJTr3KgvBGqlmtJgo7jbHzwCJdk2ibM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MuZDBSbeJIPNH6sjkN3tIbmgO01glerGxlkit3XveagkZRIL1zp36bXXWxLN8HrrhLxjsraoyLFmok3+ABTdRNasFr3g7TsrqAcYoIQ5k3QgRfJ/AOlpg85QHGjhhUtKFXqCH8jQ3Q1EZAmPx9iMPJCnl6kkeUykUy/54kt9KSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZHHgI/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JB4XLmMs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHvqCAUhpuF+Gq0HuUYMAMKZgTfwqU0ZS29JOg3guko=;
	b=uZHHgI/glHAJMxj0NAnZAXlBGKQijwJrSrYZB62gM83UVcHsL7U8qJqXliauLVW+ogjgHu
	a02+B5jlrQ9RGWwel3DaL4byI0RNZBZFaCnCrPOwYfJ9mWcYkt8ifteYNBB9fjxYqUt+aU
	4JYBgiMXjBe9vCwLHyMR3ZZfvxVzD7J7Kt1OnafGeM3iGG5V1U0253xpOsJDYlRym/17nI
	NwkJblMRNYT3GTb4vlf73zT7bOTxm5tMeSiiEgZeR67GPvOL1Ni7ecwvCmgExcSA2UoCIn
	nfyplJf2kU8++WC4bFbHirUGDZqbX+9Ff70GOn/ktutoNaSkK0qz9BAna/OWhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHvqCAUhpuF+Gq0HuUYMAMKZgTfwqU0ZS29JOg3guko=;
	b=JB4XLmMsLWT6HaaT8uEoKPvF4+d3felWEQFJ2fMQyX7Jp0Ta2ok7QWtPzZsTBKwzjTmLeF
	GomBKKyKECgffsBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Update comments in
 int3_emulate_push()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-13-mingo@kernel.org>
References: <20250411054105.2341982-13-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573439.31282.1023836498635767792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     5224f09a7b57fcf2024245d89dcb26b0756fb1c8
Gitweb:        https://git.kernel.org/tip/5224f09a7b57fcf2024245d89dcb26b0756fb1c8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Update comments in int3_emulate_push()

The idtentry macro in entry_64.S hasn't had a create_gap
option for 5 years - update the comment.

(Also clean up the entire comment block while at it.)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-13-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index c8eac8c..7e35273 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -142,13 +142,14 @@ static __always_inline
 void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
-	 * The int3 handler in entry_64.S adds a gap between the
+	 * The INT3 handler in entry_64.S adds a gap between the
 	 * stack where the break point happened, and the saving of
 	 * pt_regs. We can extend the original stack because of
-	 * this gap. See the idtentry macro's create_gap option.
+	 * this gap. See the idtentry macro's X86_TRAP_BP logic.
 	 *
-	 * Similarly entry_32.S will have a gap on the stack for (any) hardware
-	 * exception and pt_regs; see FIXUP_FRAME.
+	 * Similarly, entry_32.S will have a gap on the stack for
+	 * (any) hardware exception and pt_regs; see the
+	 * FIXUP_FRAME macro.
 	 */
 	regs->sp -= sizeof(unsigned long);
 	*(unsigned long *)regs->sp = val;

