Return-Path: <linux-tip-commits+bounces-7749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297ECC7B0C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3A930576A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B134A3CD;
	Wed, 17 Dec 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nn5B3MNp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/SuKthi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD73491FB;
	Wed, 17 Dec 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975099; cv=none; b=SNlhH5BHjAqe8HMxCGR3WED0AX1BrF8w5K5lNyrDn5b85NHaXvpSxlP23yORqDhO3wn+uB18VibBPqO7xjLGuogIDO3Gj9QEVD0UMm1om7XYvLvDyNtu7BHsCHnK3XD097fagG5UrBfEZgAKuDTgKr9JusviLHa1lOCTbK2bkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975099; c=relaxed/simple;
	bh=KJQ83haXUENk3uch11FimWc9iw3Cr4zKqgGXzsWLhhg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JfiIm+njC7k9oQEWMma6RTMslQakr7n1a/7V2MKkz/H8Lrj8f0WNwvlCx1vZoW02n4zW5qRJZ88sovPyTRilhHhhpXqZm6S2BTyQYJHCClvckdewjUAn8mV+GrpjXaXjCsI7Gqt/1QorTxBXQPLiKKJaX0JnNwQh6gXlegveCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nn5B3MNp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/SuKthi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuCvKsGLeFtXqqSriERe1hf/oAfqTzZgfMXR8pj2UhU=;
	b=nn5B3MNpqol2alodQvYv9uxH2Rco+x16Zk2gbpSfBYJMtTDpyOBx/RQB75T3tBfbSEJoui
	4K7cYJr4KtUINPMLJiU8YEy9xfIZzpEzgTzgORDDnoGtgW9v/+giL/DqC/4FnDVP4/N/ch
	PPW/m4GFzKt7PKtUIlb9Pakuus32/89v5Lh3yMgA5ytnCe6qZFw5QJTXWWZR6sS+brDA8F
	Xxjumw/mEclappWpnWhQFR6zatuO6kadXVa518HjGR96M4tu7Nvaxb+k6+wKw/875GdFCK
	7HLOEIZpwP9edFfcAbOy2/hw+xM/Zfls8qbQlz5KSRIIkzQyOqYWsCN/mIZgPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuCvKsGLeFtXqqSriERe1hf/oAfqTzZgfMXR8pj2UhU=;
	b=Q/SuKthiWUd79UAYtMpoLpsBee35kyQcEHHTT9FUjbw9ybb1mMx9gkOmG9LwPYzmC3qvXa
	2yquINElysdjjcDA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Clean up perf ctx time
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>, Xudong Hao <xudong.hao@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-6-seanjc@google.com>
References: <20251206001720.468579-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509444.510.4614767363200206786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f5c7de8f84a152d559256aa4d0fc953118b73ca4
Gitweb:        https://git.kernel.org/tip/f5c7de8f84a152d559256aa4d0fc953118b=
73ca4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:41 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:04 +01:00

perf: Clean up perf ctx time

The current perf tracks two timestamps for the normal ctx and cgroup.
The same type of variables and similar codes are used to track the
timestamps. In the following patch, the third timestamp to track the
guest time will be introduced.
To avoid the code duplication, add a new struct perf_time_ctx and factor
out a generic function update_perf_time_ctx().

No functional change.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-6-seanjc@google.com
---
 include/linux/perf_event.h | 13 +++----
 kernel/events/core.c       | 70 ++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 31929da..d5aa1bc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -999,6 +999,11 @@ struct perf_event_groups {
 	u64				index;
 };
=20
+struct perf_time_ctx {
+	u64		time;
+	u64		stamp;
+	u64		offset;
+};
=20
 /**
  * struct perf_event_context - event context structure
@@ -1037,9 +1042,7 @@ struct perf_event_context {
 	/*
 	 * Context clock, runs when context enabled.
 	 */
-	u64				time;
-	u64				timestamp;
-	u64				timeoffset;
+	struct perf_time_ctx		time;
=20
 	/*
 	 * These fields let us detect when two contexts have both
@@ -1172,9 +1175,7 @@ struct bpf_perf_event_data_kern {
  * This is a per-cpu dynamically allocated data structure.
  */
 struct perf_cgroup_info {
-	u64				time;
-	u64				timestamp;
-	u64				timeoffset;
+	struct perf_time_ctx		time;
 	int				active;
 };
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a2166b..95f1182 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -816,6 +816,24 @@ static void perf_ctx_enable(struct perf_event_context *c=
tx,
 static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, e=
num event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, en=
um event_type_t event_type);
=20
+static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now,=
 bool adv)
+{
+	if (adv)
+		time->time +=3D now - time->stamp;
+	time->stamp =3D now;
+
+	/*
+	 * The above: time' =3D time + (now - timestamp), can be re-arranged
+	 * into: time` =3D now + (time - timestamp), which gives a single value
+	 * offset to compute future time without locks on.
+	 *
+	 * See perf_event_time_now(), which can be used from NMI context where
+	 * it's (obviously) not possible to acquire ctx->lock in order to read
+	 * both the above values in a consistent manner.
+	 */
+	WRITE_ONCE(time->offset, time->time - time->stamp);
+}
+
 #ifdef CONFIG_CGROUP_PERF
=20
 static inline bool
@@ -857,7 +875,7 @@ static inline u64 perf_cgroup_event_time(struct perf_even=
t *event)
 	struct perf_cgroup_info *t;
=20
 	t =3D per_cpu_ptr(event->cgrp->info, event->cpu);
-	return t->time;
+	return t->time.time;
 }
=20
 static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 n=
ow)
@@ -866,22 +884,11 @@ static inline u64 perf_cgroup_event_time_now(struct per=
f_event *event, u64 now)
=20
 	t =3D per_cpu_ptr(event->cgrp->info, event->cpu);
 	if (!__load_acquire(&t->active))
-		return t->time;
-	now +=3D READ_ONCE(t->timeoffset);
+		return t->time.time;
+	now +=3D READ_ONCE(t->time.offset);
 	return now;
 }
=20
-static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now=
, bool adv)
-{
-	if (adv)
-		info->time +=3D now - info->timestamp;
-	info->timestamp =3D now;
-	/*
-	 * see update_context_time()
-	 */
-	WRITE_ONCE(info->timeoffset, info->time - info->timestamp);
-}
-
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpu=
ctx, bool final)
 {
 	struct perf_cgroup *cgrp =3D cpuctx->cgrp;
@@ -895,7 +902,7 @@ static inline void update_cgrp_time_from_cpuctx(struct pe=
rf_cpu_context *cpuctx,
 			cgrp =3D container_of(css, struct perf_cgroup, css);
 			info =3D this_cpu_ptr(cgrp->info);
=20
-			__update_cgrp_time(info, now, true);
+			update_perf_time_ctx(&info->time, now, true);
 			if (final)
 				__store_release(&info->active, 0);
 		}
@@ -918,7 +925,7 @@ static inline void update_cgrp_time_from_event(struct per=
f_event *event)
 	 * Do not update time when cgroup is not active
 	 */
 	if (info->active)
-		__update_cgrp_time(info, perf_clock(), true);
+		update_perf_time_ctx(&info->time, perf_clock(), true);
 }
=20
 static inline void
@@ -942,7 +949,7 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 	for (css =3D &cgrp->css; css; css =3D css->parent) {
 		cgrp =3D container_of(css, struct perf_cgroup, css);
 		info =3D this_cpu_ptr(cgrp->info);
-		__update_cgrp_time(info, ctx->timestamp, false);
+		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
 		__store_release(&info->active, 1);
 	}
 }
@@ -1563,20 +1570,7 @@ static void __update_context_time(struct perf_event_co=
ntext *ctx, bool adv)
=20
 	lockdep_assert_held(&ctx->lock);
=20
-	if (adv)
-		ctx->time +=3D now - ctx->timestamp;
-	ctx->timestamp =3D now;
-
-	/*
-	 * The above: time' =3D time + (now - timestamp), can be re-arranged
-	 * into: time` =3D now + (time - timestamp), which gives a single value
-	 * offset to compute future time without locks on.
-	 *
-	 * See perf_event_time_now(), which can be used from NMI context where
-	 * it's (obviously) not possible to acquire ctx->lock in order to read
-	 * both the above values in a consistent manner.
-	 */
-	WRITE_ONCE(ctx->timeoffset, ctx->time - ctx->timestamp);
+	update_perf_time_ctx(&ctx->time, now, adv);
 }
=20
 static void update_context_time(struct perf_event_context *ctx)
@@ -1594,7 +1588,7 @@ static u64 perf_event_time(struct perf_event *event)
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
=20
-	return ctx->time;
+	return ctx->time.time;
 }
=20
 static u64 perf_event_time_now(struct perf_event *event, u64 now)
@@ -1608,9 +1602,9 @@ static u64 perf_event_time_now(struct perf_event *event=
, u64 now)
 		return perf_cgroup_event_time_now(event, now);
=20
 	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
-		return ctx->time;
+		return ctx->time.time;
=20
-	now +=3D READ_ONCE(ctx->timeoffset);
+	now +=3D READ_ONCE(ctx->time.offset);
 	return now;
 }
=20
@@ -12113,7 +12107,7 @@ static void task_clock_event_update(struct perf_event=
 *event, u64 now)
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
 	event->hw.state =3D 0;
-	local64_set(&event->hw.prev_count, event->ctx->time);
+	local64_set(&event->hw.prev_count, event->ctx->time.time);
 	perf_swevent_start_hrtimer(event);
 }
=20
@@ -12122,7 +12116,7 @@ static void task_clock_event_stop(struct perf_event *=
event, int flags)
 	event->hw.state =3D PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
-		task_clock_event_update(event, event->ctx->time);
+		task_clock_event_update(event, event->ctx->time.time);
 }
=20
 static int task_clock_event_add(struct perf_event *event, int flags)
@@ -12142,8 +12136,8 @@ static void task_clock_event_del(struct perf_event *e=
vent, int flags)
 static void task_clock_event_read(struct perf_event *event)
 {
 	u64 now =3D perf_clock();
-	u64 delta =3D now - event->ctx->timestamp;
-	u64 time =3D event->ctx->time + delta;
+	u64 delta =3D now - event->ctx->time.stamp;
+	u64 time =3D event->ctx->time.time + delta;
=20
 	task_clock_event_update(event, time);
 }

