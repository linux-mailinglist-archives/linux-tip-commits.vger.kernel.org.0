Return-Path: <linux-tip-commits+bounces-5044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D15A91D3C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099B8169A17
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0818DB0D;
	Thu, 17 Apr 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQ2fPPT/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkU2E527"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B215FA7B;
	Thu, 17 Apr 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894975; cv=none; b=LzEeXfNsojHwjpRcYEEs23gffhAeQQl+DvEVLj/4xfXMtNumGH3Kv3K/v7hm8mzF6C5GUvdTKiWbq98VnSlOjtsPKZMREwjxyAw+Y+L+irr70VMWloTZuMJPQglqscFqo+0wnWOp0UQbBBm/Mduhly7JSFBhDZ8cFkk6a89Onfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894975; c=relaxed/simple;
	bh=AelqpKZTM7w8piXE/g7NilMkuh9zH6L6+9D+7BhFTLs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DbaxsP5wPdW8/cIQqXxkr8z4VylfeJOGgLu4TZwpH3H74wMDf4oFO/yQ6mo2WUk2CX7PyDdFXceXFGlv4aRH80QusLhwIwPXNcYHYDr9dQIPI+KW9YPXyo+du8m6OYwBH5QeT/w1SQjugaTRvz3noV8rpvdSl5LUowd7yZnDtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQ2fPPT/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkU2E527; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2y7D2sC7EK9zIPv+63jdJcyWcnQch9HW0LjgX8DAE0=;
	b=iQ2fPPT/ByvfM3OWwDt7gHh6eAlBjhqtOMVwqLGt+13pr3WYrY2HWsdku1XAkGXrjedCee
	oW99Lfd/E7gY9kQLOO8jWjDddtKFG3uZgW6e05hLZESqB4ppumoEBf36vTBOSy7r+55xaK
	cY5cmQpOs3ZNRsN8pHYWfUZG24MDyS8bFcS13oG0Z8i8Q3zqX6SQl6BsWu4R2eu8u2d6gi
	CGFyrz1y7TRBeAKXDICmkLGCgfYPO6R/SAMJVBe4lZIlT8Sm5w6HCTlDjPJF6I9AeT/tkA
	r0NM79rwsUiilfwq1RGCkl9gXS1ZBIE9YBFCE2lM3TmEiUD6pCXGdd7SiWKEkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2y7D2sC7EK9zIPv+63jdJcyWcnQch9HW0LjgX8DAE0=;
	b=KkU2E5273NaZ0sT2tMNkfVQA4wcwUg2aG4gqTsuauh8kxahCpIe79oFoP0ytStrigFKdn2
	PJ8KorDXPDffZUAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Remove the mm_cpumask(prev) warning
 from switch_mm_irqs_off()
Cc: syzbot+c2537ce72a879a38113e@syzkaller.appspotmail.com,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
In-Reply-To: <20250414135629.GA17910@noisy.programming.kicks-ass.net>
References: <20250414135629.GA17910@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489496807.31282.14803836540166615145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     52ebfe7412ce4b3af54fe962af58efe9b25cd9a9
Gitweb:        https://git.kernel.org/tip/52ebfe7412ce4b3af54fe962af58efe9b25cd9a9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Apr 2025 14:34:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:46:25 +02:00

x86/mm: Remove the mm_cpumask(prev) warning from switch_mm_irqs_off()

The CONFIG_DEBUG_VM=y warning in switch_mm_irqs_off() started
triggering in testing:

	VM_WARN_ON_ONCE(prev != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(prev)));

AFAIU what happens is that unuse_temporary_mm() clears the mm_cpumask()
for the current CPU, while switch_mm_irqs_off() then checks that the
mm_cpumask() bit is set for the current CPU.

While this behaviour hasn't really changed since the following commit:

  209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")

introduced both, but the warning is wrong, so remove it.

[ mingo: Patchified Peter's email. ]

Reported-by: syzbot+c2537ce72a879a38113e@syzkaller.appspotmail.com
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20250414135629.GA17910@noisy.programming.kicks-ass.net
---
 arch/x86/mm/tlb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c9b87e5..79c124f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -905,14 +905,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 
-		/*
-		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
-		 * mm_cpumask can be expensive under contention. The CPU
-		 * will be removed lazily at TLB flush time.
-		 */
-		VM_WARN_ON_ONCE(prev != &init_mm && !cpumask_test_cpu(cpu,
-				mm_cpumask(prev)));
-
 		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));

