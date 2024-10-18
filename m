Return-Path: <linux-tip-commits+bounces-2511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD79A369C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8991F2351D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE418CBF9;
	Fri, 18 Oct 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDStchDk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sYYJLa2g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F21885BE;
	Fri, 18 Oct 2024 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235272; cv=none; b=bsEalDwFF1shN6uvOfJsJvDTE0imtjm9vDuVP0J2TDfZNQ/1va6Yz/YV/ZY+YcsdSrE9vp44S3Vo9q+4rQ5//n/XOJkQMaY0uwcAYUrYaFUCYywzrMOgS/Wu3RbWlkaDRY+aDTqgRJbdxZu19atX+GG8ymRoTnc6TlWm1sDSHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235272; c=relaxed/simple;
	bh=Jw8LAmaz9a5JnfhtYOysAy1rtXJXWN+cm7x7i5QKY6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JZOfnZS6n0H1DuLdvcYvp5aAlX46sk4Yw8Ji2DpuuGkRFHilvzx8zKuC2MSUC7ibpA256sUnFa2OHVT9kJMHb7i8J3e+t+hWfZFEQhbK0Y0hHxDY1T0ZQmbidP7xwmgYT0PHj2arZsk6dtkCl3J6xx05BEmsuaZzhcNOalQc/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDStchDk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sYYJLa2g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cnbaih/pLW9DvPVXVsALzGsAjh/ONbzDqZsOdLeJZpE=;
	b=oDStchDkMDncORyKJyG+RrJ/QS83Uv63HND6inBuV8wqpp/mr1W6LhvACY3HxogSVfaAko
	yWYoqFogWAOkUDBm0IgDtAJyVdi2Q7P2lT64/YituIz57S8b1BE2W0NYLkmdjJjgFCWhlB
	rpzzkXrEGaxVii0B4hXrl165s0sB60mmsgddYqZcI31Gh1DZCM5+lh9W75AYa7EpyGPHcJ
	oYBStoaQ6Xmj1TADoKXPNZx7Dok7+H47SDOzXC19pfvS/Hzecupe2NAK4c3eWSLcR9dKqL
	HoXK6/BsjY2swezzusIdLHFpUbENsBZrGHX+r7p6Eg/16ocU95PPGO4fTUUr7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cnbaih/pLW9DvPVXVsALzGsAjh/ONbzDqZsOdLeJZpE=;
	b=sYYJLa2gVZEzqrF6fPij2v0/u9IfP09wKbsiHABgtDk/MLNA49uFtoZEtghXJWSacuRbv3
	nQmtYa14ypBcybCw==
From: "tip-bot2 for Connor O'Brien" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Consolidate pick_*_task to task_is_pushable helper
Cc: "Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009235352.1614323-6-jstultz@google.com>
References: <20241009235352.1614323-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526197.1442.2922596521290443950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     18adad1dac3334ed34f60ad4de2960df03058142
Gitweb:        https://git.kernel.org/tip/18adad1dac3334ed34f60ad4de2960df03058142
Author:        Connor O'Brien <connoro@google.com>
AuthorDate:    Wed, 09 Oct 2024 16:53:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:41 +02:00

sched: Consolidate pick_*_task to task_is_pushable helper

This patch consolidates rt and deadline pick_*_task functions to
a task_is_pushable() helper

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

[jstultz: split out from larger chain migration patch,
 renamed helper function]

Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-6-jstultz@google.com
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4acf5e3..a4683f8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2487,14 +2487,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2513,7 +2505,7 @@ next_node:
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e2506ab..c5c22fc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1773,15 +1773,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1795,7 +1786,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 71ce1b0..4493352 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3799,6 +3799,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return true;
+
+	return false;
+}
 #endif
 
 #ifdef CONFIG_RT_MUTEXES

