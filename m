Return-Path: <linux-tip-commits+bounces-7748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C76CC7C31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551173058603
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D3349B19;
	Wed, 17 Dec 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPMiXeUK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qxbOjuYs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048A34886A;
	Wed, 17 Dec 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975098; cv=none; b=FkBRGZoSRxYuaEqTFRAfkdUetzQ7Qf5Yw7lgnRctbU3FdtilkUTC9ClTpZz5XXfMwug1RR+NyY4v3pLKONkfUHyfWep6vAxNwLRrV2a0y+TCWue4LJ9kphJ2Q/ao9AQ+KnRTyC7hmGK541xmgkSu3YWKx/xsZMTrKqRZBusYaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975098; c=relaxed/simple;
	bh=CnIqK1yGk+Nz0Luo9dRSAdvzp7Hdo5LO0pNDuAkSQD4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WYIg/x/fXeXxVLEtHa2FMkV97OTlSHsjiWV6kcOOTshbSbapTZbaI1bcAv4KkGQtKjfiK74ELudIbGE/ERW6k3E2Qb19gpCggyhR3jX+tkuHDop267Ap1KcbQhLUAqjAP2JS1WfT9ZKi+ec0k3WksyRX+L9LJvfnY0iwsNaSW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPMiXeUK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qxbOjuYs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uI91x4jgfqBD0Js9FX9qj9YQ1J1yiWffmcsunNmle0=;
	b=mPMiXeUKRSReSh44P/fFbYLPBTDCRqlLhOH/B7QKWXHRSHaQMD2/pT8s0dCbpK0Z2Dik4W
	WCw+EILGS3nMjA7mB0FMOIq7upoCiEPfnxYXT6+Hw9TMQz/vM4qHaLcffJarQWgg3Cxyms
	KvS5Y6vP7FfDLF2sLs+B+YJt8m4ea/CXovZfCMohuB2VvzYtmHUkDaEHU7Xnl0OtlkQOe0
	Qb3XL+Rn4dtS2C4B818fe0/07XC77WQvbdi1O4Jdm+QLUs2TevdwNsEqDAeNGWdUqN8WLG
	DkTZOC9CSyn7VKHBlKumu3Jfkz2XV61HdDveDvnUx7y/D7ADPXefrAAfvcH9SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uI91x4jgfqBD0Js9FX9qj9YQ1J1yiWffmcsunNmle0=;
	b=qxbOjuYs+bTUU2luo/jGRYtoexFw25LTyn73mOcnC7Yj24BdathgNAijmbbkjiTczNc2tk
	dLUexhZ+m4MjqUCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add a EVENT_GUEST flag
Cc: Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-7-seanjc@google.com>
References: <20251206001720.468579-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509346.510.17237201458737216169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4593b4b6e218a0f21afbacc8124cf469d2d04094
Gitweb:        https://git.kernel.org/tip/4593b4b6e218a0f21afbacc8124cf469d2d=
04094
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:42 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:05 +01:00

perf: Add a EVENT_GUEST flag

Current perf doesn't explicitly schedule out all exclude_guest events
while the guest is running. There is no problem with the current
emulated vPMU. Because perf owns all the PMU counters. It can mask the
counter which is assigned to an exclude_guest event when a guest is
running (Intel way), or set the corresponding HOSTONLY bit in evsentsel
(AMD way). The counter doesn't count when a guest is running.

However, either way doesn't work with the introduced mediated vPMU.
A guest owns all the PMU counters when it's running. The host should not
mask any counters. The counter may be used by the guest. The evsentsel
may be overwritten.

Perf should explicitly schedule out all exclude_guest events to release
the PMU resources when entering a guest, and resume the counting when
exiting the guest.

It's possible that an exclude_guest event is created when a guest is
running. The new event should not be scheduled in as well.

The ctx time is shared among different PMUs. The time cannot be stopped
when a guest is running. It is required to calculate the time for events
from other PMUs, e.g., uncore events. Add timeguest to track the guest
run time. For an exclude_guest event, the elapsed time equals
the ctx time - guest time.
Cgroup has dedicated times. Use the same method to deduct the guest time
from the cgroup time as well.

[sean: massage comments]
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-7-seanjc@google.com
---
 include/linux/perf_event.h |   6 +-
 kernel/events/core.c       | 230 ++++++++++++++++++++++++++++--------
 2 files changed, 185 insertions(+), 51 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5aa1bc..d9988e3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1045,6 +1045,11 @@ struct perf_event_context {
 	struct perf_time_ctx		time;
=20
 	/*
+	 * Context clock, runs when in the guest mode.
+	 */
+	struct perf_time_ctx		timeguest;
+
+	/*
 	 * These fields let us detect when two contexts have both
 	 * been cloned (inherited) from a common ancestor.
 	 */
@@ -1176,6 +1181,7 @@ struct bpf_perf_event_data_kern {
  */
 struct perf_cgroup_info {
 	struct perf_time_ctx		time;
+	struct perf_time_ctx		timeguest;
 	int				active;
 };
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95f1182..6781d39 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -165,7 +165,19 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	=3D 0x10,
 	EVENT_CGROUP	=3D 0x20,
-	EVENT_FLAGS	=3D EVENT_CGROUP,
+
+	/*
+	 * EVENT_GUEST is set when scheduling in/out events between the host
+	 * and a guest with a mediated vPMU.  Among other things, EVENT_GUEST
+	 * is used:
+	 *
+	 * - In for_each_epc() to skip PMUs that don't support events in a
+	 *   MEDIATED_VPMU guest, i.e. don't need to be context switched.
+	 * - To indicate the start/end point of the events in a guest.  Guest
+	 *   running time is deducted for host-only (exclude_guest) events.
+	 */
+	EVENT_GUEST	=3D 0x40,
+	EVENT_FLAGS	=3D EVENT_CGROUP | EVENT_GUEST,
 	/* compound helpers */
 	EVENT_ALL         =3D EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN =3D EVENT_TIME | EVENT_FROZEN,
@@ -458,6 +470,11 @@ static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
=20
+static __always_inline bool is_guest_mediated_pmu_loaded(void)
+{
+	return false;
+}
+
 /*
  * perf event paranoia level:
  *  -1 - not paranoid at all
@@ -784,6 +801,9 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_conte=
xt *pmu_ctx,
 {
 	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
 		return true;
+	if ((event_type & EVENT_GUEST) &&
+	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
+		return true;
 	return false;
 }
=20
@@ -834,6 +854,39 @@ static inline void update_perf_time_ctx(struct perf_time=
_ctx *time, u64 now, boo
 	WRITE_ONCE(time->offset, time->time - time->stamp);
 }
=20
+static_assert(offsetof(struct perf_event_context, timeguest) -
+	      offsetof(struct perf_event_context, time) =3D=3D
+	      sizeof(struct perf_time_ctx));
+
+#define T_TOTAL		0
+#define T_GUEST		1
+
+static inline u64 __perf_event_time_ctx(struct perf_event *event,
+					struct perf_time_ctx *times)
+{
+	u64 time =3D times[T_TOTAL].time;
+
+	if (event->attr.exclude_guest)
+		time -=3D times[T_GUEST].time;
+
+	return time;
+}
+
+static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
+					    struct perf_time_ctx *times,
+					    u64 now)
+{
+	if (is_guest_mediated_pmu_loaded() && event->attr.exclude_guest) {
+		/*
+		 * (now + times[total].offset) - (now + times[guest].offset) :=3D
+		 * times[total].offset - times[guest].offset
+		 */
+		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
+	}
+
+	return now + READ_ONCE(times[T_TOTAL].offset);
+}
+
 #ifdef CONFIG_CGROUP_PERF
=20
 static inline bool
@@ -870,12 +923,16 @@ static inline int is_cgroup_event(struct perf_event *ev=
ent)
 	return event->cgrp !=3D NULL;
 }
=20
+static_assert(offsetof(struct perf_cgroup_info, timeguest) -
+	      offsetof(struct perf_cgroup_info, time) =3D=3D
+	      sizeof(struct perf_time_ctx));
+
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	struct perf_cgroup_info *t;
=20
 	t =3D per_cpu_ptr(event->cgrp->info, event->cpu);
-	return t->time.time;
+	return __perf_event_time_ctx(event, &t->time);
 }
=20
 static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 n=
ow)
@@ -884,9 +941,21 @@ static inline u64 perf_cgroup_event_time_now(struct perf=
_event *event, u64 now)
=20
 	t =3D per_cpu_ptr(event->cgrp->info, event->cpu);
 	if (!__load_acquire(&t->active))
-		return t->time.time;
-	now +=3D READ_ONCE(t->time.offset);
-	return now;
+		return __perf_event_time_ctx(event, &t->time);
+
+	return __perf_event_time_ctx_now(event, &t->time, now);
+}
+
+static inline void __update_cgrp_guest_time(struct perf_cgroup_info *info, u=
64 now, bool adv)
+{
+	update_perf_time_ctx(&info->timeguest, now, adv);
+}
+
+static inline void update_cgrp_time(struct perf_cgroup_info *info, u64 now)
+{
+	update_perf_time_ctx(&info->time, now, true);
+	if (is_guest_mediated_pmu_loaded())
+		__update_cgrp_guest_time(info, now, true);
 }
=20
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpu=
ctx, bool final)
@@ -902,7 +971,7 @@ static inline void update_cgrp_time_from_cpuctx(struct pe=
rf_cpu_context *cpuctx,
 			cgrp =3D container_of(css, struct perf_cgroup, css);
 			info =3D this_cpu_ptr(cgrp->info);
=20
-			update_perf_time_ctx(&info->time, now, true);
+			update_cgrp_time(info, now);
 			if (final)
 				__store_release(&info->active, 0);
 		}
@@ -925,11 +994,11 @@ static inline void update_cgrp_time_from_event(struct p=
erf_event *event)
 	 * Do not update time when cgroup is not active
 	 */
 	if (info->active)
-		update_perf_time_ctx(&info->time, perf_clock(), true);
+		update_cgrp_time(info, perf_clock());
 }
=20
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 	struct perf_event_context *ctx =3D &cpuctx->ctx;
 	struct perf_cgroup *cgrp =3D cpuctx->cgrp;
@@ -949,8 +1018,12 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuc=
tx)
 	for (css =3D &cgrp->css; css; css =3D css->parent) {
 		cgrp =3D container_of(css, struct perf_cgroup, css);
 		info =3D this_cpu_ptr(cgrp->info);
-		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
-		__store_release(&info->active, 1);
+		if (guest) {
+			__update_cgrp_guest_time(info, ctx->time.stamp, false);
+		} else {
+			update_perf_time_ctx(&info->time, ctx->time.stamp, false);
+			__store_release(&info->active, 1);
+		}
 	}
 }
=20
@@ -1154,7 +1227,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct=
 perf_event *event,
 }
=20
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 }
=20
@@ -1566,16 +1639,24 @@ static void perf_unpin_context(struct perf_event_cont=
ext *ctx)
  */
 static void __update_context_time(struct perf_event_context *ctx, bool adv)
 {
-	u64 now =3D perf_clock();
+	lockdep_assert_held(&ctx->lock);
+
+	update_perf_time_ctx(&ctx->time, perf_clock(), adv);
+}
=20
+static void __update_context_guest_time(struct perf_event_context *ctx, bool=
 adv)
+{
 	lockdep_assert_held(&ctx->lock);
=20
-	update_perf_time_ctx(&ctx->time, now, adv);
+	/* must be called after __update_context_time(); */
+	update_perf_time_ctx(&ctx->timeguest, ctx->time.stamp, adv);
 }
=20
 static void update_context_time(struct perf_event_context *ctx)
 {
 	__update_context_time(ctx, true);
+	if (is_guest_mediated_pmu_loaded())
+		__update_context_guest_time(ctx, true);
 }
=20
 static u64 perf_event_time(struct perf_event *event)
@@ -1588,7 +1669,7 @@ static u64 perf_event_time(struct perf_event *event)
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
=20
-	return ctx->time.time;
+	return __perf_event_time_ctx(event, &ctx->time);
 }
=20
 static u64 perf_event_time_now(struct perf_event *event, u64 now)
@@ -1602,10 +1683,9 @@ static u64 perf_event_time_now(struct perf_event *even=
t, u64 now)
 		return perf_cgroup_event_time_now(event, now);
=20
 	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
-		return ctx->time.time;
+		return __perf_event_time_ctx(event, &ctx->time);
=20
-	now +=3D READ_ONCE(ctx->time.offset);
-	return now;
+	return __perf_event_time_ctx_now(event, &ctx->time, now);
 }
=20
 static enum event_type_t get_event_type(struct perf_event *event)
@@ -2425,20 +2505,23 @@ group_sched_out(struct perf_event *group_event, struc=
t perf_event_context *ctx)
 }
=20
 static inline void
-__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context=
 *ctx, bool final)
+__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context=
 *ctx,
+		  bool final, enum event_type_t event_type)
 {
 	if (ctx->is_active & EVENT_TIME) {
 		if (ctx->is_active & EVENT_FROZEN)
 			return;
+
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, final);
+		/* vPMU should not stop time */
+		update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
 	}
 }
=20
 static inline void
 ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *=
ctx)
 {
-	__ctx_time_update(cpuctx, ctx, false);
+	__ctx_time_update(cpuctx, ctx, false, 0);
 }
=20
 /*
@@ -3510,7 +3593,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pm=
u *pmu, enum event_type_t
 	 *
 	 * would only update time for the pinned events.
 	 */
-	__ctx_time_update(cpuctx, ctx, ctx =3D=3D &cpuctx->ctx);
+	__ctx_time_update(cpuctx, ctx, ctx =3D=3D &cpuctx->ctx, event_type);
=20
 	/*
 	 * CPU-release for the below ->is_active store,
@@ -3536,7 +3619,18 @@ ctx_sched_out(struct perf_event_context *ctx, struct p=
mu *pmu, enum event_type_t
 			cpuctx->task_ctx =3D NULL;
 	}
=20
-	is_active ^=3D ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule out all exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active =3D EVENT_ALL;
+		__update_context_guest_time(ctx, false);
+		perf_cgroup_set_timestamp(cpuctx, true);
+		barrier();
+	} else {
+		is_active ^=3D ctx->is_active; /* changed bits */
+	}
=20
 	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
@@ -3995,10 +4089,15 @@ static inline void group_update_userpage(struct perf_=
event *group_event)
 		event_update_userpage(event);
 }
=20
+struct merge_sched_data {
+	int can_add_hw;
+	enum event_type_t event_type;
+};
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx =3D event->ctx;
-	int *can_add_hw =3D data;
+	struct merge_sched_data *msd =3D data;
=20
 	if (event->state <=3D PERF_EVENT_STATE_OFF)
 		return 0;
@@ -4006,13 +4105,22 @@ static int merge_sched_in(struct perf_event *event, v=
oid *data)
 	if (!event_filter_match(event))
 		return 0;
=20
-	if (group_can_go_on(event, *can_add_hw)) {
+	/*
+	 * Don't schedule in any host events from PMU with
+	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
+	 */
+	if (is_guest_mediated_pmu_loaded() &&
+	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
+	    !(msd->event_type & EVENT_GUEST))
+		return 0;
+
+	if (group_can_go_on(event, msd->can_add_hw)) {
 		if (!group_sched_in(event, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
=20
 	if (event->state =3D=3D PERF_EVENT_STATE_INACTIVE) {
-		*can_add_hw =3D 0;
+		msd->can_add_hw =3D 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
@@ -4035,11 +4143,15 @@ static int merge_sched_in(struct perf_event *event, v=
oid *data)
=20
 static void pmu_groups_sched_in(struct perf_event_context *ctx,
 				struct perf_event_groups *groups,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	int can_add_hw =3D 1;
+	struct merge_sched_data msd =3D {
+		.can_add_hw =3D 1,
+		.event_type =3D event_type,
+	};
 	visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
-			   merge_sched_in, &can_add_hw);
+			   merge_sched_in, &msd);
 }
=20
 static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
@@ -4048,9 +4160,9 @@ static void __pmu_ctx_sched_in(struct perf_event_pmu_co=
ntext *pmu_ctx,
 	struct perf_event_context *ctx =3D pmu_ctx->ctx;
=20
 	if (event_type & EVENT_PINNED)
-		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu, event_type);
 	if (event_type & EVENT_FLEXIBLE)
-		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu, event_type);
 }
=20
 static void
@@ -4067,9 +4179,11 @@ ctx_sched_in(struct perf_event_context *ctx, struct pm=
u *pmu, enum event_type_t=20
 		return;
=20
 	if (!(is_active & EVENT_TIME)) {
+		/* EVENT_TIME should be active while the guest runs */
+		WARN_ON_ONCE(event_type & EVENT_GUEST);
 		/* start ctx time */
 		__update_context_time(ctx, false);
-		perf_cgroup_set_timestamp(cpuctx);
+		perf_cgroup_set_timestamp(cpuctx, false);
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -4085,7 +4199,23 @@ ctx_sched_in(struct perf_event_context *ctx, struct pm=
u *pmu, enum event_type_t=20
 			WARN_ON_ONCE(cpuctx->task_ctx !=3D ctx);
 	}
=20
-	is_active ^=3D ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule in the required exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active =3D event_type & EVENT_ALL;
+
+		/*
+		 * Update ctx time to set the new start time for
+		 * the exclude_guest events.
+		 */
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+		barrier();
+	} else {
+		is_active ^=3D ctx->is_active; /* changed bits */
+	}
=20
 	/*
 	 * First go through the list and put on any pinned groups
@@ -4093,13 +4223,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct p=
mu *pmu, enum event_type_t=20
 	 */
 	if (is_active & EVENT_PINNED) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED | (event_type & EVENT_GUEST));
 	}
=20
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE | (event_type & EVENT_GUEST));
 	}
 }
=20
@@ -6627,22 +6757,22 @@ void perf_event_update_userpage(struct perf_event *ev=
ent)
 		goto unlock;
=20
 	/*
-	 * compute total_time_enabled, total_time_running
-	 * based on snapshot values taken when the event
-	 * was last scheduled in.
+	 * Disable preemption to guarantee consistent time stamps are stored to
+	 * the user page.
+	 */
+	preempt_disable();
+
+	/*
+	 * Compute total_time_enabled, total_time_running based on snapshot
+	 * values taken when the event was last scheduled in.
 	 *
-	 * we cannot simply called update_context_time()
-	 * because of locking issue as we can be called in
-	 * NMI context
+	 * We cannot simply call update_context_time() because doing so would
+	 * lead to deadlock when called from NMI context.
 	 */
 	calc_timer_values(event, &now, &enabled, &running);
=20
 	userpg =3D rb->user_page;
-	/*
-	 * Disable preemption to guarantee consistent time stamps are stored to
-	 * the user page.
-	 */
-	preempt_disable();
+
 	++userpg->lock;
 	barrier();
 	userpg->index =3D perf_event_index(event);
@@ -7939,13 +8069,11 @@ static void perf_output_read(struct perf_output_handl=
e *handle,
 	u64 read_format =3D event->attr.read_format;
=20
 	/*
-	 * compute total_time_enabled, total_time_running
-	 * based on snapshot values taken when the event
-	 * was last scheduled in.
+	 * Compute total_time_enabled, total_time_running based on snapshot
+	 * values taken when the event was last scheduled in.
 	 *
-	 * we cannot simply called update_context_time()
-	 * because of locking issue as we are called in
-	 * NMI context
+	 * We cannot simply call update_context_time() because doing so would
+	 * lead to deadlock when called from NMI context.
 	 */
 	if (read_format & PERF_FORMAT_TOTAL_TIMES)
 		calc_timer_values(event, &now, &enabled, &running);

