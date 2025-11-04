Return-Path: <linux-tip-commits+bounces-7230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59DC2FCEF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F07D420FDA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9953148D8;
	Tue,  4 Nov 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dW0SEutj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oido+Snp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D4311C3B;
	Tue,  4 Nov 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244236; cv=none; b=SfnoV9m/nMIoIo6bTugrpmELvpEICNGFy+BrnE0y0BqjF9uKooH32qoc7vSZb3h4t03I/2egmWfeIY9WjVMFKw3wtX4WdKkgX+sW4FTRStLoJTpJoIHGwBN22b9uJGpApYA6pmVMQihGuxIjJIb92WJxT/myy5oq9h1zG3kcw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244236; c=relaxed/simple;
	bh=tJUz4hB08rr/8E0foI745Dmr3gaBkIrF5vctwc0LwIo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZoHbbblrBu5xPCxHs3UK5xpZwFjmqjG1Fm0DH60cqzoIXAZNdvQRarDdkD/+6/KGMiATTl8VxBlaGTpRl6Ep8sifow43AeRHBZgG3j4YtJe9QBzZrp1DtCoY3iaKImY6A+byTpb4RIRJoUEQ6Io8oe3X3rm4jqKAINhTxXtIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dW0SEutj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oido+Snp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdOBuIvl4a99WwbpjQ2EYsCT/vgJOvpmQ8WiK3MtQiQ=;
	b=dW0SEutjj1pOeDfhddysi746WgzaRY4qtc8R0EpSEMgYG5Ay86PptOqiH9EjbjUTQOUHPJ
	3/Uml+2y1Ye18C7nVNwx8EKI8IMeeS1fnu570fUqpjXzVa05TE8TRni6jbI8m0RM0paHzm
	v1HxwIkAdcl0SaJnXGlkFYHKMU4zw8TmNmhAZXHOXh/qhPhQ4PxOI6hxrtveFpvr5uwNNH
	gO6tCCARPRTPJLLm/8ILk8M1t4j/33WO+tr1KKDxz/x8SEOY1g3M1LPw8jIx/D2tyyyVMg
	mZgOpgKEXZbwykmkTwcgr3/ZCLs+QvYFNKeL+pms1DjCuLnYar61S0oIpB5wHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdOBuIvl4a99WwbpjQ2EYsCT/vgJOvpmQ8WiK3MtQiQ=;
	b=Oido+SnpRynV6HQfZHPARcEwII2betKUX13UTmGpLayk+WWeGcnDedMbKdaF+im+F4lWvN
	xr/B6gE9bfWufLCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Provide and use rseq_set_ids()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.393972266@linutronix.de>
References: <20251027084307.393972266@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224423031.2601451.17976893435825335748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     0f085b41880e3140efa6941ff2b8fd43bac4d659
Gitweb:        https://git.kernel.org/tip/0f085b41880e3140efa6941ff2b8fd43bac=
4d659
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:33:33 +01:00

rseq: Provide and use rseq_set_ids()

Provide a new and straight forward implementation to set the IDs (CPU ID,
Node ID and MM CID), which can be later inlined into the fast path.

It does all operations in one scoped_user_rw_access() section and retrieves
also the critical section member (rseq::cs_rseq) from user space to avoid
another user..begin/end() pair. This is in preparation for optimizing the
fast path to avoid extra work when not required.

On rseq registration set the CPU ID fields to RSEQ_CPU_ID_UNINITIALIZED and
node and MM CID to zero. That's the same as the kernel internal reset
values. That makes the debug validation in the exit code work correctly on
the first exit to user space.

Use it to replace the whole related zoo in rseq.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.393972266@linutronix.de
---
 fs/binfmt_elf.c            |   2 +-
 include/linux/rseq.h       |  16 +-
 include/linux/rseq_entry.h |  89 ++++++++++++++-
 include/linux/sched.h      |  10 +--
 kernel/rseq.c              | 236 +++++++-----------------------------
 5 files changed, 151 insertions(+), 202 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e4653bb..3eb734c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -46,7 +46,7 @@
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
-#include <linux/rseq.h>
+#include <uapi/linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
=20
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 7f347c3..92f9cd4 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -5,6 +5,8 @@
 #ifdef CONFIG_RSEQ
 #include <linux/sched.h>
=20
+#include <uapi/linux/rseq.h>
+
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
=20
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
@@ -48,7 +50,7 @@ static inline void rseq_virt_userspace_exit(void)
 static inline void rseq_reset(struct task_struct *t)
 {
 	memset(&t->rseq, 0, sizeof(t->rseq));
-	t->rseq.ids.cpu_cid =3D ~0ULL;
+	t->rseq.ids.cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED;
 }
=20
 static inline void rseq_execve(struct task_struct *t)
@@ -59,15 +61,19 @@ static inline void rseq_execve(struct task_struct *t)
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
+ *
+ * On fork, keep the IDs (CPU, MMCID) of the parent, which avoids a fault
+ * on the COW page on exit to user space, when the child stays on the same
+ * CPU as the parent. That's obviously not guaranteed, but in overcommit
+ * scenarios it is more likely and optimizes for the fork/exec case without
+ * taking the fault.
  */
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
 {
-	if (clone_flags & CLONE_VM) {
+	if (clone_flags & CLONE_VM)
 		rseq_reset(t);
-	} else {
+	else
 		t->rseq =3D current->rseq;
-		t->rseq.ids.cpu_cid =3D ~0ULL;
-	}
 }
=20
 #else /* CONFIG_RSEQ */
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index fb53a6f..37444e8 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -75,6 +75,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, =
rseq_debug_enabled);
 #endif
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
+bool rseq_debug_validate_ids(struct task_struct *t);
=20
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -194,6 +195,43 @@ efault:
 	return false;
 }
=20
+/*
+ * On debug kernels validate that user space did not mess with it if the
+ * debug branch is enabled.
+ */
+bool rseq_debug_validate_ids(struct task_struct *t)
+{
+	struct rseq __user *rseq =3D t->rseq.usrptr;
+	u32 cpu_id, uval, node_id;
+
+	/*
+	 * On the first exit after registering the rseq region CPU ID is
+	 * RSEQ_CPU_ID_UNINITIALIZED and node_id in user space is 0!
+	 */
+	node_id =3D t->rseq.ids.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED ?
+		  cpu_to_node(t->rseq.ids.cpu_id) : 0;
+
+	scoped_user_read_access(rseq, efault) {
+		unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
+		if (cpu_id !=3D t->rseq.ids.cpu_id)
+			goto die;
+		unsafe_get_user(uval, &rseq->cpu_id, efault);
+		if (uval !=3D cpu_id)
+			goto die;
+		unsafe_get_user(uval, &rseq->node_id, efault);
+		if (uval !=3D node_id)
+			goto die;
+		unsafe_get_user(uval, &rseq->mm_cid, efault);
+		if (uval !=3D t->rseq.ids.mm_cid)
+			goto die;
+	}
+	return true;
+die:
+	t->rseq.event.fatal =3D true;
+efault:
+	return false;
+}
+
 #endif /* RSEQ_BUILD_SLOW_PATH */
=20
 /*
@@ -279,6 +317,57 @@ efault:
 	return false;
 }
=20
+/*
+ * Updates CPU ID, Node ID and MM CID and reads the critical section
+ * address, when @csaddr !=3D NULL. This allows to put the ID update and the
+ * read under the same uaccess region to spare a separate begin/end.
+ *
+ * As this is either invoked from a C wrapper with @csaddr =3D NULL or from
+ * the fast path code with a valid pointer, a clever compiler should be
+ * able to optimize the read out. Spares a duplicate implementation.
+ *
+ * Returns true, if the operation was successful, false otherwise.
+ *
+ * In the failure case task::rseq_event::fatal is set when invalid data
+ * was found on debug kernels. It's clear when the failure was an unresolved=
 page
+ * fault.
+ *
+ * If inlined into the exit to user path with interrupts disabled, the
+ * caller has to protect against page faults with pagefault_disable().
+ *
+ * In preemptible task context this would be counterproductive as the page
+ * faults could not be fully resolved. As a consequence unresolved page
+ * faults in task context are fatal too.
+ */
+static rseq_inline
+bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
+			     u32 node_id, u64 *csaddr)
+{
+	struct rseq __user *rseq =3D t->rseq.usrptr;
+
+	if (static_branch_unlikely(&rseq_debug_enabled)) {
+		if (!rseq_debug_validate_ids(t))
+			return false;
+	}
+
+	scoped_user_rw_access(rseq, efault) {
+		unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
+		unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
+		unsafe_put_user(node_id, &rseq->node_id, efault);
+		unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
+		if (csaddr)
+			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+	}
+
+	/* Cache the new values */
+	t->rseq.ids.cpu_cid =3D ids->cpu_cid;
+	rseq_stat_inc(rseq_stats.ids);
+	rseq_trace_update(t, ids);
+	return true;
+efault:
+	return false;
+}
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev =3D &current->rseq.event;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 24a9da7..e47abc8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -42,7 +42,6 @@
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
 #include <linux/rseq_types.h>
-#include <uapi/linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
@@ -1408,15 +1407,6 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
=20
 	struct rseq_data		rseq;
-#ifdef CONFIG_DEBUG_RSEQ
-	/*
-	 * This is a place holder to save a copy of the rseq fields for
-	 * validation of read-only fields. The struct rseq has a
-	 * variable-length array at the end, so it cannot be used
-	 * directly. Reserve a size large enough for the known fields.
-	 */
-	char				rseq_fields[sizeof(struct rseq)];
-#endif
=20
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9763155..1e4f1d2 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -88,13 +88,6 @@
 # define RSEQ_EVENT_GUARD	preempt
 #endif
=20
-/* The original rseq structure size (including padding) is 32 bytes. */
-#define ORIG_RSEQ_SIZE		32
-
-#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
-				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
-				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
-
 DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled=
);
=20
 static inline void rseq_control_debug(bool on)
@@ -227,159 +220,9 @@ static int __init rseq_debugfs_init(void)
 __initcall(rseq_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
=20
-#ifdef CONFIG_DEBUG_RSEQ
-static struct rseq *rseq_kernel_fields(struct task_struct *t)
-{
-	return (struct rseq *) t->rseq_fields;
-}
-
-static int rseq_validate_ro_fields(struct task_struct *t)
-{
-	static DEFINE_RATELIMIT_STATE(_rs,
-				      DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
-	u32 cpu_id_start, cpu_id, node_id, mm_cid;
-	struct rseq __user *rseq =3D t->rseq.usrptr;
-
-	/*
-	 * Validate fields which are required to be read-only by
-	 * user-space.
-	 */
-	if (!user_read_access_begin(rseq, t->rseq.len))
-		goto efault;
-	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
-	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
-	unsafe_get_user(node_id, &rseq->node_id, efault_end);
-	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
-	user_read_access_end();
-
-	if ((cpu_id_start !=3D rseq_kernel_fields(t)->cpu_id_start ||
-	    cpu_id !=3D rseq_kernel_fields(t)->cpu_id ||
-	    node_id !=3D rseq_kernel_fields(t)->node_id ||
-	    mm_cid !=3D rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
-
-		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
-			"\tcpu_id_start: %u ?=3D %u\n"
-			"\tcpu_id:       %u ?=3D %u\n"
-			"\tnode_id:      %u ?=3D %u\n"
-			"\tmm_cid:       %u ?=3D %u\n",
-			t->pid, t->comm,
-			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
-			cpu_id, rseq_kernel_fields(t)->cpu_id,
-			node_id, rseq_kernel_fields(t)->node_id,
-			mm_cid, rseq_kernel_fields(t)->mm_cid);
-	}
-
-	/* For now, only print a console warning on mismatch. */
-	return 0;
-
-efault_end:
-	user_read_access_end();
-efault:
-	return -EFAULT;
-}
-
-/*
- * Update an rseq field and its in-kernel copy in lock-step to keep a cohere=
nt
- * state.
- */
-#define rseq_unsafe_put_user(t, value, field, error_label)			\
-	do {									\
-		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
-		rseq_kernel_fields(t)->field =3D value;				\
-	} while (0)
-
-#else
-static int rseq_validate_ro_fields(struct task_struct *t)
-{
-	return 0;
-}
-
-#define rseq_unsafe_put_user(t, value, field, error_label)		\
-	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
-#endif
-
-static int rseq_update_cpu_node_id(struct task_struct *t)
-{
-	struct rseq __user *rseq =3D t->rseq.usrptr;
-	u32 cpu_id =3D raw_smp_processor_id();
-	u32 node_id =3D cpu_to_node(cpu_id);
-	u32 mm_cid =3D task_mm_cid(t);
-
-	rseq_stat_inc(rseq_stats.ids);
-
-	/* Validate read-only rseq fields on debug kernels */
-	if (rseq_validate_ro_fields(t))
-		goto efault;
-	WARN_ON_ONCE((int) mm_cid < 0);
-
-	if (!user_write_access_begin(rseq, t->rseq.len))
-		goto efault;
-
-	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
-	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
-	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
-	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
-
-	/* Cache the user space values */
-	t->rseq.ids.cpu_id =3D cpu_id;
-	t->rseq.ids.mm_cid =3D mm_cid;
-
-	/*
-	 * Additional feature fields added after ORIG_RSEQ_SIZE
-	 * need to be conditionally updated only if
-	 * t->rseq_len !=3D ORIG_RSEQ_SIZE.
-	 */
-	user_write_access_end();
-	trace_rseq_update(t);
-	return 0;
-
-efault_end:
-	user_write_access_end();
-efault:
-	return -EFAULT;
-}
-
-static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
+static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 no=
de_id)
 {
-	struct rseq __user *rseq =3D t->rseq.usrptr;
-	u32 cpu_id_start =3D 0, cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED, node_id =3D 0,
-	    mm_cid =3D 0;
-
-	/*
-	 * Validate read-only rseq fields.
-	 */
-	if (rseq_validate_ro_fields(t))
-		goto efault;
-
-	if (!user_write_access_begin(rseq, t->rseq.len))
-		goto efault;
-
-	/*
-	 * Reset all fields to their initial state.
-	 *
-	 * All fields have an initial state of 0 except cpu_id which is set to
-	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
-	 * unregistration can figure out that rseq needs to be registered
-	 * again.
-	 */
-	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
-	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
-	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
-	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
-
-	/*
-	 * Additional feature fields added after ORIG_RSEQ_SIZE
-	 * need to be conditionally reset only if
-	 * t->rseq_len !=3D ORIG_RSEQ_SIZE.
-	 */
-	user_write_access_end();
-	return 0;
-
-efault_end:
-	user_write_access_end();
-efault:
-	return -EFAULT;
+	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
 }
=20
 static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
@@ -410,6 +253,8 @@ efault:
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t =3D current;
+	struct rseq_ids ids;
+	u32 node_id;
 	bool event;
 	int sig;
=20
@@ -456,6 +301,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, st=
ruct pt_regs *regs)
 	scoped_guard(RSEQ_EVENT_GUARD) {
 		event =3D t->rseq.event.sched_switch;
 		t->rseq.event.sched_switch =3D false;
+		ids.cpu_id =3D task_cpu(t);
+		ids.mm_cid =3D task_mm_cid(t);
 	}
=20
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
@@ -464,7 +311,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, st=
ruct pt_regs *regs)
 	if (!rseq_handle_cs(t, regs))
 		goto error;
=20
-	if (unlikely(rseq_update_cpu_node_id(t)))
+	node_id =3D cpu_to_node(ids.cpu_id);
+	if (!rseq_set_ids(t, &ids, node_id))
 		goto error;
 	return;
=20
@@ -504,13 +352,33 @@ void rseq_syscall(struct pt_regs *regs)
 }
 #endif
=20
+static bool rseq_reset_ids(void)
+{
+	struct rseq_ids ids =3D {
+		.cpu_id		=3D RSEQ_CPU_ID_UNINITIALIZED,
+		.mm_cid		=3D 0,
+	};
+
+	/*
+	 * If this fails, terminate it because this leaves the kernel in
+	 * stupid state as exit to user space will try to fixup the ids
+	 * again.
+	 */
+	if (rseq_set_ids(current, &ids, 0))
+		return true;
+
+	force_sig(SIGSEGV);
+	return false;
+}
+
+/* The original rseq structure size (including padding) is 32 bytes. */
+#define ORIG_RSEQ_SIZE		32
+
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
-	int ret;
-
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
@@ -521,9 +389,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 			return -EINVAL;
 		if (current->rseq.sig !=3D sig)
 			return -EPERM;
-		ret =3D rseq_reset_rseq_cpu_node_id(current);
-		if (ret)
-			return ret;
+		if (!rseq_reset_ids())
+			return -EFAULT;
 		rseq_reset(current);
 		return 0;
 	}
@@ -563,27 +430,22 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
=20
-	/*
-	 * If the rseq_cs pointer is non-NULL on registration, clear it to
-	 * avoid a potential segfault on return to user-space. The proper thing
-	 * to do would have been to fail the registration but this would break
-	 * older libcs that reuse the rseq area for new threads without
-	 * clearing the fields. Don't bother reading it, just reset it.
-	 */
-	if (put_user(0UL, &rseq->rseq_cs))
-		return -EFAULT;
+	scoped_user_write_access(rseq, efault) {
+		/*
+		 * If the rseq_cs pointer is non-NULL on registration, clear it to
+		 * avoid a potential segfault on return to user-space. The proper thing
+		 * to do would have been to fail the registration but this would break
+		 * older libcs that reuse the rseq area for new threads without
+		 * clearing the fields. Don't bother reading it, just reset it.
+		 */
+		unsafe_put_user(0UL, &rseq->rseq_cs, efault);
+		/* Initialize IDs in user space */
+		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id_start, efault);
+		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
+		unsafe_put_user(0U, &rseq->node_id, efault);
+		unsafe_put_user(0U, &rseq->mm_cid, efault);
+	}
=20
-#ifdef CONFIG_DEBUG_RSEQ
-	/*
-	 * Initialize the in-kernel rseq fields copy for validation of
-	 * read-only fields.
-	 */
-	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start=
) ||
-	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
-	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
-	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
-		return -EFAULT;
-#endif
 	/*
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.
@@ -599,6 +461,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 	 */
 	current->rseq.event.has_rseq =3D true;
 	rseq_sched_switch_event(current);
-
 	return 0;
+
+efault:
+	return -EFAULT;
 }

