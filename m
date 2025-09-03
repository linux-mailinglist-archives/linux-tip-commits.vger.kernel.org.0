Return-Path: <linux-tip-commits+bounces-6422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62889B417E0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD50F3A773E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2E2E92B4;
	Wed,  3 Sep 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E1BhnFtX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmnOphLz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74082E0407;
	Wed,  3 Sep 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886717; cv=none; b=mnGvH0xSdeT05RoCQL7FNeHdcy11aEMnC00AhIaIe7/WF5bmKSaBUe91CGGKJt2OqiRvXSozWh+XIktnvHqhy0L0W+4pbUr2PdU/XXsWxSp7ItJ+YJdGkL72kJsI0khW4pYBgcUopX86xCy7gUwyn5ZjAX8gCk4H3TIrsRNUw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886717; c=relaxed/simple;
	bh=CAdrY36u6oUqgWFPf+Lldfz/vOz2ziDo5y3fzJed8yc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jnNQ2OWsJVD2oPu//jtLkvKaF4XiOuxsJlZbKgqX8hlasDSsFvVnXhwVviTdculV9B002BtCsw5Acuq+U8Q5dhUR2nrJ7UQ1wocMIzZ363cqXCIM+7Uq1txUOn3N0vJgmR5dLex866kDg8exKmGrflMnbloR7JVQo2mN9kXlqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E1BhnFtX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmnOphLz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znFhPa+MHCPCr+lu455RGDFuF46kSFi9qq1xgPyf9yM=;
	b=E1BhnFtXAx0UuLPn8b3SIhWqQeC0BnDJybrrQ9E7fXDtGc4z5Tcuyzuw4l+lWykrQkP3VP
	nV32ytknXVyWNQRWu7aonnb7V3QKZZcGSbg50XezbZWTBP0vzE1VaBcgJUqGVG2W/fkqkx
	w5ivnNRTqU6NcLVVnesQJZJHHYePgNKj/kV2TbSRBlarH8PyENt62lunx8hXYY3QaSTtmY
	JjcQNwLs/nlbCE1GAtWN/f13TGFroZ7/5zi42nxDMD+1LUJsONzngmANWV/p4P/lnncKpJ
	5IV/xfU8j1cSKyktXLUy4UNL1gnmefPGtv+uPPrexs2HX0yf8eFPsgWNufi9zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znFhPa+MHCPCr+lu455RGDFuF46kSFi9qq1xgPyf9yM=;
	b=HmnOphLzXDgzY5JshlFM5ipXH37t9kl4cGBfEft92doQumzq6QK8A308+6RJnyX0Kqp3aG
	S0AbLJIx+Qu/DgDw==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Get rid of throttled_lb_pair()
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829081120.806-6-ziqianlu@bytedance.com>
References: <20250829081120.806-6-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688670583.1920.14676738682642599307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5b726e9bf9544a349090879a513a5e00da486c14
Gitweb:        https://git.kernel.org/tip/5b726e9bf9544a349090879a513a5e00da4=
86c14
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Fri, 29 Aug 2025 16:11:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:14 +02:00

sched/fair: Get rid of throttled_lb_pair()

Now that throttled tasks are dequeued and can not stay on rq's cfs_tasks
list, there is no need to take special care of these throttled tasks
anymore in load balance.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250829081120.806-6-ziqianlu@bytedance.com
---
 kernel/sched/fair.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bdc9bfa..df8dc38 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5735,23 +5735,6 @@ static inline int throttled_hierarchy(struct cfs_rq *c=
fs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
=20
-/*
- * Ensure that neither of the group entities corresponding to src_cpu or
- * dest_cpu are members of a throttled hierarchy when performing group
- * load-balance operations.
- */
-static inline int throttled_lb_pair(struct task_group *tg,
-				    int src_cpu, int dest_cpu)
-{
-	struct cfs_rq *src_cfs_rq, *dest_cfs_rq;
-
-	src_cfs_rq =3D tg->cfs_rq[src_cpu];
-	dest_cfs_rq =3D tg->cfs_rq[dest_cpu];
-
-	return throttled_hierarchy(src_cfs_rq) ||
-	       throttled_hierarchy(dest_cfs_rq);
-}
-
 static inline bool task_is_throttled(struct task_struct *p)
 {
 	return cfs_bandwidth_used() && p->throttled;
@@ -6743,12 +6726,6 @@ static inline int throttled_hierarchy(struct cfs_rq *c=
fs_rq)
 	return 0;
 }
=20
-static inline int throttled_lb_pair(struct task_group *tg,
-				    int src_cpu, int dest_cpu)
-{
-	return 0;
-}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *p=
arent) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -9385,18 +9362,14 @@ int can_migrate_task(struct task_struct *p, struct lb=
_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) throttled_lb_pair, or
-	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 4) running (obviously), or
-	 * 5) are cache-hot on their current CPU, or
-	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
+	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 3) running (obviously), or
+	 * 4) are cache-hot on their current CPU, or
+	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if ((p->se.sched_delayed) && (env->migration_type !=3D migrate_load))
 		return 0;
=20
-	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
-		return 0;
-
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow

