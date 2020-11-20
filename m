Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153142BAA39
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKTMeT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKTMeJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:09 -0500
Date:   Fri, 20 Nov 2020 12:34:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtkucJkY/D30mZAY/UaYcw5xhy4fj1HuGP5dHuWrhZA=;
        b=YzOEvqBll5Jylw1kvTkBVPf3RF+1D+LKX96l13cT5tu4dxusEBaznXtpxl6sxdWtM8P1a9
        CsPs4ajLAjCHXrGuipFstSQJzAJMt1Tj71g/QJtPSiQbdPxmNWFavQoPw1c0YFLuXRGWnv
        iE/tjIv8PgBbCMsIme3Lo0/geEY2ZgLR0zOovK27m7XlQ+TQzaVkFCshgbE2UesU4n9oGE
        Uq0iIOJrKAVvi1/s9akPvg/YCI4v5l0IyWfno1pyuIwnx3w2yVEdY10C4ZJdoaUix/sJ0q
        6pZo3KtSQ7mxGzjiVgIwA2wnAhPluOf7dM6F9RG4/8GpSwfoXN4guv1xwbAVTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtkucJkY/D30mZAY/UaYcw5xhy4fj1HuGP5dHuWrhZA=;
        b=x7IQaCdEhrgJ692Zv5Y0lXQ3sBF0ebKlp4ZHHpLFG8S1oyw38E7e3kthkeSzxRvo/MIxbP
        2CKXjCW9ZOGTm3Dw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Allow to reset a task uclamp constraint value
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yun Hsiang <hsiang023167@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201113113454.25868-1-dietmar.eggemann@arm.com>
References: <20201113113454.25868-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <160587564623.11244.11912480556442620375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     480a6ca2dc6ed82c783faf7e4a9644769b8397d8
Gitweb:        https://git.kernel.org/tip/480a6ca2dc6ed82c783faf7e4a9644769b8397d8
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 13 Nov 2020 12:34:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:47 +01:00

sched/uclamp: Allow to reset a task uclamp constraint value

In case the user wants to stop controlling a uclamp constraint value
for a task, use the magic value -1 in sched_util_{min,max} with the
appropriate sched_flags (SCHED_FLAG_UTIL_CLAMP_{MIN,MAX}) to indicate
the reset.

The advantage over the 'additional flag' approach (i.e. introducing
SCHED_FLAG_UTIL_CLAMP_RESET) is that no additional flag has to be
exported via uapi. This avoids the need to document how this new flag
has be used in conjunction with the existing uclamp related flags.

The following subtle issue is fixed as well. When a uclamp constraint
value is set on a !user_defined uclamp_se it is currently first reset
and then set.
Fix this by AND'ing !user_defined with !SCHED_FLAG_UTIL_CLAMP which
stands for the 'sched class change' case.
The related condition 'if (uc_se->user_defined)' moved from
__setscheduler_uclamp() into uclamp_reset().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yun Hsiang <hsiang023167@gmail.com>
Link: https://lkml.kernel.org/r/20201113113454.25868-1-dietmar.eggemann@arm.com
---
 include/uapi/linux/sched/types.h |  2 +-
 kernel/sched/core.c              | 70 ++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153..f2c4589 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -96,6 +96,8 @@ struct sched_param {
  * on a CPU with a capacity big enough to fit the specified value.
  * A task with a max utilization value smaller than 1024 is more likely
  * scheduled on a CPU with no more capacity than the specified value.
+ *
+ * A task utilization boundary can be reset by setting the attribute to -1.
  */
 struct sched_attr {
 	__u32 size;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9e6d63..e6473ec 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1413,17 +1413,24 @@ done:
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
-	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+	int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	int util_max = p->uclamp_req[UCLAMP_MAX].value;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
-		lower_bound = attr->sched_util_min;
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
-		upper_bound = attr->sched_util_max;
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		util_min = attr->sched_util_min;
 
-	if (lower_bound > upper_bound)
-		return -EINVAL;
-	if (upper_bound > SCHED_CAPACITY_SCALE)
+		if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		util_max = attr->sched_util_max;
+
+		if (util_max + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (util_min != -1 && util_max != -1 && util_min > util_max)
 		return -EINVAL;
 
 	/*
@@ -1438,20 +1445,41 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static bool uclamp_reset(const struct sched_attr *attr,
+			 enum uclamp_id clamp_id,
+			 struct uclamp_se *uc_se)
+{
+	/* Reset on sched class change for a non user-defined clamp value. */
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
+	    !uc_se->user_defined)
+		return true;
+
+	/* Reset on sched_util_{min,max} == -1. */
+	if (clamp_id == UCLAMP_MIN &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min == -1) {
+		return true;
+	}
+
+	if (clamp_id == UCLAMP_MAX &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max == -1) {
+		return true;
+	}
+
+	return false;
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * On scheduling class change, reset to default clamps for tasks
-	 * without a task-specific value.
-	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int value;
 
-		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (!uclamp_reset(attr, clamp_id, uc_se))
 			continue;
 
 		/*
@@ -1459,21 +1487,25 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_update_util_min_rt_default(p);
+			value = sysctl_sched_uclamp_util_min_rt_default;
 		else
-			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+			value = uclamp_none(clamp_id);
+
+		uclamp_se_set(uc_se, value, false);
 
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
