Return-Path: <linux-tip-commits+bounces-2860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317319C86D1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 11:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A7CB2BF84
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8D1F8190;
	Thu, 14 Nov 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQlmf67G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5E9kEBd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94931F76AF;
	Thu, 14 Nov 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578474; cv=none; b=BSo0YO9cYUMiPY1zvcRkmq77vjozHQBivT5z9bcdNB8Tglmamyz1se3rAZ/i6mNIgZyVm+mj7YT8Gv03DBgH6UTy5AbLyBf4ERpFjAu9xEQJB0K/hEF/pvUENwaVNTJqcAyDsTv+8hsj8jAgZ/I9ckbwbqYn/fOHBKf+NZ4IuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578474; c=relaxed/simple;
	bh=KWd0VzQbaL61ew+a/eYpDEfu3RI+DlDaIVT/DFvIULI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tXRIyGF4qVbS4CeYGYjjeWIgsWTe/5iX+ag7VJdO0nFsWJHQITLVkfxEEyLSz7vL93N7AZIctWRi7xDETaNLaAu8lGjVjjkJcE+sub8nS6klEk8IE/gmGaTmMuLABfcwwpjgykugF4TSZyR2D3Cufz1BKYPyBZbu07ZfH0gGJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQlmf67G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5E9kEBd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnHyy2SmB9CPccp1UuEYVzS/puuOPuXwsDmu9tDfy7c=;
	b=AQlmf67GAv1J/J2IJylpTpUTFbyOaXVgrk1uaYpLMkXqWq6eAR3V7FHmdT5roD0FQ453i2
	pHFwbe2Ql67plYxjgMhDZqf3XYcZl5Rr4vBHqH4IqgF8wDVmzGpJd4uP750ZAmT5nUODEh
	weNfNh1aGsIBlaAP9Ebdtuy7uOf0xcARAy+2itEYLaVlj6dLFwSJEgzweN6rBfgssIP1KR
	KVF4hYQ13GgUDQEKC3Ubjz+gT8TtwoHSJHu91P1gcWnqXUM+/83+/i6pTMgrjNl4oLMhON
	E1QCo6XMlB+LPGn0oXcr9UCOvPhaDcZ5aRJzTOV8kmbpDRipDYStZ8tuTrB4Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnHyy2SmB9CPccp1UuEYVzS/puuOPuXwsDmu9tDfy7c=;
	b=X5E9kEBdVHyfmwiEPTRH7bj2GAGKIlIXXpH2XBuT/EzCSAyg2C2bEBdoLd6wQuOVRBjyd1
	RA8sXTRwypx93wAA==
From: "tip-bot2 for Colton Lewis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/powerpc: Use perf_arch_instruction_pointer()
Cc: Colton Lewis <coltonlewis@google.com>, Ingo Molnar <mingo@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241113190156.2145593-4-coltonlewis@google.com>
References: <20241113190156.2145593-4-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173157847001.32228.13971479438107981126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e807cf07d96eedb57d91a91f611f828e8918aab
Gitweb:        https://git.kernel.org/tip/3e807cf07d96eedb57d91a91f611f828e8918aab
Author:        Colton Lewis <coltonlewis@google.com>
AuthorDate:    Wed, 13 Nov 2024 19:01:53 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Nov 2024 10:40:01 +01:00

perf/powerpc: Use perf_arch_instruction_pointer()

Make sure PowerPC uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://lore.kernel.org/r/20241113190156.2145593-4-coltonlewis@google.com
---
 arch/powerpc/perf/callchain.c    | 2 +-
 arch/powerpc/perf/callchain_32.c | 2 +-
 arch/powerpc/perf/callchain_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434d..26aa264 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -51,7 +51,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, perf_instruction_pointer(regs));
+	perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current))
 		return;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ea8cfe3..ddcc2d8 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -139,7 +139,7 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 488e8a2..115d1c1 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -74,7 +74,7 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);

