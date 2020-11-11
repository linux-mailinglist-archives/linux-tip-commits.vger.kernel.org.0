Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F22AEB17
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKKIYI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgKKIXY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:24 -0500
Date:   Wed, 11 Nov 2020 08:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvE9LY1jsT/pZmVPF/sse33JIotbrXZqo8J6uvWbF9A=;
        b=tfRzn0jRzHcy8GGfSgSLlo8g6tTUN+pgFSSDX/IUn99T/OTk4KpVvq5DfSfzhbleBb828E
        lZ4hGlLpiBK+Z6gzMmlRPueWgF4dw+/V9eBkyXsofcmgUbpkwLRdVChCgbGTdoOQR8Q7NB
        J7MUB9crkPe47mxdYcUdC5hF1xx+OL0998TiRgpBk3t/W5tWijWuEyGjo4sqIZdbjoXcA2
        0kmUrl3Q7J815PQ9MixyyUE4pCet6PvCo5Q1cEWSCtsnG5Em3mT9PfiFkn8DUAiMGdSlCd
        BPR5EB8l7Wpjn77oYRdTXaabMRaesghcaRciLQKFnHCq/laa3/aKcOl4x6sqUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvE9LY1jsT/pZmVPF/sse33JIotbrXZqo8J6uvWbF9A=;
        b=CvjUC6YRXV7grWJxKl+gWWIgGxIzhZKXyPvvLIFXQKU4uL1nzVKIrxQgF4Zw36ym10MYSA
        m//Et3Qutz/JwuCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix hotplug vs CPU bandwidth control
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.639538965@infradead.org>
References: <20201023102346.639538965@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300111.11244.6541265294100152865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     120455c514f7321981c907a01c543b05aff3f254
Gitweb:        https://git.kernel.org/tip/120455c514f7321981c907a01c543b05aff3f254
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 25 Sep 2020 16:42:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:59 +01:00

sched: Fix hotplug vs CPU bandwidth control

Since we now migrate tasks away before DYING, we should also move
bandwidth unthrottle, otherwise we can gain tasks from unthrottle
after we expect all tasks to be gone already.

Also; it looks like the RT balancers don't respect cpu_active() and
instead rely on rq->online in part, complete this. This too requires
we do set_rq_offline() earlier to match the cpu_active() semantics.
(The bigger patch is to convert RT to cpu_active() entirely)

Since set_rq_online() is called from sched_cpu_activate(), place
set_rq_offline() in sched_cpu_deactivate().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.639538965@infradead.org
---
 kernel/sched/core.c     | 14 ++++++++++----
 kernel/sched/deadline.c |  2 +-
 kernel/sched/rt.c       |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c89806..dcb88a0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6977,6 +6977,8 @@ int sched_cpu_activate(unsigned int cpu)
 
 int sched_cpu_deactivate(unsigned int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 	int ret;
 
 	set_cpu_active(cpu, false);
@@ -6991,6 +6993,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	balance_push_set(cpu, true);
 
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		update_rq_clock(rq);
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -7072,10 +7082,6 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
 	BUG_ON(rq->nr_running != 1);
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305..77880fe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -543,7 +543,7 @@ static int push_dl_task(struct rq *rq);
 
 static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 {
-	return dl_task(prev);
+	return rq->online && dl_task(prev);
 }
 
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096..40a4663 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -265,7 +265,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return rq->online && rq->rt.highest_prio.curr > prev->prio;
 }
 
 static inline int rt_overloaded(struct rq *rq)
