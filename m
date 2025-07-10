Return-Path: <linux-tip-commits+bounces-6065-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E19B0025C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339D3482993
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A22E7189;
	Thu, 10 Jul 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ps47QiwD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="008I4d/q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9B2D8DD3;
	Thu, 10 Jul 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151602; cv=none; b=P3ZteSjPUbrqonnvJVdRnsAyqE9SVruhLoDXcLZtmvL8nZ0lncDrt6ZJLQ72D1fS5cEfwyfccd3/0u1+WHb4jvhhOl63MvnOJkx0sADyxbC08P8keuUtKV+TCg1Lrvk2hay56Db9Ye54u37PAGdWU1Qhst1NXFSGkFNAKxzQYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151602; c=relaxed/simple;
	bh=KJ95/ixoEKTrEpTwpnM4EkqKGxqOUiVxAlMITtEOlxs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KcLdiJpdAE9217fNgCIDQeJN1hvHK91ykmdErahD4+dMf4VbsjIqaPj9mfwc6A+CLlgn19ZG9Gch2WksHLZBz1An2saOSN6DkBjC9644XHlAnESCTcHUwmHaDSyWDDOo1UMes2XDkk8beelMvm4vngV9MpknEpoT2olzbCZfZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ps47QiwD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=008I4d/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJwWRCXTDhc7xXPU6R1E5m1q5hO7WXHDIlwWSaqWGGQ=;
	b=ps47QiwDwO+kghQ9fsVuYHhCLkd4wdELsPuTwhpH6DuALoVoN2u+2BkCTw75tGojTNEZW2
	JI+VHzZeN8j0s4bGD4Z94+KN41b/mGmHv7Hqb/L/LpYnOlgg7WSa9F+2VQoR4J0vCEYleT
	KP7CINywWEUOCI0ObWo6Oy5nnCJwG764eE8fHnReJNQaQS/q5mft1xIQamp60tWujrrV4i
	notOXPwTDt5P/+wbdAYPxxvUse9dsBlRcVDYBBCG5mfRVRmPQfeCsmXt2jdpf79M7aiVo+
	AjJA/JZAJux1kl6HqInvaMHV+rKidUXYTXeT4GC8vFI3bAWwpiCHn+6WccEjgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJwWRCXTDhc7xXPU6R1E5m1q5hO7WXHDIlwWSaqWGGQ=;
	b=008I4d/q8Nboy6swIbFbVPFWQwxVcdkZoXBqBV7Qwerg6fvcgFLTQPvKnXtdiQUztHsI4y
	bqP4RAC7Gjlm/oBg==
From: "tip-bot2 for Chris Mason" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Bump sd->max_newidle_lb_cost when
 newidle balance fails
Cc: Chris Mason <clm@fb.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250626144017.1510594-2-clm@fb.com>
References: <20250626144017.1510594-2-clm@fb.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159821.406.2234522247248219338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     155213a2aed42c85361bf4f5c817f5cb68951c3b
Gitweb:        https://git.kernel.org/tip/155213a2aed42c85361bf4f5c817f5cb68951c3b
Author:        Chris Mason <clm@fb.com>
AuthorDate:    Thu, 26 Jun 2025 07:39:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:21 +02:00

sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails

schbench (https://github.com/masoncl/schbench.git) is showing a
regression from previous production kernels that bisected down to:

sched/fair: Remove sysctl_sched_migration_cost condition (c5b0a7eefc)

The schbench command line was:

schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0

This creates 4 message threads pinned to CPUs 0-3, and 256x4 worker
threads spread across the rest of the CPUs.  Neither the worker threads
or the message threads do any work, they just wake each other up and go
back to sleep as soon as possible.

The end result is the first 4 CPUs are pegged waking up those 1024
workers, and the rest of the CPUs are constantly banging in and out of
idle.  If I take a v6.9 Linus kernel and revert that one commit,
performance goes from 3.4M RPS to 5.4M RPS.

schedstat shows there are ~100x  more new idle balance operations, and
profiling shows the worker threads are spending ~20% of their CPU time
on new idle balance.  schedstats also shows that almost all of these new
idle balance attemps are failing to find busy groups.

The fix used here is to crank up the cost of the newidle balance whenever it
fails.  Since we don't want sd->max_newidle_lb_cost to grow out of
control, this also changes update_newidle_cost() to use
sysctl_sched_migration_cost as the upper limit on max_newidle_lb_cost.

Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250626144017.1510594-2-clm@fb.com
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e2963e..ab0822c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12064,8 +12064,14 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
+		 *
+		 * sched_balance_newidle() bumps the cost whenever newidle
+		 * balance fails, and we don't want things to grow out of
+		 * control.  Use the sysctl_sched_migration_cost as the upper
+		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost = cost;
+		sd->max_newidle_lb_cost =
+			min(cost, sysctl_sched_migration_cost + 200);
 		sd->last_decay_max_lb_cost = jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -12757,10 +12763,17 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Failing newidle means it is not effective;
+			 * bump the cost so we end up doing less of it.
+			 */
+			if (!pulled_task)
+				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
+
+			update_newidle_cost(sd, domain_cost);
 		}
 
 		/*

