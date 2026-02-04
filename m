Return-Path: <linux-tip-commits+bounces-8203-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBLUNntJg2m0kwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8203-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:28:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1855DE66A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD0A43012B1F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674240F8D1;
	Wed,  4 Feb 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESGrJMrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdDWco1q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CE40F8C8;
	Wed,  4 Feb 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211645; cv=none; b=Heo1Kq/YujJ7VQYP3ndfU4joGvPUemCd5DUolMvTq77tF3PD/t6JqyGHM1k2OJ6p/OZ/Pp1IjzDp7oHb307eKGCzc2/NqwDvy/ahdP1J9lSVbfgdiRI7HOtiff0m22y9YDloaRF4W8wrPlb3A4t7S0q9gIs8v5ghum1EHHQwd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211645; c=relaxed/simple;
	bh=WSVQCycNQDtEWMGCNeWDHKvcq6PhSCNeU9SDU/gta9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZWM1x7p09UaetxDsTlVvwedfZNxbHCnQd39mkEZ9LfBT27OvjIFXnIHeHi5h7hwyy1qR0g3q+MyAD1eBUZKZKnfugulzaVIyoWnwtLuJeyk6hnJVybJU303GjjEPmUAA4a+ZhCeg5IrkRBD7Dp404fJfk7QWHqW3VQ10BN8XUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESGrJMrQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdDWco1q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 13:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770211643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTIgnYohiQuOxLjpULEkpZ0q3hmaO1oKEdd3+WuSOdk=;
	b=ESGrJMrQsQr8JNsAi93g9zOHk9Fox6W9LEXSHRiAdKeKP8wFABEVCsjq73C9RVsLEnfNn6
	TlYAG9L76oMyCTIfOds6JfkGqUQwpCqUaAfpHUjfeTsD5LMrXHRVJW5LQyWbI9xv+bh0pt
	momA+3R5qgV2AWIlEUT2NU/A38tcA57BJbttEYzoi1e/B+4wRrtkAEI6vurRX0DWsVE83d
	j7mtc7dZzcfH8TAwiOgtiLVFSPTCLhWOwXrh7Kjnc1owaIItKzroUGXyxTx8GE2LiXrEtl
	NfAnUYk5KmedWB/y6Pl0eA7kNfBLdfeFrvjsjHcPc7ipKJt4UC4PgfHxoZqjyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770211643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTIgnYohiQuOxLjpULEkpZ0q3hmaO1oKEdd3+WuSOdk=;
	b=SdDWco1qzQjWrnmu0pgUY6AUKROJRXZ7ac+hx3LZGZ7bZPF6vrkwUOYp/mMblxg9tdvSoE
	/Q1omo/o9nLWdcBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/mmcid: Prevent live lock on task to CPU
 mode transition
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260201192834.897115238@kernel.org>
References: <20260201192834.897115238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177021164239.2495410.8701940528094221515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8203-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,efficios.com:email,linux.dev:email,vger.kernel.org:replyto,msgid.link:url,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1855DE66A4
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4327fb13fa47770183c4850c35382c30ba5f939d
Gitweb:        https://git.kernel.org/tip/4327fb13fa47770183c4850c35382c30ba5=
f939d
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 10:39:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Feb 2026 12:21:11 +01:00

sched/mmcid: Prevent live lock on task to CPU mode transition

Ihor reported a BPF CI failure which turned out to be a live lock in the
MM_CID management. The scenario is:

A test program creates the 5th thread, which means the MM_CID users become
more than the number of CPUs (four in this example), so it switches to per
CPU ownership mode.

At this point each live task of the program has a CID associated. Assume
thread creation order assignment for simplicity.

   T0     CID0  runs fork() and creates T4
   T1 	  CID1
   T2 	  CID2
   T3 	  CID3
   T4       ---   not visible yet

T0 sets mm_cid::percpu =3D true and transfers its own CID to CPU0 where it
runs on and then starts the fixup which walks through the threads to
transfer the per task CIDs either to the CPU the task is running on or drop
it back into the pool if the task is not on a CPU.

During that T1 - T3 are free to schedule in and out before the fixup caught
up with them. Going through all possible permutations with a python script
revealed a few problematic cases. The most trivial one is:

   T1 schedules in on CPU1 and observes percpu =3D=3D true, so it transfers
      its CID to CPU1

   T1 is migrated to CPU2 and schedule in observes percpu =3D=3D true, but
      CPU2 does not have a CID associated and T1 transferred its own to
      CPU1

      So it has to allocate one with CPU2 runqueue lock held, but the
      pool is empty, so it keeps looping in mm_get_cid().

Now T0 reaches T1 in the thread walk and tries to lock the corresponding
runqueue lock, which is held causing a full live lock.

There is a similar scenario in the reverse direction of switching from per
CPU to task mode which is way more obvious and got therefore addressed by
an intermediate mode. In this mode the CIDs are marked with MM_CID_TRANSIT,
which means that they are neither owned by the CPU nor by the task. When a
task schedules out with a transit CID it drops the CID back into the pool
making it available for others to use temporarily. Once the task which
initiated the mode switch finished the fixup it clears the transit mode and
the process goes back into per task ownership mode.

Unfortunately this insight was not mapped back to the task to CPU mode
switch as the above described scenario was not considered in the analysis.

Apply the same transit mechanism to the task to CPU mode switch to handle
these problematic cases correctly.

As with the CPU to task transition this results in a potential temporary
contention on the CID bitmap, but that's only for the time it takes to
complete the transition. After that it stays in steady mode which does not
touch the bitmap at all.

Fixes: fbd0e71dc370 ("sched/mmcid: Provide CID ownership mode fixup functions=
")
Closes: https://lore.kernel.org/2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260201192834.897115238@kernel.org
---
 kernel/sched/core.c  | 128 +++++++++++++++++++++++++++---------------
 kernel/sched/sched.h |   4 +-
 2 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045f83a..1e790f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10269,7 +10269,8 @@ void call_trace_sched_update_nr_running(struct rq *rq=
, int count)
  * Serialization rules:
  *
  * mm::mm_cid::mutex:	Serializes fork() and exit() and therefore
- *			protects mm::mm_cid::users.
+ *			protects mm::mm_cid::users and mode switch
+ *			transitions
  *
  * mm::mm_cid::lock:	Serializes mm_update_max_cids() and
  *			mm_update_cpus_allowed(). Nests in mm_cid::mutex
@@ -10285,14 +10286,61 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
  *
  * A CID is either owned by a task (stored in task_struct::mm_cid.cid) or
  * by a CPU (stored in mm::mm_cid.pcpu::cid). CIDs owned by CPUs have the
- * MM_CID_ONCPU bit set. During transition from CPU to task ownership mode,
- * MM_CID_TRANSIT is set on the per task CIDs. When this bit is set the
- * task needs to drop the CID into the pool when scheduling out.  Both bits
- * (ONCPU and TRANSIT) are filtered out by task_cid() when the CID is
- * actually handed over to user space in the RSEQ memory.
+ * MM_CID_ONCPU bit set.
+ *
+ * During the transition of ownership mode, the MM_CID_TRANSIT bit is set
+ * on the CIDs. When this bit is set the tasks drop the CID back into the
+ * pool when scheduling out.
+ *
+ * Both bits (ONCPU and TRANSIT) are filtered out by task_cid() when the
+ * CID is actually handed over to user space in the RSEQ memory.
  *
  * Mode switching:
  *
+ * All transitions of ownership mode happen in two phases:
+ *
+ *  1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the CIDs
+ *     and denotes that the CID is only temporarily owned by a task. When
+ *     the task schedules out it drops the CID back into the pool if this
+ *     bit is set.
+ *
+ *  2) The initiating context walks the per CPU space or the tasks to fixup
+ *     or drop the CIDs and after completion it clears mm:mm_cid.transit.
+ *     After that point the CIDs are strictly task or CPU owned again.
+ *
+ * This two phase transition is required to prevent CID space exhaustion
+ * during the transition as a direct transfer of ownership would fail:
+ *
+ *   - On task to CPU mode switch if a task is scheduled in on one CPU and
+ *     then migrated to another CPU before the fixup freed enough per task
+ *     CIDs.
+ *
+ *   - On CPU to task mode switch if two tasks are scheduled in on the same
+ *     CPU before the fixup freed per CPU CIDs.
+ *
+ *   Both scenarios can result in a live lock because sched_in() is invoked
+ *   with runqueue lock held and loops in search of a CID and the fixup
+ *   thread can't make progress freeing them up because it is stuck on the
+ *   same runqueue lock.
+ *
+ * While MM_CID_TRANSIT is active during the transition phase the MM_CID
+ * bitmap can be contended, but that's a temporary contention bound to the
+ * transition period. After that everything goes back into steady state and
+ * nothing except fork() and exit() will touch the bitmap. This is an
+ * acceptable tradeoff as it completely avoids complex serialization,
+ * memory barriers and atomic operations for the common case.
+ *
+ * Aside of that this mechanism also ensures RT compability:
+ *
+ *   - The task which runs the fixup is fully preemptible except for the
+ *     short runqueue lock held sections.
+ *
+ *   - The transient impact of the bitmap contention is only problematic
+ *     when there is a thundering herd scenario of tasks scheduling in and
+ *     out concurrently. There is not much which can be done about that
+ *     except for avoiding mode switching by a proper overall system
+ *     configuration.
+ *
  * Switching to per CPU mode happens when the user count becomes greater
  * than the maximum number of CIDs, which is calculated by:
  *
@@ -10306,12 +10354,13 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
  *
  * At the point of switching to per CPU mode the new user is not yet
  * visible in the system, so the task which initiated the fork() runs the
- * fixup function: mm_cid_fixup_tasks_to_cpu() walks the thread list and
- * either transfers each tasks owned CID to the CPU the task runs on or
- * drops it into the CID pool if a task is not on a CPU at that point in
- * time. Tasks which schedule in before the task walk reaches them do the
- * handover in mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus() completes
- * it's guaranteed that no task related to that MM owns a CID anymore.
+ * fixup function. mm_cid_fixup_tasks_to_cpu() walks the thread list and
+ * either marks each task owned CID with MM_CID_TRANSIT if the task is
+ * running on a CPU or drops it into the CID pool if a task is not on a
+ * CPU. Tasks which schedule in before the task walk reaches them do the
+ * handover in mm_cid_schedin(). When mm_cid_fixup_tasks_to_cpus()
+ * completes it is guaranteed that no task related to that MM owns a CID
+ * anymore.
  *
  * Switching back to task mode happens when the user count goes below the
  * threshold which was recorded on the per CPU mode switch:
@@ -10327,28 +10376,11 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
  * run either in the deferred update function in context of a workqueue or
  * by a task which forks a new one or by a task which exits. Whatever
  * happens first. mm_cid_fixup_cpus_to_task() walks through the possible
- * CPUs and either transfers the CPU owned CIDs to a related task which
- * runs on the CPU or drops it into the pool. Tasks which schedule in on a
- * CPU which the walk did not cover yet do the handover themself.
- *
- * This transition from CPU to per task ownership happens in two phases:
- *
- *  1) mm:mm_cid.transit contains MM_CID_TRANSIT This is OR'ed on the task
- *     CID and denotes that the CID is only temporarily owned by the
- *     task. When it schedules out the task drops the CID back into the
- *     pool if this bit is set.
- *
- *  2) The initiating context walks the per CPU space and after completion
- *     clears mm:mm_cid.transit. So after that point the CIDs are strictly
- *     task owned again.
- *
- * This two phase transition is required to prevent CID space exhaustion
- * during the transition as a direct transfer of ownership would fail if
- * two tasks are scheduled in on the same CPU before the fixup freed per
- * CPU CIDs.
- *
- * When mm_cid_fixup_cpus_to_tasks() completes it's guaranteed that no CID
- * related to that MM is owned by a CPU anymore.
+ * CPUs and either marks the CPU owned CIDs with MM_CID_TRANSIT if a
+ * related task is running on the CPU or drops it into the pool. Tasks
+ * which are scheduled in before the fixup covered them do the handover
+ * themself. When mm_cid_fixup_cpus_to_tasks() completes it is guaranteed
+ * that no CID related to that MM is owned by a CPU anymore.
  */
=20
 /*
@@ -10400,9 +10432,9 @@ static bool mm_update_max_cids(struct mm_struct *mm)
 	/* Mode change required? */
 	if (!!mc->percpu =3D=3D !!mc->pcpu_thrs)
 		return false;
-	/* When switching back to per TASK mode, set the transition flag */
-	if (!mc->pcpu_thrs)
-		WRITE_ONCE(mc->transit, MM_CID_TRANSIT);
+
+	/* Set the transition flag to bridge the transfer */
+	WRITE_ONCE(mc->transit, MM_CID_TRANSIT);
 	WRITE_ONCE(mc->percpu, !!mc->pcpu_thrs);
 	return true;
 }
@@ -10493,10 +10525,10 @@ static void mm_cid_fixup_cpus_to_tasks(struct mm_st=
ruct *mm)
 	WRITE_ONCE(mm->mm_cid.transit, 0);
 }
=20
-static inline void mm_cid_transfer_to_cpu(struct task_struct *t, struct mm_c=
id_pcpu *pcp)
+static inline void mm_cid_transit_to_cpu(struct task_struct *t, struct mm_ci=
d_pcpu *pcp)
 {
 	if (cid_on_task(t->mm_cid.cid)) {
-		t->mm_cid.cid =3D cid_to_cpu_cid(t->mm_cid.cid);
+		t->mm_cid.cid =3D cid_to_transit_cid(t->mm_cid.cid);
 		pcp->cid =3D t->mm_cid.cid;
 	}
 }
@@ -10509,18 +10541,17 @@ static bool mm_cid_fixup_task_to_cpu(struct task_st=
ruct *t, struct mm_struct *mm
 	if (!t->mm_cid.active)
 		return false;
 	if (cid_on_task(t->mm_cid.cid)) {
-		/* If running on the CPU, transfer the CID, otherwise drop it */
+		/* If running on the CPU, put the CID in transit mode, otherwise drop it */
 		if (task_rq(t)->curr =3D=3D t)
-			mm_cid_transfer_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
+			mm_cid_transit_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
 		else
 			mm_unset_cid_on_task(t);
 	}
 	return true;
 }
=20
-static void mm_cid_fixup_tasks_to_cpus(void)
+static void mm_cid_do_fixup_tasks_to_cpus(struct mm_struct *mm)
 {
-	struct mm_struct *mm =3D current->mm;
 	struct task_struct *p, *t;
 	unsigned int users;
=20
@@ -10558,6 +10589,15 @@ static void mm_cid_fixup_tasks_to_cpus(void)
 	}
 }
=20
+static void mm_cid_fixup_tasks_to_cpus(void)
+{
+	struct mm_struct *mm =3D current->mm;
+
+	mm_cid_do_fixup_tasks_to_cpus(mm);
+	/* Clear the transition bit */
+	WRITE_ONCE(mm->mm_cid.transit, 0);
+}
+
 static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *m=
m)
 {
 	t->mm_cid.active =3D 1;
@@ -10596,7 +10636,7 @@ void sched_mm_cid_fork(struct task_struct *t)
 		if (!percpu)
 			mm_cid_transit_to_task(current, pcp);
 		else
-			mm_cid_transfer_to_cpu(current, pcp);
+			mm_cid_transit_to_cpu(current, pcp);
 	}
=20
 	if (percpu) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93fce4b..eff2073 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3841,6 +3841,10 @@ static __always_inline void mm_cid_from_cpu(struct tas=
k_struct *t, unsigned int=20
 		/* Still nothing, allocate a new one */
 		if (!cid_on_cpu(cpu_cid))
 			cpu_cid =3D cid_to_cpu_cid(mm_get_cid(mm));
+
+		/* Set the transition mode flag if required */
+		if (READ_ONCE(mm->mm_cid.transit))
+			cpu_cid =3D cpu_cid_to_cid(cpu_cid) | MM_CID_TRANSIT;
 	}
 	mm_cid_update_pcpu_cid(mm, cpu_cid);
 	mm_cid_update_task_cid(t, cpu_cid);

