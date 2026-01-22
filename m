Return-Path: <linux-tip-commits+bounces-8102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPXWLOf6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:24:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 230FE65358
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAC8C4EF6CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B33ED105;
	Thu, 22 Jan 2026 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9UCrVb1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIF8Exsq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C13E8C5D;
	Thu, 22 Jan 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076966; cv=none; b=JNBfBcxlc0AjHMce9lpbZBJbPngpPGsIGT2PZE0OoiSrjS38BVZgCSgzUG0KYVRpSnjsIa32+2uqaJqz7i/VJHvKE0+8KHBRVOt+o4yNqHeRwkkjt0+jaX/tMyQxvC6al/dqxPp+JxhklPFvwzqwVk0JBHJK4yI0GNZ3CJu+M60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076966; c=relaxed/simple;
	bh=LEqjncZvZEWBroMQ0qMeH0AekP3ZiqKGvddx2Edh8yo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OYwHSqub4LC3YcSS1FfSR25PwO0JH2MUmd/0ECGewwheFbutin4DspbeM8WasqIx8mk6cVR4v2ispRqeCzbuZInPF58NV6mI0J/ZNok2ONRrP5XUZkWWQAHjlynJxfmJnsELiy59wVsVWh2mz4/BFkqtRTH5A45tUCtXlFEY564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9UCrVb1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIF8Exsq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZHShCCEQSXNeWlRkpp/Od1cGz2n8cTK4JlU5YelJMs=;
	b=X9UCrVb1to6YBc1Rqf0LDN9CvWfmIaFqq99jJPhbYvsEDpFOLvLHNwAa2xiuweFvkAA7J1
	PWru6TGQtw0Mmy1UyXnvdQ77cEiG+TOttajygkqxje1w2oyEMampUlfGoD8LlUknXnYa1y
	Faek95aEZsWVLMKHx/WDX0oPjbB7PKj0yFCteCpf+z8XaUgPlNF2KZ7F0KVFnumhTBfh/C
	ZOASVrMVvFNE6CkzA2vDpD978Bc0AXC5bszy6qJ68BxMh6RLA8Z/6+zRIhrUJLOxcWJUp6
	IBEbLoPaJsvxAtGM6/EmSjUAI3gufM31+GaumBYfwk6+VYUZUqw9/BIunQa/ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZHShCCEQSXNeWlRkpp/Od1cGz2n8cTK4JlU5YelJMs=;
	b=RIF8ExsqO5ir/u7VXg8zbdxpIkfi2QWqvQqnawDbDYg7B4e/4+pwiJ1pKW81QT5SgYiY/H
	qTAiTPMpjwUCZTDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] rseq: Implement time slice extension enforcement timer
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.068329497@linutronix.de>
References: <20251215155709.068329497@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696197.510.14200713087604785854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,vger.kernel.org:replyto,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,msgid.link:url,linutronix.de:email,linutronix.de:dkim,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8102-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 230FE65358
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ac3b5c3dc45085b28a10ee730fb2860841f08ef
Gitweb:        https://git.kernel.org/tip/0ac3b5c3dc45085b28a10ee730fb2860841=
f08ef
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:18 +01:00

rseq: Implement time slice extension enforcement timer

If a time slice extension is granted and the reschedule delayed, the kernel
has to ensure that user space cannot abuse the extension and exceed the
maximum granted time.

It was suggested to implement this via the existing hrtick() timer in the
scheduler, but that turned out to be problematic for several reasons:

   1) It creates a dependency on CONFIG_SCHED_HRTICK, which can be disabled
      independently of CONFIG_HIGHRES_TIMERS

   2) HRTICK usage in the scheduler can be runtime disabled or is only used
      for certain aspects of scheduling.

   3) The function is calling into the scheduler code and that might have
      unexpected consequences when this is invoked due to a time slice
      enforcement expiry. Especially when the task managed to clear the
      grant via sched_yield(0).

It would be possible to address #2 and #3 by storing state in the
scheduler, but that is extra complexity and fragility for no value.

Implement a dedicated per CPU hrtimer instead, which is solely used for the
purpose of time slice enforcement.

The timer is armed when an extension was granted right before actually
returning to user mode in rseq_exit_to_user_mode_restart().

It is disarmed, when the task relinquishes the CPU. This is expensive as
the timer is probably the first expiring timer on the CPU, which means it
has to reprogram the hardware. But that's less expensive than going through
a full hrtimer interrupt cycle for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251215155709.068329497@linutronix.de
---
 Documentation/admin-guide/sysctl/kernel.rst |  11 ++-
 include/linux/rseq_entry.h                  |  38 +++--
 include/linux/rseq_types.h                  |   2 +-
 kernel/rseq.c                               | 132 ++++++++++++++++++-
 4 files changed, 170 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admi=
n-guide/sysctl/kernel.rst
index 239da22..b09d18e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1248,6 +1248,17 @@ reboot-cmd (SPARC only)
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
=20
+rseq_slice_extension_nsec
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A task can request to delay its scheduling if it is in a critical section
+via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
+allowed extension in nanoseconds before scheduling of the task is enforced.
+Default value is 10000ns (10us). The possible range is 10000ns (10us) to
+50000ns (50us).
+
+This value has a direct correlation to the worst case scheduling latency;
+increment at your own risk.
=20
 sched_energy_aware
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 54d8e33..8d04611 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -87,8 +87,24 @@ static __always_inline bool rseq_slice_extension_enabled(v=
oid)
 {
 	return static_branch_likely(&rseq_slice_extension_key);
 }
+
+extern unsigned int rseq_slice_ext_nsecs;
+bool __rseq_arm_slice_extension_timer(void);
+
+static __always_inline bool rseq_arm_slice_extension_timer(void)
+{
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	if (likely(!current->rseq.slice.state.granted))
+		return false;
+
+	return __rseq_arm_slice_extension_timer();
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
+static inline bool rseq_arm_slice_extension_timer(void) { return false; }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
@@ -543,17 +559,19 @@ static __always_inline void clear_tif_rseq(void) { }
 static __always_inline bool
 rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
 {
-	if (likely(!test_tif_rseq(ti_work)))
-		return false;
-
-	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
-		current->rseq.event.slowpath =3D true;
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
-		return true;
+	if (unlikely(test_tif_rseq(ti_work))) {
+		if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
+			current->rseq.event.slowpath =3D true;
+			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+			return true;
+		}
+		clear_tif_rseq();
 	}
-
-	clear_tif_rseq();
-	return false;
+	/*
+	 * Arm the slice extension timer if nothing to do anymore and the
+	 * task really goes out to user space.
+	 */
+	return rseq_arm_slice_extension_timer();
 }
=20
 #else /* CONFIG_GENERIC_ENTRY */
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 8c540e7..8a2e76c 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -89,10 +89,12 @@ union rseq_slice_state {
 /**
  * struct rseq_slice - Status information for rseq time slice extension
  * @state:	Time slice extension state
+ * @expires:	The time when a grant expires
  * @yielded:	Indicator for rseq_slice_yield()
  */
 struct rseq_slice {
 	union rseq_slice_state	state;
+	u64			expires;
 	u8			yielded;
 };
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 8aa4821..275d701 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -71,6 +71,8 @@
 #define RSEQ_BUILD_SLOW_PATH
=20
 #include <linux/debugfs.h>
+#include <linux/hrtimer.h>
+#include <linux/percpu.h>
 #include <linux/prctl.h>
 #include <linux/ratelimit.h>
 #include <linux/rseq_entry.h>
@@ -500,8 +502,91 @@ efault:
 }
=20
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
+struct slice_timer {
+	struct hrtimer	timer;
+	void		*cookie;
+};
+
+unsigned int rseq_slice_ext_nsecs __read_mostly =3D 10 * NSEC_PER_USEC;
+static DEFINE_PER_CPU(struct slice_timer, slice_timer);
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
=20
+/*
+ * When the timer expires and the task is still in user space, the return
+ * from interrupt will revoke the grant and schedule. If the task already
+ * entered the kernel via a syscall and the timer fires before the syscall
+ * work was able to cancel it, then depending on the preemption model this
+ * will either reschedule on return from interrupt or in the syscall work
+ * below.
+ */
+static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
+{
+	struct slice_timer *st =3D container_of(tmr, struct slice_timer, timer);
+
+	/*
+	 * Validate that the task which armed the timer is still on the
+	 * CPU. It could have been scheduled out without canceling the
+	 * timer.
+	 */
+	if (st->cookie =3D=3D current && current->rseq.slice.state.granted) {
+		rseq_stat_inc(rseq_stats.s_expired);
+		set_need_resched_current();
+	}
+	return HRTIMER_NORESTART;
+}
+
+bool __rseq_arm_slice_extension_timer(void)
+{
+	struct slice_timer *st =3D this_cpu_ptr(&slice_timer);
+	struct task_struct *curr =3D current;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * This check prevents a task, which got a time slice extension
+	 * granted, from exceeding the maximum scheduling latency when the
+	 * grant expired before going out to user space. Don't bother to
+	 * clear the grant here, it will be cleaned up automatically before
+	 * going out to user space after being scheduled back in.
+	 */
+	if ((unlikely(curr->rseq.slice.expires < ktime_get_mono_fast_ns()))) {
+		set_need_resched_current();
+		return true;
+	}
+
+	/*
+	 * Store the task pointer as a cookie for comparison in the timer
+	 * function. This is safe as the timer is CPU local and cannot be
+	 * in the expiry function at this point.
+	 */
+	st->cookie =3D curr;
+	hrtimer_start(&st->timer, curr->rseq.slice.expires, HRTIMER_MODE_ABS_PINNED=
_HARD);
+	/* Arm the syscall entry work */
+	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+	return false;
+}
+
+static void rseq_cancel_slice_extension_timer(void)
+{
+	struct slice_timer *st =3D this_cpu_ptr(&slice_timer);
+
+	/*
+	 * st->cookie can be safely read as preemption is disabled and the
+	 * timer is CPU local.
+	 *
+	 * As this is most probably the first expiring timer, the cancel is
+	 * expensive as it has to reprogram the hardware, but that's less
+	 * expensive than going through a full hrtimer_interrupt() cycle
+	 * for nothing.
+	 *
+	 * hrtimer_try_to_cancel() is sufficient here as the timer is CPU
+	 * local and once the hrtimer code disabled interrupts the timer
+	 * callback cannot be running.
+	 */
+	if (st->cookie =3D=3D current)
+		hrtimer_try_to_cancel(&st->timer);
+}
+
 static inline void rseq_slice_set_need_resched(struct task_struct *curr)
 {
 	/*
@@ -563,11 +648,14 @@ void rseq_syscall_enter_work(long syscall)
 		return;
=20
 	/*
-	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
-	 * kernels. Leaving the scope will reschedule on preemption models
-	 * FULL, LAZY and RT if necessary.
+	 * Required to stabilize the per CPU timer pointer and to make
+	 * set_tsk_need_resched() correct on PREEMPT[RT] kernels.
+	 *
+	 * Leaving the scope will reschedule on preemption models FULL,
+	 * LAZY and RT if necessary.
 	 */
 	scoped_guard(preempt) {
+		rseq_cancel_slice_extension_timer();
 		/*
 		 * Now that preemption is disabled, quickly check whether
 		 * the task was already rescheduled before arriving here.
@@ -665,6 +753,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
 	return yielded;
 }
=20
+#ifdef CONFIG_SYSCTL
+static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USEC;
+
+static const struct ctl_table rseq_slice_ext_sysctl[] =3D {
+	{
+		.procname	=3D "rseq_slice_extension_nsec",
+		.data		=3D &rseq_slice_ext_nsecs,
+		.maxlen		=3D sizeof(unsigned int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D (unsigned int *)&rseq_slice_ext_nsecs_min,
+		.extra2		=3D (unsigned int *)&rseq_slice_ext_nsecs_max,
+	},
+};
+
+static void rseq_slice_sysctl_init(void)
+{
+	if (rseq_slice_extension_enabled())
+		register_sysctl_init("kernel", rseq_slice_ext_sysctl);
+}
+#else /* CONFIG_SYSCTL */
+static inline void rseq_slice_sysctl_init(void) { }
+#endif  /* !CONFIG_SYSCTL */
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
@@ -677,4 +790,17 @@ static int __init rseq_slice_cmdline(char *str)
 	return 1;
 }
 __setup("rseq_slice_ext=3D", rseq_slice_cmdline);
+
+static int __init rseq_slice_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		hrtimer_setup(per_cpu_ptr(&slice_timer.timer, cpu), rseq_slice_expired,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	}
+	rseq_slice_sysctl_init();
+	return 0;
+}
+device_initcall(rseq_slice_init);
 #endif /* CONFIG_RSEQ_SLICE_EXTENSION */

