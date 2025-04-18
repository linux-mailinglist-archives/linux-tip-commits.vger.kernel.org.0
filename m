Return-Path: <linux-tip-commits+bounces-5083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3AFA9376E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 14:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C5846757C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F002275113;
	Fri, 18 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7ELrU68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xb6WSsY4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00147275119;
	Fri, 18 Apr 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980500; cv=none; b=UA0Bya0uO7u7Hxb5ldkOEM/Pk5hlJpaznOUTt7k+xYYeoq8AtrQelFC6VIMFdd/JFCAo/w24PLOTkjp3OBLqWTlbLpEiir9VrchpyByilwhqnHlXX1aDMy3scHFoebk1QFtWNu6jQEw2XeRVB3P4+nd81kxLwoNekt7/UWT/IA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980500; c=relaxed/simple;
	bh=5iP0/iUDHlPimuG6aFa0pmfO3lQC3a/ZyVK3ba58Dfc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QJ1gqWA1n/sgjl+NoBmj8d17QpbMO5Swn2Qn/I1zc4W3J8XcMjPi8TZWw5Dv42JizAz7VBPQOxkrgHXMa/i0QjdfTXu6rs34+MNRYlE2A8WouirTnQ3tryq/mhzUKTutM8OgkVaG/HT/jF3EmoLzSHo4vhe4E/uTKh4PXYZS8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7ELrU68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xb6WSsY4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 12:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744980494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iacdnq+pgxmJl7zlTNUCTe0ghULjkxMNxJ5OdN3S12M=;
	b=c7ELrU68UCywmri+LgYNIGufiFd9QYNc1+l6sqPeUEOuOzg1vOsyGjywrSFZDmxkxrltfU
	z8jOZKjDs886++w09ISb4VUMG37/W3g5PNP8x6pNyJnXOmunAKamxzcjJ4L54xqzc8mxbT
	/r7hknNzdZz5EOKYsPsFzHJyiIqB/+YWBbocauxfXZHDqTjxon1BekahCkHE+FkfsdE7Zv
	N/p8TAJMapf86T529bEnUbkHqZGM2aeeFDtdZOt7SzPSkYmDssoqER7m6xMwes/oZB8PXc
	zaLa3Vdrse0dADfhBJMndfukgwi5brPUOOSPA23fyGXNpJwDykA0kAViy7ZsiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744980494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iacdnq+pgxmJl7zlTNUCTe0ghULjkxMNxJ5OdN3S12M=;
	b=xb6WSsY4c0VV8M6TTx8qgvb6xRt1FO6fefTNJkvLau1WhXDvcR267LR4oKCql3J+XEnW4g
	ksp2Dlg6rLkML5Aw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Fix {,un}use_temporary_mm() IRQ state
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418095034.GR38216@noisy.programming.kicks-ass.net>
References: <20250418095034.GR38216@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174498049254.31282.3233990850246687101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     aef1d0209ddf127a8069aca5fa3a062be4136b76
Gitweb:        https://git.kernel.org/tip/aef1d0209ddf127a8069aca5fa3a062be4136b76
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Apr 2025 11:50:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 14:36:18 +02:00

x86/mm: Fix {,un}use_temporary_mm() IRQ state

As the function switch_mm_irqs_off() implies, it ought to be called with
IRQs *off*. Commit 58f8ffa91766 ("x86/mm: Allow temporary MMs when IRQs
are on") caused this to not be the case for EFI.

Ensure IRQs are off where it matters.

Fixes: 58f8ffa91766 ("x86/mm: Allow temporary MMs when IRQs are on")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20250418095034.GR38216@noisy.programming.kicks-ass.net
---
 arch/x86/mm/tlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 79c124f..39761c7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -986,6 +986,7 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 	struct mm_struct *prev_mm;
 
 	lockdep_assert_preemption_disabled();
+	guard(irqsave)();
 
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
@@ -1018,6 +1019,7 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 void unuse_temporary_mm(struct mm_struct *prev_mm)
 {
 	lockdep_assert_preemption_disabled();
+	guard(irqsave)();
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
 	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(this_cpu_read(cpu_tlbstate.loaded_mm)));

