Return-Path: <linux-tip-commits+bounces-3230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F56A11D46
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E1B7A1897
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049A22F82F;
	Wed, 15 Jan 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y25C4zdN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf9SKLFF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560313DABF1;
	Wed, 15 Jan 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932644; cv=none; b=sypcyAdb5Qu6zyLrSEJxuFFahy+XP7CXVVugCqpBLIca6pXxzeXN+bMtLPslxz2PyAhQxVJTeOTroGaaO1OZw0J7JmrFZiCKAJy5dAL7nCvMyIPhlwS+7YLn98rKVYQEA33Kt1HDzATZwZVTV9c++pSxPyqOk/tio1gFusEofws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932644; c=relaxed/simple;
	bh=uxjVSsXD2TBkX5Fi4zy4weYBOfZt2HHrIWDrKOatxjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wp0Q8RJBcf3Bnlyvnxb9i8cZc8fclwHItN+JXuUr9//Pl8iKoAICPt7RgbbXFZJqo/yk0yFVgF/+QjV1lVA+lgj7DKIMWCnWt6jWc12WFREZ9tyBROpT0WWMr0Cr2SrzJ1OZzUL04SWnLtlHqnrrye1BgbYPB9jPdQr5vhp008c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y25C4zdN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf9SKLFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7UnwC2uT4fvReSG0gaIdtF0uYY5IV7UjAznAlv1JNs=;
	b=Y25C4zdN97Sre4mCKZvi5j3oV9rPJUTyP2SvzXhVN81Xaz61CkzBAD915z+fPyjowfI/A0
	LLGgvHhh0bgKKw3BCmRdABBaPdHUSNlAeqgLMwhg34MGr+csriXWE/OBcDO5eDzGGsQarx
	ogO4adcWJgLrFT1+3T6LTDUaunHvxOEQROxWfPTqzWx6MK7df+til9zPmj6n2PCbtx1e3v
	WcnxhTaUw0F62Yoog0JHLB3zJLO8HNhtspTQw5Lf6EMTddhYBqe51eLznFmAWE6NkscH2j
	636gI7NuCuUDCoOB+8g9iZjDzUEuwawoVaAQL5KFQ1GxjS0h51KdttfipJQVVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7UnwC2uT4fvReSG0gaIdtF0uYY5IV7UjAznAlv1JNs=;
	b=sf9SKLFFV4/G8dvRhbOHk4DL9xY/hFy0CrSuXN7eGvy1xYy94jaePfD6nTCMGuG30KpY0M
	G0fX+caSukyECHDw==
From: "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Fix race between yield_to() and try_to_wake_up()
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241231055020.6521-1-dtcccc@linux.alibaba.com>
References: <20241231055020.6521-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263944.31546.17125599138962679235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5d808c78d97251af1d3a3e4f253e7d6c39fd871e
Gitweb:        https://git.kernel.org/tip/5d808c78d97251af1d3a3e4f253e7d6c39fd871e
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Tue, 31 Dec 2024 13:50:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:22 +01:00

sched: Fix race between yield_to() and try_to_wake_up()

We met a SCHED_WARN in set_next_buddy():
  __warn_printk
  set_next_buddy
  yield_to_task_fair
  yield_to
  kvm_vcpu_yield_to [kvm]
  ...

After a short dig, we found the rq_lock held by yield_to() may not
be exactly the rq that the target task belongs to. There is a race
window against try_to_wake_up().

         CPU0                             target_task

                                        blocking on CPU1
   lock rq0 & rq1
   double check task_rq == p_rq, ok
                                        woken to CPU2 (lock task_pi & rq2)
                                        task_rq = rq2
   yield_to_task_fair (w/o lock rq2)

In this race window, yield_to() is operating the task w/o the correct
lock. Fix this by taking task pi_lock first.

Fixes: d95f41220065 ("sched: Add yield_to(task, preempt) functionality")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241231055020.6521-1-dtcccc@linux.alibaba.com
---
 kernel/sched/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ff0e5ab..943406c 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1433,7 +1433,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	struct rq *rq, *p_rq;
 	int yielded = 0;
 
-	scoped_guard (irqsave) {
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		rq = this_rq();
 
 again:

