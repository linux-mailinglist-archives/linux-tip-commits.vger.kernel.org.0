Return-Path: <linux-tip-commits+bounces-4908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0237A86EF9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B2617E964
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A12219A7E;
	Sat, 12 Apr 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbkWd9sk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMeSx4iB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507ED14AD20;
	Sat, 12 Apr 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483617; cv=none; b=Kr6H3NETIjmQa0re/0lUnahVH8N+1B955ou+tTR+sLQe9JzAWmCEwBy2vpAMxBN2BQ5adQ/LBnu2o9SY8pUqCiQFkcknAKlHP6H4w3HHMjLV9hyfhiqVMoKJPfLjNvh17Vg5YnTfvM6XvxHeopZveuUfVA6yj4z/y+J8CKeGq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483617; c=relaxed/simple;
	bh=fZhn0UiKEmEbt/kipTaDRSv45kfKJsjh6AKCX6p4fEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ftkcr9TaBTrm1ZJ7S4lZ8/pyfwlGZqoqjXEnpIczh8Km/0eHI17pRdRjanO7L9McQpugpcQasSYVyv5yQLBbaJpwK1B8ei2owou2ueQJYjhfl5BhpuDSzqO9RJdRgRlencvMLcSS1oNT1OWBXw0SGctUXAzS67NJv32tG4MI7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbkWd9sk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMeSx4iB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/hZ92GekqnqM4Hegl9q85TcmQCDuuVZfnUARvqVX2A=;
	b=ZbkWd9sktR20Nl3lNfNmAwtniOwdkk/I5BHezasRYao/VsMn/IqDc/2+u3n8yNVnEhB57x
	nIDOvxuYW7ROkEDy3oSTnqWU7E1Qn1S2gmuqhYOQRSjVsIhW5VEVn6VJKRKSZxSI+7Pwf6
	cR76n7Iqh0M+Iv2YXG0k3S548ytWGqbGfo1WXmAvaBu2FFYENSAM2EQNRh5hnoziktXVtR
	aZp0Vu3lpw68RjksHEEpTlsQxTBX7hk/xs5QIUFXttxgVqal1mrW100KlSwxzzSRXbvafQ
	og1iJCBLMt4N6pEofMvs5X4euKYtx+ttSDTERe5uvZhTX2/+7HCvbv2NfpW3Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/hZ92GekqnqM4Hegl9q85TcmQCDuuVZfnUARvqVX2A=;
	b=ZMeSx4iBfWWHC7e3GjbWfGgetLPPHmv+HcWmbj5Cg8Hsyz9e/ZF0jMRPSqPjIe2XPVx/2c
	t0jLCusVJlHQs4CQ==
From: "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Opt-in to IRQs-off activate_mm()
Cc: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-8-mingo@kernel.org>
References: <20250402094540.3586683-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448360413.31282.11770365769162014117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     af8967158f9ad759a93e8e7a933c10e7cbb01ba2
Gitweb:        https://git.kernel.org/tip/af8967158f9ad759a93e8e7a933c10e7cbb01ba2
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:06:08 +02:00

x86/mm: Opt-in to IRQs-off activate_mm()

We gain nothing by having the core code enable IRQs right before calling
activate_mm() only for us to turn them right back off again in switch_mm().

This will save a few cycles, so execve() should be blazingly fast with this
patch applied!

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-8-mingo@kernel.org
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/include/asm/mmu_context.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378..aeac63b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
+	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_WATCHDOG
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 988c117..c511f85 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -190,7 +190,7 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 #define activate_mm(prev, next)			\
 do {						\
 	paravirt_enter_mmap(next);		\
-	switch_mm((prev), (next), NULL);	\
+	switch_mm_irqs_off((prev), (next), NULL);	\
 } while (0);
 
 #ifdef CONFIG_X86_32

