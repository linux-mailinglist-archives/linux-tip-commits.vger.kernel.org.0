Return-Path: <linux-tip-commits+bounces-7305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32339C4D70C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC29534ECB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16235B13C;
	Tue, 11 Nov 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kAOgASBV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sv1ZgNpj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB6357A27;
	Tue, 11 Nov 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861046; cv=none; b=kWg92GOkP2uMTFEugHbWwESSqKSTkqSYxUf0ie4aMwKm+Nc85GE5Wo4pcopJDyCkYH7tTrDDrOJdyD2pzWypyhSrCCFLY1GHdl+vh+5DCvDuWrVPQ7FobB1gbI0dAF6P48xkJXEQy7O+fxVKio1571EbsG2B9suULsoJ1+NrtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861046; c=relaxed/simple;
	bh=zK6FmVbc1YQzF/L90kA1pdMlvA5rOWYTQpkb8ueebvw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ggxYzWEWV9bOR3Z0qpwiZCoPi5okLXep05MG7iD5IglymtkYoobqEUrYLYQScjmvU4NQBwZKOi+61ygn+MRbjzqQyb5VNsGgvdeKpBxd167NnqqY1mK901YHXc7sIClXktqcQTPrGrkgpb/ZuIgYK/OG1q0yU4LJ4X+dPmR/4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kAOgASBV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sv1ZgNpj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCrV9AZDABUv7PZhGi/2ks/L1hnfYr+3hAN0MSC4gOw=;
	b=kAOgASBV/L1wIgad5OJ188aI3wvD5kPXZisYWnE1uQbX8eTG5oYWDx1KJa8SkMoYa6e5Sd
	fI3LmMRdNFktUR9rmLOhdLP8nGWhvQ2Gv74aSOafqp8JAB9SYQXBwrax+RDPjpmW2VN+D6
	hHeoNsK2/GYVGkCWoRnljncoKPujP4mdntsg2ZaRJBlh4v0GEg2DmnBpy/7nMF39l8C6u7
	WCAHZ64Pwl0LtZTym8U/gnxdtROKedkcO3uhDlLnHdNxS2J9QL1WMiU/j43cMa2HQeTyT7
	zyVBuBjrTKRBupN481cCwb3gUqPZHrwZ/oPWBq9dKs05oVnF1Cov2yHf+nfVAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCrV9AZDABUv7PZhGi/2ks/L1hnfYr+3hAN0MSC4gOw=;
	b=sv1ZgNpj78n72gfI9Xdv2i/d7Q8c4g8Fe4gFcMXdONCEWQ1rFZFHRmBXEIJnUciNoGe6QB
	xLAoRR/WpFsl2DCQ==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/proxy: Yield the donor task
Cc: kernel test robot <oliver.sang@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Fernand Sieber <sieberf@amazon.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106104022.195157-1-sieberf@amazon.com>
References: <20251106104022.195157-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286104220.498.5228299661392935552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     127b90315ca07ccad2618db7ba950a63e3b32d22
Gitweb:        https://git.kernel.org/tip/127b90315ca07ccad2618db7ba950a63e3b=
32d22
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 06 Nov 2025 12:40:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:36 +01:00

sched/proxy: Yield the donor task

When executing a task in proxy context, handle yields as if they were
requested by the donor task. This matches the traditional PI semantics
of yield() as well.

This avoids scenario like proxy task yielding, pick next task selecting the
same previous blocked donor, running the proxy task again, etc.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202510211205.1e0f5223-lkp@intel.com
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251106104022.195157-1-sieberf@amazon.com
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/ext.c      | 4 ++--
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/syscalls.c | 5 +++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6b8a928..13112c6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2143,7 +2143,7 @@ static void yield_task_dl(struct rq *rq)
 	 * it and the bandwidth timer will wake it up and will give it
 	 * new scheduling parameters (thanks to dl_yielded=3D1).
 	 */
-	rq->curr->dl.dl_yielded =3D 1;
+	rq->donor->dl.dl_yielded =3D 1;
=20
 	update_rq_clock(rq);
 	update_curr_dl(rq);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b063444..224b72c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1474,7 +1474,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task=
_struct *p, int deq_flags
 static void yield_task_scx(struct rq *rq)
 {
 	struct scx_sched *sch =3D scx_root;
-	struct task_struct *p =3D rq->curr;
+	struct task_struct *p =3D rq->donor;
=20
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
@@ -1485,7 +1485,7 @@ static void yield_task_scx(struct rq *rq)
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 {
 	struct scx_sched *sch =3D scx_root;
-	struct task_struct *from =3D rq->curr;
+	struct task_struct *from =3D rq->donor;
=20
 	if (SCX_HAS_OP(sch, yield))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e287..f1d8eb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8980,7 +8980,7 @@ static void put_prev_task_fair(struct rq *rq, struct ta=
sk_struct *prev, struct t
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr =3D rq->curr;
+	struct task_struct *curr =3D rq->donor;
 	struct cfs_rq *cfs_rq =3D task_cfs_rq(curr);
 	struct sched_entity *se =3D &curr->se;
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1fd97f2..f1867fe 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1490,7 +1490,7 @@ static void requeue_task_rt(struct rq *rq, struct task_=
struct *p, int head)
=20
 static void yield_task_rt(struct rq *rq)
 {
-	requeue_task_rt(rq, rq->curr, 0);
+	requeue_task_rt(rq, rq->donor, 0);
 }
=20
 static int find_lowest_rq(struct task_struct *task);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 8f0f603..8078791 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1319,7 +1319,7 @@ static void do_sched_yield(void)
 	rq =3D this_rq_lock_irq(&rf);
=20
 	schedstat_inc(rq->yld_count);
-	current->sched_class->yield_task(rq);
+	rq->donor->sched_class->yield_task(rq);
=20
 	preempt_disable();
 	rq_unlock_irq(rq, &rf);
@@ -1388,12 +1388,13 @@ EXPORT_SYMBOL(yield);
  */
 int __sched yield_to(struct task_struct *p, bool preempt)
 {
-	struct task_struct *curr =3D current;
+	struct task_struct *curr;
 	struct rq *rq, *p_rq;
 	int yielded =3D 0;
=20
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		rq =3D this_rq();
+		curr =3D rq->donor;
=20
 again:
 		p_rq =3D task_rq(p);

