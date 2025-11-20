Return-Path: <linux-tip-commits+bounces-7412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B01C73ACD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4B1A358093
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FB33121B;
	Thu, 20 Nov 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inxpmQ6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RoLIpuG1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D4330B0B;
	Thu, 20 Nov 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637599; cv=none; b=RznnVauoLhtZ/qK++HVomaGWGfIY3YGtxZXWer76MS/38/890Le5qKqwuGwD6sA7xMldsU3Po+/xX4q8il1EOQ83y9Pw+IQUbGYIKHxPFzH0d4PVclSl7XIWjYG6znQ8vmjag+0U/ylS1kK4t+ZOIYK73HzfJ6cPTHXxFidep4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637599; c=relaxed/simple;
	bh=MbJ+Tm4kRsdj+cvxZ0y0h1war40Hqg+VzzcCRx8ZTX4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JCVdQSEkn3WY0gFS/PNXykqhXtzP6C1y2JE2pUxnrJ11T1Hn1hw1CCwPaGO6RCxvBOOuqGxJ9iikuTMeBQ1ZCfzsqp2cgQqipZSLyCoJy5WG0np4beAcc1s4BlqVazX4rwqMPgPErP9atu+tM5NN+F9mFKp4Q0OR3/FwBXGwNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inxpmQ6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RoLIpuG1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/4ebYJiUZv5RHDPQZ54sPhyzFSL7oyarAa7xlgjUUo=;
	b=inxpmQ6A/3oQVSBGHwFmR4XCKrn1RaqKIWIZ7xMRD7Wau0/HsflpsCfPNWPoQBS0NO926y
	PK90g5b968IaOc0XCFvGfDukEIoHQVByCLtoMF/HsOpCoX8U9muk5L8I/OodfsKCaEoi7K
	XyKJdR5IZ7MueP8krJrH1w3Vjk7CiGTnJXvGA6eBl2fsiWHVO+Zb7DJESt9btlrZDnPafC
	TBbAORMSX4udStNIwgy5pKnVk8yB3k3Lw4AUpmKbko0AyPKEI3SYCcxVkdGHjdAHf6OJNA
	w791C2VDpnnbKVk6tpGZZIq16ZZZKdZYTyAuF2SuAgxtu58xrim5UPBkWf13OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/4ebYJiUZv5RHDPQZ54sPhyzFSL7oyarAa7xlgjUUo=;
	b=RoLIpuG11jIImgGxmSiQ7V7joPbzAlXvuuoETJAG/BlSMLOXGi0PFc5OlIB6PAL6Tyz6c5
	ArGvSmH3SV711jAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] sched/mmcid: Introduce per task/CPU ownership infrastructure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.960252358@linutronix.de>
References: <20251119172549.960252358@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363759412.498.12903619904613289835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     1bcc335bb29457d402b4fb033673aa89eca8187b
Gitweb:        https://git.kernel.org/tip/1bcc335bb29457d402b4fb033673aa89eca=
8187b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:57 +01:00

sched/mmcid: Introduce per task/CPU ownership infrastructure

The MM CID management has two fundamental requirements:

  1) It has to guarantee that at no given point in time the same CID is
     used by concurrent tasks in userspace.

  2) The CID space must not exceed the number of possible CPUs in a
     system. While most allocators (glibc, tcmalloc, jemalloc) do not care
     about that, there seems to be at least librseq depending on it.

The CID space compaction itself is not a functional correctness
requirement, it is only a useful optimization mechanism to reduce the
memory foot print in unused user space pools.

The optimal CID space is:

    min(nr_tasks, nr_cpus_allowed);

Where @nr_tasks is the number of actual user space threads associated to
the mm and @nr_cpus_allowed is the superset of all task affinities. It is
growth only as it would be insane to take a racy snapshot of all task
affinities when the affinity of one task changes just do redo it 2
milliseconds later when the next task changes its affinity.

That means that as long as the number of tasks is lower or equal than the
number of CPUs allowed, each task owns a CID. If the number of tasks
exceeds the number of CPUs allowed it switches to per CPU mode, where the
CPUs own the CIDs and the tasks borrow them as long as they are scheduled
in.

For transition periods CIDs can go beyond the optimal space as long as they
don't go beyond the number of possible CPUs.

The current upstream implementation adds overhead into task migration to
keep the CID with the task. It also has to do the CID space consolidation
work from a task work in the exit to user space path. As that work is
assigned to a random task related to a MM this can inflict unwanted exit
latencies.

This can be done differently by implementing a strict CID ownership
mechanism. Either the CIDs are owned by the tasks or by the CPUs. The
latter provides less locality when tasks are heavily migrating, but there
is no justification to optimize for overcommit scenarios and thereby
penalizing everyone else.

Provide the basic infrastructure to implement this:

  - Change the UNSET marker to BIT(31) from ~0U
  - Add the ONCPU marker as BIT(30)
  - Add the TRANSIT marker as BIT(29)

That allows to check for ownership trivially and provides a simple check for
UNSET as well. The TRANSIT marker is required to prevent CID space
exhaustion when switching from per CPU to per task mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251119172549.960252358@linutronix.de
---
 include/linux/rseq_types.h |  4 ++-
 include/linux/sched.h      |  6 ++--
 kernel/sched/core.c        | 10 ++++++-
 kernel/sched/sched.h       | 59 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 574aba6..87854ef 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -92,7 +92,9 @@ struct rseq_data { };
=20
 #ifdef CONFIG_SCHED_MM_CID
=20
-#define MM_CID_UNSET	(~0U)
+#define MM_CID_UNSET	BIT(31)
+#define MM_CID_ONCPU	BIT(30)
+#define MM_CID_TRANSIT	BIT(29)
=20
 /**
  * struct sched_mm_cid - Storage for per task MM CID data
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c411ae0..9eec409 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2299,16 +2299,16 @@ void sched_mm_cid_before_execve(struct task_struct *t=
);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
-static inline int task_mm_cid(struct task_struct *t)
+static __always_inline int task_mm_cid(struct task_struct *t)
 {
-	return t->mm_cid.cid;
+	return t->mm_cid.cid & ~(MM_CID_ONCPU | MM_CID_TRANSIT);
 }
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
 static inline void sched_mm_cid_exit(struct task_struct *t) { }
-static inline int task_mm_cid(struct task_struct *t)
+static __always_inline int task_mm_cid(struct task_struct *t)
 {
 	/*
 	 * Use the processor id as a fall-back when the mm cid feature is
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01903cf..55bb9c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10386,6 +10386,16 @@ void call_trace_sched_update_nr_running(struct rq *r=
q, int count)
  *
  * The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
  * lock.
+ *
+ * CID ownership:
+ *
+ * A CID is either owned by a task (stored in task_struct::mm_cid.cid) or
+ * by a CPU (stored in mm::mm_cid.pcpu::cid). CIDs owned by CPUs have the
+ * MM_CID_ONCPU bit set. During transition from CPU to task ownership mode,
+ * MM_CID_TRANSIT is set on the per task CIDs. When this bit is set the
+ * task needs to drop the CID into the pool when scheduling out.  Both bits
+ * (ONCPU and TRANSIT) are filtered out by task_cid() when the CID is
+ * actually handed over to user space in the RSEQ memory.
  */
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d539fb2..4b49284 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3540,6 +3540,65 @@ extern void sched_dynamic_update(int mode);
 extern const char *preempt_modes[];
=20
 #ifdef CONFIG_SCHED_MM_CID
+
+static __always_inline bool cid_on_cpu(unsigned int cid)
+{
+	return cid & MM_CID_ONCPU;
+}
+
+static __always_inline bool cid_in_transit(unsigned int cid)
+{
+	return cid & MM_CID_TRANSIT;
+}
+
+static __always_inline unsigned int cpu_cid_to_cid(unsigned int cid)
+{
+	return cid & ~MM_CID_ONCPU;
+}
+
+static __always_inline unsigned int cid_to_cpu_cid(unsigned int cid)
+{
+	return cid | MM_CID_ONCPU;
+}
+
+static __always_inline unsigned int cid_to_transit_cid(unsigned int cid)
+{
+	return cid | MM_CID_TRANSIT;
+}
+
+static __always_inline unsigned int cid_from_transit_cid(unsigned int cid)
+{
+	return cid & ~MM_CID_TRANSIT;
+}
+
+static __always_inline bool cid_on_task(unsigned int cid)
+{
+	/* True if none of the MM_CID_ONCPU, MM_CID_TRANSIT, MM_CID_UNSET bits is s=
et */
+	return cid < MM_CID_TRANSIT;
+}
+
+static __always_inline void mm_drop_cid(struct mm_struct *mm, unsigned int c=
id)
+{
+	clear_bit(cid, mm_cidmask(mm));
+}
+
+static __always_inline void mm_unset_cid_on_task(struct task_struct *t)
+{
+	unsigned int cid =3D t->mm_cid.cid;
+
+	t->mm_cid.cid =3D MM_CID_UNSET;
+	if (cid_on_task(cid))
+		mm_drop_cid(t->mm, cid);
+}
+
+static __always_inline void mm_drop_cid_on_cpu(struct mm_struct *mm, struct =
mm_cid_pcpu *pcp)
+{
+	/* Clear the ONCPU bit, but do not set UNSET in the per CPU storage */
+	pcp->cid =3D cpu_cid_to_cid(pcp->cid);
+	mm_drop_cid(mm, pcp->cid);
+}
+
+/* Active implementation */
 static inline void init_sched_mm_cid(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;

