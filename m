Return-Path: <linux-tip-commits+bounces-6712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F475B97AE3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 00:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2612A17C87F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 22:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716452EA462;
	Tue, 23 Sep 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7oOqqP0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E452BEFFB;
	Tue, 23 Sep 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664943; cv=none; b=tceX1qdFvzgZxedyCQ/YSFc46q3jkOepLOHHTY1PZQ+i7U9AlfZHxSLgl6LJmLcb5RU2a0NFUWjLRr5vBql3Ilh2hU9zb2DgHXAg5JvsakdS2JcsV/SW5sMWgvBVTuQDKsIsLQrW7BXxRf9bAL5YAtgcFileITqY8qF+R9QLS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664943; c=relaxed/simple;
	bh=ZvHBpXwnkj5G3I1cpdIXPWuC255s6dCf87ZVQ9cW8iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No9KDKmKsNQkplzMx86HZ2+dzXEahqhb1fqoxCs8nSzaFssMVdBpThZpCJ3wwgkuZl+FA33bQhwIjkxpGjBuG01ODPGrp809DV1bwb7ZGO7hq97SGDpLl6TgCIU3PkAHdCkKEgHnoKGdKmXSSfh/gFTdjcrcYDHv6CGfDzkmTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z7oOqqP0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QixL5darDDEERriWyfS2OL32wLPe3yRI2QeNuDom3NA=; b=Z7oOqqP0Sxe2p0JyVNpCK0yD4V
	UKCXWonHTzGqOFsNQ4ZENCo3h6tdnOeByT3yW4g/7T3Mplo8dwHVAuZrXQjWMdCaM5VoKbUowkcQ3
	eRecHm8o2aVf3ZdbYSlqxTrBs7kccoU3ihW9n/YFjNNbAacB3O6wTORBTckHXVWtJrp6aJPzxrfeb
	ZI0h2PGEmNF3e1PzGwZ0h5jXbZ5zqdbMAudb2UzsTX1zi0DFAjq/VuZ/c0+uy4tJWu4jwiT1xCLKt
	xJFFZAH6vZb6OhFfYVZRtHii0IxtFwXmC1Yqxx+CRnoGg9CGfOrpjauZgVxHz5iqUt4LqSaWwFpn9
	CX8SThJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1B5U-00000002GJt-1xGr;
	Tue, 23 Sep 2025 22:02:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35CCA3001F7; Wed, 24 Sep 2025 00:02:15 +0200 (CEST)
Date: Wed, 24 Sep 2025 00:02:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	John Stultz <jstultz@google.com>, x86@kernel.org,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
Message-ID: <20250923220215.GH3419281@noisy.programming.kicks-ass.net>
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
 <CGME20250922215704eucas1p1f53a65a5cd1eafd3e0db006653231efd@eucas1p1.samsung.com>
 <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com>

On Mon, Sep 22, 2025 at 11:57:02PM +0200, Marek Szyprowski wrote:
> On 18.09.2025 08:56, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the sched/urgent branch of tip:
> >
> > Commit-ID:     077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> > Gitweb:        https://git.kernel.org/tip/077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00
> >
> > sched/deadline: Fix dl_server getting stuck
> >
> > John found it was easy to hit lockup warnings when running locktorture
> > on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
> > ("sched/deadline: Less agressive dl_server handling").
> >
> > While debugging it seems there is a chance where we end up with the
> > dl_server dequeued, with dl_se->dl_server_active. This causes
> > dl_server_start() to return without enqueueing the dl_server, thus it
> > fails to run when RT tasks starve the cpu.
> >
> > When this happens, dl_server_timer() catches the
> > '!dl_se->server_has_tasks(dl_se)' case, which then calls
> > replenish_dl_entity() and dl_server_stopped() and finally return
> > HRTIMER_NO_RESTART.
> >
> > This ends in no new timer and also no enqueue, leaving the dl_server
> > 'dead', allowing starvation.
> >
> > What should have happened is for the bandwidth timer to start the
> > zero-laxity timer, which in turn would enqueue the dl_server and cause
> > dl_se->server_pick_task() to be called -- which will stop the
> > dl_server if no fair tasks are observed for a whole period.
> >
> > IOW, it is totally irrelevant if there are fair tasks at the moment of
> > bandwidth refresh.
> >
> > This removes all dl_se->server_has_tasks() users, so remove the whole
> > thing.
> >
> > Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> > Reported-by: John Stultz <jstultz@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: John Stultz <jstultz@google.com>
> > ---
> 
> This patch landed in today's linux-next as commit 077e1e2e0015 
> ("sched/deadline: Fix dl_server getting stuck"). In my tests I found 
> that it breaks CPU hotplug on some of my systems. On 64bit 
> Exynos5433-based TM2e board I've captured the following lock dep warning 
> (which unfortunately doesn't look like really related to CPU hotplug):

Right -- I've looked at this patch a few times over the day, and the
only thing I can think of is that we keep the dl_server timer running.
But I already gave you a patch that *should've* stopped it.

There were a few issues with it -- notably if you've booted with
something like isolcpus / nohz_full it might not have worked because the
site I put the dl_server_stop() would only get ran if there was a root
domain attached to the CPU.

Put it in a different spot, just to make sure.

There is also the fact that dl_server_stop() uses
hrtimer_try_to_cancel(), which can 'fail' when the timer is actively
running. But if that is the case, it must be spin-waiting on rq->lock
-- since the caller of dl_server_stop() will be holding that. Once
dl_server_stop() completes and the rq->lock is released, the timer will
see !dl_se->dl_throttled and immediately stop without restarting.

So that *should* not be a problem.

Anyway, clutching at staws here etc.

> # for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
> Detected VIPT I-cache on CPU7
> CPU7: Booted secondary processor 0x0000000101 [0x410fd031]
> ------------[ cut here ]------------
> WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:4329 
> rcutree_report_cpu_starting+0x1e8/0x348

This is really weird; this does indeed look like CPU7 decides to boot
again. AFAICT it is not hotplug failing and bringing the CPU back again,
but it is really starting again.

I'm not well versed enough in ARM64 foo to know what would cause a CPU
to boot -- but on x86_64 this isn't something that would easily happen
by accident.

Not stopping a timer would certainly not be sufficient -- notably
hrtimers_cpu_dying() would have migrated the thing.

> (system is frozen at this point).

The whole lockdep and freezing thing is typically printk choking on
itself.

My personal way around this are these here patches:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental

They don't apply cleanly anymore, but the conflict isn't hard, so I've
not taken the bother to rebase them yet. It relies on the platform
having earlyprintk configured, then add force_early_printk to your
kernel cmdline to have earlyprintk completely take over.

Typical early serial drivers are lock-free and don't suffer from
lockups.

If you get it to work, you might get more data out of it.


---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3eb6faa91d06..c0b1dc360e68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8363,6 +8363,7 @@ static inline void sched_set_rq_offline(struct rq *rq, int cpu)
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
 }
 

