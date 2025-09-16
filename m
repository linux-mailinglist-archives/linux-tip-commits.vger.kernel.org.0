Return-Path: <linux-tip-commits+bounces-6647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D3B59577
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929CC1B2121B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127525C70C;
	Tue, 16 Sep 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tBfIAjZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2i6So3mW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C192D73AD;
	Tue, 16 Sep 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023014; cv=none; b=IzJVPUvk5MQEnNEP4hDIssqk1NffILE/mqoS5FauJMhHC9g0ywlvHyT9giKxBhvJnjYF5H9gxFToR3r1vCkZnfS0GpX34xiDuaB0W3uOBcygF1EiU1Pd0/uQMW3yzLxoJ5UdoLMfjU76zXsDSXkzP4NhDoLT1tHXjFZlUxc9UlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023014; c=relaxed/simple;
	bh=YGsPTge+eGU0HvaZ5uTYCG13xBB6IdiWRJQyLICbrYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PQKIERdAykrt9p/30W08/W633Yymk7ogDLQ0XlBo/2strOLEIPAXkTD9bBMenY6tfE4Dc+IV9bKAj8lMlqjvX5BCzMMQ4V7+fEB0Ve23rfBcDV8nV1tPdFvI/SqfthIyzujB3lWIH8prbnuGEPlp7TxPEpsXHJYvpSetVCocNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tBfIAjZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2i6So3mW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:43:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758023011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfrbBSNeZk25KJQbvybH4RxMq7N9KdtDvyPwSBEctUs=;
	b=tBfIAjZiz0LP3gd4wIb415kw8tkiH7nPHU2c00EZiV/s+ZEroZwN59+wzLAS0o68o7opty
	VC5JRmc0TmXh7oyg08dYeNCra7gyZrCkF3AHw6DMtsFV5iHnSZE51w9ZnbWa5GruC/f++8
	RFCBWIB722bSfn8alHkTqF3SyilPq+pgNaPGPVCMg32yA8sJsxHplX+bsp0tOT+vWwOLtv
	ckxCY/pmuvbhpkeduwSUYkkVcu0+xQ7bj1uPXdwSwNBaFKZiz8A+/nY0g/QjBSOrdvPKNe
	qSYcC6dvJJLC0AxnbergMT7mJxSV0hzo9ZxK1RnAKMMsHiIkAJyVMXCwz5b+Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758023011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfrbBSNeZk25KJQbvybH4RxMq7N9KdtDvyPwSBEctUs=;
	b=2i6So3mWlxKSDgVLbcqrx0hc40f88XgLN3FUM4WkEcENy6xdbl6px8DVwU4sxMyt/nngM5
	jetDt/NiZl6qZ4AA==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Do not balance task to a throttled cfs_rq
Cc: Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912034428.GA33@bytedance>
References: <20250912034428.GA33@bytedance>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802300983.709179.2391176496832053003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0d4eaf8caf8cd633b23e949e2996b420052c2d45
Gitweb:        https://git.kernel.org/tip/0d4eaf8caf8cd633b23e949e2996b420052=
c2d45
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Fri, 12 Sep 2025 11:44:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:38 +02:00

sched/fair: Do not balance task to a throttled cfs_rq

When doing load balance and the target cfs_rq is in throttled hierarchy,
whether to allow balancing there is a question.

The good side to allow balancing is: if the target CPU is idle or less
loaded and the being balanced task is holding some kernel resources,
then it seems a good idea to balance the task there and let the task get
the CPU earlier and release kernel resources sooner. The bad part is, if
the task is not holding any kernel resources, then the balance seems not
that useful.

While theoretically it's debatable, a performance test[0] which involves
200 cgroups and each cgroup runs hackbench(20 sender, 20 receiver) in
pipe mode showed a performance degradation on AMD Genoa when allowing
load balance to throttled cfs_rq. Analysis[1] showed hackbench doesn't
like task migration across LLC boundary. For this reason, add a check in
can_migrate_task() to forbid balancing to a cfs_rq that is in throttled
hierarchy. This reduced task migration a lot and performance restored.

[0]: https://lore.kernel.org/lkml/20250822110701.GB289@bytedance/
[1]: https://lore.kernel.org/lkml/20250903101102.GB42@bytedance/

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3dbdfaa..18a30ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5737,6 +5737,11 @@ static inline int throttled_hierarchy(struct cfs_rq *c=
fs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
=20
+static inline int lb_throttled_hierarchy(struct task_struct *p, int dst_cpu)
+{
+	return throttled_hierarchy(task_group(p)->cfs_rq[dst_cpu]);
+}
+
 static inline bool task_is_throttled(struct task_struct *p)
 {
 	return cfs_bandwidth_used() && p->throttled;
@@ -6733,6 +6738,11 @@ static inline int throttled_hierarchy(struct cfs_rq *c=
fs_rq)
 	return 0;
 }
=20
+static inline int lb_throttled_hierarchy(struct task_struct *p, int dst_cpu)
+{
+	return 0;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *p=
arent) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -9369,14 +9379,18 @@ int can_migrate_task(struct task_struct *p, struct lb=
_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU, or
-	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
+	 * 2) target cfs_rq is in throttled hierarchy, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU, or
+	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if ((p->se.sched_delayed) && (env->migration_type !=3D migrate_load))
 		return 0;
=20
+	if (lb_throttled_hierarchy(p, env->dst_cpu))
+		return 0;
+
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow

