Return-Path: <linux-tip-commits+bounces-6424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F6B417D7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBD1B4E4AA5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8E2EAB78;
	Wed,  3 Sep 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDef3nFR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6IKOn9AV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2C2E8E00;
	Wed,  3 Sep 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886719; cv=none; b=pOr4z+DixRNWYXlxDtcn7Z5M0bih79F5nWpLnADhXMHUt4HEfoBHPS59URDhzaPWvRGp+qQZyhpCZEItw9UpmIB0LyQ3NiFgUzFc0PtJ0R/oHuh5wXp91k519gTAhZmKrCmCTA1ZJBT4fY++4WQkY6iFqDZsY1XYWSmcHDPdOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886719; c=relaxed/simple;
	bh=aWpZJcshQHB5pkxE+ZTa3PV8JCT55lPQzqR6aIHYClM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g7e85CZX9aer61Cc2tgCkTGbIS22rnQevWddPS7RNszuSWqcXrdZVl/je1eiGqZA+gkupxFbYJPhmDCRTI3bU6n12DfA0XiI6EvsnVYlArjUStDA0EctGhT2VPfs839D+P3uaOzsu0fm6WChXwTnw5M/Ko3JwSEo/fMozmUIauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDef3nFR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6IKOn9AV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GPimEl1zZqE8IWtdu1E7Bb8HZMkXS46EAw9rTX+MNc=;
	b=eDef3nFRtoV6C4LuKeNxIwWf02wO2JnqHVvFbWk6hwWRyriS+CicknidsvjLB+HvqmmGAc
	LZYSQ+KD0WrraYFcaLKrYLGJum7fE3vBB1sr3G0wk0Smzkq58pLDif6pr0DQbvZaVkeAsC
	acYBOnALT3BE2jlA4aUtf9KuDVkXqOy/1hcYPJdfEOzqBJdR+BOdu4P87rgn+S5o096POd
	F3vo2bhJ8TBGDTGSyTiO+A+j2Jnp8/NY+uQxC+Dso85/rdVDN6JMjJF3rOejwmvixK6cyh
	wV5kI2l0r5KsmamBgNAqJL+ql6HOvIoIlhxAg7Vb952f5ol6gPglq9yUgjq4aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GPimEl1zZqE8IWtdu1E7Bb8HZMkXS46EAw9rTX+MNc=;
	b=6IKOn9AVM2ESE4HQapOhZgwDXNp7LHogA18Xw5uKhcY0OsYvqY+D+fKhkpbN9hYHkzziR1
	AgMLwOJ3q09vSECg==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add related data structure for task
 based throttle
Cc: Valentin Schneider <vschneid@redhat.com>,
 Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829081120.806-2-ziqianlu@bytedance.com>
References: <20250829081120.806-2-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688671071.1920.12257841418757117966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2cd571245b43492867bf1b4252485f3e6647b643
Gitweb:        https://git.kernel.org/tip/2cd571245b43492867bf1b4252485f3e664=
7b643
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Fri, 29 Aug 2025 16:11:16 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:13 +02:00

sched/fair: Add related data structure for task based throttle

Add related data structures for this new throttle functionality.

Tesed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Link: https://lore.kernel.org/r/20250829081120.806-2-ziqianlu@bytedance.com
---
 include/linux/sched.h |  5 +++++
 kernel/sched/core.c   |  3 +++
 kernel/sched/fair.c   | 13 +++++++++++++
 kernel/sched/sched.h  |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b8..644a01b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -883,6 +883,11 @@ struct task_struct {
=20
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct callback_head		sched_throttle_work;
+	struct list_head		throttle_node;
+	bool				throttled;
+#endif
 #endif
=20
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629..feb750a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4490,6 +4490,9 @@ static void __sched_fork(unsigned long clone_flags, str=
uct task_struct *p)
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			=3D NULL;
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
 #endif
=20
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a05..8fff40f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5748,6 +5748,18 @@ static inline int throttled_lb_pair(struct task_group =
*tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
=20
+static void throttle_cfs_rq_work(struct callback_head *work)
+{
+}
+
+void init_cfs_throttle_work(struct task_struct *p)
+{
+	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_wo=
rk() */
+	p->sched_throttle_work.next =3D &p->sched_throttle_work;
+	INIT_LIST_HEAD(&p->throttle_node);
+}
+
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq =3D data;
@@ -6472,6 +6484,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled =3D 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }
=20
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d..a6493d2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -739,6 +739,7 @@ struct cfs_rq {
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head        throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -2658,6 +2659,8 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt=
_rq);
=20
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
=20
+extern void init_cfs_throttle_work(struct task_struct *p);
+
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8

