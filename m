Return-Path: <linux-tip-commits+bounces-6839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02419BE2768
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 239074FD601
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42E31E0EB;
	Thu, 16 Oct 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysV8Zjin";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUWTqxkZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87F31E0F0;
	Thu, 16 Oct 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607220; cv=none; b=Tnh1AkQfgWdKgZldHfasIwh46nMqE6rHc4+o6nNMcRNHPp3MpwBr+OX83gIfhdqwCI10KZZwgHYo8Lz3qpgFhpB7qbbdP5vLDa6e/0R+fQDqnHPJOIGURj3utp8Psj5lmkVfOuOMeUdZW2OXk4Ns58PlEWEy0j12cD1Y9sjvVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607220; c=relaxed/simple;
	bh=rfcrVQEXGsZMTonGvrVe9MaKbHsfPfMguNpgZqmGlRk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VZYTWGpwwbp0LPSbjUIHTsRzF7z0r1KvSQvsO8Tq+zU/s8i/9oMB+B0r+rtDk1D3SKOgpnX5hy1BOQPSqK8AQvpbnwuQPDqscTfYqkJYDfnx9SW84bsjRw0KQWS0aWjJ9chJKv+4fXCkDgA+beweGCHWrT16RALmdyMZJBqt5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysV8Zjin; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VUWTqxkZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyCurUD32yYno3j6jycxnahOd0LXMTpHmpi0aHfHAT0=;
	b=ysV8ZjinoAn8fWa0qRunl1gv3A+7KyByXcT0xboGVXUaBd+iDbUQ5oLpFVqe0U3/AR3v++
	+KFwCeiUCY2m3DL47jkap69se3pWwIZ6ue7FwmAmtAj3pXZsq4iQBE7+Zn19XvWiyks9OS
	gS7sRgC0B4PXvUALdjSGktrbMw4RIabhoeyLt6PFTcQkbO3MeUz7YbZoJ/MdS1kvKt0qvd
	d/qIwX+qSWD0oAiK/nXA/Kzfsq/ZHmkWgWHOBA9H+DmMIgdgcI0RKkY9uuh+Kqv/ou5Euo
	haZLJ4Qb7NQ7O3QB7wEQoCtAEFVVWXnPS6tAohKW4QelgWDtD3vzo8oxmmN87g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyCurUD32yYno3j6jycxnahOd0LXMTpHmpi0aHfHAT0=;
	b=VUWTqxkZhL2wvZ+C9nMBikYGWnLPI0oM7/zu3p0E8H16O3BQ1ExXEN+W4nswqQxfiv7jW/
	dvk7XGUruEoqWPAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Cleanup sched_delayed handling for class switches
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104526.964100769@infradead.org>
References: <20251006104526.964100769@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721531.709179.10648552165493064488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1ae5f5dfe5adc64a90b1b0ab5bd9bd7c9d140c28
Gitweb:        https://git.kernel.org/tip/1ae5f5dfe5adc64a90b1b0ab5bd9bd7c9d1=
40c28
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2024 15:47:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:51 +02:00

sched: Cleanup sched_delayed handling for class switches

Use the new sched_class::switching_from() method to dequeue delayed
tasks before switching to another class.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c     | 12 ++++++++----
 kernel/sched/ext.c      |  6 ------
 kernel/sched/fair.c     |  7 +++++++
 kernel/sched/syscalls.c |  3 ---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4dbd206..bd2c551 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7366,9 +7366,6 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 	if (prev_class !=3D next_class)
 		queue_flag |=3D DEQUEUE_CLASS;
=20
-	if (prev_class !=3D next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
@@ -10840,8 +10837,15 @@ struct sched_change_ctx *sched_change_begin(struct t=
ask_struct *p, unsigned int=20
 	lockdep_assert_rq_held(rq);
=20
 	if (flags & DEQUEUE_CLASS) {
-		if (p->sched_class->switching_from)
+		if (p->sched_class->switching_from) {
+			/*
+			 * switching_from_fair() assumes CLASS implies NOCLOCK;
+			 * fixing this assumption would mean switching_from()
+			 * would need to be able to change flags.
+			 */
+			WARN_ON(!(flags & DEQUEUE_NOCLOCK));
 			p->sched_class->switching_from(rq, p);
+		}
 	}
=20
 	*ctx =3D (struct sched_change_ctx){
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a408c39..b0a1e2a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3922,9 +3922,6 @@ static void scx_disable_workfn(struct kthread_work *wor=
k)
 		if (old_class !=3D new_class)
 			queue_flags |=3D DEQUEUE_CLASS;
=20
-		if (old_class !=3D new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
-
 		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class =3D new_class;
 		}
@@ -4673,9 +4670,6 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
 		if (old_class !=3D new_class)
 			queue_flags |=3D DEQUEUE_CLASS;
=20
-		if (old_class !=3D new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOC=
LOCK);
-
 		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice =3D SCX_SLICE_DFL;
 			p->sched_class =3D new_class;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac881df..6c462e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13249,6 +13249,12 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 }
=20
+static void switching_from_fair(struct rq *rq, struct task_struct *p)
+{
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+}
+
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
@@ -13650,6 +13656,7 @@ DEFINE_SCHED_CLASS(fair) =3D {
=20
 	.reweight_task		=3D reweight_task_fair,
 	.prio_changed		=3D prio_changed_fair,
+	.switching_from		=3D switching_from_fair,
 	.switched_from		=3D switched_from_fair,
 	.switched_to		=3D switched_to_fair,
=20
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index bcef5c7..6583faf 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -687,9 +687,6 @@ change:
 	if (prev_class !=3D next_class)
 		queue_flags |=3D DEQUEUE_CLASS;
=20
-	if (prev_class !=3D next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flags) {
=20
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {

