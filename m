Return-Path: <linux-tip-commits+bounces-3367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D9A36D6C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367D018953F6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A01AAE1E;
	Sat, 15 Feb 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24DPUQTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NthJqut1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F71A316A;
	Sat, 15 Feb 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616962; cv=none; b=Asp7AaH2GxUJAeFwNQUJVmRwKEUmwAyB1LFX5cT32msphVrfHT8zNfI1HR1esRItIrAgKObOwyO/I/CiL64U/T/PELlQUXTHTWgYbcQsGduYASogEJUH5LAvRtqSPVpNg23+XX6aff2e9c3bgD5igBLztBLO6Y1QmFdFefn04e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616962; c=relaxed/simple;
	bh=SSUx7OzLzc6SxMkhifY9y6/0jC+CUN1tFzb7Au0bWAI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lv9uiMBxCNbXP9V/hrUYRmX4Al4YvIwK/U01+IGRWGjgcfDywpBnh9U9w0g8fzk62sgK1NRWqm/7JhJnS5BJDtsSG3CEfXK0Ri4XL+WmPdsGjv+qSaplTmgaYcBvC+TzgQQfoQ7JA/vwyLf1iDPw3XwowTTtUPtriYfqbN1IqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24DPUQTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NthJqut1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:55:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWyQm3CHTMNeNCnReiBfKhfxsApT/3vKxVPVpAcdfA=;
	b=24DPUQTkKa3mVXuM/lp4SyO9pQ8cF0uiJ+B8JHlucZQ7c8R6M7ouFB36NfguVQz2xmUi25
	l1xw5YtZl4zHQIy+3+m4mofqGG7dNp0vBldnFr46t++XT/OXyfGd6aylP/AZSsI+YkcGh7
	TgSp6MDK9Gtu9SiZ85xkJf0sP0pzXZYqyWb7QbbB9cEKYQ6OtKqwIdcseqUHNTQk2FJpVF
	ItMBdYtP6zNR+qbjnEEbuiYJpDrkzke+DO6sXLHfdLHviVogFMVEXEmv6JIp65xw4hE8UY
	mBP7Qye/qgj5hCxTKafoFf6mOsHvZN7RhQHPG9SZeKRPWHsyvpeHLmCfzciYfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nWyQm3CHTMNeNCnReiBfKhfxsApT/3vKxVPVpAcdfA=;
	b=NthJqut1ss8SV4dh+Ld6tsxQ3r/94SLU+QpDTuA/TfcjcxhUVSm/CG/4eu2g/cq2O6LwxZ
	ddo9k/SFI8JwG7Ag==
From: "tip-bot2 for zihan zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Cancel the slice protection of the idle entity
Cc: zihan zhou <15645113830zzh@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250208080850.16300-1-15645113830zzh@gmail.com>
References: <20250208080850.16300-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961695853.10177.12588433756462565858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f553741ac8c0e467a3b873e305f34b902e50b86d
Gitweb:        https://git.kernel.org/tip/f553741ac8c0e467a3b873e305f34b902e50b86d
Author:        zihan zhou <15645113830zzh@gmail.com>
AuthorDate:    Sat, 08 Feb 2025 16:08:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:00 +01:00

sched: Cancel the slice protection of the idle entity

A wakeup non-idle entity should preempt idle entity at any time,
but because of the slice protection of the idle entity, the non-idle
entity has to wait, so just cancel it.

This patch is aimed at minimizing the impact of SCHED_IDLE on
SCHED_NORMAL. For example, a task with SCHED_IDLE policy that sleeps for
1s and then runs for 3 ms, running cyclictest on the same cpu, has a
maximum latency of 3 ms, which is caused by the slice protection of the
idle entity. It is unreasonable. With this patch, the cyclictest latency
under the same conditions is basically the same on the cpu with idle
processes and on empty cpu.

[peterz: add helpers]
Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250208080850.16300-1-15645113830zzh@gmail.com
---
 kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef43..61b826f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -884,6 +884,26 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 }
 
 /*
+ * HACK, stash a copy of deadline at the point of pick in vlag,
+ * which isn't used until dequeue.
+ */
+static inline void set_protect_slice(struct sched_entity *se)
+{
+	se->vlag = se->deadline;
+}
+
+static inline bool protect_slice(struct sched_entity *se)
+{
+	return se->vlag == se->deadline;
+}
+
+static inline void cancel_protect_slice(struct sched_entity *se)
+{
+	if (protect_slice(se))
+		se->vlag = se->deadline + 1;
+}
+
+/*
  * Earliest Eligible Virtual Deadline First
  *
  * In order to provide latency guarantees for different request sizes
@@ -919,11 +939,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	/*
-	 * Once selected, run a task until it either becomes non-eligible or
-	 * until it gets a new slice. See the HACK in set_next_entity().
-	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (sched_feat(RUN_TO_PARITY) && curr && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -5528,11 +5544,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
-		/*
-		 * HACK, stash a copy of deadline at the point of pick in vlag,
-		 * which isn't used until dequeue.
-		 */
-		se->vlag = se->deadline;
+
+		set_protect_slice(se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -8781,8 +8794,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
 	 * in the inverse case).
 	 */
-	if (cse_is_idle && !pse_is_idle)
+	if (cse_is_idle && !pse_is_idle) {
+		/*
+		 * When non-idle entity preempt an idle entity,
+		 * don't give idle entity slice protection.
+		 */
+		cancel_protect_slice(se);
 		goto preempt;
+	}
+
 	if (cse_is_idle != pse_is_idle)
 		return;
 
@@ -8801,8 +8821,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	 * Note that even if @p does not turn out to be the most eligible
 	 * task at this moment, current's slice protection will be lost.
 	 */
-	if (do_preempt_short(cfs_rq, pse, se) && se->vlag == se->deadline)
-		se->vlag = se->deadline + 1;
+	if (do_preempt_short(cfs_rq, pse, se))
+		cancel_protect_slice(se);
 
 	/*
 	 * If @p has become the most eligible task, force preemption.

