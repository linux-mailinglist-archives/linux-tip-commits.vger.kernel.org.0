Return-Path: <linux-tip-commits+bounces-7226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC00C2FCCE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFFD3BFDE6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064D31328C;
	Tue,  4 Nov 2025 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKT69y9F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TYHB/Bm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1853128D8;
	Tue,  4 Nov 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244215; cv=none; b=V+TxkI2us6MZtvtWBPiIOf8EVRAhy/ZFIYxxI4SA5kX7l0Y7rP4CLYSl9vcFtDhCaunUTromaBVvOSv813TsB8fXT7pE7+2a8GMh9k0cdo95GIjpHB2rQ8JqdFD/akHU3clHSv7vBtoR9ciE3cU1rgVXhCd+UGB2qwwPGYt61ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244215; c=relaxed/simple;
	bh=m+doUK8sAJL76SlYUcM2csOkkJ7IdikwP+HLXUzxdKY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e1SexdkuXrxWn8pB7Gy3tLMcYT2JEJRGVfnJVPrbCU3Q6n16GvWqqVya0Qy03+xDCyGLPruffLY8Xh7rPbh603bJPYAyLUn5i6IslJ789c3ztwXBte6Fy249g18GOcn/+gAP7s4gM32SOE6nFZQwRMV4SzvQVvD3GRE8oUjymrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKT69y9F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TYHB/Bm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjOyD02Y9YgiTkK8kQ4PChnQYGInkIuRByImYrSK5+Y=;
	b=CKT69y9FwuOzfB4engjPnPiMFTkAyommnCF/5XNso7PO7tQgen7usHVanv9eVVEfyTA21g
	fRIP/P0qVUnMk/wsghYjoekckIY2QOcOVXK0bXTjPdI5qBea6uzoSpMeiN5nJ3ugJyVbV+
	cV6iYI1ldYtVBv6sqduodhxK33V29iGiwkn26F82fFu2V1bn1FOkwKW0KgPHPyQpe2BFkY
	qzY1oQao6d9TTD5rFihbCSirs9qNZleCkDSnvJwUYM1CbXR0ca1do9ijqUf7MwvcpMS1U8
	5Wf5DSusqjKaPKwkizVV4YP/M65M0qgtSI41xG+sG0ALhkmIx+JFz3bZfQRYuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjOyD02Y9YgiTkK8kQ4PChnQYGInkIuRByImYrSK5+Y=;
	b=1TYHB/Bm+uW6BpNVWIf7yXg4uPQfdGr43Eytdws7e2IvsNzGwRiLViMgtBWY3nvWC4fIOv
	k9V1eHbdfFxuQWDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Implement fast path for exit to user
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.638929615@linutronix.de>
References: <20251027084307.638929615@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224420903.2601451.7066249552903983213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     05b44aef709cae5e4274590f050cf35049dcc24e
Gitweb:        https://git.kernel.org/tip/05b44aef709cae5e4274590f050cf35049d=
cc24e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:34:18 +01:00

rseq: Implement fast path for exit to user

Implement the actual logic for handling RSEQ updates in a fast path after
handling the TIF work and at the point where the task is actually returning
to user space.

This is the right point to do that because at this point the CPU and the MM
CID are stable and cannot longer change due to yet another reschedule.
That happens when the task is handling it via TIF_NOTIFY_RESUME in
resume_user_mode_work(), which is invoked from the exit to user mode work
loop.

The function is invoked after the TIF work is handled and runs with
interrupts disabled, which means it cannot resolve page faults. It
therefore disables page faults and in case the access to the user space
memory faults, it:

  - notes the fail in the event struct
  - raises TIF_NOTIFY_RESUME
  - returns false to the caller

The caller has to go back to the TIF work, which runs with interrupts
enabled and therefore can resolve the page faults. This happens mostly on
fork() when the memory is marked COW.

If the user memory inspection finds invalid data, the function returns
false as well and sets the fatal flag in the event struct along with
TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
and terminate the task with SIGSEGV as documented.

The initial decision to invoke any of this is based on one flags in the
event struct: @sched_switch. The decision is in pseudo ASM:

      load	tsk::event::sched_switch
      jnz	inspect_user_space
      mov	$0, tsk::event::events
      ...
      leave

So for the common case where the task was not scheduled out, this really
boils down to three instructions before going out if the compiler is not
completely stupid (and yes, some of them are).

If the condition is true, then it checks, whether CPU ID or MM CID have
changed. If so, then the CPU/MM IDs have to be updated and are thereby
cached for the next round. The update unconditionally retrieves the user
space critical section address to spare another user*begin/end() pair.  If
that's not zero and tsk::event::user_irq is set, then the critical section
is analyzed and acted upon. If either zero or the entry came via syscall
the critical section analysis is skipped.

If the comparison is false then the critical section has to be analyzed
because the event flag is then only true when entry from user was by
interrupt.

This is provided without the actual hookup to let reviewers focus on the
implementation details. The hookup happens in the next step.

Note: As with quite some other optimizations this depends on the generic
entry infrastructure and is not enabled to be sucked into random
architecture implementations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.638929615@linutronix.de
---
 include/linux/rseq_entry.h | 133 +++++++++++++++++++++++++++++++++++-
 include/linux/rseq_types.h |   3 +-
 kernel/rseq.c              |   2 +-
 3 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index aa1c046..3f13be7 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -10,6 +10,7 @@ struct rseq_stats {
 	unsigned long	exit;
 	unsigned long	signal;
 	unsigned long	slowpath;
+	unsigned long	fastpath;
 	unsigned long	ids;
 	unsigned long	cs;
 	unsigned long	clear;
@@ -245,12 +246,13 @@ rseq_update_user_cs(struct task_struct *t, struct pt_re=
gs *regs, unsigned long c
 {
 	struct rseq_cs __user *ucs =3D (struct rseq_cs __user *)(unsigned long)csad=
dr;
 	unsigned long ip =3D instruction_pointer(regs);
+	unsigned long tasksize =3D TASK_SIZE;
 	u64 start_ip, abort_ip, offset;
 	u32 usig, __user *uc_sig;
=20
 	rseq_stat_inc(rseq_stats.cs);
=20
-	if (unlikely(csaddr >=3D TASK_SIZE)) {
+	if (unlikely(csaddr >=3D tasksize)) {
 		t->rseq.event.fatal =3D true;
 		return false;
 	}
@@ -287,7 +289,7 @@ rseq_update_user_cs(struct task_struct *t, struct pt_regs=
 *regs, unsigned long c
 		 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
 		 * protection.
 		 */
-		if (abort_ip >=3D TASK_SIZE || abort_ip < sizeof(*uc_sig))
+		if (unlikely(abort_ip >=3D tasksize || abort_ip < sizeof(*uc_sig)))
 			goto die;
=20
 		/* The address is guaranteed to be >=3D 0 and < TASK_SIZE */
@@ -397,6 +399,128 @@ static rseq_inline bool rseq_update_usr(struct task_str=
uct *t, struct pt_regs *r
 	return rseq_update_user_cs(t, regs, csaddr);
 }
=20
+/*
+ * If you want to use this then convert your architecture to the generic
+ * entry code. I'm tired of building workarounds for people who can't be
+ * bothered to make the maintenance of generic infrastructure less
+ * burdensome. Just sucking everything into the architecture code and
+ * thereby making others chase the horrible hacks and keep them working is
+ * neither acceptable nor sustainable.
+ */
+#ifdef CONFIG_GENERIC_ENTRY
+
+/*
+ * This is inlined into the exit path because:
+ *
+ * 1) It's a one time comparison in the fast path when there is no event to
+ *    handle
+ *
+ * 2) The access to the user space rseq memory (TLS) is unlikely to fault
+ *    so the straight inline operation is:
+ *
+ *	- Four 32-bit stores only if CPU ID/ MM CID need to be updated
+ *	- One 64-bit load to retrieve the critical section address
+ *
+ * 3) In the unlikely case that the critical section address is !=3D NULL:
+ *
+ *     - One 64-bit load to retrieve the start IP
+ *     - One 64-bit load to retrieve the offset for calculating the end
+ *     - One 64-bit load to retrieve the abort IP
+ *     - One 64-bit load to retrieve the signature
+ *     - One store to clear the critical section address
+ *
+ * The non-debug case implements only the minimal required checking. It
+ * provides protection against a rogue abort IP in kernel space, which
+ * would be exploitable at least on x86, and also against a rogue CS
+ * descriptor by checking the signature at the abort IP. Any fallout from
+ * invalid critical section descriptors is a user space problem. The debug
+ * case provides the full set of checks and terminates the task if a
+ * condition is not met.
+ *
+ * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
+ * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
+ * slow path there will handle the failure.
+ */
+static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, stru=
ct task_struct *t)
+{
+	/*
+	 * Page faults need to be disabled as this is called with
+	 * interrupts disabled
+	 */
+	guard(pagefault)();
+	if (likely(!t->rseq.event.ids_changed)) {
+		struct rseq __user *rseq =3D t->rseq.usrptr;
+		/*
+		 * If IDs have not changed rseq_event::user_irq must be true
+		 * See rseq_sched_switch_event().
+		 */
+		u64 csaddr;
+
+		if (unlikely(get_user_inline(csaddr, &rseq->rseq_cs)))
+			return false;
+
+		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
+			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
+				return false;
+		}
+		return true;
+	}
+
+	struct rseq_ids ids =3D {
+		.cpu_id =3D task_cpu(t),
+		.mm_cid =3D task_mm_cid(t),
+	};
+	u32 node_id =3D cpu_to_node(ids.cpu_id);
+
+	return rseq_update_usr(t, regs, &ids, node_id);
+}
+
+static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs =
*regs)
+{
+	struct task_struct *t =3D current;
+
+	/*
+	 * If the task did not go through schedule or got the flag enforced
+	 * by the rseq syscall or execve, then nothing to do here.
+	 *
+	 * CPU ID and MM CID can only change when going through a context
+	 * switch.
+	 *
+	 * rseq_sched_switch_event() sets the rseq_event::sched_switch bit
+	 * only when rseq_event::has_rseq is true. That conditional is
+	 * required to avoid setting the TIF bit if RSEQ is not registered
+	 * for a task. rseq_event::sched_switch is cleared when RSEQ is
+	 * unregistered by a task so it's sufficient to check for the
+	 * sched_switch bit alone.
+	 *
+	 * A sane compiler requires three instructions for the nothing to do
+	 * case including clearing the events, but your mileage might vary.
+	 */
+	if (unlikely((t->rseq.event.sched_switch))) {
+		rseq_stat_inc(rseq_stats.fastpath);
+
+		if (unlikely(!rseq_exit_user_update(regs, t)))
+			return true;
+	}
+	/* Clear state so next entry starts from a clean slate */
+	t->rseq.event.events =3D 0;
+	return false;
+}
+
+static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *r=
egs)
+{
+	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
+		current->rseq.event.slowpath =3D true;
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		return true;
+	}
+	return false;
+}
+
+#else /* CONFIG_GENERIC_ENTRY */
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs) { re=
turn false; }
+#endif /* !CONFIG_GENERIC_ENTRY */
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev =3D &current->rseq.event;
@@ -421,9 +545,12 @@ static inline void rseq_debug_syscall_return(struct pt_r=
egs *regs)
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);
 }
-
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
+static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
+{
+	return false;
+}
 static inline void rseq_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index a1389ff..9c7a341 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -18,6 +18,8 @@ struct rseq;
  * @has_rseq:		True if the task has a rseq pointer installed
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
+ * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
+ *			is required
  *
  * @sched_switch and @ids_changed must be adjacent and the combo must be
  * 16bit aligned to allow a single store, when both are set at the same
@@ -42,6 +44,7 @@ struct rseq_event {
 				u16		error;
 				struct {
 					u8	fatal;
+					u8	slowpath;
 				};
 			};
 		};
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 183dde7..c5d6336 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -133,6 +133,7 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 		stats.exit	+=3D data_race(per_cpu(rseq_stats.exit, cpu));
 		stats.signal	+=3D data_race(per_cpu(rseq_stats.signal, cpu));
 		stats.slowpath	+=3D data_race(per_cpu(rseq_stats.slowpath, cpu));
+		stats.fastpath	+=3D data_race(per_cpu(rseq_stats.fastpath, cpu));
 		stats.ids	+=3D data_race(per_cpu(rseq_stats.ids, cpu));
 		stats.cs	+=3D data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+=3D data_race(per_cpu(rseq_stats.clear, cpu));
@@ -142,6 +143,7 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 	seq_printf(m, "exit:   %16lu\n", stats.exit);
 	seq_printf(m, "signal: %16lu\n", stats.signal);
 	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
+	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
 	seq_printf(m, "ids:    %16lu\n", stats.ids);
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);

