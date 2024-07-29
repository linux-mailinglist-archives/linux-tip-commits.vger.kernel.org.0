Return-Path: <linux-tip-commits+bounces-1792-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FB693F2CB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1421A2822EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70510144D1E;
	Mon, 29 Jul 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kx6GQhkP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XUZvzKdp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926A2F5A;
	Mon, 29 Jul 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249247; cv=none; b=kOtUzDnLr7qvTQH3rRvaDVCboaoAFqFOLKMayHskMsyE1f7OmRzvACD9aCCyr2H88PHI1szpvADldEqJBNrEAn8yK9Ah4v1tMbKgKOb747ki5ptPN2XbRDfYs6Mpnu3sOkzZbXnmEq5KAAKZrOsKfZzN2zQxF7PeI/pWlCFd/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249247; c=relaxed/simple;
	bh=5qz9fpPxtCZu5WNl2l5a6EqpktBRujJzLwCp9d9hGFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eo/N96anS5PaEAAO0xNAduDF06nsCYKppvg9lGmyj7TNMDgbsVLdH3rfklCPB1mWvZwldx3dVPxfMtTIwNUN/dHcrFBucScdErBwxpNTQY1tZI0ttB7Av9PcjuNCc+VgPtgbJ5+2h+gNHFqW84Wa5Q10WwSTAYUrh5+aORhcZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kx6GQhkP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XUZvzKdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhPTDWt8IQpy/8LPh+Px5qySLzpoG6ZiRvyNjzWxaRQ=;
	b=Kx6GQhkPDLlbXMx1kqVyPUduOw16eR7zNfYXxew3orLALSiKp/lZeugKSH68w1O1aaXpXD
	viyP6zO+l0NyaknObQ7+pkjEO8rrE4op9oFWq9BJ+0BOWLVJwFqF+EFFYJU6X0FTv+lcih
	PSGx4fwBGYHvSRSaieue0vo73oqL8JjQd+2SxBiXU/rtAh5hUkK3zYw6mMr56FDLc1ZWer
	5F9gu+rZsqbQLa68kFeOEDJvmc/42sBIdz6iRBUSEaYpL8vIW9npxUDhsdAQ8wkr46tqkS
	+Q18zY9fs2+YiIX4+W13DpOzrb+uGNvjKp8MR5CVQypjVui+QO/MxK1I3HfSyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhPTDWt8IQpy/8LPh+Px5qySLzpoG6ZiRvyNjzWxaRQ=;
	b=XUZvzKdpSIj4bvRspUhPui6eHmIIqwZNnru+zKI/kiIjT1DeKCqbNNkLNujXepz7+IQcMm
	eaLAUDPcSQ5wpaBw==
From: "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fair server interface
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <a9ef9fc69bcedb44bddc9bc34f2b313296052819.1716811044.git.bristot@kernel.org>
References:
 <a9ef9fc69bcedb44bddc9bc34f2b313296052819.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924353.2215.847554989590119475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d741f297bceaf52aa1b97b997708fc0cd853c73e
Gitweb:        https://git.kernel.org/tip/d741f297bceaf52aa1b97b997708fc0cd853c73e
Author:        Daniel Bristot de Oliveira <bristot@kernel.org>
AuthorDate:    Mon, 27 May 2024 14:06:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:36 +02:00

sched/fair: Fair server interface

Add an interface for fair server setup on debugfs.

Each CPU has two files under /debug/sched/fair_server/cpu{ID}:

 - runtime: set runtime in ns
 - period:  set period in ns

This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to set
bounds on admission control.

The interface also add the server to the dl bandwidth accounting.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/a9ef9fc69bcedb44bddc9bc34f2b313296052819.1716811044.git.bristot@kernel.org
---
 kernel/sched/deadline.c | 103 ++++++++++++++++++++-----
 kernel/sched/debug.c    | 159 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h    |   3 +-
 kernel/sched/topology.c |   8 ++-
 4 files changed, 256 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1b29531..747c0c5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -320,19 +320,12 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
-static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+static void dl_rq_change_utilization(struct rq *rq, struct sched_dl_entity *dl_se, u64 new_bw)
 {
-	struct rq *rq;
-
-	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
-
-	if (task_on_rq_queued(p))
-		return;
+	if (dl_se->dl_non_contending) {
+		sub_running_bw(dl_se, &rq->dl);
+		dl_se->dl_non_contending = 0;
 
-	rq = task_rq(p);
-	if (p->dl.dl_non_contending) {
-		sub_running_bw(&p->dl, &rq->dl);
-		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
 		 * timer cannot be canceled, inactive_task_timer()
@@ -340,13 +333,25 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	}
-	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
+	__sub_rq_bw(dl_se->dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+{
+	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
+
+	if (task_on_rq_queued(p))
+		return;
+
+	dl_rq_change_utilization(task_rq(p), &p->dl, new_bw);
+}
+
 static void __dl_clear_params(struct sched_dl_entity *dl_se);
 
 /*
@@ -1621,11 +1626,17 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	/*
+	 * XXX: the apply do not work fine at the init phase for the
+	 * fair server because things are not yet set. We need to improve
+	 * this before getting generic.
+	 */
 	if (!dl_server(dl_se)) {
 		/* Disabled */
-		dl_se->dl_runtime = 0;
-		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
-		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+		u64 runtime = 0;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
@@ -1660,6 +1671,64 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick = pick;
 }
 
+void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	u64 new_bw = dl_se->dl_bw;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+
+	dl_b = dl_bw_of(cpu_of(rq));
+	guard(raw_spinlock)(&dl_b->lock);
+
+	if (!dl_bw_cpus(cpu))
+		return;
+
+	__dl_add(dl_b, new_bw, dl_bw_cpus(cpu));
+}
+
+int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
+{
+	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	u64 new_bw = to_ratio(period, runtime);
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	unsigned long cap;
+	int retval = 0;
+	int cpus;
+
+	dl_b = dl_bw_of(cpu);
+	guard(raw_spinlock)(&dl_b->lock);
+
+	cpus = dl_bw_cpus(cpu);
+	cap = dl_bw_capacity(cpu);
+
+	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+		return -EBUSY;
+
+	if (init) {
+		__add_rq_bw(new_bw, &rq->dl);
+		__dl_add(dl_b, new_bw, cpus);
+	} else {
+		__dl_sub(dl_b, dl_se->dl_bw, cpus);
+		__dl_add(dl_b, new_bw, cpus);
+
+		dl_rq_change_utilization(rq, dl_se, new_bw);
+	}
+
+	dl_se->dl_runtime = runtime;
+	dl_se->dl_deadline = period;
+	dl_se->dl_period = period;
+
+	dl_se->runtime = 0;
+	dl_se->deadline = 0;
+
+	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
+
+	return retval;
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 90c4a99..72f2715 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,8 +333,165 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+enum dl_param {
+	DL_RUNTIME = 0,
+	DL_PERIOD,
+};
+
+static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+
+static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
+				       size_t cnt, loff_t *ppos, enum dl_param param)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+	u64 runtime, period;
+	size_t err;
+	int retval;
+	u64 value;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
+	if (err)
+		return err;
+
+	scoped_guard (rq_lock_irqsave, rq) {
+		runtime  = rq->fair_server.dl_runtime;
+		period = rq->fair_server.dl_period;
+
+		switch (param) {
+		case DL_RUNTIME:
+			if (runtime == value)
+				break;
+			runtime = value;
+			break;
+		case DL_PERIOD:
+			if (value == period)
+				break;
+			period = value;
+			break;
+		}
+
+		if (runtime > period ||
+		    period > fair_server_period_max ||
+		    period < fair_server_period_min) {
+			return  -EINVAL;
+		}
+
+		if (rq->cfs.h_nr_running) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
+
+		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		if (retval)
+			cnt = retval;
+
+		if (!runtime)
+			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
+					cpu_of(rq));
+
+		if (rq->cfs.h_nr_running)
+			dl_server_start(&rq->fair_server);
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+	u64 value;
+
+	switch (param) {
+	case DL_RUNTIME:
+		value = rq->fair_server.dl_runtime;
+		break;
+	case DL_PERIOD:
+		value = rq->fair_server.dl_period;
+		break;
+	}
+
+	seq_printf(m, "%llu\n", value);
+	return 0;
+
+}
+
+static ssize_t
+sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_runtime_fops = {
+	.open		= sched_fair_server_runtime_open,
+	.write		= sched_fair_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t
+sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+}
+
+static int sched_fair_server_period_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_PERIOD);
+}
+
+static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_period_fops = {
+	.open		= sched_fair_server_period_open,
+	.write		= sched_fair_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
+static void debugfs_fair_server_init(void)
+{
+	struct dentry *d_fair;
+	unsigned long cpu;
+
+	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
+	if (!d_fair)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_fair);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -374,6 +531,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_fair_server_init();
+
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64fb677..b777ac3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,6 +366,9 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
+extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
+extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
+		    u64 runtime, u64 period, bool init);
 
 #ifdef CONFIG_CGROUP_SCHED
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 76504b7..9748a4c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -516,6 +516,14 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
+	/*
+	 * Because the rq is not a task, dl_add_task_root_domain() did not
+	 * move the fair server bw to the rd if it already started.
+	 * Add it now.
+	 */
+	if (rq->fair_server.dl_server)
+		__dl_server_attach_root(&rq->fair_server, rq);
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)

