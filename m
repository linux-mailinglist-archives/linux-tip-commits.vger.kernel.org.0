Return-Path: <linux-tip-commits+bounces-4765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD496A81577
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3160E189B686
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49862459FF;
	Tue,  8 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="diWJqQta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nPHI8S8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F2247DDD;
	Tue,  8 Apr 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139137; cv=none; b=P93RJ5oNriNmLb3/qiCIKfAm6wHWI1ZPajV6bhZZ0ouI5pS5CvFMoV1JBEkqQM4o9GNQGm6+SxkL2Cq9QjHk9EgWMxu45gQPUociERAF/EdGyibLQ7ACU74vi4T4YPeiSdy4NBXCSy7Ht2gnQYx5ymKLYK2hnW1sjWsQaC3n138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139137; c=relaxed/simple;
	bh=8BeQN15WX0E0AtpLOOj7RWLYPVKF6tKjSdeI4XIsHjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ENnaZCDgtIPnVbzOL+rVq///o+QEvp0Ihu991mdH3SbktvM42Edu233I9g3ww5KOnEHyUticC494HzBWrZukWzCQ8yfLgSbYqltcZ3AcuC6eEut9kZyHS/1/2eU6BdGYL6UBt4hcL2L07aI5P55cWqvQ8R+TZ9gSea3svVw0M4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=diWJqQta; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2nPHI8S8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYzJzR23dAROVd5Do/TLisW63zEc22ohPjYlVWEilFo=;
	b=diWJqQtaW8BhKgIM+mASa2Q2SVbVIZ0GBI1N7ZQ5lVr4vwfTsCnjNlfm7jm5Bo9hYK2sY6
	zL4DZdF6SqQrdCI19TE9BKFcNTNxu9UIrkXuEnHCLOZofxPjkofIzsiJvJvchQrdDc8V5t
	ZTkjTlM6Ztq0JUvvgR4FFY7FURVEFRUidnoVN41Dnu3XLJb5dstLOck819SqOZRLJyWoNi
	FGG2lvkM5NfKHtIY2617oDo0mk2V/e7Q/wOgnApuxXmk3SrwbcT7OPiXk2vt6OFgAWZ/hv
	i7IBajvpg3o6g+g32i5FWrO0Ur4e2cXrwBi9UG/jxwHMIqXXU3qn1A0blOookw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYzJzR23dAROVd5Do/TLisW63zEc22ohPjYlVWEilFo=;
	b=2nPHI8S83nW+Ng/G0JGv+sblzXMQLj3Wc3OTjs4iza81zR+yeCciielpw6mf6d8KnimTM4
	6PLrpkRNEp5ll0CQ==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Do not construct nor expose RT_GROUP_SCHED
 structures if disabled
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-8-mkoutny@suse.com>
References: <20250310170442.504716-8-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913338.31282.839144510526685734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d6809c2f606c14f9e95be87d75a576901d2fa050
Gitweb:        https://git.kernel.org/tip/d6809c2f606c14f9e95be87d75a576901d2=
fa050
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:54 +02:00

sched: Do not construct nor expose RT_GROUP_SCHED structures if disabled

Thanks to kernel cmdline being available early, before any
cgroup hierarchy exists, we can achieve the RT_GROUP_SCHED boottime
disabling goal by simply skipping any creation (and destruction) of
RT_GROUP data and its exposure via RT attributes.

We can do this thanks to previously placed runtime guards that would
redirect all operations to root_task_group's data when RT_GROUP_SCHED
disabled.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-8-mkoutny@suse.com
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++------------
 kernel/sched/rt.c   |  9 +++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6900ce5..79692f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9867,18 +9867,6 @@ static struct cftype cpu_legacy_files[] =3D {
 		.seq_show =3D cpu_cfs_local_stat_show,
 	},
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	{
-		.name =3D "rt_runtime_us",
-		.read_s64 =3D cpu_rt_runtime_read,
-		.write_s64 =3D cpu_rt_runtime_write,
-	},
-	{
-		.name =3D "rt_period_us",
-		.read_u64 =3D cpu_rt_period_read_uint,
-		.write_u64 =3D cpu_rt_period_write_uint,
-	},
-#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name =3D "uclamp.min",
@@ -9897,6 +9885,20 @@ static struct cftype cpu_legacy_files[] =3D {
 };
=20
 #ifdef CONFIG_RT_GROUP_SCHED
+static struct cftype rt_group_files[] =3D {
+	{
+		.name =3D "rt_runtime_us",
+		.read_s64 =3D cpu_rt_runtime_read,
+		.write_s64 =3D cpu_rt_runtime_write,
+	},
+	{
+		.name =3D "rt_period_us",
+		.read_u64 =3D cpu_rt_period_read_uint,
+		.write_u64 =3D cpu_rt_period_write_uint,
+	},
+	{ }	/* Terminate */
+};
+
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -9919,6 +9921,16 @@ static int __init setup_rt_group_sched(char *str)
 	return 1;
 }
 __setup("rt_group_sched=3D", setup_rt_group_sched);
+
+static int __init cpu_rt_group_init(void)
+{
+	if (!rt_group_sched_enabled())
+		return 0;
+
+	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
+	return 0;
+}
+subsys_initcall(cpu_rt_group_init);
 #endif /* CONFIG_RT_GROUP_SCHED */
=20
 static int cpu_extra_stat_show(struct seq_file *sf,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5e82bfe..b611934 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -193,6 +193,9 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_enti=
ty *rt_se)
=20
 void unregister_rt_sched_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return;
+
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
 }
@@ -201,6 +204,9 @@ void free_rt_sched_group(struct task_group *tg)
 {
 	int i;
=20
+	if (!rt_group_sched_enabled())
+		return;
+
 	for_each_possible_cpu(i) {
 		if (tg->rt_rq)
 			kfree(tg->rt_rq[i]);
@@ -245,6 +251,9 @@ int alloc_rt_sched_group(struct task_group *tg, struct ta=
sk_group *parent)
 	struct sched_rt_entity *rt_se;
 	int i;
=20
+	if (!rt_group_sched_enabled())
+		return 1;
+
 	tg->rt_rq =3D kcalloc(nr_cpu_ids, sizeof(rt_rq), GFP_KERNEL);
 	if (!tg->rt_rq)
 		goto err;

