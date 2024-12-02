Return-Path: <linux-tip-commits+bounces-2929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE5C9E001E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885C2161A4C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1171209F3A;
	Mon,  2 Dec 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRT8j/w3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="luCbp7Yg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD86209675;
	Mon,  2 Dec 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138092; cv=none; b=gDtDmei5Qe58FbkNUxsXmHOsBsvBONmYuuIIK91fNedylx7vsupvBEZFYCxRq2pRuNQIROViko7KU9BbWgP1mtg2PZo2nL0YGrvjfsdJ6LCa2danJYqtBDbyF1oFbGx04Kt2zmwG4yX3zb8hydtxwjnHs23dXea5daBZU6PwM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138092; c=relaxed/simple;
	bh=FFoenbSkWq3AhEzFht99ejT9uFvz9lANGuUM0t5cSzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j5jZRmSK9aCNB1jaqdvUIO+O6zrrQEXhp3f4GFdhFnLY+Ljex1V/xWQVv8pKyhPhSy+beCmSb7gBx0dULl2qdDPz0zUxAA18M6A6w2gN4GJfgr3jxjTK7+xKwqPC0Hv8d2jGqrvypEnFEHhRcQFXgTHCzHravoeqyD0O4GuLsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRT8j/w3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=luCbp7Yg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cU6I5J9k0ZPbbFiOq/nxIXh10d3jrM7/Sql1reSseuk=;
	b=SRT8j/w305y23ikB3lPRzxwBlXbpv+hE35BAnYVMA/6gHd1QZ4hotospA6XcWtBQ9n9V9d
	m3nuCRmFGX21vaQhixoO4Lt20+EkJU9F3LlTvYy2t18w/ya4y0GRvopbC5HIizcc0+DzT9
	7Au8/dgn0AaHjMir2puyAQ0ME4jDsLbg1APt5qVlFL+ztdvIh9XkD2GRf4MYnd3NPIWqu9
	2O+U4eUQ7n0FJy8cJEQrPK5W4WVYE9y4trpcx172q+DYaCpeQ9ehaTLV8hfH+3TJTNmDR+
	yEjrFBkrR6TuayEjRZY90L0EVwqLTO2AcvAlsnJPhUOtSjRi3TfV0qMJ28pB5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cU6I5J9k0ZPbbFiOq/nxIXh10d3jrM7/Sql1reSseuk=;
	b=luCbp7YgFZgQrUHaTnH2UcLw23otajq4yb3bH+Em9c9krghRXM0jN5mCtS4ipkuSgR22M7
	kNQ+VrZBgoAU20Dw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Check idle_cpu() before need_resched()
 to detect ilb CPU turning busy
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119054432.6405-4-kprateek.nayak@amd.com>
References: <20241119054432.6405-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808896.412.10235644272421165401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ff47a0acfcce309cf9e175149c75614491953c8f
Gitweb:        https://git.kernel.org/tip/ff47a0acfcce309cf9e175149c75614491953c8f
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Tue, 19 Nov 2024 05:44:31 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:28 +01:00

sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy

Commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
optimizes IPIs to idle CPUs in TIF_POLLING_NRFLAG mode by setting the
TIF_NEED_RESCHED flag in idle task's thread info and relying on
flush_smp_call_function_queue() in idle exit path to run the
call-function. A softirq raised by the call-function is handled shortly
after in do_softirq_post_smp_call_flush() but the TIF_NEED_RESCHED flag
remains set and is only cleared later when schedule_idle() calls
__schedule().

need_resched() check in _nohz_idle_balance() exists to bail out of load
balancing if another task has woken up on the CPU currently in-charge of
idle load balancing which is being processed in SCHED_SOFTIRQ context.
Since the optimization mentioned above overloads the interpretation of
TIF_NEED_RESCHED, check for idle_cpu() before going with the existing
need_resched() check which can catch a genuine task wakeup on an idle
CPU processing SCHED_SOFTIRQ from do_softirq_post_smp_call_flush(), as
well as the case where ksoftirqd needs to be preempted as a result of
new task wakeup or slice expiry.

In case of PREEMPT_RT or threadirqs, although the idle load balancing
may be inhibited in some cases on the ilb CPU, the fact that ksoftirqd
is the only fair task going back to sleep will trigger a newidle balance
on the CPU which will alleviate some imbalance if it exists if idle
balance fails to do so.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241119054432.6405-4-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89..05b8f1e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12568,7 +12568,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 		 * work being done for other CPUs. Next load
 		 * balancing owner will pick it up.
 		 */
-		if (need_resched()) {
+		if (!idle_cpu(this_cpu) && need_resched()) {
 			if (flags & NOHZ_STATS_KICK)
 				has_blocked_load = true;
 			if (flags & NOHZ_NEXT_KICK)

