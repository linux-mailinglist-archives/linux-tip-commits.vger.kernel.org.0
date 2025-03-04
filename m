Return-Path: <linux-tip-commits+bounces-3909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01690A4DAC5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D0A1885A7D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C91FDE15;
	Tue,  4 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzgEbvPj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPRuiZzW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9D1F5834;
	Tue,  4 Mar 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084585; cv=none; b=g3lmZC2VDWY11lsJcil2+XFw0UxCXHGRoDjoAUkuuozfiTloLMAxUaxhI0oRsiNV/MzgCcir1PEDPP4x72KlegDjqX3IFdAl5m7un6PBs69Dy/16oVe/9pGXEj7iiX+93cW7NquSfwx/4386Ami0NLveDIqPzvlCvgrcO/o94Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084585; c=relaxed/simple;
	bh=4jHAblMxliWyhL3ZaElD1UByKxli9xdBB+SM8oFpsok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iR91VpBhpv92xwK3tzE8CIO+xYm++sjho7FW41zcKpAUM3Yt1qbmJbRBhcC9VHbGuPjUlalo2w5gPzcREtagT0XnuORWtvQy31eCWHmjRuP+2zvGZXqbWmbcidbcFiSEUeXI7Up5HnJinFaAC3I4CdI/3uAfpxrZ3kJAQZZzwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzgEbvPj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPRuiZzW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSCbfC1lqrWlCsBSs/RacUuL9OwQRSAEwVDDnh3JOT0=;
	b=TzgEbvPjsDnSBaULEEmlWbfKYNsjOys7lfPQJfbeehKxwGEG61bJqhpARNzrQCWKBFqA3g
	cFW1i1VL+UD05Ra9hOumWGTlR7a8BLWC5fHtFSmj3WnzK/Xg95uTNCx2p7OpDdFQ3PuKNi
	BLg2gFqgd5R98zV8R7hPHNwEsdHoJZ1QWdxB7Y3maWEsBZAd5Xr00McPsg+uweQ0W+Fa+H
	PgCCiaKxG7CiLYIHGyY7CHjcNtJDgq2haa0WaECSuVHdGGN1gBzrsoY6OT/CT7PbeAgKMP
	72UfZ8eB59Bx8/7kRxeKQCI/YUkjwO3W/NZtESgwsroUzC3zHkwjWcgHPqUeaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSCbfC1lqrWlCsBSs/RacUuL9OwQRSAEwVDDnh3JOT0=;
	b=JPRuiZzWvotq3csNY0X9FM1d37xYT7mJhVX4XE1axOcpp0mFdBA4JZhXRjwqRrNSGtb/tH
	Z56LonFMYGM4KICw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Use current_stack_pointer to avoid asm()
 in check_stack_overflow()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-4-ubizjak@gmail.com>
References: <20250303155446.112769-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458195.14745.16912760676522793123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     9266be1052e0586ea932011ad671beefbaff1a64
Gitweb:        https://git.kernel.org/tip/9266be1052e0586ea932011ad671beefbaff1a64
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()

Make code more readable by using the 'current_stack_pointer' global variable.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-4-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index f351fa1..2428d66 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -31,10 +31,7 @@ int sysctl_panic_on_stackoverflow __read_mostly;
 /* Debugging check for stack overflow: is there less than 1KB free? */
 static int check_stack_overflow(void)
 {
-	long sp;
-
-	__asm__ __volatile__("andl %%esp,%0" :
-			     "=r" (sp) : "0" (THREAD_SIZE - 1));
+	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
 	return sp < (sizeof(struct thread_info) + STACK_WARN);
 }

