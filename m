Return-Path: <linux-tip-commits+bounces-6420-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9CB417DA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA99A3BD546
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7D2E54C8;
	Wed,  3 Sep 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Wv9B/Io";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yUHO92ic"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5412D8372;
	Wed,  3 Sep 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886715; cv=none; b=WJrXOsAOqXII+nWV3E1IwD1B0+cVOFH3qaQVWr82tgLLWqS79fOpJ3GA7oEymRbJQvrCFH1Z91BZQxMxZHzwcRlj2IFtHJR1O5vYTvlMSbSyR1V2Gw0p3dd8A9jILsYEKTe96TvKlSsBpmHb5hE7thEIvQwAqv/G6EUAS0pD06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886715; c=relaxed/simple;
	bh=z5WRwq9bY2WMDKoUEcFcn431l9zJlnECr30/FlcSlx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ejUBaNJeMK6k886Uhva70KsqgCNF0nuRiNV8FS+0MwHjb/foylsbatVosDFU0E6Mdc0hpwgzhUKGHAqs5Nesn+PURNyXIw+ZOxZ4QxaPBhxc1j1BKsdIqropQzYBa2QAKs51r8QAKFV1SQNFKoeOmpO+ltDvb39RHMGc6NntXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Wv9B/Io; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yUHO92ic; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwfQAXbsSI+Kc2fSY/CIIJzeOmdHsclxk/uVixO2QJc=;
	b=4Wv9B/IoAERZN4mhJNulHI8W5kkpnpQGk76PixgsMY+/FU61XHkcyb1xtc+ejmotu2k2uu
	CiMPhs8VHt5DnxxHpthRWq4fH9xPDbs6GmLGvYqeWw5PR682caEOnobzMq2OJNIMZpH4Yz
	Vyt/4Rob+vUSQrgJAZOglWrBTx6ZsxXBqGkmKW36cwgOrSBuS5vyMbgYxkZcB8MTVTaftP
	gf7C42qfX4k47FL5IId66tOlEDeWfgQE3fulgpz5HMxTCpc/LPb2gfJVDIkjAvJcRcb1+W
	g9mMpUzyjbWI57ciaDnnBUgXxvwxTJ0pCFu99EUJwKBz6zQTZ7dfUVeWmdAjiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwfQAXbsSI+Kc2fSY/CIIJzeOmdHsclxk/uVixO2QJc=;
	b=yUHO92icwohlGq3JbrY9I6Pq2tDyeEPBDFmoi2AbdmwHpbfWFh8cHbDt4dWA67A02tBrIx
	JuKqP+NiX4B6KaAg==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement throttle task work and
 related helpers
Cc: Valentin Schneider <vschneid@redhat.com>,
 Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829081120.806-3-ziqianlu@bytedance.com>
References: <20250829081120.806-3-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688670948.1920.2009327424050880478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7fc2d14392475e368a2a7be458aba4eecdf2439b
Gitweb:        https://git.kernel.org/tip/7fc2d14392475e368a2a7be458aba4eecdf=
2439b
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Fri, 29 Aug 2025 16:11:17 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:13 +02:00

sched/fair: Implement throttle task work and related helpers

Implement throttle_cfs_rq_work() task work which gets executed on task's
ret2user path where the task is dequeued and marked as throttled.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250829081120.806-3-ziqianlu@bytedance.com
---
 kernel/sched/fair.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8fff40f..dab4ed8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5748,8 +5748,51 @@ static inline int throttled_lb_pair(struct task_group =
*tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
=20
+static inline bool task_is_throttled(struct task_struct *p)
+{
+	return cfs_bandwidth_used() && p->throttled;
+}
+
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flag=
s);
 static void throttle_cfs_rq_work(struct callback_head *work)
 {
+	struct task_struct *p =3D container_of(work, struct task_struct, sched_thro=
ttle_work);
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+
+	WARN_ON_ONCE(p !=3D current);
+	p->sched_throttle_work.next =3D &p->sched_throttle_work;
+
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
+
+	scoped_guard(task_rq_lock, p) {
+		se =3D &p->se;
+		cfs_rq =3D cfs_rq_of(se);
+
+		/* Raced, forget */
+		if (p->sched_class !=3D &fair_sched_class)
+			return;
+
+		/*
+		 * If not in limbo, then either replenish has happened or this
+		 * task got migrated out of the throttled cfs_rq, move along.
+		 */
+		if (!cfs_rq->throttle_count)
+			return;
+		rq =3D scope.rq;
+		update_rq_clock(rq);
+		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		p->throttled =3D true;
+		resched_curr(rq);
+	}
 }
=20
 void init_cfs_throttle_work(struct task_struct *p)
@@ -5789,6 +5832,26 @@ static int tg_unthrottle_up(struct task_group *tg, voi=
d *data)
 	return 0;
 }
=20
+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next !=3D &p->sched_throttle_work;
+}
+
+static inline void task_throttle_setup_work(struct task_struct *p)
+{
+	if (task_has_throttle_work(p))
+		return;
+
+	/*
+	 * Kthreads and exiting tasks don't return to userspace, so adding the
+	 * work is pointless
+	 */
+	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
+		return;
+
+	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq =3D data;
@@ -6652,6 +6715,8 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)=
 { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
+static void task_throttle_setup_work(struct task_struct *p) {}
+static bool task_is_throttled(struct task_struct *p) { return false; }
=20
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {

