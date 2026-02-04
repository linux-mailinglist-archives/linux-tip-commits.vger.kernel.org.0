Return-Path: <linux-tip-commits+bounces-8202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIUqJ8JKg2m0kwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:33:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51222E678B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523B130F4DFA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468640B6F6;
	Wed,  4 Feb 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8znXU7w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YfyHbpTX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F440B6EF;
	Wed,  4 Feb 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211644; cv=none; b=est13EYWP6QTY9TIyZCgbVgF7EuiTtxIgS/nfgEslyBlTdJNYXYH/mntzzOVtJ28hj2opBSRBzmYSGVUrsBVAnZXgheOqfnt23YTYvB/LnV3sRpg7FiE6bUYjnCti1GuFs/1w8wLDPOoPgC9M4IkdNZNYVn7I9N936G7SL5RtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211644; c=relaxed/simple;
	bh=sK6BjQsYHChdmJ52i9cml2Tf8sdEvHY99eQCeVmxLnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UEBml/rXWxhImD5wqJxhRL5L1TgeziyKQEEnZac9TBcqSOW9Ji/j5PPwryU6hPZ0qnsi+t2RQGkA4XYO7L032yog4OM/pRZzZ6ZP19i0e3jfNQNK7QAuuTFfAfP2fMq5NkgKikjOcY62WPF5l3Ty/07rv+YM6YeV3KKD+wZk0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8znXU7w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YfyHbpTX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 13:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770211642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g96MfRsU2DEfHd1dVskj0gudbQzOCfPJ8TfhsqdC08U=;
	b=N8znXU7wkK5tV0vAg7dq6BXON+XHGm+NhvW9ksBv8tAbXITnVAl0XlstmbFHbSVOcEqYGv
	vbx7y5sr4nlq120z763NBeFphRAOIuc5vrynghqAKqx2KixMAxvbEctYsiIDJoAVTqv3co
	8rPbOqoYO8eGYjgnEA3WiLGdiJKGfWcoEqvKv2UCvlCPhQKbPtncSUEzehrBdThkD1vkCl
	7+qjPz9KLokWlb6rtEHR/a+56+wM1HPdwolMh1MGs9qDEYYiIfxmne2xo/7jvsTfkpzRXv
	pnDY1RQsmYxgA0PA6N8zbKbMb42dpuHObgwo0opMjgxLFT0nYM8idbZC/rbnkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770211642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g96MfRsU2DEfHd1dVskj0gudbQzOCfPJ8TfhsqdC08U=;
	b=YfyHbpTXz143haEiqk76CMDvDIxxgmp+X/7Cp1EKRqyWKYG/1DeIREjQ6SoB45pZDjVUlI
	TZLFr4jt/X/3CHDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/mmcid: Protect transition on weakly ordered systems
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260201192834.965217106@kernel.org>
References: <20260201192834.965217106@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177021164123.2495410.17213910638191632399.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8202-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,efficios.com:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 51222E678B
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     47ee94efccf6732e4ef1a815c451aacaf1464757
Gitweb:        https://git.kernel.org/tip/47ee94efccf6732e4ef1a815c451aacaf14=
64757
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 10:39:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Feb 2026 12:21:12 +01:00

sched/mmcid: Protect transition on weakly ordered systems

Shrikanth reported a hard lockup which he observed once. The stack trace
shows the following CID related participants:

  watchdog: CPU 23 self-detected hard LOCKUP @ mm_get_cid+0xe8/0x188
  NIP: mm_get_cid+0xe8/0x188
  LR:  mm_get_cid+0x108/0x188
   mm_cid_switch_to+0x3c4/0x52c
   __schedule+0x47c/0x700
   schedule_idle+0x3c/0x64
   do_idle+0x160/0x1b0
   cpu_startup_entry+0x48/0x50
   start_secondary+0x284/0x288
   start_secondary_prolog+0x10/0x14

  watchdog: CPU 11 self-detected hard LOCKUP @ plpar_hcall_norets_notrace+0x1=
8/0x2c
  NIP: plpar_hcall_norets_notrace+0x18/0x2c
  LR:  queued_spin_lock_slowpath+0xd88/0x15d0
   _raw_spin_lock+0x80/0xa0
   raw_spin_rq_lock_nested+0x3c/0xf8
   mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
   sched_mm_cid_exit+0x108/0x22c
   do_exit+0xf4/0x5d0
   make_task_dead+0x0/0x178
   system_call_exception+0x128/0x390
   system_call_vectored_common+0x15c/0x2ec

The task on CPU11 is running the CID ownership mode change fixup function
and is stuck on a runqueue lock. The task on CPU23 is trying to get a CID
from the pool with the same runqueue lock held, but the pool is empty.

After decoding a similar issue in the opposite direction switching from per
task to per CPU mode the tool which models the possible scenarios failed to
come up with a similar loop hole.

This showed up only once, was not reproducible and according to tooling not
related to a overlooked scheduling scenario permutation. But the fact that
it was observed on a PowerPC system gave the right hint: PowerPC is a
weakly ordered architecture.

The transition mechanism does:

    WRITE_ONCE(mm->mm_cid.transit, MM_CID_TRANSIT);
    WRITE_ONCE(mm->mm_cid.percpu, new_mode);

    fixup()

    WRITE_ONCE(mm->mm_cid.transit, 0);

mm_cid_schedin() does:

    if (!READ_ONCE(mm->mm_cid.percpu))
       ...
       cid |=3D READ_ONCE(mm->mm_cid.transit);

so weakly ordered systems can observe percpu =3D=3D false and transit =3D=3D =
0 even
if the fixup function has not yet completed. As a consequence the task will
not drop the CID when scheduling out before the fixup is completed, which
means the CID space can be exhausted and the next task scheduling in will
loop in mm_get_cid() and the fixup thread can livelock on the held runqueue
lock as above.

This could obviously be solved by using:
     smp_store_release(&mm->mm_cid.percpu, true);
and
     smp_load_acquire(&mm->mm_cid.percpu);

but that brings a memory barrier back into the scheduler hotpath, which was
just designed out by the CID rewrite.

That can be completely avoided by combining the per CPU mode and the
transit storage into a single mm_cid::mode member and ordering the stores
against the fixup functions to prevent the CPU from reordering them.

That makes the update of both states atomic and a concurrent read observes
always consistent state.

The price is an additional AND operation in mm_cid_schedin() to evaluate
the per CPU or the per task path, but that's in the noise even on strongly
ordered architectures as the actual load can be significantly more
expensive and the conditional branch evaluation is there anyway.

Fixes: fbd0e71dc370 ("sched/mmcid: Provide CID ownership mode fixup functions=
")
Closes: https://lore.kernel.org/bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ib=
m.com
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260201192834.965217106@kernel.org
---
 include/linux/rseq_types.h |  6 +--
 kernel/sched/core.c        | 66 ++++++++++++++++++++++++-------------
 kernel/sched/sched.h       | 21 ++++++------
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 332dc14..ef08113 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -121,8 +121,7 @@ struct mm_cid_pcpu {
 /**
  * struct mm_mm_cid - Storage for per MM CID data
  * @pcpu:		Per CPU storage for CIDs associated to a CPU
- * @percpu:		Set, when CIDs are in per CPU mode
- * @transit:		Set to MM_CID_TRANSIT during a mode change transition phase
+ * @mode:		Indicates per CPU and transition mode
  * @max_cids:		The exclusive maximum CID value for allocation and convergence
  * @irq_work:		irq_work to handle the affinity mode change case
  * @work:		Regular work to handle the affinity mode change case
@@ -139,8 +138,7 @@ struct mm_cid_pcpu {
 struct mm_mm_cid {
 	/* Hotpath read mostly members */
 	struct mm_cid_pcpu	__percpu *pcpu;
-	unsigned int		percpu;
-	unsigned int		transit;
+	unsigned int		mode;
 	unsigned int		max_cids;
=20
 	/* Rarely used. Moves @lock and @mutex into the second cacheline */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e790f2..8580283 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10297,16 +10297,25 @@ void call_trace_sched_update_nr_running(struct rq *=
rq, int count)
  *
  * Mode switching:
  *
+ * The ownership mode is per process and stored in mm:mm_cid::mode with the
+ * following possible states:
+ *
+ *	0:				Per task ownership
+ *	0 | MM_CID_TRANSIT:		Transition from per CPU to per task
+ *	MM_CID_ONCPU:			Per CPU ownership
+ *	MM_CID_ONCPU | MM_CID_TRANSIT:	Transition from per task to per CPU
+ *
  * All transitions of ownership mode happen in two phases:
  *
- *  1) mm:mm_cid.transit contains MM_CID_TRANSIT. This is OR'ed on the CIDs
- *     and denotes that the CID is only temporarily owned by a task. When
- *     the task schedules out it drops the CID back into the pool if this
- *     bit is set.
+ *  1) mm:mm_cid::mode has the MM_CID_TRANSIT bit set. This is OR'ed on the
+ *     CIDs and denotes that the CID is only temporarily owned by a
+ *     task. When the task schedules out it drops the CID back into the
+ *     pool if this bit is set.
  *
  *  2) The initiating context walks the per CPU space or the tasks to fixup
- *     or drop the CIDs and after completion it clears mm:mm_cid.transit.
- *     After that point the CIDs are strictly task or CPU owned again.
+ *     or drop the CIDs and after completion it clears MM_CID_TRANSIT in
+ *     mm:mm_cid::mode. After that point the CIDs are strictly task or CPU
+ *     owned again.
  *
  * This two phase transition is required to prevent CID space exhaustion
  * during the transition as a direct transfer of ownership would fail:
@@ -10411,6 +10420,7 @@ static inline unsigned int mm_cid_calc_pcpu_thrs(stru=
ct mm_mm_cid *mc)
 static bool mm_update_max_cids(struct mm_struct *mm)
 {
 	struct mm_mm_cid *mc =3D &mm->mm_cid;
+	bool percpu =3D cid_on_cpu(mc->mode);
=20
 	lockdep_assert_held(&mm->mm_cid.lock);
=20
@@ -10419,7 +10429,7 @@ static bool mm_update_max_cids(struct mm_struct *mm)
 	__mm_update_max_cids(mc);
=20
 	/* Check whether owner mode must be changed */
-	if (!mc->percpu) {
+	if (!percpu) {
 		/* Enable per CPU mode when the number of users is above max_cids */
 		if (mc->users > mc->max_cids)
 			mc->pcpu_thrs =3D mm_cid_calc_pcpu_thrs(mc);
@@ -10430,12 +10440,17 @@ static bool mm_update_max_cids(struct mm_struct *mm)
 	}
=20
 	/* Mode change required? */
-	if (!!mc->percpu =3D=3D !!mc->pcpu_thrs)
+	if (percpu =3D=3D !!mc->pcpu_thrs)
 		return false;
=20
-	/* Set the transition flag to bridge the transfer */
-	WRITE_ONCE(mc->transit, MM_CID_TRANSIT);
-	WRITE_ONCE(mc->percpu, !!mc->pcpu_thrs);
+	/* Flip the mode and set the transition flag to bridge the transfer */
+	WRITE_ONCE(mc->mode, mc->mode ^ (MM_CID_TRANSIT | MM_CID_ONCPU));
+	/*
+	 * Order the store against the subsequent fixups so that
+	 * acquire(rq::lock) cannot be reordered by the CPU before the
+	 * store.
+	 */
+	smp_mb();
 	return true;
 }
=20
@@ -10460,7 +10475,7 @@ static inline void mm_update_cpus_allowed(struct mm_s=
truct *mm, const struct cpu
=20
 	WRITE_ONCE(mc->nr_cpus_allowed, weight);
 	__mm_update_max_cids(mc);
-	if (!mc->percpu)
+	if (!cid_on_cpu(mc->mode))
 		return;
=20
 	/* Adjust the threshold to the wider set */
@@ -10478,6 +10493,16 @@ static inline void mm_update_cpus_allowed(struct mm_=
struct *mm, const struct cpu
 	irq_work_queue(&mc->irq_work);
 }
=20
+static inline void mm_cid_complete_transit(struct mm_struct *mm, unsigned in=
t mode)
+{
+	/*
+	 * Ensure that the store removing the TRANSIT bit cannot be
+	 * reordered by the CPU before the fixups have been completed.
+	 */
+	smp_mb();
+	WRITE_ONCE(mm->mm_cid.mode, mode);
+}
+
 static inline void mm_cid_transit_to_task(struct task_struct *t, struct mm_c=
id_pcpu *pcp)
 {
 	if (cid_on_cpu(t->mm_cid.cid)) {
@@ -10521,8 +10546,7 @@ static void mm_cid_fixup_cpus_to_tasks(struct mm_stru=
ct *mm)
 			}
 		}
 	}
-	/* Clear the transition bit */
-	WRITE_ONCE(mm->mm_cid.transit, 0);
+	mm_cid_complete_transit(mm, 0);
 }
=20
 static inline void mm_cid_transit_to_cpu(struct task_struct *t, struct mm_ci=
d_pcpu *pcp)
@@ -10594,8 +10618,7 @@ static void mm_cid_fixup_tasks_to_cpus(void)
 	struct mm_struct *mm =3D current->mm;
=20
 	mm_cid_do_fixup_tasks_to_cpus(mm);
-	/* Clear the transition bit */
-	WRITE_ONCE(mm->mm_cid.transit, 0);
+	mm_cid_complete_transit(mm, MM_CID_ONCPU);
 }
=20
 static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *m=
m)
@@ -10626,13 +10649,13 @@ void sched_mm_cid_fork(struct task_struct *t)
 		}
=20
 		if (!sched_mm_cid_add_user(t, mm)) {
-			if (!mm->mm_cid.percpu)
+			if (!cid_on_cpu(mm->mm_cid.mode))
 				t->mm_cid.cid =3D mm_get_cid(mm);
 			return;
 		}
=20
 		/* Handle the mode change and transfer current's CID */
-		percpu =3D !!mm->mm_cid.percpu;
+		percpu =3D cid_on_cpu(mm->mm_cid.mode);
 		if (!percpu)
 			mm_cid_transit_to_task(current, pcp);
 		else
@@ -10671,7 +10694,7 @@ static bool __sched_mm_cid_exit(struct task_struct *t)
 	 * affinity change increased the number of allowed CPUs and the
 	 * deferred fixup did not run yet.
 	 */
-	if (WARN_ON_ONCE(mm->mm_cid.percpu))
+	if (WARN_ON_ONCE(cid_on_cpu(mm->mm_cid.mode)))
 		return false;
 	/*
 	 * A failed fork(2) cleanup never gets here, so @current must have
@@ -10762,7 +10785,7 @@ static void mm_cid_work_fn(struct work_struct *work)
 		if (!mm_update_max_cids(mm))
 			return;
 		/* Affinity changes can only switch back to task mode */
-		if (WARN_ON_ONCE(mm->mm_cid.percpu))
+		if (WARN_ON_ONCE(cid_on_cpu(mm->mm_cid.mode)))
 			return;
 	}
 	mm_cid_fixup_cpus_to_tasks(mm);
@@ -10783,8 +10806,7 @@ static void mm_cid_irq_work(struct irq_work *work)
 void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 {
 	mm->mm_cid.max_cids =3D 0;
-	mm->mm_cid.percpu =3D 0;
-	mm->mm_cid.transit =3D 0;
+	mm->mm_cid.mode =3D 0;
 	mm->mm_cid.nr_cpus_allowed =3D p->nr_cpus_allowed;
 	mm->mm_cid.users =3D 0;
 	mm->mm_cid.pcpu_thrs =3D 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eff2073..f85fd6b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3816,7 +3816,8 @@ static __always_inline void mm_cid_update_pcpu_cid(stru=
ct mm_struct *mm, unsigne
 	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
 }
=20
-static __always_inline void mm_cid_from_cpu(struct task_struct *t, unsigned =
int cpu_cid)
+static __always_inline void mm_cid_from_cpu(struct task_struct *t, unsigned =
int cpu_cid,
+					    unsigned int mode)
 {
 	unsigned int max_cids, tcid =3D t->mm_cid.cid;
 	struct mm_struct *mm =3D t->mm;
@@ -3842,15 +3843,16 @@ static __always_inline void mm_cid_from_cpu(struct ta=
sk_struct *t, unsigned int=20
 		if (!cid_on_cpu(cpu_cid))
 			cpu_cid =3D cid_to_cpu_cid(mm_get_cid(mm));
=20
-		/* Set the transition mode flag if required */
-		if (READ_ONCE(mm->mm_cid.transit))
+		/* Handle the transition mode flag if required */
+		if (mode & MM_CID_TRANSIT)
 			cpu_cid =3D cpu_cid_to_cid(cpu_cid) | MM_CID_TRANSIT;
 	}
 	mm_cid_update_pcpu_cid(mm, cpu_cid);
 	mm_cid_update_task_cid(t, cpu_cid);
 }
=20
-static __always_inline void mm_cid_from_task(struct task_struct *t, unsigned=
 int cpu_cid)
+static __always_inline void mm_cid_from_task(struct task_struct *t, unsigned=
 int cpu_cid,
+					     unsigned int mode)
 {
 	unsigned int max_cids, tcid =3D t->mm_cid.cid;
 	struct mm_struct *mm =3D t->mm;
@@ -3876,7 +3878,7 @@ static __always_inline void mm_cid_from_task(struct tas=
k_struct *t, unsigned int
 		if (!cid_on_task(tcid))
 			tcid =3D mm_get_cid(mm);
 		/* Set the transition mode flag if required */
-		tcid |=3D READ_ONCE(mm->mm_cid.transit);
+		tcid |=3D mode & MM_CID_TRANSIT;
 	}
 	mm_cid_update_pcpu_cid(mm, tcid);
 	mm_cid_update_task_cid(t, tcid);
@@ -3885,16 +3887,17 @@ static __always_inline void mm_cid_from_task(struct t=
ask_struct *t, unsigned int
 static __always_inline void mm_cid_schedin(struct task_struct *next)
 {
 	struct mm_struct *mm =3D next->mm;
-	unsigned int cpu_cid;
+	unsigned int cpu_cid, mode;
=20
 	if (!next->mm_cid.active)
 		return;
=20
 	cpu_cid =3D __this_cpu_read(mm->mm_cid.pcpu->cid);
-	if (likely(!READ_ONCE(mm->mm_cid.percpu)))
-		mm_cid_from_task(next, cpu_cid);
+	mode =3D READ_ONCE(mm->mm_cid.mode);
+	if (likely(!cid_on_cpu(mode)))
+		mm_cid_from_task(next, cpu_cid, mode);
 	else
-		mm_cid_from_cpu(next, cpu_cid);
+		mm_cid_from_cpu(next, cpu_cid, mode);
 }
=20
 static __always_inline void mm_cid_schedout(struct task_struct *prev)

