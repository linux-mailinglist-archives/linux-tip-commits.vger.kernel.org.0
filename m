Return-Path: <linux-tip-commits+bounces-7189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8CC2C952
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9B4F0161
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F004314A6C;
	Mon,  3 Nov 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHRFCEsE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oadk/1To"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4553168FC;
	Mon,  3 Nov 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181262; cv=none; b=lVBqWAZzf0E/pOP9pojamm85f6LttXoaa8DAYwAt2dJKsqYespUC+nR+bS3cIUJUsXmMo8GcjdBEGlHZnJ6gNszuX8k/FPQiuoG+bMFOfbxdGC2BSGzIrvWryu6v45MxBc4Bvl3KC6fzWu/vgylMrxMFTqTgLFkE9Dg+k/KGNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181262; c=relaxed/simple;
	bh=A8SbQQu9i8O8huvNy/Sjmi2ftw8/b8P0bUlSCsEhsfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KYuew6BBMJvF0V7WVI/Deuc6gFsFN8Yldtr8oQRtfdrrozxSRUhM4DrJ4FgQVQc112Qtk3kOBsExPEQW3bzT2E9WFOLi/dSaIEt2eMIiaGgMNvht3rQQLC515e2ez5owjJkgQQmgmtPWSyi4gCSIJNVpNf74L76nph66Z5yP1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHRFCEsE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oadk/1To; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB1ddyQyUYt6UDsuGhly/w05rmilT7lFsxl538xBTDU=;
	b=jHRFCEsENB5r8lo9WQt2vpZG22ZSd+Ng6KzWT5Tp31hDXICpeiUouATLi3z6IeHFViAtTe
	Gg74WV7yp6bQIrGFNHGy2BtpPaBu6BqQ3SyguaDgGXTDUOxkJVA7B0uWeMeCKsGoyB5SUL
	LZ/iTun6TcOS8JY9Z+MQUvp8tGLNLoNYwCuI2vGSOSvGkDz4c9aKhdOUpDTZRS0pZkHeUt
	+dgdfMr2gWfu/kAbuDX7VdhH4MVu68PL+AinZEMJhknxuSdfF3aGIWxIZjMxQpnjAKA7DT
	Ny5sPUDMdEfXgV8vi15/x/KfkJ2bAxI7N0BjpqaWzIiOU5vwMLz21uXFfrAGIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB1ddyQyUYt6UDsuGhly/w05rmilT7lFsxl538xBTDU=;
	b=Oadk/1To/B/9LWSK4jK5PhMSfSHPv1ShNXXkMAoVaNQp2BpVnBzGeePbQA7L/0IMz1almc
	uNq9mfn5qELt7uCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Expose lightweight statistics in debugfs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.027916598@linutronix.de>
References: <20251027084307.027916598@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218125744.2601451.3292523379179580428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     5f58b34aae52d285674b5f99f6b1bd42e737e190
Gitweb:        https://git.kernel.org/tip/5f58b34aae52d285674b5f99f6b1bd42e73=
7e190
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:17 +01:00

rseq: Expose lightweight statistics in debugfs

Analyzing the call frequency without actually using tracing is helpful for
analysis of this infrastructure. The overhead is minimal as it just
increments a per CPU counter associated to each operation.

The debugfs readout provides a racy sum of all counters.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.027916598@linutronix.de
---
 include/linux/rseq.h       | 16 +-------
 include/linux/rseq_entry.h | 49 +++++++++++++++++++++++-
 init/Kconfig               | 12 ++++++-
 kernel/rseq.c              | 79 +++++++++++++++++++++++++++++++++----
 4 files changed, 133 insertions(+), 23 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index a200836..7f347c3 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -29,21 +29,6 @@ static inline void rseq_sched_switch_event(struct task_str=
uct *t)
 	}
 }
=20
-static __always_inline void rseq_exit_to_user_mode(void)
-{
-	struct rseq_event *ev =3D &current->rseq.event;
-
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
-		WARN_ON_ONCE(ev->sched_switch);
-
-	/*
-	 * Ensure that event (especially user_irq) is cleared when the
-	 * interrupt did not result in a schedule and therefore the
-	 * rseq processing did not clear it.
-	 */
-	ev->events =3D 0;
-}
-
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
  * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
@@ -92,7 +77,6 @@ static inline void rseq_sched_switch_event(struct task_stru=
ct *t) { }
 static inline void rseq_virt_userspace_exit(void) { }
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
 static inline void rseq_execve(struct task_struct *t) { }
-static inline void rseq_exit_to_user_mode(void) { }
 #endif  /* !CONFIG_RSEQ */
=20
 #ifdef CONFIG_DEBUG_RSEQ
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 5be507a..ff9080b 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -2,6 +2,37 @@
 #ifndef _LINUX_RSEQ_ENTRY_H
 #define _LINUX_RSEQ_ENTRY_H
=20
+/* Must be outside the CONFIG_RSEQ guard to resolve the stubs */
+#ifdef CONFIG_RSEQ_STATS
+#include <linux/percpu.h>
+
+struct rseq_stats {
+	unsigned long	exit;
+	unsigned long	signal;
+	unsigned long	slowpath;
+	unsigned long	ids;
+	unsigned long	cs;
+	unsigned long	clear;
+	unsigned long	fixup;
+};
+
+DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
+
+/*
+ * Slow path has interrupts and preemption enabled, but the fast path
+ * runs with interrupts disabled so there is no point in having the
+ * preemption checks implied in __this_cpu_inc() for every operation.
+ */
+#ifdef RSEQ_BUILD_SLOW_PATH
+#define rseq_stat_inc(which)	this_cpu_inc((which))
+#else
+#define rseq_stat_inc(which)	raw_cpu_inc((which))
+#endif
+
+#else /* CONFIG_RSEQ_STATS */
+#define rseq_stat_inc(x)	do { } while (0)
+#endif /* !CONFIG_RSEQ_STATS */
+
 #ifdef CONFIG_RSEQ
 #include <linux/rseq.h>
=20
@@ -39,8 +70,26 @@ static __always_inline void rseq_note_user_irq_entry(void)
 		current->rseq.event.user_irq =3D true;
 }
=20
+static __always_inline void rseq_exit_to_user_mode(void)
+{
+	struct rseq_event *ev =3D &current->rseq.event;
+
+	rseq_stat_inc(rseq_stats.exit);
+
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+		WARN_ON_ONCE(ev->sched_switch);
+
+	/*
+	 * Ensure that event (especially user_irq) is cleared when the
+	 * interrupt did not result in a schedule and therefore the
+	 * rseq processing did not clear it.
+	 */
+	ev->events =3D 0;
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
+static inline void rseq_exit_to_user_mode(void) { }
 #endif /* !CONFIG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_ENTRY_H */
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad2..f39fdfb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1913,6 +1913,18 @@ config RSEQ
=20
 	  If unsure, say Y.
=20
+config RSEQ_STATS
+	default n
+	bool "Enable lightweight statistics of restartable sequences" if EXPERT
+	depends on RSEQ && DEBUG_FS
+	help
+	  Enable lightweight counters which expose information about the
+	  frequency of RSEQ operations via debugfs. Mostly interesting for
+	  kernel debugging or performance analysis. While lightweight it's
+	  still adding code into the user/kernel mode transitions.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
diff --git a/kernel/rseq.c b/kernel/rseq.c
index f49d311..c0dbe2e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -67,12 +67,16 @@
  *   F1. <failure>
  */
=20
+/* Required to select the proper per_cpu ops for rseq_stats_inc() */
+#define RSEQ_BUILD_SLOW_PATH
+
+#include <linux/debugfs.h>
+#include <linux/ratelimit.h>
+#include <linux/rseq_entry.h>
 #include <linux/sched.h>
-#include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/rseq_entry.h>
+#include <linux/uaccess.h>
 #include <linux/types.h>
-#include <linux/ratelimit.h>
 #include <asm/ptrace.h>
=20
 #define CREATE_TRACE_POINTS
@@ -108,6 +112,56 @@ void __rseq_trace_ip_fixup(unsigned long ip, unsigned lo=
ng start_ip,
 }
 #endif /* CONFIG_TRACEPOINTS */
=20
+#ifdef CONFIG_RSEQ_STATS
+DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
+
+static int rseq_debug_show(struct seq_file *m, void *p)
+{
+	struct rseq_stats stats =3D { };
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		stats.exit	+=3D data_race(per_cpu(rseq_stats.exit, cpu));
+		stats.signal	+=3D data_race(per_cpu(rseq_stats.signal, cpu));
+		stats.slowpath	+=3D data_race(per_cpu(rseq_stats.slowpath, cpu));
+		stats.ids	+=3D data_race(per_cpu(rseq_stats.ids, cpu));
+		stats.cs	+=3D data_race(per_cpu(rseq_stats.cs, cpu));
+		stats.clear	+=3D data_race(per_cpu(rseq_stats.clear, cpu));
+		stats.fixup	+=3D data_race(per_cpu(rseq_stats.fixup, cpu));
+	}
+
+	seq_printf(m, "exit:   %16lu\n", stats.exit);
+	seq_printf(m, "signal: %16lu\n", stats.signal);
+	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
+	seq_printf(m, "ids:    %16lu\n", stats.ids);
+	seq_printf(m, "cs:     %16lu\n", stats.cs);
+	seq_printf(m, "clear:  %16lu\n", stats.clear);
+	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
+	return 0;
+}
+
+static int rseq_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rseq_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_ops =3D {
+	.open		=3D rseq_debug_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int __init rseq_debugfs_init(void)
+{
+	struct dentry *root_dir =3D debugfs_create_dir("rseq", NULL);
+
+	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
+	return 0;
+}
+__initcall(rseq_debugfs_init);
+#endif /* CONFIG_RSEQ_STATS */
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {
@@ -187,12 +241,13 @@ static int rseq_update_cpu_node_id(struct task_struct *=
t)
 	u32 node_id =3D cpu_to_node(cpu_id);
 	u32 mm_cid =3D task_mm_cid(t);
=20
-	/*
-	 * Validate read-only rseq fields.
-	 */
+	rseq_stat_inc(rseq_stats.ids);
+
+	/* Validate read-only rseq fields on debug kernels */
 	if (rseq_validate_ro_fields(t))
 		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
+
 	if (!user_write_access_begin(rseq, t->rseq.len))
 		goto efault;
=20
@@ -403,6 +458,8 @@ static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
 	struct rseq_cs rseq_cs;
 	int ret;
=20
+	rseq_stat_inc(rseq_stats.cs);
+
 	ret =3D rseq_get_rseq_cs(t, &rseq_cs);
 	if (ret)
 		return ret;
@@ -412,8 +469,10 @@ static int rseq_ip_fixup(struct pt_regs *regs, bool abor=
t)
 	 * If not nested over a rseq critical section, restart is useless.
 	 * Clear the rseq_cs pointer and return.
 	 */
-	if (!in_rseq_cs(ip, &rseq_cs))
+	if (!in_rseq_cs(ip, &rseq_cs)) {
+		rseq_stat_inc(rseq_stats.clear);
 		return clear_rseq_cs(t->rseq.usrptr);
+	}
 	ret =3D rseq_check_flags(t, rseq_cs.flags);
 	if (ret < 0)
 		return ret;
@@ -422,6 +481,7 @@ static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
 	ret =3D clear_rseq_cs(t->rseq.usrptr);
 	if (ret)
 		return ret;
+	rseq_stat_inc(rseq_stats.fixup);
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
 			    rseq_cs.abort_ip);
 	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
@@ -462,6 +522,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, s=
truct pt_regs *regs)
 	if (unlikely(t->flags & PF_EXITING))
 		return;
=20
+	if (ksig)
+		rseq_stat_inc(rseq_stats.signal);
+	else
+		rseq_stat_inc(rseq_stats.slowpath);
+
 	/*
 	 * Read and clear the event pending bit first. If the task
 	 * was not preempted or migrated or a signal is on the way,

