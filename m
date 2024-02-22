Return-Path: <linux-tip-commits+bounces-528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193BA85FED6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Feb 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9928D1F282D7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Feb 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A01552EC;
	Thu, 22 Feb 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1YI0nF3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3/GAVlE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC784154437;
	Thu, 22 Feb 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621929; cv=none; b=VfzWGpNfycPi609yzPu90qq9oPy2ITJqNChcJFyAFXb7pC5URbKnT6izYHr4anuLdPiyIv0DWVVX2DUnJybSXaKjFGq2yhCBPhAX8yiOOKFX9Oy4iobDGaduGvx5KKDVpivmKVF+t/n6DBPHlaf6dT97rhxkK2FErcWQ+5J1O10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621929; c=relaxed/simple;
	bh=KnWtylmq3bB1Qjht0RmyzNDxas/ssm/2ihr0GrRdUmw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TZGE5w6XRsnCJsBZeZhwpX184ARmgnsksNpsIk7vibjUhgLGxDs4r8dWSM4BqXkOQ4n1QoXErPiHNDHHXZb9UMexX4ziY6Hapmsz/wMZ84XS/NY4hOTL+vlGbOJcM8/QMlgZ8IJli+V0HG5abgHypRlyQzNHCfbTQwIya+YJ8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1YI0nF3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3/GAVlE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xdh7WdhIjTRn9UFdCcH1bNJomPSqt7pYGQb1b9Fnp0=;
	b=Y1YI0nF3amNHEFypsd2YvflkSrNTW+movSzdFIs/fTpHEoKHZj2U2rm12CX9KxHyfp0GWr
	l0jBFGtmEUqse0SQt7bRbuz3/3AZ6ZkC0zAxlKTTo0Gssb3VRI8ZyerrMlXydpBtnQVIj/
	elIYYJNyd2sCfvYIBtKnUK8NwFsj3O8e4tVN/YdEIiRJExh/E/krN8M39DTe8XzFWZqoY2
	r2bZuaPcZvIPjU+9f97EgGKSgbeEYBNBMQpDbpB37Qs7/HbFiQ6IwBHhjPtfs7lCGGLgmK
	mJPPff2s2jt6Q4ONWi4lpIDYo70iuNMktOLe8NtRh86O2QIrfxhz6giPpT+1uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xdh7WdhIjTRn9UFdCcH1bNJomPSqt7pYGQb1b9Fnp0=;
	b=m3/GAVlEtKxPqdJxe+WIZGsQts38RMTiWPiIKRF2dTFhmStGGEXV9jDpg2Jw/OuVb7mepn
	ZDK9dV2CVOmorsDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer_migration: Add tracepoints
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222103403.31923-1-anna-maria@linutronix.de>
References: <20240222103403.31923-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192537.398.14231226594852045597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     36e40df35d2c1891fe58241640c7c95de4aa739b
Gitweb:        https://git.kernel.org/tip/36e40df35d2c1891fe58241640c7c95de4aa739b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Thu, 22 Feb 2024 11:34:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:32 +01:00

timer_migration: Add tracepoints

The timer pull logic needs proper debugging aids. Add tracepoints so the
hierarchical idle machinery can be diagnosed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222103403.31923-1-anna-maria@linutronix.de

---
 MAINTAINERS                            |   1 +-
 include/trace/events/timer_migration.h | 298 ++++++++++++++++++++++++-
 kernel/time/timer_migration.c          |  26 ++-
 3 files changed, 325 insertions(+)
 create mode 100644 include/trace/events/timer_migration.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d38..70c07ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17499,6 +17499,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
 F:	include/linux/timer*
+F:	include/trace/events/timer*
 F:	kernel/time/*timer*
 F:	kernel/time/namespace.c
 
diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
new file mode 100644
index 0000000..79f19e7
--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+TRACE_EVENT(tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node)
+);
+
+TRACE_EVENT(tmigr_connect_child_parent,
+
+	TP_PROTO(struct tmigr_group *child),
+
+	TP_ARGS(child),
+
+	TP_STRUCT__entry(
+		__field( void *,	child		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		= child;
+		__entry->parent		= child->parent;
+		__entry->lvl		= child->parent->level;
+		__entry->numa_node	= child->parent->numa_node;
+		__entry->num_children	= child->parent->num_children;
+		__entry->childmask	= child->childmask;
+	),
+
+	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+TRACE_EVENT(tmigr_connect_cpu_parent,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent		)
+		__field( unsigned int,	cpu		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->lvl		= tmc->tmgroup->level;
+		__entry->numa_node	= tmc->tmgroup->numa_node;
+		__entry->num_children	= tmc->tmgroup->num_children;
+		__entry->childmask	= tmc->childmask;
+	),
+
+	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( u32,		childmask	)
+		__field( u8,		active		)
+		__field( u8,		migrator	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->parent		= group->parent;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->childmask	= childmask;
+		__entry->active		= state.active;
+		__entry->migrator	= state.migrator;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%0x migrator=%0x "
+		  "parent=%p childmask=%0x",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator,
+		  __entry->parent, __entry->childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( u64,		wakeup	)
+		__field( void *,	parent	)
+		__field( unsigned int,	cpu	)
+
+	),
+
+	TP_fast_assign(
+		__entry->wakeup		= tmc->wakeup;
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+	),
+
+	TP_printk("cpu=%d parent=%p wakeup=%llu", __entry->cpu, __entry->parent, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DECLARE_EVENT_CLASS(tmigr_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt),
+
+	TP_STRUCT__entry(
+		__field( u64,		nextevt)
+		__field( u64,		wakeup)
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+	),
+
+	TP_fast_assign(
+		__entry->nextevt	= nextevt;
+		__entry->wakeup		= tmc->wakeup;
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+	),
+
+	TP_printk("cpu=%d parent=%p nextevt=%llu wakeup=%llu",
+		  __entry->cpu, __entry->parent, __entry->nextevt, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_new_timer_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+TRACE_EVENT(tmigr_update_events,
+
+	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
+		 union tmigr_state childstate,	union tmigr_state groupstate,
+		 u64 nextevt),
+
+	TP_ARGS(child, group, childstate, groupstate, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	child			)
+		__field( void *,	group			)
+		__field( u64,		nextevt			)
+		__field( u64,		group_next_expiry	)
+		__field( u64,		child_evt_expiry	)
+		__field( unsigned int,	group_lvl		)
+		__field( unsigned int,	child_evtcpu		)
+		__field( u8,		child_active		)
+		__field( u8,		group_active		)
+	),
+
+	TP_fast_assign(
+		__entry->child			= child;
+		__entry->group			= group;
+		__entry->nextevt		= nextevt;
+		__entry->group_next_expiry	= group->next_expiry;
+		__entry->child_evt_expiry	= child ? child->groupevt.nextevt.expires : 0;
+		__entry->group_lvl		= group->level;
+		__entry->child_evtcpu		= child ? child->groupevt.cpu : 0;
+		__entry->child_active		= childstate.active;
+		__entry->group_active		= groupstate.active;
+	),
+
+	TP_printk("child=%p group=%p group_lvl=%d child_active=%0x group_active=%0x "
+		  "nextevt=%llu next_expiry=%llu child_evt_expiry=%llu child_evtcpu=%d",
+		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_active,
+		  __entry->group_active,
+		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
+		  __entry->child_evtcpu)
+);
+
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void * ,	group	)
+		__field( unsigned int ,	lvl	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+	),
+
+	TP_printk("group=%p lvl=%d",
+		   __entry->group, __entry->lvl)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 23cb6ea..d85aa2a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -14,6 +14,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 /*
  * The timer migration mechanism is built on a hierarchy of groups. The
  * lowest level group contains CPUs, the next level groups of CPU groups
@@ -663,6 +666,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -672,6 +677,8 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 
 	data.childmask = tmc->childmask;
 
+	trace_tmigr_cpu_active(tmc);
+
 	tmc->cpuevt.ignore = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -829,6 +836,9 @@ check_toplvl:
 		data->firstexp = tmigr_next_groupevt_expires(group);
 	}
 
+	trace_tmigr_update_events(child, group, childstate, groupstate,
+				  nextexp);
+
 unlock:
 	raw_spin_unlock(&group->lock);
 
@@ -863,6 +873,8 @@ static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
 	if (tmc->remote)
 		return KTIME_MAX;
 
+	trace_tmigr_cpu_new_timer(tmc);
+
 	tmc->cpuevt.ignore = false;
 	data.remote = false;
 
@@ -904,6 +916,8 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 		return;
 	}
 
+	trace_tmigr_handle_remote_cpu(tmc);
+
 	tmc->remote = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -984,6 +998,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 
 	childmask = data->childmask;
 
+	trace_tmigr_handle_remote(group);
 again:
 	/*
 	 * Handle the group only if @childmask is the migrator or if the
@@ -1206,6 +1221,7 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1298,6 +1314,8 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	 */
 	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
 
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -1350,6 +1368,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1467,6 +1486,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -1484,6 +1504,8 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
 
+	trace_tmigr_connect_child_parent(child);
+
 	/*
 	 * To prevent inconsistent states, active children need to be active in
 	 * the new parent as well. Inactive children are already marked inactive
@@ -1575,6 +1597,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 			raw_spin_unlock_irq(&group->lock);
 
+			trace_tmigr_connect_cpu_parent(tmc);
+
 			/* There are no children that need to be connected */
 			continue;
 		} else {
@@ -1642,6 +1666,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 	}
 	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
 	tmc->idle = timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
@@ -1681,6 +1706,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {

