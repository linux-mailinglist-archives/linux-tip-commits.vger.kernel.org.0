Return-Path: <linux-tip-commits+bounces-2044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC98950E43
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0840B283D6E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6E38FB9;
	Tue, 13 Aug 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7ACY/E4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DA1E86A;
	Tue, 13 Aug 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582948; cv=none; b=SgHPEnQclSbGRXD+wNl7OrtGJIqIwHX4gzaoCzBT1dEpocDXjDLzzn4pT4XICDIwpYGHxIMCgRSmWPLyAtC0ziYpAR1VI5ttUkbcepPhYuodPct+IudL+El5HgxoCzpVGLy7zk3uwEmfKlY/bmk/4wpSbo0HzIifneBrRfJqNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582948; c=relaxed/simple;
	bh=3UZ9S2Y70HljE2j3ZOj5LBkVKN9Mw4UJ4WbwkYnUraA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOqbd2vhffb5WWkjnZZGRUdG/SMyKgKgMxSK+kceScvSlj30SRmbCk+LUssuwj1MAtVx4ooD1f9w6e+mThRd9WMiAZN0bYb740pw8ULH+qxSPDbnf6b3BdH1sPMb69Palm/z3lEWJ6uTN/tl+aVoJIVThxSogb17oeZZ0miFzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O7ACY/E4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2IOmSrY70uwk1HcUoylW9y1turDpgUbCA7KHSlUuurs=; b=O7ACY/E4I/53NE4vlQtKuUot2Q
	y2/CPLUI2Kry3BYvzL4Ru2Y1smRabroqTxun/G2poPbybtSj5br/bc0FopCBjHHNqVC9+AFIoHHH3
	tjwSYXCiRhYWGFseuVeEAaq6LNbV9NsZrKesEugIo6bw5vVxbgb2EJB7AyLgGZF4PSdDPSPrCZmvp
	TXUDr8FU7eRW5/E3hD0BK+UtFDidxKZRqRVNip+Qtn7a3ZXOvYquBps2A5DQeJMPXIsAD3OYU67Zx
	VATxBpxHx+CUmGaZDKH8dCb5Ol9OJJuU+MG3VhN9DyEQ60Ye7DW1ylaudBH+IfkkN5nDXlHRdfi7P
	+SWwtAeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdyeh-00000007rGr-3Qlz;
	Tue, 13 Aug 2024 21:02:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80DE530074E; Tue, 13 Aug 2024 23:02:09 +0200 (CEST)
Date: Tue, 13 Aug 2024 23:02:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, pengfei.xu@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	x86@kernel.org, lkft-triage@lists.linaro.org,
	dan.carpenter@linaro.org, anders.roxell@linaro.org, arnd@arndb.de,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [tip: perf/core] perf: Fix event_function_call() locking
Message-ID: <20240813210209.GA35275@noisy.programming.kicks-ass.net>
References: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
 <20240813151959.99058-1-naresh.kamboju@linaro.org>
 <Zrul5kzUc-5BfWcT@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrul5kzUc-5BfWcT@google.com>

On Tue, Aug 13, 2024 at 11:28:54AM -0700, Namhyung Kim wrote:

Duh, yeah.

> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9893ba5e98aa..85204c2376fa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -298,13 +298,14 @@ static int event_function(void *info)
>  static void event_function_call(struct perf_event *event, event_f func, void *data)
>  {
>  	struct perf_event_context *ctx = event->ctx;
> -	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> +	struct perf_cpu_context *cpuctx;
>  	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
>  	struct event_function_struct efs = {
>  		.event = event,
>  		.func = func,
>  		.data = data,
>  	};
> +	unsigned long flags;
>  
>  	if (!event->parent) {
>  		/*
> @@ -327,22 +328,27 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
>  	if (!task_function_call(task, event_function, &efs))
>  		return;
>  
> +	local_irq_save(flags);

This can just be local_irq_disable() though, seeing how the fingered
commit replaced raw_spin_lock_irq().

I'll queue the below...

---
Subject: perf: Really fix event_function_call() locking
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue Aug 13 22:55:11 CEST 2024

Commit 558abc7e3f89 ("perf: Fix event_function_call() locking") lost
IRQ disabling by mistake.

Fixes: 558abc7e3f89 ("perf: Fix event_function_call() locking")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -298,8 +298,8 @@ static int event_function(void *info)
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
+	struct perf_cpu_context *cpuctx;
 	struct event_function_struct efs = {
 		.event = event,
 		.func = func,
@@ -327,22 +327,25 @@ static void event_function_call(struct p
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
+	local_irq_disable();
+	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE) {
-		perf_ctx_unlock(cpuctx, ctx);
-		return;
-	}
+	if (task == TASK_TOMBSTONE)
+		goto unlock;
 	if (ctx->is_active) {
 		perf_ctx_unlock(cpuctx, ctx);
+		local_irq_enable();
 		goto again;
 	}
 	func(event, NULL, ctx, data);
+unlock:
 	perf_ctx_unlock(cpuctx, ctx);
+	local_irq_enable();
 }
 
 /*

