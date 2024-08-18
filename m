Return-Path: <linux-tip-commits+bounces-2058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27298955B24
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9693A1F218A0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D2DDC1;
	Sun, 18 Aug 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="00bXlL17";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bIv5ejox"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757DD51C;
	Sun, 18 Aug 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962190; cv=none; b=dvcNzcPTY2jwKSv67tq9tJr3gEcUtaO1NG9mupewOkVwof/15f8i5RgzPZ5WnI3roFgupjTluY95YdKMln1piZMvtmPhNMN/f0CXWS2z2/cSIvrWR6/hauNitW9gaod9F8fLwlErqXyjR9daGivmqN5m8Nth2V9ACP4QIT9kAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962190; c=relaxed/simple;
	bh=aVFKrLJhXxWXwRUwnKKMzAtO36aAV2kzr5mSrZmPiAA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UsYuPyKwuzkC1Pnotlzg+GPw1HfhXpmwOV9/uoBymXbEGbrR9C+3fa4ZODfkxJA6i9qDThLx+QA8KkskXP5r3x+qAgmJVzasFq5sWnSBOOsLoGBW+Vx/JX674lgOmWyt6zGGp0COnlthGeot66+F2vSkB5vluqs6JGsk0t1xbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=00bXlL17; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bIv5ejox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1k2n3fJ+ZrT80AAB5sEVg1Kr9Xa5tI51YNvoRO05ba4=;
	b=00bXlL17l6LrIpS/ASc6ravixuA9zA9JADqp5tpkh2sPIvYkhalNMZUTVGeWnuoyjrlE6B
	uC3Ie9kHhS7YToRoSLOZRu5QEMiKJup5dqZ7dA0WrJ21ZoOuy/EWc5dYL6cYuNZhpVCGgB
	UxBv8Syiw09/I8N6Q1/CVH4SPfjlFsNPWiSBKn8sAUF+5k1Y+psxiQlbq+PkNXHCf8w3b8
	O0Wjq/y3ebrEBWPsmHtG3RA/BBYfZGDO8EFQoY/fwXxyhCmlq2NrRjkJTwbJQ4bNBoO7QS
	dVvqFQjNOAd6OOJTioZpgjt4h+iXesHQ6aC7seq84CsnDrYJoE7uRMn1yxOc9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1k2n3fJ+ZrT80AAB5sEVg1Kr9Xa5tI51YNvoRO05ba4=;
	b=bIv5ejoxNaANzHPcTsqEDeDv+EGJTkneQ0lTQUu1wLI/uastoZAiqrs/bbryNGKTQKBZV3
	BLDnJdSuVcQGujAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Allow shorter slices to wakeup-preempt
Cc: Chunxin Zang <zangchunxin@lixiang.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Mike Galbraith <umgwanakikbuti@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.735459544@infradead.org>
References: <20240727105030.735459544@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218653.2215.11691929258007595773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     85e511df3cec46021024176672a748008ed135bf
Gitweb:        https://git.kernel.org/tip/85e511df3cec46021024176672a748008ed135bf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Sep 2023 14:32:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:45 +02:00

sched/eevdf: Allow shorter slices to wakeup-preempt

Part of the reason to have shorter slices is to improve
responsiveness. Allow shorter slices to preempt longer slices on
wakeup.

    Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |

  100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT

  1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
  2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
  3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
  1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
  2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
  3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
  1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
  2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
  3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |

  100ms massive_intr 500us cyclictest PREEMPT_SHORT

  1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
  2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
  3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
  1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
  2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
  3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
  1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
  2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
  3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |

As per the numbers the, this makes cyclictest (short slice) it's
max-delay more consistent and consistency drops the sum-delay. The
trade-off is that the massive_intr (long slice) gets more context
switches and a slight increase in sum-delay.

Chunxin contributed did_preempt_short() where a task that lost slice
protection from PREEMPT_SHORT gets rescheduled once it becomes
in-eligible.

[mike: numbers]
Co-Developed-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Link: https://lkml.kernel.org/r/20240727105030.735459544@infradead.org
---
 kernel/sched/fair.c     | 64 +++++++++++++++++++++++++++++++++++-----
 kernel/sched/features.h |  5 +++-
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fef0e1f..cc30ea3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -973,10 +973,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -993,10 +993,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
-		clear_buddies(cfs_rq, se);
-	}
+	return true;
 }
 
 #include "pelt.h"
@@ -1134,6 +1131,38 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 		dl_server_update(p->dl_server, delta_exec);
 }
 
+static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	if (!sched_feat(PREEMPT_SHORT))
+		return false;
+
+	if (curr->vlag == curr->deadline)
+		return false;
+
+	return !entity_eligible(cfs_rq, curr);
+}
+
+static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
+				    struct sched_entity *pse, struct sched_entity *se)
+{
+	if (!sched_feat(PREEMPT_SHORT))
+		return false;
+
+	if (pse->slice >= se->slice)
+		return false;
+
+	if (!entity_eligible(cfs_rq, pse))
+		return false;
+
+	if (entity_before(pse, se))
+		return true;
+
+	if (!entity_eligible(cfs_rq, se))
+		return true;
+
+	return false;
+}
+
 /*
  * Used by other classes to account runtime.
  */
@@ -1157,6 +1186,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
+	bool resched;
 
 	if (unlikely(!curr))
 		return;
@@ -1166,7 +1196,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		return;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	resched = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -1184,6 +1214,14 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	if (rq->nr_running == 1)
+		return;
+
+	if (resched || did_preempt_short(cfs_rq, curr)) {
+		resched_curr(rq);
+		clear_buddies(cfs_rq, curr);
+	}
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -8605,7 +8643,17 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 	/*
-	 * XXX pick_eevdf(cfs_rq) != se ?
+	 * If @p has a shorter slice than current and @p is eligible, override
+	 * current's slice protection in order to allow preemption.
+	 *
+	 * Note that even if @p does not turn out to be the most eligible
+	 * task at this moment, current's slice protection will be lost.
+	 */
+	if (do_preempt_short(cfs_rq, pse, se) && se->vlag == se->deadline)
+		se->vlag = se->deadline + 1;
+
+	/*
+	 * If @p has become the most eligible task, force preemption.
 	 */
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index caa4d72..2908740 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -18,6 +18,11 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
  * 0-lag point or until is has exhausted it's slice.
  */
 SCHED_FEAT(RUN_TO_PARITY, true)
+/*
+ * Allow wakeup of tasks with a shorter slice to cancel RESPECT_SLICE for
+ * current.
+ */
+SCHED_FEAT(PREEMPT_SHORT, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed

