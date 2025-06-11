Return-Path: <linux-tip-commits+bounces-5763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8DAD4FC8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B6D189FAA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE802620C6;
	Wed, 11 Jun 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTRnYRpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRofqjtB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF12609C2;
	Wed, 11 Jun 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634199; cv=none; b=iayhFOa5WgxSXa8FS/eJxSc3Qa+Tu4r4Ci0y2Dd0wD9N1UXSqUvMhN3ayn8IZ1iSBPHi3Tq3D6JxhiW+YFjsHGhCYaHHPlzXEfFsS2AqaVPNNnYquinqS1l7UP4I+IFSA26ocDXFwzKSM5a2ydigK6Y1L+7twTO0GR9kzn1PBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634199; c=relaxed/simple;
	bh=oJ72dR1s0z8kyrUXCO6WcfbYkzOQSiRCywrVG0PsnJE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vx3DPL7ioCam467wLMLZU2gMTqi8vEFgZFN+8yI0CNm80/K0rbrMM1VX1izAvRTE1tJQT+3C6Qrc1JsMuXg3ZhLNolBcR14QCqcPNFT4XYjQ5umeiHnVnQykfVUL70qzv5VP/Yc3X/Hphzd57nTYvMVg55Eguf6FqKL6L/AxjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTRnYRpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IRofqjtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ubBetirWuzNlWZsvp41TYR3tDxq4sYiDWGtbk47Zk=;
	b=wTRnYRpfbDe/7l/l2JW1KwSP0cQGJJECPREGvKd7oZ6g3Mn/SrvYlyEIBB5KKUkOCqWfDk
	Mbf01xsHbtZvePUilpPumFviSr+WXJiU3DBqAD7BbHBLKKKvCPMJLXuGMVf9D/B6KmiHCc
	j9zxTN8js4fe3gZo5lWqadjEMdYyUNMJwtX8l9Klu455msiUGLcNeOrcSSpEaYqtFAUP9x
	qXwBQ2uItB60fuQ2Z5Eq6HohI5LrrzxaAkn0hvvnohbkQ3cznyNufXERveg5LwkOhNe4lG
	+QYwQSMdnmuBilsthShRmVKqHYhaAgQLDVBEpR1+A27JUsmZedx1v2CbASQUug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ubBetirWuzNlWZsvp41TYR3tDxq4sYiDWGtbk47Zk=;
	b=IRofqjtBKAIqHnCEWZZegW9YNAR0Ta3zbMLEgZfQ5J9Jaxbb2YwMceR54k/UqhQ93gK9ZT
	BwWBGYYMdCJkp+AQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make clangd usable
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963419485.406.884452610882068130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3d7e10188ae0b68dadd60f611ca81ecf9d991f77
Gitweb:        https://git.kernel.org/tip/3d7e10188ae0b68dadd60f611ca81ecf9d991f77
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 23 May 2025 18:26:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:53 +02:00

sched: Make clangd usable

Due to the weird Makefile setup of sched the various files do not
compile as stand alone units. The new generation of editors are trying
to do just this -- mostly to offer fancy things like completions but
also better syntax highlighting and code navigation.

Specifically, I've been playing around with neovim and clangd.

Setting up clangd on the kernel source is a giant pain in the arse
(this really should be improved), but once you do manage, you run into
dumb stuff like the above.

Fix up the scheduler files to at least pretend to work.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20250523164348.GN39944@noisy.programming.kicks-ass.net
---
 kernel/sched/autogroup.c         | 3 +++
 kernel/sched/autogroup.h         | 2 ++
 kernel/sched/clock.c             | 3 +++
 kernel/sched/completion.c        | 5 +++++
 kernel/sched/core_sched.c        | 2 ++
 kernel/sched/cpuacct.c           | 2 ++
 kernel/sched/cpudeadline.c       | 1 +
 kernel/sched/cpudeadline.h       | 2 ++
 kernel/sched/cpufreq.c           | 1 +
 kernel/sched/cpufreq_schedutil.c | 2 ++
 kernel/sched/cpupri.c            | 1 +
 kernel/sched/cpupri.h            | 3 +++
 kernel/sched/cputime.c           | 3 +++
 kernel/sched/deadline.c          | 4 ++++
 kernel/sched/debug.c             | 3 +++
 kernel/sched/idle.c              | 5 +++++
 kernel/sched/isolation.c         | 2 ++
 kernel/sched/loadavg.c           | 2 ++
 kernel/sched/membarrier.c        | 2 ++
 kernel/sched/pelt.c              | 1 +
 kernel/sched/pelt.h              | 7 ++++++-
 kernel/sched/psi.c               | 4 ++++
 kernel/sched/rt.c                | 3 +++
 kernel/sched/sched-pelt.h        | 1 +
 kernel/sched/sched.h             | 1 +
 kernel/sched/smp.h               | 7 +++++++
 kernel/sched/stats.c             | 1 +
 kernel/sched/stop_task.c         | 1 +
 kernel/sched/swait.c             | 1 +
 kernel/sched/topology.c          | 2 ++
 kernel/sched/wait.c              | 1 +
 kernel/sched/wait_bit.c          | 3 +++
 32 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2b33182..e96a167 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -4,6 +4,9 @@
  * Auto-group scheduling implementation:
  */
 
+#include "autogroup.h"
+#include "sched.h"
+
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
 static atomic_t autogroup_seq_nr;
diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index 90d69f2..5c1796a 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -2,6 +2,8 @@
 #ifndef _KERNEL_SCHED_AUTOGROUP_H
 #define _KERNEL_SCHED_AUTOGROUP_H
 
+#include "sched.h"
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 
 struct autogroup {
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index a09655b..e62b551 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -54,6 +54,9 @@
  *
  */
 
+#include <linux/sched/clock.h>
+#include "sched.h"
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  * This is default implementation.
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab5..19ee702 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -13,6 +13,11 @@
  * Waiting for completion is a typically sync point, but not an exclusion point.
  */
 
+#include <linux/linkage.h>
+#include <linux/sched/debug.h>
+#include <linux/completion.h>
+#include "sched.h"
+
 static void complete_with_flags(struct completion *x, int wake_flags)
 {
 	unsigned long flags;
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index c4606ca..9ede71e 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -4,6 +4,8 @@
  * A simple wrapper around refcount. An allocated sched_core_cookie's
  * address is used to compute the cookie of the task.
  */
+#include "sched.h"
+
 struct sched_core_cookie {
 	refcount_t refcnt;
 };
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda..23a56ba 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -6,6 +6,8 @@
  * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
  * (balbir@in.ibm.com).
  */
+#include <linux/sched/cputime.h>
+#include "sched.h"
 
 /* Time spent by the tasks of the CPU accounting group executing in ... */
 enum cpuacct_stat_index {
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 95baa12..cdd740b 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -6,6 +6,7 @@
  *
  *  Author: Juri Lelli <j.lelli@sssup.it>
  */
+#include "sched.h"
 
 static inline int parent(int i)
 {
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 0adeda9..3f7c73d 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/spinlock.h>
 
 #define IDX_INVALID		-1
 
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 5252fb1..742fb9e 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+#include "sched.h"
 
 DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 461242e..3d7e9cc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+#include <uapi/linux/sched/types.h>
+#include "sched.h"
 
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 42c40cf..76a9ac5 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -22,6 +22,7 @@
  *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
+#include "sched.h"
 
 /*
  * p->rt_priority   p->prio   newpri   cpupri
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index d6cba00..f0f5a73 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/sched/rt.h>
 
 #define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO+1)
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 6dab485..f01f17a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,9 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/cputime.h>
+#include <linux/tsacct_kern.h>
+#include "sched.h"
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
  #include <asm/cputime.h>
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ad45a8f..ff5be80 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,10 @@
  */
 
 #include <linux/cpuset.h>
+#include <linux/sched/clock.h>
+#include <uapi/linux/sched/types.h>
+#include "sched.h"
+#include "pelt.h"
 
 /*
  * Default limits for DL period; on the top end we guard against small util
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9d71baf..b384124 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -6,6 +6,9 @@
  *
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
+#include <linux/debugfs.h>
+#include <linux/nmi.h>
+#include "sched.h"
 
 /*
  * This allows printing both to /sys/kernel/debug/sched/debug and
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 2c85c86..cd32986 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -6,6 +6,11 @@
  * (NOTE: these are not related to SCHED_IDLE batch scheduled
  *        tasks which are handled in sched/fair.c )
  */
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <linux/livepatch.h>
+#include "sched.h"
+#include "smp.h"
 
 /* Linker adds these: start and end of __cpuidle functions */
 extern char __cpuidle_text_start[], __cpuidle_text_end[];
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 93b038d..a4cf17b 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2017-2018 SUSE, Frederic Weisbecker
  *
  */
+#include <linux/sched/isolation.h>
+#include "sched.h"
 
 enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b..f6df84c 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -6,6 +6,8 @@
  * figure. Its a silly number but people think its important. We go through
  * great pains to make it work on big machines and tickless kernels.
  */
+#include <linux/sched/nohz.h>
+#include "sched.h"
 
 /*
  * Global load-average calculations
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 809194c..62fba83 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -4,6 +4,8 @@
  *
  * membarrier system call
  */
+#include <uapi/linux/membarrier.h>
+#include "sched.h"
 
 /*
  * For documentation purposes, here are some membarrier ordering
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 7a8534a..09be6a8 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -23,6 +23,7 @@
  *  Move PELT related code from fair.c into this pelt.c file
  *  Author: Vincent Guittot <vincent.guittot@linaro.org>
  */
+#include "pelt.h"
 
 /*
  * Approximate:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index f4f6a08..1959207 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _KERNEL_SCHED_PELT_H
+#define _KERNEL_SCHED_PELT_H
+#include "sched.h"
+
 #ifdef CONFIG_SMP
 #include "sched-pelt.h"
 
@@ -233,4 +238,4 @@ update_idle_rq_clock_pelt(struct rq *rq) { }
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
-
+#endif /* _KERNEL_SCHED_PELT_H */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ad04a5c..333a7ba 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -136,6 +136,10 @@
  * cost-wise, yet way more sensitive and accurate than periodic
  * sampling of the aggregate task states would be.
  */
+#include <linux/sched/clock.h>
+#include <linux/workqueue.h>
+#include <linux/psi.h>
+#include "sched.h"
 
 static int psi_bug __read_mostly;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c..16008ac 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -4,6 +4,9 @@
  * policies)
  */
 
+#include "sched.h"
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
diff --git a/kernel/sched/sched-pelt.h b/kernel/sched/sched-pelt.h
index c529706..6803cfe 100644
--- a/kernel/sched/sched-pelt.h
+++ b/kernel/sched/sched-pelt.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by Documentation/scheduler/sched-pelt; do not modify. */
+#include <linux/types.h>
 
 static const u32 runnable_avg_yN_inv[] __maybe_unused = {
 	0xffffffff, 0xfa83b2da, 0xf5257d14, 0xefe4b99a, 0xeac0c6e6, 0xe5b906e6,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb59..f3a4148 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -69,6 +69,7 @@
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
 #include <linux/delayacct.h>
+#include <linux/mmu_context.h>
 
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 21ac444..7f151d9 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -1,8 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_SCHED_SMP_H
+#define _KERNEL_SCHED_SMP_H
+
 /*
  * Scheduler internal SMP callback types and methods between the scheduler
  * and other internal parts of the core kernel:
  */
+#include <linux/types.h>
 
 extern void sched_ttwu_pending(void *arg);
 
@@ -13,3 +18,5 @@ extern void flush_smp_call_function_queue(void);
 #else
 static inline void flush_smp_call_function_queue(void) { }
 #endif
+
+#endif /* _KERNEL_SCHED_SMP_H */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 4346fd8..1faea87 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -2,6 +2,7 @@
 /*
  * /proc/schedstat implementation
  */
+#include "sched.h"
 
 void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
 			       struct sched_statistics *stats)
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 058dd42..1c1bbc6 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -7,6 +7,7 @@
  *
  * See kernel/stop_machine.c
  */
+#include "sched.h"
 
 #ifdef CONFIG_SMP
 static int
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 72505cd..0fef649 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -2,6 +2,7 @@
 /*
  * <linux/swait.h> (simple wait queues ) implementation:
  */
+#include "sched.h"
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe4..9026d32 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3,7 +3,9 @@
  * Scheduler topology setup/handling methods
  */
 
+#include <linux/sched/isolation.h>
 #include <linux/bsearch.h>
+#include "sched.h"
 
 DEFINE_MUTEX(sched_domains_mutex);
 void sched_domains_mutex_lock(void)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5..a6f0001 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -4,6 +4,7 @@
  *
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
+#include "sched.h"
 
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index b410b61..1088d3b 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sched/debug.h>
+#include "sched.h"
+
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */

