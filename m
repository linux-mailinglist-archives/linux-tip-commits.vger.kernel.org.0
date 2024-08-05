Return-Path: <linux-tip-commits+bounces-1941-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8689C947AC2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0C71C20306
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B0158D87;
	Mon,  5 Aug 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FP0lXzR7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJ0zVkxe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00069157A6C;
	Mon,  5 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858971; cv=none; b=XKNGr1F5ZViPXjg+gIFfd4Sq63oegnyAx8BW8/uQB7AnkLUzpAvNEfcSx5WgWJ83sqUZPmtAvCfWqCtMg84YK4emkX7vS54F1z9YttGPX4J5eI47O9VEg/Vspfz0Dim+HJSHGyDe56MRpcjOUwFgnMoPFKKSCDf9SzuH9bm2vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858971; c=relaxed/simple;
	bh=o6XipFEWDDhf/NF1XdKeEQT012R5AlL2Ls6LigeCIKU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VuvDE8NjDuZBDBeUL9n96TOuRNnRuEhnW2eIAFp1hrajkphBOPfLiuTPaRbCxPXeOEz8t89ge8mX4Bmit3MfdbjwIzGWM2uzMS2NyojSqWLdTzSlpQ2tDwMSwr8L/kMKAQXR6kymMNLlunVheFZVJ+4P8E1Wv5u4qkqMCI0Dpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FP0lXzR7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJ0zVkxe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncuNCw4lPVau5fwyJQMnDXnyyTFrunoBcsPAWjGJelQ=;
	b=FP0lXzR72M4HKl74tPDNrSlJ+nqAY4Nw9pDFd/NMABC1oBgzKtAGna3x4IMPYcPbF67K4l
	Gcd4IrwFBl64VoHy3buHsOUvU0NFsfeVssAyUwAITt/MwIw07htgCI9T615aljVgKLWnEO
	hr24AtpPkxYl4Sw5EyKERc4w6aq3xIeGvIhA2dyxFj7L91KQ4DYvS0+tqxPef4jqcmXYKI
	JBeDyHAdBMXvC3UcXr/GKp+2mpHtWX8GNUt9csgbu9UlGGO370sJ9Vox0wPu4pYn2GRBUW
	u3IGbL11Cjdm4BimwUL1yrbDNmlBes5bbTCrHdUWlLbTB1atHn71F38VfN5XQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncuNCw4lPVau5fwyJQMnDXnyyTFrunoBcsPAWjGJelQ=;
	b=aJ0zVkxe6yBi1nUleONIz0eLFfzUC8EuBdfgeoAbCa/YMeNM1+FBsrWdsE9MzTMl4QGeD3
	pq8v2RMnOogBZnAA==
From: "tip-bot2 for Ben Gainey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Support PERF_SAMPLE_READ with inherit
Cc: Ben Gainey <ben.gainey@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730084417.7693-3-ben.gainey@arm.com>
References: <20240730084417.7693-3-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896694.2215.11840827765221233368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7e8b255650fcfa1d05a57e4093d8405e6d8dd488
Gitweb:        https://git.kernel.org/tip/7e8b255650fcfa1d05a57e4093d8405e6d8dd488
Author:        Ben Gainey <ben.gainey@arm.com>
AuthorDate:    Tue, 30 Jul 2024 09:44:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:30 +02:00

perf: Support PERF_SAMPLE_READ with inherit

This change allows events to use PERF_SAMPLE_READ with inherit
so long as PERF_SAMPLE_TID is also set. This enables sample based
profiling of a group of counters over a hierarchy of processes or
threads. This is useful, for example, for collecting per-thread
counters/metrics, event based sampling of multiple counters as a unit,
access to the enabled and running time when using multiplexing and so
on.

Prior to this, users were restricted to either collecting aggregate
statistics for a multi-threaded/-process application (e.g. with
"perf stat"), or to sample individual threads, or to profile the entire
system (which requires root or CAP_PERFMON, and may produce much more
data than is required). Theoretically a tool could poll for or otherwise
monitor thread/process creation and construct whatever events the user
is interested in using perf_event_open, for each new thread or process,
but this is racy, can lead to file-descriptor exhaustion, and ultimately
just replicates the behaviour of inherit, but in userspace.

This configuration differs from inherit without PERF_SAMPLE_READ in that
the accumulated event count, and consequently any sample (such as if
triggered by overflow of sample_period) will be on a per-thread rather
than on an aggregate basis.

The meaning of read_format::value field of both PERF_RECORD_READ and
PERF_RECORD_SAMPLE is changed such that if the sampled event uses this
new configuration then the values reported will be per-thread rather
than the global aggregate value. This is a change from the existing
semantics of read_format (where PERF_SAMPLE_READ is used without
inherit), but it is necessary to expose the per-thread counter values,
and it avoids reinventing a separate "read_format_thread" field that
otherwise replicates the same behaviour. This change should not break
existing tools, since this configuration was not previously valid and
was rejected by the kernel. Tools that opt into this new mode will need
to account for this when calculating the counter delta for a given
sample. Tools that wish to have both the per-thread and aggregate value
can perform the global aggregation themselves from the per-thread
values.

The change to read_format::value does not affect existing valid
perf_event_attr configurations, nor does it change the behaviour of
calls to "read" on an event descriptor. Both continue to report the
aggregate value for the entire thread/process hierarchy. The difference
between the results reported by "read" and PERF_RECORD_SAMPLE in this
new configuration is justified on the basis that it is not (easily)
possible for "read" to target a specific thread (the caller only has
the fd for the original parent event).

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240730084417.7693-3-ben.gainey@arm.com
---
 include/linux/perf_event.h |  3 ++-
 kernel/events/core.c       | 55 +++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 655f66b..7015499 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -969,6 +969,9 @@ struct perf_event_context {
 	 * The count of events for which using the switch-out fast path
 	 * should be avoided.
 	 *
+	 * Sum (event->pending_work + events with
+	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
+	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
 	 */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e6cc354..c01a326 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1768,6 +1768,14 @@ perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
 				typeof(*event), group_node))
 
 /*
+ * Does the event attribute request inherit with PERF_SAMPLE_READ
+ */
+static inline bool has_inherit_and_sample_read(struct perf_event_attr *attr)
+{
+	return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
+}
+
+/*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
  */
@@ -1797,6 +1805,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
+	if (has_inherit_and_sample_read(&event->attr))
+		local_inc(&ctx->nr_no_switch_fast);
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2021,6 +2031,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
+	if (has_inherit_and_sample_read(&event->attr))
+		local_dec(&ctx->nr_no_switch_fast);
 
 	list_del_rcu(&event->event_entry);
 
@@ -3522,6 +3534,11 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
+				 *
+				 * Likewise, when a context contains inherit +
+				 * SAMPLE_READ events they should be switched
+				 * out using the slow path so that they are
+				 * treated as if they were distinct contexts.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -4538,8 +4555,11 @@ unlock:
 	raw_spin_unlock(&ctx->lock);
 }
 
-static inline u64 perf_event_count(struct perf_event *event)
+static inline u64 perf_event_count(struct perf_event *event, bool self)
 {
+	if (self)
+		return local64_read(&event->count);
+
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -5498,7 +5518,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 	mutex_lock(&event->child_mutex);
 
 	(void)perf_event_read(event, false);
-	total += perf_event_count(event);
+	total += perf_event_count(event, false);
 
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5507,7 +5527,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 
 	list_for_each_entry(child, &event->child_list, child_list) {
 		(void)perf_event_read(child, false);
-		total += perf_event_count(child);
+		total += perf_event_count(child, false);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -5589,14 +5609,14 @@ static int __perf_read_group_add(struct perf_event *leader,
 	/*
 	 * Write {count,id} tuples for every sibling.
 	 */
-	values[n++] += perf_event_count(leader);
+	values[n++] += perf_event_count(leader, false);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
-		values[n++] += perf_event_count(sub);
+		values[n++] += perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -6176,7 +6196,7 @@ void perf_event_update_userpage(struct perf_event *event)
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-	userpg->offset = perf_event_count(event);
+	userpg->offset = perf_event_count(event, false);
 	if (userpg->index)
 		userpg->offset -= local64_read(&event->hw.prev_count);
 
@@ -7250,7 +7270,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	u64 values[5];
 	int n = 0;
 
-	values[n++] = perf_event_count(event);
+	values[n++] = perf_event_count(event, has_inherit_and_sample_read(&event->attr));
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
 		values[n++] = enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -7268,14 +7288,15 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 }
 
 static void perf_output_read_group(struct perf_output_handle *handle,
-			    struct perf_event *event,
-			    u64 enabled, u64 running)
+				   struct perf_event *event,
+				   u64 enabled, u64 running)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
 	unsigned long flags;
 	u64 values[6];
 	int n = 0;
+	bool self = has_inherit_and_sample_read(&event->attr);
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling
@@ -7295,7 +7316,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
-	values[n++] = perf_event_count(leader);
+	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
@@ -7310,7 +7331,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
-		values[n++] = perf_event_count(sub);
+		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -7331,6 +7352,10 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * The problem is that its both hard and excessively expensive to iterate the
  * child list, not to mention that its impossible to IPI the children running
  * on another CPU, from interrupt/NMI context.
+ *
+ * Instead the combination of PERF_SAMPLE_READ and inherit will track per-thread
+ * counts rather than attempting to accumulate some value across all children on
+ * all cores.
  */
 static void perf_output_read(struct perf_output_handle *handle,
 			     struct perf_event *event)
@@ -12057,10 +12082,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
+	 * collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
@@ -13084,7 +13111,7 @@ static void sync_child_event(struct perf_event *child_event)
 			perf_event_read_event(child_event, task);
 	}
 
-	child_val = perf_event_count(child_event);
+	child_val = perf_event_count(child_event, false);
 
 	/*
 	 * Add back the child's count to the parent's count:

