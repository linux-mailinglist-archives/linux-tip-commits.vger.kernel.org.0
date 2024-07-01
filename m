Return-Path: <linux-tip-commits+bounces-1562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637291DD80
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A371F21240
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625D13D509;
	Mon,  1 Jul 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIqdU/T4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gg6GlEAT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4113BC3F;
	Mon,  1 Jul 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832030; cv=none; b=Sf5n4uXtSDqMxSoH0YF9Q2icFYPOQdyP++IlJmAKQpIU7U56ON+H3OgbmENXoNx2Coc6vrT6mZslKLxZhZEuZ/D2aMMYL7WfPGQfa0EImnqq7ImYs/QZusz6R7IahOW5JR+DVxQlyxF9eS62gEUajeVFFX4czCswCOnSzLJIKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832030; c=relaxed/simple;
	bh=QYhkVckkISO2d4FXEZ1Wsra2oqK5BZvOn+vXhhVd1ak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FEZD5ghxNSsZEc/htgMdPHqpbe4SIabQh1YnQQNf4KMXUxuyOvqAKWp6Z/ul9lU8qMzoJRNyPUx5606DfWFTF8Krj6va3Y8LP+s+heVZAhRslQQ6e2selDd1W/R6OWlTBz/9szHTSAfNFRgl2XkfhrojBwCZaeM5e5Lbi2Gx9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIqdU/T4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gg6GlEAT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 11:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHmXBY1Eh20aqxeX3zBBeeCrsUfcmLWHwnZNNm8upMQ=;
	b=pIqdU/T4T4ZyeL10/cGsqGtybIjHcRYmJJHGTYJWyxcrGkTcz2WZu8CH8nk08Z4E66pbat
	2PZdCIq9N8DO6KdV7IPfsRqAq6OWbnIBv5IztHozSP8BakpMDMyg/AUjXW6H0YHPfZFipZ
	xESYmp74dbp6KfOnvcIFiubIy5svks5fVl6apCsAxTFZwVSR6IoCj2/qUEsiG7lF0kNap7
	e5nV76UpD73yVGTw7FZSRiwygUEtatQIpVg1R0yTpvuE58lEmPzyGC2c62u8TSCteZmfdi
	32V2dYhfLFx5X3rU1vZaIhn2tPnInnmhmQRtlmGIynNG3xIX2I8fAQ994AAR/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHmXBY1Eh20aqxeX3zBBeeCrsUfcmLWHwnZNNm8upMQ=;
	b=gg6GlEATJu5M0Tkypn+GUz4FWnmhQMDea97AAzLvkDe29Dh164XR+Y14nU3WgBjXSBNgO8
	Ppm3hykQuVWJk5Dg==
From: "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] Revert "sched/fair: Make sure to try to detach at
 least one movable task"
Cc: Josh Don <joshdon@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240620214450.316280-1-joshdon@google.com>
References: <20240620214450.316280-1-joshdon@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171983202748.2215.8471718170845644440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2feab2492deb2f14f9675dd6388e9e2bf669c27a
Gitweb:        https://git.kernel.org/tip/2feab2492deb2f14f9675dd6388e9e2bf669c27a
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 20 Jun 2024 14:44:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Jul 2024 13:01:43 +02:00

Revert "sched/fair: Make sure to try to detach at least one movable task"

This reverts commit b0defa7ae03ecf91b8bfd10ede430cff12fcbd06.

b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
all tasks examined to that point were pinned. The goal of the patch was
to make it more likely to be able to detach a task buried in a long list
of pinned tasks. However, this has the unfortunate side effect of
creating an O(n) iteration in detach_tasks(), as we now must fully
iterate every task on a cpu if all or most are pinned. Since this load
balance code is done with rq lock held, and often in softirq context, it
is very easy to trigger hard lockups. We observed such hard lockups with
a user who affined O(10k) threads to a single cpu.

When I discussed this with Vincent he initially suggested that we keep
the limit on the number of tasks to detach, but increase the number of
tasks we can search. However, after some back and forth on the mailing
list, he recommended we instead revert the original patch, as it seems
likely no one was actually getting hit by the original issue.

Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least one movable task")
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240620214450.316280-1-joshdon@google.com
---
 kernel/sched/fair.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae..24dda70 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9149,12 +9149,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		env->loop++;
-		/*
-		 * We've more or less seen every task there is, call it quits
-		 * unless we haven't found any movable task yet.
-		 */
-		if (env->loop > env->loop_max &&
-		    !(env->flags & LBF_ALL_PINNED))
+		/* We've more or less seen every task there is, call it quits */
+		if (env->loop > env->loop_max)
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -11393,9 +11389,7 @@ more_balance:
 
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			/* Stop if we tried all running tasks */
-			if (env.loop < busiest->nr_running)
-				goto more_balance;
+			goto more_balance;
 		}
 
 		/*

