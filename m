Return-Path: <linux-tip-commits+bounces-6710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B96B94C0B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 09:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E98C16C029
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Sep 2025 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34243112A3;
	Tue, 23 Sep 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7J2h100"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5730F945;
	Tue, 23 Sep 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612311; cv=none; b=RGxotQZcPgxi1md+oX9bQKcRidk7lk/GJdBedAVwZ2CCRKTyRpG0CLkbaNztZsxV/rB7sQUOaC5htuQ9OWbmaCWlccLe9BomOfzcaYSdsi6eS88srTXmLV9cbC9g9YHXl8+jXFR8t3sh6ksO3deVBEZfbyACz6GCG4FQnQlKxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612311; c=relaxed/simple;
	bh=2eXitxmg44/bp8R4RFlHu4OrveXvoKtKAqA8I94Qq6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoJT4tik7I0Gfjk9EvGH9l97Jzsn85wi7yo5v0rdEBz2EvX748w7ID2+wWkATYAWBvlz65SS+zFQn7PB/oh4CbR92cQsNWjMiYvc6RmiOU+kUonZh/OZZ9aP5krYMEmCgbUcHTKMlSlOUTzKh1A4bieewkwygQzcTdVrZLWn7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A7J2h100; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4VU5Idh4/mzW55SWK3c++fc6M33U0n4ReMwOfNRHoLw=; b=A7J2h100w112Z0WtbE97SnOZOu
	3bewdX9mB9fJZY7AkGHPKRYhjxi5pO8INI+dg2lWdjITbCRO9/o9zMMIQ0WTIS7MdanYZWW1w1RN+
	RvEEZXe+jRIt3T44r/vnYaaaNELM7ccCJv7cN22OK/+p5NMp85bfztyc6mdCBfXLeJkUBzZgd5BRv
	vGnrCmCGVX9cvUJUsBx9uE+VJHWbxGCuJaBEZsMOWCwwwtp1MRRvdozU6pi8Gc5Q+W2YfMesYHxof
	zVPPh1fZPfLM32yFpeU2Lez7tx1+w9U7FR6lY2DmZ7Rx709ifr97LEHRI4cw0lqvQ0WQYyNG+1vdG
	5lvRv0qQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0xOd-00000008Tmr-0HtI;
	Tue, 23 Sep 2025 07:25:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BCE530049C; Tue, 23 Sep 2025 09:25:06 +0200 (CEST)
Date: Tue, 23 Sep 2025 09:25:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	John Stultz <jstultz@google.com>, x86@kernel.org,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
Message-ID: <20250923072506.GS3245006@noisy.programming.kicks-ass.net>
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

Absolutely wild guess; does something like this help?

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18a30ae35441..bf78c46620a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12972,6 +12972,8 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure that we remove rq contribution to group share: */
 	clear_tg_offline_cfs_rqs(rq);
+
+	dl_server_stop(&rq->fair_server);
 }
 
 #ifdef CONFIG_SCHED_CORE

