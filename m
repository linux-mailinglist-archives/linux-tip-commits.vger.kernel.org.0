Return-Path: <linux-tip-commits+bounces-7244-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B59C2FD1C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED24434D080
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF231DD8D;
	Tue,  4 Nov 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XJb7xC7V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCbrlTHE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EE31C562;
	Tue,  4 Nov 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244257; cv=none; b=Dq/eeLNXNa3k/a51qbshj49Z15Y4qx9p/kJSYFCN+8QibVchV8+WZqor7pd79ALR609gJ6mSHdVtjSJHVOOH1ChImOQNPSCxI5xwRuONYMq7kYX53OThqIOiShLOcujkX8rqx7k4N/Fh96BNmyoG6JhuoW7H0KemHmUIrJT7L68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244257; c=relaxed/simple;
	bh=JysRntpvItkvplNJ2DnjypXr/eWdqqNVObFD97s0HiM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mvbZGEr6TXeor2u1dYt/8MsqTWUGJ6N9gU6kXArsxax8FZHrFAbgkCgsUaWxhxCHbwc7IVVthtAIwHYcsVTVAG8mVd0Ra3WCEC6GUfwFsDmtzIMv3Bgr8WzeJWMjhrl0y0QvU03hop5Hr4FDMdfsYr69lPpRv4gQthTFJYSbEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XJb7xC7V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCbrlTHE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGCjsKGUoVj+y1E05r7Gv8QJS4pRQrKQIIMcZhmBOF0=;
	b=XJb7xC7V6Dd6mf9hahBiFnnD+jn9bb2Ez613fmqbctFzIcj8WO/ewgBiuB9Ub/ojp83UYE
	f+NcYt+5BIXhxCpEmRenkNLPaS/ybXgBkhlUgJKNpTpfsCYmky27qsj2OMghLJ1XsqjDb4
	oFmJSK++tF672fEbTQObsowa9QboeuP3Qm7fb8r9sjAvehhLGHvxgH/BBE5ZRjPa/7psGI
	LaKwcTLcoiwhPn/GlgPrnXJGXaS6uE+ITl/bKHVh7u8YEY1owI4OrpvtXDWIrw31/7novd
	Gb+QpX4a7pFx39gFvgBiNZGcFmIPqtmAza6j61yOQmsCiJCIutD+3k9c5yDFxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGCjsKGUoVj+y1E05r7Gv8QJS4pRQrKQIIMcZhmBOF0=;
	b=tCbrlTHEo9UVHXI59F584oy7hHg3IyyVzZvpRe5LRQD57yBuPDBDxJDzNSPcCnYShs7bG/
	OYADnvtBWxWRxsBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Introduce struct rseq_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.527086690@linutronix.de>
References: <20251027084306.527086690@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224425236.2601451.13799532872956042476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     faba9d250eaec7afa248bba71531a08ccc497aab
Gitweb:        https://git.kernel.org/tip/faba9d250eaec7afa248bba71531a08ccc4=
97aab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:50 +01:00

rseq: Introduce struct rseq_data

In preparation for a major rewrite of this code, provide a data structure
for rseq management.

Put all the rseq related data into it (except for the debug part), which
allows to simplify fork/execve by using memset() and memcpy() instead of
adding new fields to initialize over and over.

Create a storage struct for event management as well and put the
sched_switch event and a indicator for RSEQ on a task into it as a
start. That uses a union, which allows to mask and clear the whole lot
efficiently.

The indicators are explicitly not a bit field. Bit fields generate abysmal
code.

The boolean members are defined as u8 as that actually guarantees that it
fits. There seem to be strange architecture ABIs which need more than 8
bits for a boolean.

The has_rseq member is redundant vs. task::rseq, but it turns out that
boolean operations and quick checks on the union generate better code than
fiddling with separate entities and data types.

This struct will be extended over time to carry more information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.527086690@linutronix.de
---
 include/linux/rseq.h       | 48 ++++++++++++----------------
 include/linux/rseq_types.h | 51 ++++++++++++++++++++++++++++++-
 include/linux/sched.h      | 14 +-------
 kernel/ptrace.c            |  6 ++--
 kernel/rseq.c              | 63 ++++++++++++++++++-------------------
 5 files changed, 110 insertions(+), 72 deletions(-)
 create mode 100644 include/linux/rseq_types.h

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index c6267f7..ab91b1e 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -9,22 +9,22 @@ void __rseq_handle_notify_resume(struct ksignal *sig, struc=
t pt_regs *regs);
=20
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq)
+	if (current->rseq.event.has_rseq)
 		__rseq_handle_notify_resume(NULL, regs);
 }
=20
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs)
 {
-	if (current->rseq) {
-		current->rseq_event_pending =3D true;
+	if (current->rseq.event.has_rseq) {
+		current->rseq.event.sched_switch =3D true;
 		__rseq_handle_notify_resume(ksig, regs);
 	}
 }
=20
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
-	if (t->rseq) {
-		t->rseq_event_pending =3D true;
+	if (t->rseq.event.has_rseq) {
+		t->rseq.event.sched_switch =3D true;
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 	}
 }
@@ -32,8 +32,9 @@ static inline void rseq_sched_switch_event(struct task_stru=
ct *t)
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
-			current->rseq_event_pending =3D false;
+		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
+				 current->rseq.event.events))
+			current->rseq.event.events =3D 0;
 	}
 }
=20
@@ -49,35 +50,30 @@ static __always_inline void rseq_exit_to_user_mode(void)
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (current->rseq_event_pending)
+	if (current->rseq.event.sched_switch)
 		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 }
=20
+static inline void rseq_reset(struct task_struct *t)
+{
+	memset(&t->rseq, 0, sizeof(t->rseq));
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	rseq_reset(t);
+}
+
 /*
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
 {
-	if (clone_flags & CLONE_VM) {
-		t->rseq =3D NULL;
-		t->rseq_len =3D 0;
-		t->rseq_sig =3D 0;
-		t->rseq_event_pending =3D false;
-	} else {
+	if (clone_flags & CLONE_VM)
+		rseq_reset(t);
+	else
 		t->rseq =3D current->rseq;
-		t->rseq_len =3D current->rseq_len;
-		t->rseq_sig =3D current->rseq_sig;
-		t->rseq_event_pending =3D current->rseq_event_pending;
-	}
-}
-
-static inline void rseq_execve(struct task_struct *t)
-{
-	t->rseq =3D NULL;
-	t->rseq_len =3D 0;
-	t->rseq_sig =3D 0;
-	t->rseq_event_pending =3D false;
 }
=20
 #else /* CONFIG_RSEQ */
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
new file mode 100644
index 0000000..f7a60c8
--- /dev/null
+++ b/include/linux/rseq_types.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSEQ_TYPES_H
+#define _LINUX_RSEQ_TYPES_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_RSEQ
+struct rseq;
+
+/**
+ * struct rseq_event - Storage for rseq related event management
+ * @all:		Compound to initialize and clear the data efficiently
+ * @events:		Compound to access events with a single load/store
+ * @sched_switch:	True if the task was scheduled out
+ * @has_rseq:		True if the task has a rseq pointer installed
+ */
+struct rseq_event {
+	union {
+		u32				all;
+		struct {
+			union {
+				u16		events;
+				struct {
+					u8	sched_switch;
+				};
+			};
+
+			u8			has_rseq;
+		};
+	};
+};
+
+/**
+ * struct rseq_data - Storage for all rseq related data
+ * @usrptr:	Pointer to the registered user space RSEQ memory
+ * @len:	Length of the RSEQ region
+ * @sig:	Signature of critial section abort IPs
+ * @event:	Storage for event management
+ */
+struct rseq_data {
+	struct rseq __user		*usrptr;
+	u32				len;
+	u32				sig;
+	struct rseq_event		event;
+};
+
+#else /* CONFIG_RSEQ */
+struct rseq_data { };
+#endif /* !CONFIG_RSEQ */
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6627c52..1562776 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -41,6 +41,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
+#include <linux/rseq_types.h>
 #include <uapi/linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
@@ -1406,16 +1407,8 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
=20
-#ifdef CONFIG_RSEQ
-	struct rseq __user		*rseq;
-	u32				rseq_len;
-	u32				rseq_sig;
-	/*
-	 * RmW on rseq_event_pending must be performed atomically
-	 * with respect to preemption.
-	 */
-	bool				rseq_event_pending;
-# ifdef CONFIG_DEBUG_RSEQ
+	struct rseq_data		rseq;
+#ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
 	 * validation of read-only fields. The struct rseq has a
@@ -1423,7 +1416,6 @@ struct task_struct {
 	 * directly. Reserve a size large enough for the known fields.
 	 */
 	char				rseq_fields[sizeof(struct rseq)];
-# endif
 #endif
=20
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75a84ef..392ec2f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -793,9 +793,9 @@ static long ptrace_get_rseq_configuration(struct task_str=
uct *task,
 					  unsigned long size, void __user *data)
 {
 	struct ptrace_rseq_configuration conf =3D {
-		.rseq_abi_pointer =3D (u64)(uintptr_t)task->rseq,
-		.rseq_abi_size =3D task->rseq_len,
-		.signature =3D task->rseq_sig,
+		.rseq_abi_pointer =3D (u64)(uintptr_t)task->rseq.usrptr,
+		.rseq_abi_size =3D task->rseq.len,
+		.signature =3D task->rseq.sig,
 		.flags =3D 0,
 	};
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 81dddaf..aae6266 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -103,13 +103,13 @@ static int rseq_validate_ro_fields(struct task_struct *=
t)
 				      DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	u32 cpu_id_start, cpu_id, node_id, mm_cid;
-	struct rseq __user *rseq =3D t->rseq;
+	struct rseq __user *rseq =3D t->rseq.usrptr;
=20
 	/*
 	 * Validate fields which are required to be read-only by
 	 * user-space.
 	 */
-	if (!user_read_access_begin(rseq, t->rseq_len))
+	if (!user_read_access_begin(rseq, t->rseq.len))
 		goto efault;
 	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
 	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
@@ -147,10 +147,10 @@ efault:
  * Update an rseq field and its in-kernel copy in lock-step to keep a cohere=
nt
  * state.
  */
-#define rseq_unsafe_put_user(t, value, field, error_label)		\
-	do {								\
-		unsafe_put_user(value, &t->rseq->field, error_label);	\
-		rseq_kernel_fields(t)->field =3D value;			\
+#define rseq_unsafe_put_user(t, value, field, error_label)			\
+	do {									\
+		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
+		rseq_kernel_fields(t)->field =3D value;				\
 	} while (0)
=20
 #else
@@ -160,12 +160,12 @@ static int rseq_validate_ro_fields(struct task_struct *=
t)
 }
=20
 #define rseq_unsafe_put_user(t, value, field, error_label)		\
-	unsafe_put_user(value, &t->rseq->field, error_label)
+	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
 #endif
=20
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	struct rseq __user *rseq =3D t->rseq;
+	struct rseq __user *rseq =3D t->rseq.usrptr;
 	u32 cpu_id =3D raw_smp_processor_id();
 	u32 node_id =3D cpu_to_node(cpu_id);
 	u32 mm_cid =3D task_mm_cid(t);
@@ -176,7 +176,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	if (rseq_validate_ro_fields(t))
 		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
-	if (!user_write_access_begin(rseq, t->rseq_len))
+	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
=20
 	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
@@ -201,7 +201,7 @@ efault:
=20
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	struct rseq __user *rseq =3D t->rseq;
+	struct rseq __user *rseq =3D t->rseq.usrptr;
 	u32 cpu_id_start =3D 0, cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED, node_id =3D 0,
 	    mm_cid =3D 0;
=20
@@ -211,7 +211,7 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct=
 *t)
 	if (rseq_validate_ro_fields(t))
 		goto efault;
=20
-	if (!user_write_access_begin(rseq, t->rseq_len))
+	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
=20
 	/*
@@ -272,7 +272,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct=
 rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
=20
-	ret =3D rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	ret =3D rseq_get_rseq_cs_ptr_val(t->rseq.usrptr, &ptr);
 	if (ret)
 		return ret;
=20
@@ -305,10 +305,10 @@ static int rseq_get_rseq_cs(struct task_struct *t, stru=
ct rseq_cs *rseq_cs)
 	if (ret)
 		return ret;
=20
-	if (current->rseq_sig !=3D sig) {
+	if (current->rseq.sig !=3D sig) {
 		printk_ratelimited(KERN_WARNING
 			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x =
(pid=3D%d, addr=3D%p).\n",
-			sig, current->rseq_sig, current->pid, usig);
+			sig, current->rseq.sig, current->pid, usig);
 		return -EINVAL;
 	}
 	return 0;
@@ -338,7 +338,7 @@ static int rseq_check_flags(struct task_struct *t, u32 cs=
_flags)
 		return -EINVAL;
=20
 	/* Get thread flags. */
-	ret =3D get_user(flags, &t->rseq->flags);
+	ret =3D get_user(flags, &t->rseq.usrptr->flags);
 	if (ret)
 		return ret;
=20
@@ -392,13 +392,13 @@ static int rseq_ip_fixup(struct pt_regs *regs, bool abo=
rt)
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t->rseq);
+		return clear_rseq_cs(t->rseq.usrptr);
 	ret =3D rseq_check_flags(t, rseq_cs.flags);
 	if (ret < 0)
 		return ret;
 	if (!abort)
 		return 0;
-	ret =3D clear_rseq_cs(t->rseq);
+	ret =3D clear_rseq_cs(t->rseq.usrptr);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -460,8 +460,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, st=
ruct pt_regs *regs)
 	 * inconsistencies.
 	 */
 	scoped_guard(RSEQ_EVENT_GUARD) {
-		event =3D t->rseq_event_pending;
-		t->rseq_event_pending =3D false;
+		event =3D t->rseq.event.sched_switch;
+		t->rseq.event.sched_switch =3D false;
 	}
=20
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
@@ -492,7 +492,7 @@ void rseq_syscall(struct pt_regs *regs)
 	struct task_struct *t =3D current;
 	struct rseq_cs rseq_cs;
=20
-	if (!t->rseq)
+	if (!t->rseq.usrptr)
 		return;
 	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
 		force_sig(SIGSEGV);
@@ -511,33 +511,31 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
 		/* Unregister rseq for current thread. */
-		if (current->rseq !=3D rseq || !current->rseq)
+		if (current->rseq.usrptr !=3D rseq || !current->rseq.usrptr)
 			return -EINVAL;
-		if (rseq_len !=3D current->rseq_len)
+		if (rseq_len !=3D current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig !=3D sig)
+		if (current->rseq.sig !=3D sig)
 			return -EPERM;
 		ret =3D rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
-		current->rseq =3D NULL;
-		current->rseq_sig =3D 0;
-		current->rseq_len =3D 0;
+		rseq_reset(current);
 		return 0;
 	}
=20
 	if (unlikely(flags))
 		return -EINVAL;
=20
-	if (current->rseq) {
+	if (current->rseq.usrptr) {
 		/*
 		 * If rseq is already registered, check whether
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq !=3D rseq || rseq_len !=3D current->rseq_len)
+		if (current->rseq.usrptr !=3D rseq || rseq_len !=3D current->rseq.len)
 			return -EINVAL;
-		if (current->rseq_sig !=3D sig)
+		if (current->rseq.sig !=3D sig)
 			return -EPERM;
 		/* Already registered. */
 		return -EBUSY;
@@ -586,15 +584,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.
 	 */
-	current->rseq =3D rseq;
-	current->rseq_len =3D rseq_len;
-	current->rseq_sig =3D sig;
+	current->rseq.usrptr =3D rseq;
+	current->rseq.len =3D rseq_len;
+	current->rseq.sig =3D sig;
=20
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
+	current->rseq.event.has_rseq =3D true;
 	rseq_sched_switch_event(current);
=20
 	return 0;

