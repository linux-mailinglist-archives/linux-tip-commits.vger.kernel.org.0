Return-Path: <linux-tip-commits+bounces-4764-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E8A8158E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977783A7632
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE4255E4E;
	Tue,  8 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pdz/vQHP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT7Hpcrc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35D2475E3;
	Tue,  8 Apr 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139137; cv=none; b=QsFCsnVFlAHsLw1oHfuqizey2QSfNYnrXMED2a96bhIVYsNadJUaKNwzJNctsyy/od0qj6i07qU8j+PIT6cGgkU9ca4MsFwmQmvxKGzQHFDWzZIbVqd0IOtEFAy5FJpc0zgehfmBIHOlTwbEo6JS7bbqIIMuB1oprVqNgHfzvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139137; c=relaxed/simple;
	bh=F/bMVeHp4Nm/MzcK3uqeQuBy6zyjDlV03lrauNlUqzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1ZrQe7BAJGiPpFFrI+1CDLD2s12dPh6TcDN/CciXFU/2vqr8quYd4jByOtFVhxoD7X8kY8Bp8QjBX7zRCoi5dD1V4zmug39dDBo62DhDBHQVfyj2pR5whN7jg4iV5UYRHmyiRbKdEWxup3yx2H0Z7XTlclT71+2DJO7ayKzBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pdz/vQHP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qT7Hpcrc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VqGEQMnsIvLClX46WtErdbVUJ+Rl1qferSoRGmC2N0=;
	b=pdz/vQHPmKuyqjgt/cPf9OnctzFuvAlfmGiu6aCPA0U9A4XZX4VR9RJavWTONgGTmy6aBX
	lpyK+9+OZ5bLFlBQIcMriOIOMDJKhtpRLfg2D1ptpN0v58LCjFDcMPS3czasLy7TYMMcvG
	0cUIe2ETrIlM1DGoIoeTxl6HIxXZxLL71QmvXO18o2av4tkOTZ5XJeuvY5Z/ZjrNU/Kxxt
	GoLwrYsriYOAmtLnzwGcf/VTLtsMGgRfDLfv6v+oEfWW6Mv8RLSlwrJCeiOs61K7oFPJIn
	ga4LUV3ShvzLKpWi2FpljDZpuENEct5dknj9OEDaKqrMrG8ZbbvMgwnsAtELUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VqGEQMnsIvLClX46WtErdbVUJ+Rl1qferSoRGmC2N0=;
	b=qT7HpcrcrAfyo77zRLa2bVQC6JSZy/VKLh48p54cIwQTUgOXpzjipoxpWtV7bYgunic28j
	rRYqrHmQpT+XOQDg==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Add RT_GROUP WARN checks for non-root task_groups
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-9-mkoutny@suse.com>
References: <20250310170442.504716-9-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913226.31282.16525753339504827738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     87f1fb77d87a6dac9968a321bb10799ae6d2039c
Gitweb:        https://git.kernel.org/tip/87f1fb77d87a6dac9968a321bb10799ae6d=
2039c
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:54 +02:00

sched: Add RT_GROUP WARN checks for non-root task_groups

With CONFIG_RT_GROUP_SCHED but runtime disabling of RT_GROUPs we expect
the existence of the root task_group only and all rt_sched_entity'ies
should be queued on root's rt_rq.

If we get a non-root RT_GROUP something went wrong.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-9-mkoutny@suse.com
---
 kernel/sched/rt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b611934..778911b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -176,11 +176,14 @@ static inline struct task_struct *rt_task_of(struct sch=
ed_rt_entity *rt_se)
=20
 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
 	return rt_rq->rq;
 }
=20
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
+	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg !=3D &root_task_group=
);
 	return rt_se->rt_rq;
 }
=20
@@ -188,6 +191,7 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_enti=
ty *rt_se)
 {
 	struct rt_rq *rt_rq =3D rt_se->rt_rq;
=20
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
 	return rt_rq->rq;
 }
=20
@@ -504,8 +508,10 @@ typedef struct task_group *rt_rq_iter_t;
=20
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
+	if (!rt_group_sched_enabled()) {
+		WARN_ON(tg !=3D &root_task_group);
 		return NULL;
+	}
=20
 	do {
 		tg =3D list_entry_rcu(tg->list.next,
@@ -2607,8 +2613,9 @@ static int task_is_throttled_rt(struct task_struct *p, =
int cpu)
 {
 	struct rt_rq *rt_rq;
=20
-#ifdef CONFIG_RT_GROUP_SCHED
+#ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched_r=
t_period_rt_rq
 	rt_rq =3D task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
 #else
 	rt_rq =3D &cpu_rq(cpu)->rt;
 #endif
@@ -2718,6 +2725,9 @@ static int tg_rt_schedulable(struct task_group *tg, voi=
d *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
=20
+	if (WARN_ON(!rt_group_sched_enabled() && tg !=3D &root_task_group))
+		return -EBUSY;
+
 	total =3D to_ratio(period, runtime);
=20
 	/*

