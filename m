Return-Path: <linux-tip-commits+bounces-7422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0AFC73B06
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 324922C428
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25B33506B;
	Thu, 20 Nov 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WulcMfgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfqcsx4l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF0332EAF;
	Thu, 20 Nov 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637612; cv=none; b=Uv5tskJTi1SYF2NGGlAtZkoB5jpuDwSYH/cas2590Srjk6neDRC4zetkXu88QR1Asv1qoVHrLt/ERPAvz5ulJAOTU3GZmrWObe4a4pKuMyFWnmA469NiKiYC1+h8hlBPRKw7xR+nnwYxfPX354hj05gemBNEui0mXN/CjzYpraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637612; c=relaxed/simple;
	bh=Eot6llpb/wOrKWqlyH88DWfRseGrvGQ7uXTGLYWzarQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EdF0lC489cGq3S5stnl2biR59S+SGvQQMGh5OQyOFlQlm7HCc24hd8iuDvhwH36ShbETX6wCkAGAUi7C0XeWmjz3wvAoFGtox+LOejBoKXjvvrctSfpx+MRRcI4aXdECH/+tPhu8ljejV9EVI7mqAMDwRp9Hwhd47N+bEAP+oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WulcMfgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfqcsx4l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSJHZo7ur185SLb06PjnmIWnRx/5KG2G1mUbjqpOMg=;
	b=WulcMfgSM/rEnMgYBiGRyaQzSX+Aq/VwDJQkg976NJqfHpKnukQjlK9heDiZXAsmIv5HIn
	22zMx6bqyFvjzC5/G26AOQvnVRI6wIxbQLEJeE6LYt4rM9+/9XaLcU/AsDNNpzD/pkPTZd
	Blg875iWDwBDvUlL7Yw8F8GbEPaffywATCO8mxYtlEKJ6Uz8upAPTdN6O3/tyGnN5EeSQ4
	bIIkvC2TCpHa1IJJmULHhNCq9Kk0BXqqllKTgXYLIszdYJ/i7VkYwHFbn5c4PSa9hBxa9J
	fkbzf+bI2wzA6a6xBM/+60uJSI4+HKVKiMsAB8z8ofzmFS01uWFvwde7abPROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSJHZo7ur185SLb06PjnmIWnRx/5KG2G1mUbjqpOMg=;
	b=lfqcsx4l5/qwOyF3DEFcWEzUobphRxhI4RxeJp6DJWSyBrkescEGotuLmAfNVUmvLfJm3h
	GY905v0rV9mn0vBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] sched/mmcid: Move scheduler code out of global header
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.321259077@linutronix.de>
References: <20251119172549.321259077@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760422.498.2790832140605413701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     b08ef5fc8fa01ae5285bef5ff783bbb425d1fb08
Gitweb:        https://git.kernel.org/tip/b08ef5fc8fa01ae5285bef5ff783bbb425d=
1fb08
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:53 +01:00

sched/mmcid: Move scheduler code out of global header

This is only used in the scheduler core code, so there is no point to have
it in a global header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Link: https://patch.msgid.link/20251119172549.321259077@linutronix.de
---
 include/linux/mm_types.h | 13 -------------
 kernel/sched/core.c      | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e4818e9..67a7bdf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1387,27 +1387,14 @@ static inline unsigned int mm_cid_size(void)
 	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
 }
=20
-static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cp=
umask *cpumask)
-{
-	struct cpumask *mm_allowed =3D mm_cpus_allowed(mm);
-
-	if (!mm)
-		return;
-	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	cpumask_or(mm_allowed, mm_allowed, cpumask);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
-}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) =
{ }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) =
{ return 0; }
 static inline void mm_destroy_cid(struct mm_struct *mm) { }
-
 static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
-static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cp=
umask *cpumask) { }
 #endif /* CONFIG_SCHED_MM_CID */
=20
 struct mmu_gather;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b667171..f5e37c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2669,6 +2669,8 @@ out_unlock:
 	return 0;
 }
=20
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const cpumas=
k_t *affmask);
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
@@ -2728,7 +2730,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct aff=
inity_context *ctx)
 		put_prev_task(rq, p);
=20
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_set_cpus_allowed(p->mm, ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
=20
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10372,6 +10374,18 @@ void call_trace_sched_update_nr_running(struct rq *r=
q, int count)
  * When a task exits, the MM CID held by the task is not longer required as
  * the task cannot return to user space.
  */
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk)
+{
+	struct cpumask *mm_allowed =3D mm_cpus_allowed(mm);
+
+	if (!mm)
+		return;
+	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+	cpumask_or(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+}
+
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
@@ -10411,7 +10425,9 @@ void sched_mm_cid_fork(struct task_struct *t)
 	WARN_ON_ONCE(!t->mm || t->mm_cid.cid !=3D MM_CID_UNSET);
 	t->mm_cid.active =3D 1;
 }
-#endif /* CONFIG_SCHED_MM_CID */
+#else /* CONFIG_SCHED_MM_CID */
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk) { }
+#endif /* !CONFIG_SCHED_MM_CID */
=20
 #ifdef CONFIG_SCHED_CLASS_EXT
 void sched_deq_and_put_task(struct task_struct *p, int queue_flags,

