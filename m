Return-Path: <linux-tip-commits+bounces-1554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16C91D88E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A78C1F2139A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2356F076;
	Mon,  1 Jul 2024 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J8DIqe8r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Wa4lXmV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C41B809;
	Mon,  1 Jul 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817612; cv=none; b=rty6rXIUkcBLNUsg2dM1+JfqaUG/jNuw1p3zEMCCnEqTdGbohVN9Zyxxg7WeeCDs59BTZ+NtIzw9CXC7jXPt59HSWo/Qod15G9tMeeeLZKE8U4OZxmcT0KJCLYTW1NzX1T28+fxnJoLDb4e7y0hURHaxvqc9wkwiz5IQr7Xofws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817612; c=relaxed/simple;
	bh=fjxFWygSuQpoPgtJ+k86zB3eL7URJmk8o6EORui94Y4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HjW+c08rleTHwzFh0Zn0tYePKKhmrBBiVIi8JerSWc6G354ZGixhs/IW94ObkjBPJXLe7oWYw5yxW4sgvaNaSGYzibjKn7/yMOBIir566udFx23v8W/mJE8t99VT2B+DN/2/S8yKaDMEzQAeoE9u8qfeqy3M9IMDQcHyVw36BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J8DIqe8r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Wa4lXmV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 07:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719817607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mT0F9WUftZVujqs50Dk5XrwptC4ap6XO0K6HFKQKAVU=;
	b=J8DIqe8rs1isB5JkumiLIqzew0NF8jI43g0IKmrXJ3s+2wo8U1wuP7QdgOPVPTebHivZkn
	kIo4+SG5sAcFXfZH8GCvCwDhULTbTra/h4V81O+5Z+aMORkvrYz/27ftZQQPDryXtpCtsm
	joN2qJCgawJN5a99AemcOS9eLV5p73qJXgEjRbYsZjS0tZxgCsCRS0vZmfp1oMBvHUNS6D
	mj7PnUNzrV9Ebbk/evycfrmFE9Xq+8cHM2AZRKivmAODh5sUWBsxuphNPhWxQ/VuZNywSV
	OewLF6nHKatWNbnKE8P5FkCZsIRykMTfnWbX8rh4G5vpBdqfrGXYmLnjAwZQZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719817607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mT0F9WUftZVujqs50Dk5XrwptC4ap6XO0K6HFKQKAVU=;
	b=6Wa4lXmVosYzMMOy+llF7I3f3bwhUGsZ2+vx7xVXbMbTRgntD47TWoZcukpcN5Pg4oLiPg
	nEkFqoH78I+ulHDA==
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
Message-ID: <171981760756.2215.13153463631073562206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     05f8404bcdf31822874bff41992336150240c109
Gitweb:        https://git.kernel.org/tip/05f8404bcdf31822874bff41992336150240c109
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 20 Jun 2024 14:44:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jun 2024 10:43:41 +02:00

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

