Return-Path: <linux-tip-commits+bounces-3114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D99FBB8F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816EF168C5A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B31CEE82;
	Tue, 24 Dec 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyXrrvqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7O91rzbb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EF183CD1;
	Tue, 24 Dec 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033653; cv=none; b=gM1UqMnV8vg/FHxcAG+HRer5H0foEgylX6SCQfx9ekIZ3tdrsexHKfN8vvny/g5gVNt3QsmFiWsnvxydO6glGwJCAs2GYVrmiF/rxolwSnKTZP5159yoqNFbTISbNBvHYpY4s0TJe2m4/hGQVyXgNz4rDnxTEKgXIcDlo3JMcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033653; c=relaxed/simple;
	bh=B+YnSZIk/IHMnCSsl4m5lJlNhLBTZh3tYLct2mtRZ3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hEhWFnmgKz+22sZ3HWJCxTtOcDtr+0OfVY6XGvZYMj+dWgJKYsLM4nI42KfjWtUMsxFzX/w3lnXaa1xon90xWtUJkLbmp+kU07IXwN1PRfAGEJGYminwWH01mCP0w8yC6Gca6SUlHd4yFkGwBsNNV0iHvfRSJ+vYXm0LfYb4KxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyXrrvqF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7O91rzbb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhXapJ1KgmkxevtuC4j++u/+2yYw1idPNBoABAUsN4=;
	b=iyXrrvqFT2fVo65CW3hfqN1SmmiShHgLQGTSXwT+4hUgjBbcYQvrN/VUbFGhHjuoSDoMJA
	NuOi+EkjvhNj2weilGE9yug6ixbgH80acq06gDnsPra2LIETSYGWb9VC1ge+Ujyj+S3jTr
	F+mUen/kk4WhgjeXYPpKEdKwVVx1wMVKp7yGLdkpRJZy9sZo8NKIaXs0XzetIbRN1vmP+B
	zuNKJCtwi+5p3W2iLaxnFB37kdEAAZKjh+1p2/sNs7psBsULwL4CUCXz4WiLgsf38E+i3m
	OX5f0hhumeyi0/HKFH9kl78L24ztthvKRx7YUmOig3/FXKc8eyYs87SpXbcCPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhXapJ1KgmkxevtuC4j++u/+2yYw1idPNBoABAUsN4=;
	b=7O91rzbbAA5lfkaBVdkzH6KLcxeJfdBG6QFYQ6D2pzzYdkDc06y7KPVkdsLh3txDUhVply
	/na6FQaRJc92CqDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/mm: Convert unreachable() to BUG()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241216093215.GD12338@noisy.programming.kicks-ass.net>
References: <20241216093215.GD12338@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503364879.399.5490115993339890700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     41a1e976623eb430f7b5a8619d3810b44e6235ad
Gitweb:        https://git.kernel.org/tip/41a1e976623eb430f7b5a8619d3810b44e6235ad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Dec 2024 11:08:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:21 +01:00

x86/mm: Convert unreachable() to BUG()

Commit 2190966fbc14 ("x86: Convert unreachable() to BUG()") missed
one.

And after commit 06e24745985c ("objtool: Remove
annotate_{,un}reachable()") the invalid use of unreachable()
(rightfully) triggers warnings:

  vmlinux.o: warning: objtool: page_fault_oops() falls through to next function is_prefetch()

Fixes: 2190966fbc14 ("x86: Convert unreachable() to BUG()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241216093215.GD12338@noisy.programming.kicks-ass.net
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b..ac52255 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -678,7 +678,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
 
-		unreachable();
+		BUG();
 	}
 #endif
 

