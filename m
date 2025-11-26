Return-Path: <linux-tip-commits+bounces-7533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D71C88111
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A1355671
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0146311969;
	Wed, 26 Nov 2025 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwNLvRpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PALUF4HQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740830F537;
	Wed, 26 Nov 2025 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131775; cv=none; b=kD2yPkMfoeyXx/5Fq67nXfwlAHn4gDP3690VVJS1qmFMtYUAPtIseB5MFrqfMB/INFd/0zOQCX1Tg4kqG3Uspmq6VJhmQ8KjTtIPSC3Tt36dl28msKTJBmEnJQf2ishNk7UVhzoyNamZSvlyQHA03qjU+GO8BnFyTEE3GeS7bAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131775; c=relaxed/simple;
	bh=Ob1AtlCamH9/wsXsfm9eL/KteaAFuVkaXhBqhKVxRX0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A7Uc3kAQzyROevCEAVH2nZZzETIOcF4JfVl6QBXJhWNwG6OS2WXI+CKSAMYzlU+BBlx2wI3UQKCIzGFYX8CJuATYFhcsWTyt8jj3KnmR98iI6E/m4xpsusNBWm5CDlVc3oO9TauhQSsOILfnFM1Zjc8UtSET5uym4W00kt+EWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwNLvRpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PALUF4HQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4bBcm6itFATNZ8sjEcGHQjoYrKHWveIAdl8PfTNBGU=;
	b=fwNLvRpTBFThcCf3LqM4h/ysy8r/bBYqQeDsIIXkgt5lYLNoh4Bxd/HrisiaILAEa0184t
	ccxNhn+GsclazrFoVJLNry6sScoUxvESJHSXBDguhgYYk5mbeoX+dhDXZo1TAkZiZmOnTy
	BMhDUZLwuZ7AgGklzMw6s+ttA7XK774VthB1So9KHKaM//2PEVtbyxs8+icjs9qk+z0Hna
	/XxktiRbtytN+5pE/CWweDomKezzIRvAUbnD+A6HMOALUYP188ruXO5shh58WD/QP2b1Up
	LJgc6/0xeNwv1vLBNuLVmgkbch0Rj+bnmHWHpFrP76hpqeMcpGU+HqiU5sFmew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4bBcm6itFATNZ8sjEcGHQjoYrKHWveIAdl8PfTNBGU=;
	b=PALUF4HQ7LwahLTBgJWpFnrygRAUerqPxcU820H4QXH/QDCui8QhvhsbmMtIdHgPLqO4zo
	tMm+FCnHE4aE0jAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Serialize sched_mm_cid_fork()/exit()
 with a mutex
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.895826703@linutronix.de>
References: <20251119172549.895826703@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176413177120.498.1022026369489322174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     51dd92c71a38647803478fb81e1812286a8998b1
Gitweb:        https://git.kernel.org/tip/51dd92c71a38647803478fb81e1812286a8=
998b1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:41 +01:00

sched/mmcid: Serialize sched_mm_cid_fork()/exit() with a mutex

Prepare for the new CID management scheme which puts the CID ownership
transition into the fork() and exit() slow path by serializing
sched_mm_cid_fork()/exit() with it, so task list and cpu mask walks can be
done in interruptible and preemptible code.

The contention on it is not worse than on other concurrency controls in the
fork()/exit() machinery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.895826703@linutronix.de
---
 include/linux/rseq_types.h |  2 ++
 kernel/sched/core.c        | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 0fab369..574aba6 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -125,6 +125,7 @@ struct mm_cid_pcpu {
  *			do not actually share the MM.
  * @lock:		Spinlock to protect all fields except @pcpu. It also protects
  *			the MM cid cpumask and the MM cidmask bitmap.
+ * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
@@ -132,6 +133,7 @@ struct mm_mm_cid {
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
 	raw_spinlock_t		lock;
+	struct mutex		mutex;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_mm_cid { };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9295c4..01903cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10370,6 +10370,25 @@ void call_trace_sched_update_nr_running(struct rq *r=
q, int count)
=20
 #ifdef CONFIG_SCHED_MM_CID
 /*
+ * Concurrency IDentifier management
+ *
+ * Serialization rules:
+ *
+ * mm::mm_cid::mutex:	Serializes fork() and exit() and therefore
+ *			protects mm::mm_cid::users.
+ *
+ * mm::mm_cid::lock:	Serializes mm_update_max_cids() and
+ *			mm_update_cpus_allowed(). Nests in mm_cid::mutex
+ *			and runqueue lock.
+ *
+ * The mm_cidmask bitmap is not protected by any of the mm::mm_cid locks
+ * and can only be modified with atomic operations.
+ *
+ * The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
+ * lock.
+ */
+
+/*
  * Update the CID range properties when the constraints change. Invoked via
  * fork(), exit() and affinity changes
  */
@@ -10412,6 +10431,7 @@ void sched_mm_cid_fork(struct task_struct *t)
=20
 	WARN_ON_ONCE(!mm || t->mm_cid.cid !=3D MM_CID_UNSET);
=20
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active =3D 1;
 	mm->mm_cid.users++;
@@ -10431,6 +10451,7 @@ void sched_mm_cid_exit(struct task_struct *t)
 	if (!mm || !t->mm_cid.active)
 		return;
=20
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active =3D 0;
 	mm->mm_cid.users--;
@@ -10467,6 +10488,7 @@ void mm_init_cid(struct mm_struct *mm, struct task_st=
ruct *p)
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
 	mm->mm_cid.users =3D 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
+	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
 }

