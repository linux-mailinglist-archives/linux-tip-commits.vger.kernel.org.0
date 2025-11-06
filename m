Return-Path: <linux-tip-commits+bounces-7264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B1C3AB56
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 12:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C1464710
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153D30F93D;
	Thu,  6 Nov 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NM28UPE0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2FCWbr2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9730F948;
	Thu,  6 Nov 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429269; cv=none; b=EQBo5ALqUOBfDYUUtYBSwFtmYcZq3Hpl1gSch4BYdzeVl1NlmEovrTNX788uxWx4PgGczRJ5fDbqe3FVZ6NHsEnhtolyaivLm1Csf8nHce7NGINDooK/ebIprqp9gs78/AP4PunM3xUfOnNaW2l+ShOrhf0a42JplblpFNi7USE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429269; c=relaxed/simple;
	bh=W8dsyEbo9xMEnvaG9xz4Ip/v7n0eTB57UanqdnTOQFk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s9xP8Z+/GkZ+opcm01ADJ6hMhlVvsX1vm5fqgVPpXHhOiyINBZAejeGNQLvS//DZAXZrFThcdQMJduQm2OE6WJD3N+KP3MScvmMRTb3EQ5ybAN20FhfUuF6y0wEqJkk303QUFdPt2qDnAhmHusqL1ekbJeRj3USrz5yyfNrYPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NM28UPE0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2FCWbr2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 11:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762429264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WKZEOHtytLHUmj3XqeRgfaMWw/ysPoP5Miq5irD2+M=;
	b=NM28UPE0Pmyz0dUAeqPMjUuz1YsdFI7aukMDbYP5Ed328bS6h0cf0VyMPHG2yt8W9BEg6h
	MXX/arsGJmeKaU68B5NljNpt6PdC1sY/OmNXAtBbwX8qBi2hqZ1vDACCpCmQZ0tPKqB5zB
	9KmxJ9YGtM3BfZZLegiwDTENz6FtaBnzo7rci+1RlMxds+0PUNfoYZ1Q9wAGRnnTRxxl51
	dpPojV9hinAq723LhatcxghwF4Xd77RGbKsgx3FHFiC7i97yxU+GGZTzmUrlYSOUd/FyhI
	ByPcC79A34pQPvOTaoVcu+fQlj0Kp3Tu048VKTXUK46SeWdjnVp/Vw7fuAsS3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762429264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WKZEOHtytLHUmj3XqeRgfaMWw/ysPoP5Miq5irD2+M=;
	b=T2FCWbr2cgZQyQuLQ9/2ocM8BLqViZtZUmlXFyOCfRyOng2C5PKhrdCptTTyeosdvRuXx/
	RzF3svjrNu2w7wBA==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Cc: Benjamin Segall <bsegall@google.com>, Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Hao Jia <jiahao1@lixiang.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251030032755.560-1-ziqianlu@bytedance.com>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176242926295.2601451.9600202594830902272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     956dfda6a70885f18c0f8236a461aa2bc4f556ad
Gitweb:        https://git.kernel.org/tip/956dfda6a70885f18c0f8236a461aa2bc4f=
556ad
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Thu, 30 Oct 2025 11:27:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 Nov 2025 12:30:52 +01:00

sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining

When a cfs_rq is to be throttled, its limbo list should be empty and
that's why there is a warn in tg_throttle_down() for non empty
cfs_rq->throttled_limbo_list.

When running a test with the following hierarchy:

          root
        /      \
        A*     ...
     /  |  \   ...
        B
       /  \
      C*

where both A and C have quota settings, that warn on non empty limbo list
is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
part of the cfs_rq for the sake of simpler representation).

Debug showed it happened like this:
Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
*multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
these throttled tasks are directly placed into cfs_rq_c's limbo list by
enqueue_throttled_task().

Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
can't get more runtime and enters tg_throttle_down(), where the warning
is hit due to remaining tasks in the limbo list.

I think it's a chaos to trigger throttle on unthrottle path, the status
of a being unthrottled cfs_rq can be in a mixed state in the end, so fix
this by granting 1ns to cfs_rq in tg_set_cfs_bandwidth(). This ensures
cfs_rq_c has a positive runtime_remaining when initialized as unthrottled
and cannot enter tg_unthrottle_up() with zero runtime_remaining.

Also, update outdated comments in tg_throttle_down() since
unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
While at it, remove a redundant assignment to se in tg_throttle_down().

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Reviewed-By: Benjamin Segall <bsegall@google.com>
Suggested-by: Benjamin Segall <bsegall@google.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Hao Jia <jiahao1@lixiang.com>
Link: https://patch.msgid.link/20251030032755.560-1-ziqianlu@bytedance.com
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67..f754a60 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
=20
 		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled =3D runtime_enabled;
-		cfs_rq->runtime_remaining =3D 0;
+		cfs_rq->runtime_remaining =3D 1;
=20
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970db..5b75232 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6024,20 +6024,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se =3D cfs_rq->tg->se[cpu_of(rq)];
=20
 	/*
-	 * It's possible we are called with !runtime_remaining due to things
-	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
-	 * unthrottled us with a positive runtime_remaining but other still
-	 * running entities consumed those runtime before we reached here.
+	 * It's possible we are called with runtime_remaining < 0 due to things
+	 * like async unthrottled us with a positive runtime_remaining but other
+	 * still running entities consumed those runtime before we reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
-	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
-	 * throttle, which is not supposed to happen on unthrottle path.
+	 * We can't unthrottle this cfs_rq without any runtime remaining because
+	 * any enqueue in tg_unthrottle_up() will immediately trigger a throttle,
+	 * which is not supposed to happen on unthrottle path.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <=3D 0)
 		return;
=20
-	se =3D cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled =3D 0;
=20
 	update_rq_clock(rq);

