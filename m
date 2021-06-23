Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4403B15AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFWIVu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFWIVi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:38 -0400
Date:   Wed, 23 Jun 2021 08:19:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9LcxUTeiWxuiLctkkiu/wJsIpyM+4WO11Iiw3VxoD0=;
        b=MtGHjdFa7+vdd46uVDHrU23ElnCO5LcxweGottx9ejcVdOZ2WxzusjffMMGjme8UI94WR9
        UUqJVnD60LOmuE39YBgFVRSe1v/bULURUy0OVfwAZrWI9TKzBSprLTaEyL0Z8rY20h4+xy
        y1Z26kA6Ab1ZIO8W/zzIsPG6LpaJwaPdLUYn6JtTYbiHFNDbJhZDSA041CzdzJIdMgVAGW
        evjtCyaO9ZIqAsX/vOiDtNyDzpVg2BsI9HhY8G0OGbpVzKY32aFtQMaDM64hrOiBMPS/25
        9lhDT1EQ5dpm9XUxIr3Bg2pnXVnaIU6ZijIWTJtuC2XLU1nt9pAinT5MiLRC/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9LcxUTeiWxuiLctkkiu/wJsIpyM+4WO11Iiw3VxoD0=;
        b=NW1wbnJG+aQv9LMlGlMTntuyFNXFwtTznNpS3qRuWTjtlTh0MdVxGQoAZPdyKNC7afbEp5
        8BkBdv4CWY8adJCA==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix uclamp_tg_restrict()
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210617165155.3774110-1-qais.yousef@arm.com>
References: <20210617165155.3774110-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <162443635986.395.6760451381829068161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0213b7083e81f4acd69db32cb72eb4e5f220329a
Gitweb:        https://git.kernel.org/tip/0213b7083e81f4acd69db32cb72eb4e5f220329a
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 17 Jun 2021 17:51:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:41:59 +02:00

sched/uclamp: Fix uclamp_tg_restrict()

Now cpu.uclamp.min acts as a protection, we need to make sure that the
uclamp request of the task is within the allowed range of the cgroup,
that is it is clamp()'ed correctly by tg->uclamp[UCLAMP_MIN] and
tg->uclamp[UCLAMP_MAX].

As reported by Xuewen [1] we can have some corner cases where there's
inversion between uclamp requested by task (p) and the uclamp values of
the taskgroup it's attached to (tg). Following table demonstrates
2 corner cases:

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	CASE 1
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  60%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	CASE 2
	-----------+-----+------+-----------
	uclamp_min | 0%  | 30%  |  30%
	-----------+-----+------+-----------
	uclamp_max | 20% | 50%  |  20%
	-----------+-----+------+-----------

With this fix we get:

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	CASE 1
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  50%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	CASE 2
	-----------+-----+------+-----------
	uclamp_min | 0%  | 30%  |  30%
	-----------+-----+------+-----------
	uclamp_max | 20% | 50%  |  30%
	-----------+-----+------+-----------

Additionally uclamp_update_active_tasks() must now unconditionally
update both UCLAMP_MIN/MAX because changing the tg's UCLAMP_MAX for
instance could have an impact on the effective UCLAMP_MIN of the tasks.

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	old
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  50%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	*new*
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   | *60%*
	-----------+-----+------+-----------
	uclamp_max | 80% |*70%* | *70%*
	-----------+-----+------+-----------

[1] https://lore.kernel.org/lkml/CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com/

Fixes: 0c18f2ecfcc2 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
Reported-by: Xuewen Yan <xuewen.yan94@gmail.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210617165155.3774110-1-qais.yousef@arm.com
---
 kernel/sched/core.c | 49 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 309745a..fc231d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1403,8 +1403,10 @@ static void uclamp_sync_util_min_rt_default(void)
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
+	/* Copy by value as we could modify it */
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+	unsigned int tg_min, tg_max, value;
 
 	/*
 	 * Tasks in autogroups or root task group will be
@@ -1415,23 +1417,11 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 	if (task_group(p) == &root_task_group)
 		return uc_req;
 
-	switch (clamp_id) {
-	case UCLAMP_MIN: {
-		struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
-		if (uc_req.value < uc_min.value)
-			return uc_min;
-		break;
-	}
-	case UCLAMP_MAX: {
-		struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
-		if (uc_req.value > uc_max.value)
-			return uc_max;
-		break;
-	}
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	tg_min = task_group(p)->uclamp[UCLAMP_MIN].value;
+	tg_max = task_group(p)->uclamp[UCLAMP_MAX].value;
+	value = uc_req.value;
+	value = clamp(value, tg_min, tg_max);
+	uclamp_se_set(&uc_req, value, false);
 #endif
 
 	return uc_req;
@@ -1630,8 +1620,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 }
 
 static inline void
-uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
+uclamp_update_active(struct task_struct *p)
 {
+	enum uclamp_id clamp_id;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -1651,9 +1642,11 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	if (p->uclamp[clamp_id].active) {
-		uclamp_rq_dec_id(rq, p, clamp_id);
-		uclamp_rq_inc_id(rq, p, clamp_id);
+	for_each_clamp_id(clamp_id) {
+		if (p->uclamp[clamp_id].active) {
+			uclamp_rq_dec_id(rq, p, clamp_id);
+			uclamp_rq_inc_id(rq, p, clamp_id);
+		}
 	}
 
 	task_rq_unlock(rq, p, &rf);
@@ -1661,20 +1654,14 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
-uclamp_update_active_tasks(struct cgroup_subsys_state *css,
-			   unsigned int clamps)
+uclamp_update_active_tasks(struct cgroup_subsys_state *css)
 {
-	enum uclamp_id clamp_id;
 	struct css_task_iter it;
 	struct task_struct *p;
 
 	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it))) {
-		for_each_clamp_id(clamp_id) {
-			if ((0x1 << clamp_id) & clamps)
-				uclamp_update_active(p, clamp_id);
-		}
-	}
+	while ((p = css_task_iter_next(&it)))
+		uclamp_update_active(p);
 	css_task_iter_end(&it);
 }
 
@@ -9634,7 +9621,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 		}
 
 		/* Immediately update descendants RUNNABLE tasks */
-		uclamp_update_active_tasks(css, clamps);
+		uclamp_update_active_tasks(css);
 	}
 }
 
