Return-Path: <linux-tip-commits+bounces-7421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4188C73B12
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275154E6D0D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C401334690;
	Thu, 20 Nov 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdYqaRRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGyDJq6/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54A333432;
	Thu, 20 Nov 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637608; cv=none; b=UE2g/83C70RUeH7TzqWw53ETBinjSgTKsNctHAVVNIL4XFfBPeg1Cih4UrYceMDlv8GRLts2OPpUkFwYLySPCcJJNxvDLBFptZfPoai4FVxP2pc+t8Des61keFcZp1DRt6zeAZdedcp3DnGx7Pjd7ilH0+ZNzlQ9S1udcU3F5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637608; c=relaxed/simple;
	bh=Fe+ZFGkb6lkRe2g4i05tK9n1lJahhd3A6zJox7jA7uE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u6eHemy6TGhMpiYL6uRut2rRHCGzMFs9WCU9lTfN55xXvTbhfgCF3Bj2EWVx4rFnocEUQL7rhBH7iqvrINxcMfzuWTSnrVBBxeylXM1Q/pDIwX4EjjK6sxAjR9Fu0ShoW8NNor4kZbYkyngspfp+3aMre0+1cYNW34VR6PV5IXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OdYqaRRK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGyDJq6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXpFLZyDZnekSlIOawyCCX4/hh27pkGYjiW6qTmgU8I=;
	b=OdYqaRRKJBEIIEhq71CtxKlaXJdk2AXwfWXoj+vBCER4ducNJfaHm3/1fDbwLFmOOQhKqX
	ST6nM/3Vr/FXrA6eeEeODul4QStZysru/oStPijqhHiAEpX4Pf5DNMF5GTKVYYnL/yxqFC
	+n3flGAp6I8DYpPWjPGX8xXOBr95Ahym57h0NShkl5ghn7hTFvOd+J0kGCD1r/KAusOreT
	BJdOLv28w315ijxwr6tX0Fp96owAzuTq35EOdgKh6oFF+ebuKDGzXUO0Q6ooZ5ImJJQhzR
	TpAAMQjpsI2VR9o1HA/o42HFQ1fe8E208T2r/YJpbFOKpYUNvyCCV+fBVhdd1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXpFLZyDZnekSlIOawyCCX4/hh27pkGYjiW6qTmgU8I=;
	b=lGyDJq6/VP16ih3Hcq/Y7bwZH/4ct8T2HvcdzjDtYUc7t6T6+TnvWff7YZyhXsdevBXqqN
	9g5IGQu8eYhvH+CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.385208276@linutronix.de>
References: <20251119172549.385208276@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760325.498.6044219070321321409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     0d032a43ebeb9bf255cd7e3dad5f7a6371571648
Gitweb:        https://git.kernel.org/tip/0d032a43ebeb9bf255cd7e3dad5f7a63715=
71648
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:54 +01:00

sched/mmcid: Prevent pointless work in mm_update_cpus_allowed()

mm_update_cpus_allowed() is not required to be invoked for affinity changes
due to migrate_disable() and migrate_enable().

migrate_disable() restricts the task temporarily to a CPU on which the task
was already allowed to run, so nothing changes. migrate_enable() restores
the actual task affinity mask.

If that mask changed between migrate_disable() and migrate_enable() then
that change was already accounted for.

Move the invocation to the proper place to avoid that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.385208276@linutronix.de
---
 kernel/sched/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5e37c2..2ea77e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2684,6 +2684,7 @@ void set_cpus_allowed_common(struct task_struct *p, str=
uct affinity_context *ctx
=20
 	cpumask_copy(&p->cpus_mask, ctx->new_mask);
 	p->nr_cpus_allowed =3D cpumask_weight(ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
=20
 	/*
 	 * Swap in a new user_cpus_ptr if SCA_USER flag set
@@ -2730,7 +2731,6 @@ __do_set_cpus_allowed(struct task_struct *p, struct aff=
inity_context *ctx)
 		put_prev_task(rq, p);
=20
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_update_cpus_allowed(p->mm, ctx->new_mask);
=20
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10376,12 +10376,17 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
  */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk)
 {
-	struct cpumask *mm_allowed =3D mm_cpus_allowed(mm);
+	struct cpumask *mm_allowed;
=20
 	if (!mm)
 		return;
-	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+
+	/*
+	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
+	 * allowed CPUs mask which means it can only grow.
+	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
+	mm_allowed =3D mm_cpus_allowed(mm);
 	cpumask_or(mm_allowed, mm_allowed, affmsk);
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
 }

