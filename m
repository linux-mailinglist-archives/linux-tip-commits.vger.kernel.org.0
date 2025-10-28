Return-Path: <linux-tip-commits+bounces-7031-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDBC151E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 15:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788B618866BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351B221F17;
	Tue, 28 Oct 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jm73QtCD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nm85i7fR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922616DC28;
	Tue, 28 Oct 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660636; cv=none; b=nzIn/XUWmkJqIqDG7syCzUmZB7HdL7M+VAFGlXX3KXemuyjD8feOGawOEz7/G2PRojmNpSr1IvQDK/FcsP+KYbCeoswxCc1Oa2NTGR+IgaUvShomv0942Sxt9Dghe9yBlMiJTDoZinJSxYjYXNRmNeGeLB542nd1nofrIlu+GQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660636; c=relaxed/simple;
	bh=djyze9ldgzI4ZKoBLm8S71QabwqL4pNZjmOMYfiZCVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ScNqwRgD9GVnr1vpuPiWZ2yufJWv6z03Xjo871+mf/61TIsV51BF0p7k4WRbsf8Uyg5UT8z5urckx9hBwUTIeYdOmU9z1HeljQbc+kWdXPBcKw4q+Z3gMbHndUFKHUkx0WlDKcIOOlkCnFa9Nn4sErfKwoBVnrC/5pfqGjNHKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jm73QtCD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nm85i7fR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 14:10:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761660631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH0POa2oO+05kPQ+RLcpZTyKg4u+UzeQxFqhSWQnI5E=;
	b=jm73QtCDeDikysVMu7QPoEKVGPayQKTlW7+WnlWanCamJpYkSPqiSp5jT9Y/lJyN0jjOyA
	N32+sf7ainTneYHIVeRTEXo4VkdLHLCgAi1WZKeac45PacUrNW4NEc4ITVBCKJUklfeECH
	jtL9JkaEy8pCGM6abMq6lEDbt/g2kjbXJHQN+5hVWIMTNlQurBH08vRqpldPZHRaDFnmZ3
	GyAbBNz/3u8QSA/CVqJ/Dk8jJivDfqAQWpnZADrLHPnKod1GaO+2Ekrc+YTETUKpwvAkut
	XvNCGUFB8CevhyNJt1bN/Chdt5C29kSD8jPyvfOhQr4oKY/twu3cAUJlQTf8nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761660631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH0POa2oO+05kPQ+RLcpZTyKg4u+UzeQxFqhSWQnI5E=;
	b=nm85i7fR6ioKv53530a727BHgRI53Mr9vg5ikdTOK6RQQkPCRwZ/xvfEfykG/11Xgq5CCN
	11GLgz/QDhlIfkBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix the do_set_cpus_allowed() locking fix
Cc: Jan Polensky <japo@linux.ibm.com>,
 kernel test robot <oliver.sang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027110133.GI3245006@noisy.programming.kicks-ass.net>
References: <20251027110133.GI3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176166063011.2601451.2694990479291864074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af13e5e437dc2eb8a3291aad70fc80d9cc78bc73
Gitweb:        https://git.kernel.org/tip/af13e5e437dc2eb8a3291aad70fc80d9cc7=
8bc73
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 27 Oct 2025 12:01:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Oct 2025 15:00:48 +01:00

sched: Fix the do_set_cpus_allowed() locking fix

Commit abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
overlooked that __balance_push_cpu_stop() calls select_fallback_rq()
with rq->lock held. This makes that set_cpus_allowed_force() will
recursively take rq->lock and the machine locks up.

Run select_fallback_rq() earlier, without holding rq->lock. This opens
up a race window where a task could get migrated out from under us, but
that is harmless, we want the task migrated.

select_fallback_rq() itself will not be subject to concurrency as it
will be fully serialized by p->pi_lock, so there is no chance of
set_cpus_allowed_force() getting called with different arguments and
selecting different fallback CPUs for one task.

Fixes: abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
Reported-by: Jan Polensky <japo@linux.ibm.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Jan Polensky <japo@linux.ibm.com>
Closes: https://lore.kernel.org/oe-lkp/202510271206.24495a68-lkp@intel.com
Link: https://patch.msgid.link/20251027110133.GI3245006@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 096e8d0..fd9ff69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8044,18 +8044,15 @@ static int __balance_push_cpu_stop(void *arg)
 	struct rq_flags rf;
 	int cpu;
=20
-	raw_spin_lock_irq(&p->pi_lock);
-	rq_lock(rq, &rf);
-
-	update_rq_clock(rq);
-
-	if (task_rq(p) =3D=3D rq && task_on_rq_queued(p)) {
+	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
 		cpu =3D select_fallback_rq(rq->cpu, p);
-		rq =3D __migrate_task(rq, &rf, p, cpu);
-	}
=20
-	rq_unlock(rq, &rf);
-	raw_spin_unlock_irq(&p->pi_lock);
+		rq_lock(rq, &rf);
+		update_rq_clock(rq);
+		if (task_rq(p) =3D=3D rq && task_on_rq_queued(p))
+			rq =3D __migrate_task(rq, &rf, p, cpu);
+		rq_unlock(rq, &rf);
+	}
=20
 	put_task_struct(p);
=20

