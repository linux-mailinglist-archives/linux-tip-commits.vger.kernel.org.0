Return-Path: <linux-tip-commits+bounces-6832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E69BE26D1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D56C3E3141
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30F31B11F;
	Thu, 16 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6MlccQK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wVK/71U3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397AF31AF06;
	Thu, 16 Oct 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607212; cv=none; b=TaV5Z8Ubxht16GjAAOmdIIx1Cx71r/+DQxKsCPARRf4ZdnQgbGpjn/nGG0p08dHeqE96kj30ol7ocAPiXjvunCuFmQHJ5STRGzkdXCKyr0jpvCQs9jBQ2PAJ0ejOOpCaCdJifBTCdR/WxcSvqB2e8KQB9V953rZ1iKGbLRK9Bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607212; c=relaxed/simple;
	bh=HapQ6B6X0GAMNZZXX/BLZwad9cRUv6o7DTc1Su2KQiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NurezpLBt67pxFsJWo5xlsQlK2jDaaQoxSSAOzGWa7GQtusMwRvVfzLDdrtppbf1GL+Wkkk/13LBQ6GEp4v42zEIznDVPfkuU526w/r8jf/NqnuOkSBjZ5KtoYtbc23aoD+Ff5qWW3A3vQUb8CXyIhJ5E3GP6whzepZWpE/eexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6MlccQK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wVK/71U3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT2+TaJWGhmDQDIjSvSKfy9tCdm2pKaoP1iOJlJLbAk=;
	b=s6MlccQK9Tw/ErGY87QpSfanz0LzT2QZHJ8UED5KwlTgyP+TYZ4ebWTT3iICner5D3dvnf
	WeOOKi9b2DBm/qfUGbvdiogv6SwB6BRfsZAWxTIpp3oO6ScXTucj5MQQjKJiQ6aKrdE7zL
	+X69QOvhn5TpF8LyA7Ecg6b+qSffCf4vsdas56vppKo6TbV/mbleJO3kvC8iA4s4Vr7txj
	+ZEiPhw5nj1Lz854PGFMtO5OdNwQJRaNZ9oiBnDZMvnu7Y3+0BiCnB6YULJwnzdMSi32bS
	TzPTmpKAKqkvavniSTRh78rGV03ypUiSoJpqEPQ/phF8v0NHxrzzeETl/cM23Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT2+TaJWGhmDQDIjSvSKfy9tCdm2pKaoP1iOJlJLbAk=;
	b=wVK/71U3u4BpSeItzYuIcodgkeJwavZ4pfu7cs4c9/JZfZ2pr47SnXcrWM/jPYpHdcrpc0
	DkDQ6BTnHLrmb3Bg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Match __task_rq_{,un}lock()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.813272361@infradead.org>
References: <20251006104527.813272361@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720600.709179.949762469775900348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5892cbd85dbf9059b8a3a7dd8ab64c0fce671029
Gitweb:        https://git.kernel.org/tip/5892cbd85dbf9059b8a3a7dd8ab64c0fce6=
71029
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Sep 2025 11:26:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:54 +02:00

sched: Match __task_rq_{,un}lock()

In preparation to adding more rules to __task_rq_lock(), such that
__task_rq_unlock() will no longer be equivalent to rq_unlock(),
make sure every __task_rq_lock() is matched by a __task_rq_unlock()
and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 13 ++++++++-----
 kernel/sched/sched.h |  8 ++++----
 kernel/sched/stats.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8c55740..e715147 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2582,7 +2582,8 @@ static int migration_cpu_stop(void *data)
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
 		preempt_disable();
-		task_rq_unlock(rq, p, &rf);
+		rq_unlock(rq, &rf);
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		preempt_enable();
@@ -2591,7 +2592,8 @@ static int migration_cpu_stop(void *data)
 out:
 	if (pending)
 		pending->stop_pending =3D false;
-	task_rq_unlock(rq, p, &rf);
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
=20
 	if (complete)
 		complete_all(&pending->done);
@@ -3708,7 +3710,7 @@ static int ttwu_runnable(struct task_struct *p, int wak=
e_flags)
 		ttwu_do_wakeup(p);
 		ret =3D 1;
 	}
-	__task_rq_unlock(rq, &rf);
+	__task_rq_unlock(rq, p, &rf);
=20
 	return ret;
 }
@@ -4301,7 +4303,7 @@ int task_call_func(struct task_struct *p, task_call_f f=
unc, void *arg)
 	ret =3D func(p, arg);
=20
 	if (rq)
-		rq_unlock(rq, &rf);
+		__task_rq_unlock(rq, p, &rf);
=20
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
@@ -7362,7 +7364,8 @@ out_unlock:
=20
 	rq_unpin_lock(rq, &rf);
 	__balance_callbacks(rq);
-	raw_spin_rq_unlock(rq);
+	rq_repin_lock(rq, &rf);
+	__task_rq_unlock(rq, p, &rf);
=20
 	preempt_enable();
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3462145..e3d2710 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1825,7 +1825,8 @@ struct rq *task_rq_lock(struct task_struct *p, struct r=
q_flags *rf)
 	__acquires(p->pi_lock)
 	__acquires(rq->lock);
=20
-static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
+static inline void
+__task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
@@ -1837,8 +1838,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, st=
ruct rq_flags *rf)
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
-	rq_unpin_lock(rq, rf);
-	raw_spin_rq_unlock(rq);
+	__task_rq_unlock(rq, p, rf);
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
=20
@@ -1849,7 +1849,7 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
=20
 DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
 		    _T->rq =3D __task_rq_lock(_T->lock, &_T->rf),
-		    __task_rq_unlock(_T->rq, &_T->rf),
+		    __task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
=20
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 26f3fd4..cbf7206 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -206,7 +206,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
=20
 		rq =3D __task_rq_lock(p, &rf);
 		psi_task_change(p, p->psi_flags, 0);
-		__task_rq_unlock(rq, &rf);
+		__task_rq_unlock(rq, p, &rf);
 	}
 }
=20

