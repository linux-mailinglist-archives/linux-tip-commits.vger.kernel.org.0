Return-Path: <linux-tip-commits+bounces-6681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7EDB8554B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CE31C2805F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E023AE87;
	Thu, 18 Sep 2025 14:47:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE9E226CE0;
	Thu, 18 Sep 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206822; cv=none; b=SldP8nXfuQ8wcdQm5oaeSImsIDjxFto6p1uhfvTesz3VE0069FfG7zRe6PTprD6QE0qFuFsH9pgsUSwizKR0VcoAx4bt/NVU9v9Ss37WeEgfyFAtc1NEU9F5qgMrtHOT1pOczmmsdh8pSxSjNTM7lAPngJVZQAFv/llu4hu+hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206822; c=relaxed/simple;
	bh=qGntfUQHvtw2Bw8rI5jyiQrAxDx7zsfoNHIYuVUIwBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYTMALjBeD0PCwaYVkjIPYqYZTFRHB7YmnIzGm3+6WFkpwxxtpC9o+Hls2UsYldHrU83dnVcE5s9Cu+etA0EYfoGEbtRQlSPf2uSf2v5CX97A63lkukTy91Xrsq82VUBkF8wIEoifDN4euPTd47IavUlVLg8K6WrnbVWbq+nqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8FE11764;
	Thu, 18 Sep 2025 07:46:51 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 165233F673;
	Thu, 18 Sep 2025 07:46:58 -0700 (PDT)
Message-ID: <5494e934-9024-4c39-831b-75ec938161a1@arm.com>
Date: Thu, 18 Sep 2025 16:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/urgent] sched/deadline: Fix dl_server getting stuck
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <175817861820.709179.10538516755307778527.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.09.25 08:56, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> Gitweb:        https://git.kernel.org/tip/077e1e2e0015e5ba6538d1c5299fb299a3a92d60
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 16 Sep 2025 23:02:41 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00
> 
> sched/deadline: Fix dl_server getting stuck
> 
> John found it was easy to hit lockup warnings when running locktorture
> on a 2 CPU VM, which he bisected down to: commit cccb45d7c429
> ("sched/deadline: Less agressive dl_server handling").
> 
> While debugging it seems there is a chance where we end up with the
> dl_server dequeued, with dl_se->dl_server_active. This causes
> dl_server_start() to return without enqueueing the dl_server, thus it
> fails to run when RT tasks starve the cpu.
> 
> When this happens, dl_server_timer() catches the
> '!dl_se->server_has_tasks(dl_se)' case, which then calls
> replenish_dl_entity() and dl_server_stopped() and finally return
> HRTIMER_NO_RESTART.
> 
> This ends in no new timer and also no enqueue, leaving the dl_server
> 'dead', allowing starvation.
> 
> What should have happened is for the bandwidth timer to start the
> zero-laxity timer, which in turn would enqueue the dl_server and cause
> dl_se->server_pick_task() to be called -- which will stop the
> dl_server if no fair tasks are observed for a whole period.
> 
> IOW, it is totally irrelevant if there are fair tasks at the moment of
> bandwidth refresh.
> 
> This removes all dl_se->server_has_tasks() users, so remove the whole
> thing.

I see the same results like John running his locktorture test, the
'BUG: workqueue lockup' is gone now.

Just got confused because of these two remaining dl_server_has_tasks references:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 73c7de26fa60..73d750292446 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -634,7 +634,6 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
-typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
 typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
 
 struct sched_dl_entity {
@@ -728,9 +727,6 @@ struct sched_dl_entity {
         * dl_server_update().
         *
         * @rq the runqueue this server is for
-        *
-        * @server_has_tasks() returns true if @server_pick return a
-        * runnable task.
         */
        struct rq                       *rq;
        dl_server_pick_f                server_pick_task;

Can you still tweak the patch to get rif of them with the patch?

[...]

