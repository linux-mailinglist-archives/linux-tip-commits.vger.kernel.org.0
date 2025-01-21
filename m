Return-Path: <linux-tip-commits+bounces-3279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE9A17DBD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Jan 2025 13:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F540188B267
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Jan 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C91F1508;
	Tue, 21 Jan 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAt/zTWX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziGLWstj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACE1F0E32;
	Tue, 21 Jan 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462085; cv=none; b=PSF+OQiXnCDRpPyx0269o0NMeKfFKWIgEvAP8Rzduxjd9CUF+cKujI5uEskZCr66trvusw4981dzPsDfdKX0pRpcLdC2MrmP7lm8ywnCgn8ADwVsbVYPwTOyroQw8r6wAk0Qe6SrJMxmu+q76g5YKn3SWWMZFMpSgyWNHdYH9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462085; c=relaxed/simple;
	bh=bZo82n6ickplvhZk90SlklU/KIfXwT89XIX4z8AmmQ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kmWH7Gc263OLlgtNHuUlCbbGGEFva2RJwf97faoHoTZfmEIsyzaAGPIedfe5OvwGWT7vFIKz3Xa6e9eQkQ7NrX3OEcMC1G66jxgSaxHe5YbakIS3dKloGyONlScsVNsiUfTqTCqssRe7wX8hg6A6IWF68Lj0nsARfH8Kxdqhg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAt/zTWX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ziGLWstj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Jan 2025 12:21:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737462075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCzzRZgFIWRuSM7zy8BoFlWYJ2pIWUb+yuQJgF2gRVA=;
	b=qAt/zTWXdRz8XBzd5KTQ0tb3aBpSPBI35iKMoIcSsAhJW6QFARtAAd+AlwJZDRgPyWCLMh
	w7pc5efx3g+bxaxsSZ7HPzJNutwe9o/K0INU1XtOJS9giJ9Y6jtwEBqDRSQIfcZg3HI0uq
	0bIDGZ+0PeOz8qfxlYL1DR7RFcrftFanv8r+P7fyt7OocE+H3iRBCttYzByYx0/6Wr7o7u
	Xe1I1eZn2SnUabpdh/aC/kI4MEMUf1nOcjzwL1kyhP1WFLNk85wZgwXqWjJALJ/5DM0iJM
	kP6EVzOWQCNlvnptLsi/gOAfa5sQiwaVfOKvwoMRYDgksUbUH+DH/Px3W4JjSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737462075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCzzRZgFIWRuSM7zy8BoFlWYJ2pIWUb+yuQJgF2gRVA=;
	b=ziGLWstjcEFyjbM9WaStu0qzAUdDRYH/PNrYaehQxY+AVfvdjiuhuIRrK07IJ6U+nz0YWQ
	P4nLYXcp8SRCmLCg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix inaccurate h_nr_runnable
 accounting with delayed dequeue
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250117105852.23908-1-kprateek.nayak@amd.com>
References: <20250117105852.23908-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173746207146.31546.3446635183950754481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3429dd57f0deb1a602c2624a1dd7c4c11b6c4734
Gitweb:        https://git.kernel.org/tip/3429dd57f0deb1a602c2624a1dd7c4c11b6c4734
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Fri, 17 Jan 2025 10:58:52 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Jan 2025 13:13:36 +01:00

sched/fair: Fix inaccurate h_nr_runnable accounting with delayed dequeue

set_delayed() adjusts cfs_rq->h_nr_runnable for the hierarchy when an
entity is delayed irrespective of whether the entity corresponds to a
task or a cfs_rq.

Consider the following scenario:

	root
       /    \
      A	     B (*) delayed since B is no longer eligible on root
      |	     |
    Task0  Task1 <--- dequeue_task_fair() - task blocks

When Task1 blocks (dequeue_entity() for task's se returns true),
dequeue_entities() will continue adjusting cfs_rq->h_nr_* for the
hierarchy of Task1. However, when the sched_entity corresponding to
cfs_rq B is delayed, set_delayed() will adjust the h_nr_runnable for the
hierarchy too leading to both dequeue_entity() and set_delayed()
decrementing h_nr_runnable for the dequeue of the same task.

A SCHED_WARN_ON() to inspect h_nr_runnable post its update in
dequeue_entities() like below:

    cfs_rq->h_nr_runnable -= h_nr_runnable;
    SCHED_WARN_ON(((int) cfs_rq->h_nr_runnable) < 0);

is consistently tripped when running wakeup intensive workloads like
hackbench in a cgroup.

This error is self correcting since cfs_rq are per-cpu and cannot
migrate. The entitiy is either picked for full dequeue or is requeued
when a task wakes up below it. Both those paths call clear_delayed()
which again increments h_nr_runnable of the hierarchy without
considering if the entity corresponds to a task or not.

h_nr_runnable will eventually reflect the correct value however in the
interim, the incorrect values can still influence PELT calculation which
uses se->runnable_weight or cfs_rq->h_nr_runnable.

Since only delayed tasks take the early return path in
dequeue_entities() and enqueue_task_fair(), adjust the
h_nr_runnable in {set,clear}_delayed() only when a task is delayed as
this path skips the h_nr_* update loops and returns early.

For entities corresponding to cfs_rq, the h_nr_* update loop in the
caller will do the right thing.

Fixes: 76f2f783294d ("sched/eevdf: More PELT vs DELAYED_DEQUEUE")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Link: https://lkml.kernel.org/r/20250117105852.23908-1-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2695843..f4e4d3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5372,6 +5372,15 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void set_delayed(struct sched_entity *se)
 {
 	se->sched_delayed = 1;
+
+	/*
+	 * Delayed se of cfs_rq have no tasks queued on them.
+	 * Do not adjust h_nr_runnable since dequeue_entities()
+	 * will account it for blocked tasks.
+	 */
+	if (!entity_is_task(se))
+		return;
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
@@ -5384,6 +5393,16 @@ static void set_delayed(struct sched_entity *se)
 static void clear_delayed(struct sched_entity *se)
 {
 	se->sched_delayed = 0;
+
+	/*
+	 * Delayed se of cfs_rq have no tasks queued on them.
+	 * Do not adjust h_nr_runnable since a dequeue has
+	 * already accounted for it or an enqueue of a task
+	 * below it will account for it in enqueue_task_fair().
+	 */
+	if (!entity_is_task(se))
+		return;
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 

