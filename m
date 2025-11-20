Return-Path: <linux-tip-commits+bounces-7429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973AC760F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CF839241FC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172127FD7D;
	Thu, 20 Nov 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKexLfSf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgzMPU0u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDD4315A;
	Thu, 20 Nov 2025 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666575; cv=none; b=fF6ZjhVoJN1nG91iVy5I4/rvgJ03MBHetEa1oiwP7ZqWPXnuusnPjpY2lnzg9nFMVaQ7ohEU7Nx+Ov3MMtqkt2BYGcw9oHOUtG8Ng+f5RyJyOP5sUj1WztpwRIiY/Wda8dqx9CpzkrEHgl9dg2fHQi0fGd9SzFD4n8Ty0TbE8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666575; c=relaxed/simple;
	bh=2mwtxF3+B1/FXt6cNBxddYATdUuyCcibF4YQMpCzB00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rbITVajTa4P9Ad6G2ChBINDWvetzbQ35DJ3Ux10Wxz3pkA9XfIyPHsn+JXa7SYBZWdCFuF30QQZ59wy3xqc0/RRUCZjsdRe4ytDh4BMO/vdCmP/s8LrSxUVDwo/qnBuSWKNqHUaEnFA7trOUW0RWj+EoOM0cqby+vPkMmaJvnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKexLfSf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgzMPU0u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfrBkNH+KI7i96TqHvegY2eeUdzpFgjh4YUEWiQby8Q=;
	b=MKexLfSfRn1HWLst/rUm5oBZBFE2cl5tN81HQQeF+0pzOt0wO13dY2keuJI2BahvTg+jFd
	+Di4O+yjSbLPwU1Uz2ynyKIx6XyN0hMQzToyx2+aYBVrR81qd4vmzkbk8AsFV8ThIkRmlO
	H8TBH5WSUP8hTv1tH9m8ecvI30PGe+BU2VY7NKOS3oUElMIWH0bHKesm+vLmx5FX3gXmHE
	ZqaZ0FUIr9hrrFRfJ4GMHrcTMgixufIbnoMUwYI2sFxeX8P3OTR6sVNnkenvo0Dn469w/3
	F2t1MKdwnJsMv9Qd5P4KAr2WhmU5KpZMzAIRwzhVsYgD4GFkSebTaC5wq9EMcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfrBkNH+KI7i96TqHvegY2eeUdzpFgjh4YUEWiQby8Q=;
	b=FgzMPU0uAgcb4BtFOylZZIw9bsm8X/JPEtl1vu1UpJTCZSNdqAot8qy2jRDuhXSJKonO68
	3AakeF0tm9JfftCA==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/migration: Exclude isolated cpus from hierarchy
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-8-gmonaco@redhat.com>
References: <20251120145653.296659-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657050.498.9563044693157663383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7dec062cfcf27808dbb70a0b231d1a698792743d
Gitweb:        https://git.kernel.org/tip/7dec062cfcf27808dbb70a0b231d1a69879=
2743d
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:32 +01:00

timers/migration: Exclude isolated cpus from hierarchy

The timer migration mechanism allows active CPUs to pull timers from
idle ones to improve the overall idle time. This is however undesired
when CPU intensive workloads run on isolated cores, as the algorithm
would move the timers from housekeeping to isolated cores, negatively
affecting the isolation.

Exclude isolated cores from the timer migration algorithm, extend the
concept of unavailable cores, currently used for offline ones, to
isolated ones:
* A core is unavailable if isolated or offline;
* A core is available if non isolated and online;

A core is considered unavailable as isolated if it belongs to:
* the isolcpus (domain) list
* an isolated cpuset
Except if it is:
* in the nohz_full list (already idle for the hierarchy)
* the nohz timekeeper core (must be available to handle global timers)

CPUs are added to the hierarchy during late boot, excluding isolated
ones, the hierarchy is also adapted when the cpuset isolation changes.

Due to how the timer migration algorithm works, any CPU part of the
hierarchy can have their global timers pulled by remote CPUs and have to
pull remote timers, only skipping pulling remote timers would break the
logic.
For this reason, prevent isolated CPUs from pulling remote global
timers, but also the other way around: any global timer started on an
isolated CPU will run there. This does not break the concept of
isolation (global timers don't come from outside the CPU) and, if
considered inappropriate, can usually be mitigated with other isolation
techniques (e.g. IRQ pinning).

This effect was noticed on a 128 cores machine running oslat on the
isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
and the CPU with lowest count in a timer migration hierarchy (here 1
and 65) appears as always active and continuously pulls global timers,
from the housekeeping CPUs. This ends up moving driver work (e.g.
delayed work) to isolated CPUs and causes latency spikes:

before the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:     1203 10 3 4 ... 5 (us)

after the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:      10 4 3 4 3 ... 5 (us)

The same behaviour was observed on a machine with as few as 20 cores /
40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20251120145653.296659-8-gmonaco@redhat.com
---
 include/linux/timer.h         |   9 ++-
 kernel/cgroup/cpuset.c        |   3 +-
 kernel/time/timer_migration.c | 143 +++++++++++++++++++++++++++++++++-
 3 files changed, 155 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 0414d9e..62e1cea 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -188,4 +188,13 @@ int timers_dead_cpu(unsigned int cpu);
 #define timers_dead_cpu		NULL
 #endif
=20
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask);
+#else
+static inline int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpu=
mask)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cf34623..bfc3b31 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1350,6 +1350,9 @@ static void update_isolation_cpumasks(bool isolcpus_upd=
ated)
=20
 	ret =3D workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+
+	ret =3D tmigr_isolated_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
 }
=20
 /**
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index a01c7f8..18dda1a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 #include <trace/events/ipi.h>
+#include <linux/sched/isolation.h>
=20
 #include "timer_migration.h"
 #include "tick-internal.h"
@@ -427,8 +428,13 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 /*
  * CPUs available for timer migration.
  * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ * Additionally tmigr_available_mutex serializes set/clear operations with e=
ach other.
  */
 static cpumask_var_t tmigr_available_cpumask;
+static DEFINE_MUTEX(tmigr_available_mutex);
+
+/* Enabled during late initcall */
+static DEFINE_STATIC_KEY_FALSE(tmigr_exclude_isolated);
=20
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
@@ -439,6 +445,33 @@ static inline bool tmigr_is_not_available(struct tmigr_c=
pu *tmc)
 }
=20
 /*
+ * Returns true if @cpu should be excluded from the hierarchy as isolated.
+ * Domain isolated CPUs don't participate in timer migration, nohz_full CPUs
+ * are still part of the hierarchy but become idle (from a tick and timer
+ * migration perspective) when they stop their tick. This lets the timekeepi=
ng
+ * CPU handle their global timers. Marking also isolated CPUs as idle would =
be
+ * too costly, hence they are completely excluded from the hierarchy.
+ * This check is necessary, for instance, to prevent offline isolated CPUs f=
rom
+ * being incorrectly marked as available once getting back online.
+ *
+ * This function returns false during early boot and the isolation logic is
+ * enabled only after isolated CPUs are marked as unavailable at late boot.
+ * The tick CPU can be isolated at boot, however we cannot mark it as
+ * unavailable to avoid having no global migrator for the nohz_full CPUs. Th=
is
+ * should be ensured by the callers of this function: implicitly from hotplug
+ * callbacks and explicitly in tmigr_init_isolation() and
+ * tmigr_isolated_exclude_cpumask().
+ */
+static inline bool tmigr_is_isolated(int cpu)
+{
+	if (!static_branch_unlikely(&tmigr_exclude_isolated))
+		return false;
+	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
+		cpuset_cpu_is_isolated(cpu)) &&
+	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
+}
+
+/*
  * Returns true, when @childmask corresponds to the group migrator or when t=
he
  * group is not active - so no migrator is set.
  */
@@ -1439,8 +1472,12 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
=20
+	guard(mutex)(&tmigr_available_mutex);
+
 	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (!tmc->available)
+			return 0;
 		tmc->available =3D false;
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
=20
@@ -1468,8 +1505,15 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
=20
+	if (tmigr_is_isolated(cpu))
+		return 0;
+
+	guard(mutex)(&tmigr_available_mutex);
+
 	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (tmc->available)
+			return 0;
 		trace_tmigr_cpu_available(tmc);
 		tmc->idle =3D timer_base_is_idle();
 		if (!tmc->idle)
@@ -1479,6 +1523,105 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	return 0;
 }
=20
+static void tmigr_cpu_isolate(struct work_struct *ignored)
+{
+	tmigr_clear_cpu_available(smp_processor_id());
+}
+
+static void tmigr_cpu_unisolate(struct work_struct *ignored)
+{
+	tmigr_set_cpu_available(smp_processor_id());
+}
+
+/**
+ * tmigr_isolated_exclude_cpumask - Exclude given CPUs from hierarchy
+ * @exclude_cpumask: the cpumask to be excluded from timer migration hierarc=
hy
+ *
+ * This function can be called from cpuset code to provide the new set of
+ * isolated CPUs that should be excluded from the hierarchy.
+ * Online CPUs not present in exclude_cpumask but already excluded are broug=
ht
+ * back to the hierarchy.
+ * Functions to isolate/unisolate need to be called locally and can sleep.
+ */
+int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+{
+	struct work_struct __percpu *works __free(free_percpu) =3D
+		alloc_percpu(struct work_struct);
+	cpumask_var_t cpumask __free(free_cpumask_var) =3D CPUMASK_VAR_NULL;
+	int cpu;
+
+	lockdep_assert_cpus_held();
+
+	if (!works)
+		return -ENOMEM;
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * First set previously isolated CPUs as available (unisolate).
+	 * This cpumask contains only CPUs that switched to available now.
+	 */
+	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
+	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
+
+	for_each_cpu(cpu, cpumask) {
+		struct work_struct *work =3D per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, tmigr_cpu_unisolate);
+		schedule_work_on(cpu, work);
+	}
+	for_each_cpu(cpu, cpumask)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	/*
+	 * Then clear previously available CPUs (isolate).
+	 * This cpumask contains only CPUs that switched to not available now.
+	 * There cannot be overlap with the newly available ones.
+	 */
+	cpumask_and(cpumask, exclude_cpumask, tmigr_available_cpumask);
+	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	/*
+	 * Handle this here and not in the cpuset code because exclude_cpumask
+	 * might include also the tick CPU if included in isolcpus.
+	 */
+	for_each_cpu(cpu, cpumask) {
+		if (!tick_nohz_cpu_hotpluggable(cpu)) {
+			cpumask_clear_cpu(cpu, cpumask);
+			break;
+		}
+	}
+
+	for_each_cpu(cpu, cpumask) {
+		struct work_struct *work =3D per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, tmigr_cpu_isolate);
+		schedule_work_on(cpu, work);
+	}
+	for_each_cpu(cpu, cpumask)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	return 0;
+}
+
+static int __init tmigr_init_isolation(void)
+{
+	cpumask_var_t cpumask __free(free_cpumask_var) =3D CPUMASK_VAR_NULL;
+
+	static_branch_enable(&tmigr_exclude_isolated);
+
+	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
+		return 0;
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_andnot(cpumask, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOM=
AIN));
+
+	/* Protect against RCU torture hotplug testing */
+	guard(cpus_read_lock)();
+	return tmigr_isolated_exclude_cpumask(cpumask);
+}
+late_initcall(tmigr_init_isolation);
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {

