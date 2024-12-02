Return-Path: <linux-tip-commits+bounces-2925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582249E00FE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C0BB2538F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA088208985;
	Mon,  2 Dec 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+8nycja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROmfkOvv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66D207A2B;
	Mon,  2 Dec 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138089; cv=none; b=jsCWmg9Db07dnV4xG5LmBtHO2TnCkF89Qn+5z4dTMp09peQP5R37Jqp+1HO9LLg3GExI2NBhAnx86prVZq8/cjkjoxwWN6UW7U1A0ZyX11IsCBi+YPo1asLCwScp5OPqpbRMpL14OfzgW2BdkbRBywh6NdqwPKh9DgrNMKV56hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138089; c=relaxed/simple;
	bh=1o9negT4RhGLgYPorhd2BwFe9ccwL1EipFpvLRWiOKY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u9MoejEGnWbH6X3G3QJPQGpee+vv20gEgH5j5PD4ubgmoRrb9gZQb6VOOAfgXuAOHqTy+6AGVcndTujwh2mQ52Nt8QXFUhyHOMNP07EZ9wbfdozdVBXM/aIz3wgf4S7Jd8ng1F4XmApnwp90cSvkfMeQMAEggJwwXHQf7cLTRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+8nycja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROmfkOvv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLLuY9t2rTmkRE210dDrPrl5VoVogYOBNfBwk+rCx3c=;
	b=C+8nycja3HwF/ff0vz2L/wdt2xSJknsoh9GOZIeOzpB3mYxoPBfp58ivtbaRyZETnogQfx
	Qe1RXGw7f5FYWCUzKhaX35is+A20rEVU9WunzWy39CKbXfwo+t+2LLCd+J/GGIVZ3XyZ1g
	zV/MEqJZZl39HZ4Y7oi1beSafnoxIRbySe06z9GIx7Dto82j2aSTPHa6hxjAIGhh0UivH9
	oHqluWroD0ukLWHq6xXc8Hzf/FYXRCQ6HWB/1cjgO8WSAYqZNEXtyYZQp7V6RG0om5PSqq
	0IAOTjU3R8oYUbypum3zReDpv8BGmPJPD33WzYjxaFzwrUsAvWYEqiBB4+RiJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLLuY9t2rTmkRE210dDrPrl5VoVogYOBNfBwk+rCx3c=;
	b=ROmfkOvv60lvjLDYZD31Blwq3ycb/oo4BG52QsHFfitpgeaEhsYOvzngLJ46uXs+kn+xHr
	yLAzyCiQJo0Am/Bg==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] locking: rtmutex: Fix wake_q logic in
 task_blocks_on_rt_mutex
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114190051.552665-1-jstultz@google.com>
References: <20241114190051.552665-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808609.412.18083738316919093467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82f9cc094975240885c93effbca7f4603f5de1bf
Gitweb:        https://git.kernel.org/tip/82f9cc094975240885c93effbca7f4603f5de1bf
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Thu, 14 Nov 2024 11:00:47 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:29 +01:00

locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex

Anders had bisected a crash using PREEMPT_RT with linux-next and
isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
wakeups from under mutex::wait_lock"), where it seemed the
wake_q structure was somehow getting corrupted causing a null
pointer traversal.

I was able to easily repoduce this with PREEMPT_RT and managed
to isolate down that through various call stacks we were
actually calling wake_up_q() twice on the same wake_q.

I found that in the problematic commit, I had added the
wake_up_q() call in task_blocks_on_rt_mutex() around
__ww_mutex_add_waiter(), following a similar pattern in
__mutex_lock_common().

However, its just wrong. We haven't dropped the lock->wait_lock,
so its contrary to the point of the original patch. And it
didn't match the __mutex_lock_common() logic of re-initializing
the wake_q after calling it midway in the stack.

Looking at it now, the wake_up_q() call is incorrect and should
just be removed. So drop the erronious logic I had added.

Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Closes: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20241114190051.552665-1-jstultz@google.com
---
 kernel/locking/rtmutex.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ac1365a..e858de2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1248,10 +1248,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
-		preempt_disable();
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
-		wake_up_q(wake_q);
-		preempt_enable();
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);

