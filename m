Return-Path: <linux-tip-commits+bounces-6111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDFB03A77
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D28717AA2E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639A245023;
	Mon, 14 Jul 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXdO2GQl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v16ewYC3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493D243968;
	Mon, 14 Jul 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484248; cv=none; b=bQm/lkiQtKazZlK+B50RNFfb5e7tXxewgFVRxbDu9/QBw+WO6iKRivZz2oT2GS+u4z7VXBAxX9G0RBUNC+xxcwgBXnCYshYG5iiGNV5vrk67XY43gFOsV9aULHSDtzzLE5OekHtD7h4ntY9esWlBiUXSAIHfOQP1mkCZQg0UCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484248; c=relaxed/simple;
	bh=C8pHY8tQC8gzi/NzuDfOnx5v8PL9stBfk3MAhdFVrdo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jqp/H0GuzURThfIc8n0J6bJDXHhyjnebqobaFLh/0MWNH5fQMJDBFvXaiyfsqJsVWL7SliGq6+n/k/Aa+pmj6l5ocFXqksn1gyhPgq/+LxYuXcdwQW8jVBErhmj8mgnkMVF/A+3gu9AvV7pCB7rASh9RiI9nedCGGEjYrOkHaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXdO2GQl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v16ewYC3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxeCeIvQrwV1zYihyuPeziQ2sZ+dX8OxMS3PaBSJnE8=;
	b=dXdO2GQlbXVei1uyuazrmN4PdyqcWEJMoFd8MjZNMFXVYyYSAfOFEnNlmmZma1q/7N3YDJ
	A7LQtStKCSVnNwFU6AeKjdkiCwN/mM6Qt/YYdw7SJHDUL3hMqw/jxdhuRrTB7XVeDQ0+/H
	qAxcrMasQmcXdzKYDGtC87CL9m7SsPEYhSKsBUjunDJYD662nc4b59HZka6y9a151GV2yG
	kNAl7sHeNurVBzcsDyqUjtAHQOFAMVhdDrnEwunyWx1eVtNO0F4iIdk24Oj91pJZsq3c1C
	kIE0wOmb5eywFSpQASCTCEpHEQwMdaTd4Ep8T41gQGZxR0XF9R4QTvofh4cQEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxeCeIvQrwV1zYihyuPeziQ2sZ+dX8OxMS3PaBSJnE8=;
	b=v16ewYC3dDFbIWrDx1WsqD2H4xwPUcRrpja+UQHz9r0rUOSjf8RXV2o+te4tpt0KQp4n9F
	Iv5wUv/RR2K/HVDg==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Initialize dl_servers after SMP
Cc: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
 Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627115118.438797-2-juri.lelli@redhat.com>
References: <20250627115118.438797-2-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248424304.406.9479462804989012657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9f239df55546ee1d28f0976130136ffd1cad0fd7
Gitweb:        https://git.kernel.org/tip/9f239df55546ee1d28f0976130136ffd1cad0fd7
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Fri, 27 Jun 2025 13:51:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:32 +02:00

sched/deadline: Initialize dl_servers after SMP

dl-servers are currently initialized too early at boot when CPUs are not
fully up (only boot CPU is). This results in miscalculation of per
runqueue DEADLINE variables like extra_bw (which needs a stable CPU
count).

Move initialization of dl-servers later on after SMP has been
initialized and CPUs are all online, so that CPU count is stable and
DEADLINE variables can be computed correctly.

Fixes: d741f297bceaf ("sched/fair: Fair server interface")
Reported-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-2-juri.lelli@redhat.com
---
 kernel/sched/core.c     |  2 ++-
 kernel/sched/deadline.c | 48 +++++++++++++++++++++++++---------------
 kernel/sched/sched.h    |  1 +-
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f8caa9..89b3ed6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8371,6 +8371,8 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
+	sched_init_dl_servers();
+
 	sched_smp_initialized = true;
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 23668fc..0d25553 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -761,6 +761,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
+	update_rq_clock(rq);
+
 	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
 
@@ -1585,23 +1587,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
-	/*
-	 * XXX: the apply do not work fine at the init phase for the
-	 * fair server because things are not yet set. We need to improve
-	 * this before getting generic.
-	 */
-	if (!dl_server(dl_se)) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
-
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
-	}
-
-	if (!dl_se->dl_runtime || dl_se->dl_server_active)
+	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
 	dl_se->dl_server_active = 1;
@@ -1612,7 +1598,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
-	if (!dl_se->dl_runtime)
+	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
@@ -1645,6 +1631,32 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick_task = pick_task;
 }
 
+void sched_init_dl_servers(void)
+{
+	int cpu;
+	struct rq *rq;
+	struct sched_dl_entity *dl_se;
+
+	for_each_online_cpu(cpu) {
+		u64 runtime =  50 * NSEC_PER_MSEC;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		rq = cpu_rq(cpu);
+
+		guard(rq_lock_irq)(rq);
+
+		dl_se = &rq->fair_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+	}
+}
+
 void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
 {
 	u64 new_bw = dl_se->dl_bw;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 105190b..3058fb6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -385,6 +385,7 @@ extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
+extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);

