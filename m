Return-Path: <linux-tip-commits+bounces-4016-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E8A50DCF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A5C3B2DB4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2625CC9F;
	Wed,  5 Mar 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vf4zg+di";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4y6tS71i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CF2586D9;
	Wed,  5 Mar 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210590; cv=none; b=BPom0PrnX18Wt3UVJa8lAqokSFc9rsEccVjFfOXwM5dEiM2A6W1Yde5r2l9fVy7RMlFzTqy5+UjfezY6KO2yfBz+FXy2BnmDyuG44Lz8Uv5uzy+PF3uMnsP2TBYKpjvsdhzAUmqkgVMZO5tnv/VGq9KpsWPn51B/GY93ByTKBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210590; c=relaxed/simple;
	bh=DEnGKwwNLfEWov/ZfOaYtngc85YVIaa93iGWbQYLADM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aTlBLrz//U6Jq6tUNEuaqcC/5B5aQIiBt0JVrAGHuw7LS6WuH8m1yMkT2KwavwQ+2hGBLTU0fAZDqAjqVq26agFfp4jdlwRagqC23/0wTYYMTjWkSlosJMzvT/IdKXnMaTGzMwALZZcAIiYU1En9C/u4KgNUGio5S5xDjlmBQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vf4zg+di; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4y6tS71i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjSJWlhTGrBw4sQajHxuUXxwJrpgjJE8ggNtUIW0+E8=;
	b=vf4zg+dif0/KTR1p87hYkEBWEtUlGQHmjUJVqFW0M6FZdya//XmF4E7uVSItTn8CAfmg1J
	m8Umq7L5TPEG5CIQ1cXQoYZs05wI9ESVk2P970PHWB3pM2ikcJgIN5ShaZ+xHOaYcNp1vY
	VLd0aVK8MMIvK9eMgJKpJrth5FrerB5ajfdCPYEzRetmwOlahVn/oCEKzjeYuXy/91QFQn
	51E1JjRFJvG/t9O1NgEbOHNSULSrKvkMWnePPj+A6Fa9CcSgZoWjpIvvGzULMguSNy4J4O
	eY2QhPpUlU/ZGlBjYi+/6JA4T7mHb588acs1xM/p8IDJ+pzNJO/5hgjh66qDPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjSJWlhTGrBw4sQajHxuUXxwJrpgjJE8ggNtUIW0+E8=;
	b=4y6tS71itYC4zi0WBE+prbCMlXfBCwm0K+ZotGxwhU1qjh0cs4o2WYGHT+DQy79VbD64UL
	TTCi8FfT3vyHblDw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use broadcast TLB flushing in page reclaim
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-7-riel@surriel.com>
References: <20250226030129.530345-7-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058573.14745.18178096566558928235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0b3a2f246a5bf016b80a136a9f8c24d886107dc3
Gitweb:        https://git.kernel.org/tip/0b3a2f246a5bf016b80a136a9f8c24d886107dc3
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:41 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:52 +01:00

x86/mm: Use broadcast TLB flushing in page reclaim

Page reclaim tracks only the CPU(s) where the TLB needs to be flushed, rather
than all the individual mappings that may be getting invalidated.

Use broadcast TLB flushing when that is available.

  [ bp: Massage commit message. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-7-riel@surriel.com
---
 arch/x86/mm/tlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8cd084b..76b4a88 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1320,7 +1320,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		invlpgb_flush_all_nonglobals();
+	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();

