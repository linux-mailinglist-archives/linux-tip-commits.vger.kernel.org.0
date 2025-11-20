Return-Path: <linux-tip-commits+bounces-7408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06605C73AB8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69A53355067
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015031ED89;
	Thu, 20 Nov 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKX5NwQe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e96uh1vM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161922882D7;
	Thu, 20 Nov 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637594; cv=none; b=GeVxdrCJpr27MU/UATIUIqKjwvXYBMddL8nfm+Pnt3qEIUwnU6M44CDlqeX1R1uBK048faMtq0DOKtmE6119XbeDq/ZtEJ7S1cNXmwOuI6ip4cuRiVMoGgolVSHskBHhx4Ak0hmBw+B+IsXRLEjiMSH9AmjVbrG7qT/foctRXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637594; c=relaxed/simple;
	bh=va1xTA9XxHn8NBK72tS6m86KJG8fdQiwdz3Dc2aX9Es=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NAVnxjN1N7MnnNhgRIjcjbcUMO8F72hITRMr5ihLOAGfFIyFLEZUTFpFRGiV5yJ5ATKOYE8ajhmJ9Wgv9B1FhKRusFOWZ1UbgqFY8MQyhKOw0P5VsxkOwfgqpfX6M/kcKi93oIQAhd4yDziQ48ZiCe/MJGEhu/MD/4bYF7dApRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKX5NwQe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e96uh1vM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RjIWLM65CAYZHyoKMi2+UFkfZBEnqvrOmI68DlV7MY=;
	b=BKX5NwQehbGgDwEWFaV4K1ZVBv81WEjPh7uZVwjxLvqdlVoUlhnlCEhbcDAP0Bijs3sXNx
	qVy82Zf6gPxCARWiKaj4Yh40Ag5EeW1d7Ycn4k52cGF6IyY+di3HK3NjCRKTRgJC5ZIuNF
	+9j6uYRDFssuiyMrzWc0KsVAySQpwbIXGUBGlsAO9JXn3XOKvGDxLT25q/RQ0zd3EuYLhB
	qaAOSp+/N0IwWmiiGwwDkgqpGSwhQdczFqBNVOs0NPHWRi6QjWC5L0bVdYnr0teZB9jcM3
	jqyqC09nCLb2TpdU93r72Ojz1DRafBx4MbS73SdMVLfyeaTqYH1dhgUyl7eVXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RjIWLM65CAYZHyoKMi2+UFkfZBEnqvrOmI68DlV7MY=;
	b=e96uh1vMwifx/nfunUmsR9VuraT9fBhiv+TFEY++o3khtA+pvWvTZ1+g8LKiYOpkS0OHCv
	NmpuBQ+uODzXa4Dg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Implement deferred mode change
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172550.216484739@linutronix.de>
References: <20251119172550.216484739@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363758971.498.14385026602393334564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     cba5e581161e379037a94f5a75d1a61bd1ccce3b
Gitweb:        https://git.kernel.org/tip/cba5e581161e379037a94f5a75d1a61bd1c=
cce3b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:58 +01:00

sched/mmcid: Implement deferred mode change

When affinity changes cause an increase of the number of CPUs allowed for
tasks which are related to a MM, that might results in a situation where
the ownership mode can go back from per CPU mode to per task mode.

As affinity changes happen with runqueue lock held there is no way to do
the actual mode change and required fixup right there.

Add the infrastructure to defer it to a workqueue. The scheduled work can
race with a fork() or exit(). Whatever happens first takes care of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172550.216484739@linutronix.de
---
 include/linux/rseq_types.h |  8 +++++-
 kernel/sched/core.c        | 58 ++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index a3a4f3f..81fbb88 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_RSEQ_TYPES_H
 #define _LINUX_RSEQ_TYPES_H
=20
+#include <linux/irq_work_types.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
=20
 #ifdef CONFIG_RSEQ
 struct rseq;
@@ -122,6 +124,8 @@ struct mm_cid_pcpu {
  * @percpu:		Set, when CIDs are in per CPU mode
  * @transit:		Set to MM_CID_TRANSIT during a mode change transition phase
  * @max_cids:		The exclusive maximum CID value for allocation and convergence
+ * @irq_work:		irq_work to handle the affinity mode change case
+ * @work:		Regular work to handle the affinity mode change case
  * @lock:		Spinlock to protect against affinity setting which can't take @mu=
tex
  * @mutex:		Mutex to serialize forks and exits related to this mm
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The =
map
@@ -139,6 +143,10 @@ struct mm_mm_cid {
 	unsigned int		transit;
 	unsigned int		max_cids;
=20
+	/* Rarely used. Moves @lock and @mutex into the second cacheline */
+	struct irq_work		irq_work;
+	struct work_struct	work;
+
 	raw_spinlock_t		lock;
 	struct mutex		mutex;
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f781d59..938757e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10538,8 +10538,17 @@ static inline void mm_update_cpus_allowed(struct mm_=
struct *mm, const struct cpu
=20
 	/* Adjust the threshold to the wider set */
 	mc->pcpu_thrs =3D mm_cid_calc_pcpu_thrs(mc);
+	/* Switch back to per task mode? */
+	if (mc->users >=3D mc->pcpu_thrs)
+		return;
+
+	/* Don't queue twice */
+	if (mc->update_deferred)
+		return;
=20
-	/* Scheduling of deferred mode switch goes here */
+	/* Queue the irq work, which schedules the real work */
+	mc->update_deferred =3D true;
+	irq_work_queue(&mc->irq_work);
 }
=20
 static inline void mm_cid_transit_to_task(struct task_struct *t, struct mm_c=
id_pcpu *pcp)
@@ -10552,7 +10561,7 @@ static inline void mm_cid_transit_to_task(struct task=
_struct *t, struct mm_cid_p
 	}
 }
=20
-static void __maybe_unused mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
+static void mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
 {
 	unsigned int cpu;
=20
@@ -10713,14 +10722,47 @@ void sched_mm_cid_after_execve(struct task_struct *=
t)
 	mm_cid_select(t);
 }
=20
-void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+static void mm_cid_work_fn(struct work_struct *work)
 {
-	struct mm_cid_pcpu __percpu *pcpu =3D mm->mm_cid.pcpu;
-	int cpu;
+	struct mm_struct *mm =3D container_of(work, struct mm_struct, mm_cid.work);
=20
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(pcpu, cpu)->cid =3D MM_CID_UNSET;
+	/* Make it compile, but not functional yet */
+	if (!IS_ENABLED(CONFIG_NEW_MM_CID))
+		return;
+
+	guard(mutex)(&mm->mm_cid.mutex);
+	/* Did the last user task exit already? */
+	if (!mm->mm_cid.users)
+		return;
+
+	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
+		/* Have fork() or exit() handled it already? */
+		if (!mm->mm_cid.update_deferred)
+			return;
+		/* This clears mm_cid::update_deferred */
+		if (!mm_update_max_cids(mm))
+			return;
+		/* Affinity changes can only switch back to task mode */
+		if (WARN_ON_ONCE(mm->mm_cid.percpu))
+			return;
+	}
+	mm_cid_fixup_cpus_to_tasks(mm);
+}
+
+static void mm_cid_irq_work(struct irq_work *work)
+{
+	struct mm_struct *mm =3D container_of(work, struct mm_struct, mm_cid.irq_wo=
rk);
=20
+	/*
+	 * Needs to be unconditional because mm_cid::lock cannot be held
+	 * when scheduling work as mm_update_cpus_allowed() nests inside
+	 * rq::lock and schedule_work() might end up in wakeup...
+	 */
+	schedule_work(&mm->mm_cid.work);
+}
+
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+{
 	mm->mm_cid.max_cids =3D 0;
 	mm->mm_cid.percpu =3D 0;
 	mm->mm_cid.transit =3D 0;
@@ -10730,6 +10772,8 @@ void mm_init_cid(struct mm_struct *mm, struct task_st=
ruct *p)
 	mm->mm_cid.update_deferred =3D 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	mutex_init(&mm->mm_cid.mutex);
+	mm->mm_cid.irq_work =3D IRQ_WORK_INIT_HARD(mm_cid_irq_work);
+	INIT_WORK(&mm->mm_cid.work, mm_cid_work_fn);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
 }

