Return-Path: <linux-tip-commits+bounces-2347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815469900AF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C101F20E8F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CB1494D4;
	Fri,  4 Oct 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svxWt0f6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSXM36pW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB51465A5;
	Fri,  4 Oct 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036967; cv=none; b=A6sZOMqfEdtdZoFQgurvRHpPoewKGzk33Hg0n47vQfq4ty0fzQO5DA7rGwW9NH7aSpOWszBjnxGFJOLuN2NyAchUTIcZI9ZURMuLY2Rd/UlMFOHbNkIWfAQ4OrXGlSmCDmaX3++QS1efWtDpPSkf2hOQ0+TKFlpVwl0IFM/KdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036967; c=relaxed/simple;
	bh=CfzEQwl+7x5FIToBl73Vj+kujNV19wtNZYHHXd0UmwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZrVR9Cpnx2RfLGN/J38tnG7pS7yAEfj7TdlC7zkdleU0rBE0/Jfw6kn16CvmTkUYeVyeT97rRqJIzb0/XGdevOcN/Dh+X3l9aTMFWP/AAC+x1C75oc3S44/xcd2lrDXMSrBF6YzAnOlDjcZHwo9BrSjqKqxmFUpKyxI9OUhw1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=svxWt0f6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSXM36pW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Oct 2024 10:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728036963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s4Jy2DFv0C5tZeA1EnauH2g4bvCgRXRhJ4II/+n/lU=;
	b=svxWt0f6quIgJ+dfkVmuKeY+poxUV0eF63m1h+pz9OSSXK7xegyjkqt1lL1ScUNd70KM3K
	7brkBmhkiEQK+xthWlxOAJAQN4ZPlgVua+JPJ4Ys1hvEENlC80amY3WdFDwxNwzfYi7flT
	Se36V9H0Bf2iFGHs7gL6CJk06sj3k/uQEfUUGa0VRMPbcAd91YYXQ6S4pzVHiJSslgm2hd
	GbsK7HqI9+lhCiqjsoHTg418/o2DIcNziOdgFgue6/rdl6luSocQ4eJXVXX2YIXBQXdtPV
	qBaLZNHCsDQC6pQA2IHt85n+CoMmlSfc91QLaeWBZIGSfaAtQiF5vEAJE2hPMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728036963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s4Jy2DFv0C5tZeA1EnauH2g4bvCgRXRhJ4II/+n/lU=;
	b=KSXM36pWT3X0PB2aXdTXcr2t/nsMIjdfxL3lXDivReRhwAlVHLeb9kmMo7CnZ6OM0GC5K3
	jDe2ewjXLkYkkdCg==
From: "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Cc: kernel test robot <oliver.sang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Chen Yu <yu.c.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Honglei Wang <jameshongleiwang@126.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240925085440.358138-1-yu.c.chen@intel.com>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172803696293.1442.1468634187645796907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d4ac164bde7a12ec0a238a7ead5aa26819bbb1c1
Gitweb:        https://git.kernel.org/tip/d4ac164bde7a12ec0a238a7ead5aa26819bbb1c1
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Wed, 25 Sep 2024 16:54:40 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Oct 2024 11:27:54 +02:00

sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running

Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
introduced a mechanism that a wakee with shorter slice could preempt
the current running task. It also lower the bar for the current task
to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
when the current task has ran out of time slice. But there is a scenario
that is problematic. Say, if there is 1 cfs task and 1 rt task, before
85e511df3cec, update_deadline() will not trigger a reschedule, and after
85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
would happen.

Some workloads (like the hackbench reported by lkp) do not like
over-scheduling. We can see that the preemption rate has been
increased by 2.2%:

1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches

Restore its previous check criterion.

Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Honglei Wang <jameshongleiwang@126.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240925085440.358138-1-yu.c.chen@intel.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b63a7ac..ab497fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (rq->nr_running == 1)
+	if (cfs_rq->nr_running == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {

