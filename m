Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19879388917
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbhESIK2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37430 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbhESIK0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:26 -0400
Date:   Wed, 19 May 2021 08:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zok2lfxBy8pJZRD1RjFZUKLqbjwI1pxJmEaefzrafuo=;
        b=eDt7Bk51WK3EJUsVYQfH8Grv2918WVrR+1JuUqU3kVP8Ir4bKR9sB5DyffAt9tjM859MVb
        nX1tOudBd85FZW38ZAEPeLHaSwUVJxdax666/VI6kqZISczHSmhw06ubI3y0830bAs5vxE
        d5q3aNX+duIhVDSXN7IADKTV1g1dfGxHXX0eRqa6by8k0nA1FCVREYGjupJKSEMn43gsTo
        G/Vf87pznzgeQVeP14+E0BqUD6orpUTKFjuBW4HG11a8rnt5CB6lFqCaB7fTXwXczbiyz8
        LkmWKqCTVOY5ir+5XZYTgabZ0qYvwvvC8cpaVnQgHuVNPO83YP2rTgKhGxoMfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zok2lfxBy8pJZRD1RjFZUKLqbjwI1pxJmEaefzrafuo=;
        b=3PsrBayEOMGc1JhZXY+4Q4DtfgQd5luiHbPcbp3Rf+bVNTCWY6gtX7y8jLtDYhpx3HVy4v
        yPOaE/aJSXF/RKCw==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix wrong implementation of cpu.uclamp.min
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510145032.1934078-2-qais.yousef@arm.com>
References: <20210510145032.1934078-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <162141174557.29796.1259372044191640801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6938840392c89f0ef81e9efe51e2efcdd209fd83
Gitweb:        https://git.kernel.org/tip/6938840392c89f0ef81e9efe51e2efcdd209fd83
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 10 May 2021 15:50:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:54 +02:00

sched/uclamp: Fix wrong implementation of cpu.uclamp.min

cpu.uclamp.min is a protection as described in cgroup-v2 Resource
Distribution Model

	Documentation/admin-guide/cgroup-v2.rst

which means we try our best to preserve the minimum performance point of
tasks in this group. See full description of cpu.uclamp.min in the
cgroup-v2.rst.

But the current implementation makes it a limit, which is not what was
intended.

For example:

	tg->cpu.uclamp.min = 20%

	p0->uclamp[UCLAMP_MIN] = 0
	p1->uclamp[UCLAMP_MIN] = 50%

	Previous Behavior (limit):

		p0->effective_uclamp = 0
		p1->effective_uclamp = 20%

	New Behavior (Protection):

		p0->effective_uclamp = 20%
		p1->effective_uclamp = 50%

Which is inline with how protections should work.

With this change the cgroup and per-task behaviors are the same, as
expected.

Additionally, we remove the confusing relationship between cgroup and
!user_defined flag.

We don't want for example RT tasks that are boosted by default to max to
change their boost value when they attach to a cgroup. If a cgroup wants
to limit the max performance point of tasks attached to it, then
cpu.uclamp.max must be set accordingly.

Or if they want to set different boost value based on cgroup, then
sysctl_sched_util_clamp_min_rt_default must be used to NOT boost to max
and set the right cpu.uclamp.min for each group to let the RT tasks
obtain the desired boost value when attached to that group.

As it stands the dependency on !user_defined flag adds an extra layer of
complexity that is not required now cpu.uclamp.min behaves properly as
a protection.

The propagation model of effective cpu.uclamp.min in child cgroups as
implemented by cpu_util_update_eff() is still correct. The parent
protection sets an upper limit of what the child cgroups will
effectively get.

Fixes: 3eac870a3247 (sched/uclamp: Use TG's clamps to restrict TASK's clamps)
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
---
 kernel/sched/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a5124c..f97eb73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1405,7 +1405,6 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	struct uclamp_se uc_max;
 
 	/*
 	 * Tasks in autogroups or root task group will be
@@ -1416,9 +1415,23 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 	if (task_group(p) == &root_task_group)
 		return uc_req;
 
-	uc_max = task_group(p)->uclamp[clamp_id];
-	if (uc_req.value > uc_max.value || !uc_req.user_defined)
-		return uc_max;
+	switch (clamp_id) {
+	case UCLAMP_MIN: {
+		struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
+		if (uc_req.value < uc_min.value)
+			return uc_min;
+		break;
+	}
+	case UCLAMP_MAX: {
+		struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
+		if (uc_req.value > uc_max.value)
+			return uc_max;
+		break;
+	}
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 #endif
 
 	return uc_req;
