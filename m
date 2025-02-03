Return-Path: <linux-tip-commits+bounces-3304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C5A259B7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B6A1640FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D36204C02;
	Mon,  3 Feb 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wj1DGhJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ls2WUsPQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED92040B5;
	Mon,  3 Feb 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586901; cv=none; b=Pg+arxQw3AjfZEJEU4k0DCwacPfOrAaPx/LRFeyLpa6P1uxBHlf0rNnc1vZwbgiDeQaEXtzwuk156e4ES2HjcJzUD8Xow8sqDyVwbWq9oZmmrIJ/F1NMff57xFjy6yMOgDtfsfwYm8j/cLcffAv5UpfcIooKcoeLTCFbMSq0mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586901; c=relaxed/simple;
	bh=+vgyv3Yw9NY0h3VzIiESYamsvGVlA8aZEZouU78+3QA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sh48ymlctYhikgSap52FTC+nhxqpMEUD75vrocdd7j1gPx6KXw11bWKeLxnpuxoOjaxfWONIAlXLrFfol4wkq+OitD/U4PWM2iFdtkY5JtcelInk7l/DGAemKcyUtJXoyN60/iLADy4Fw/QeW5Nx6IzTyTpB01hs42wEVtLYqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wj1DGhJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ls2WUsPQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLhMVIZ6z9NOUxstX01OHKEOl+mAHIv7x2LahfuW3bw=;
	b=wj1DGhJrFoYsZDW1/gcF0FeOhpvEedSTJRaRPPznJTeSFeB/+af6qxwqkBfzSGLBFlMnZH
	wf+5iY1OArPGuWRPGKHva9uBZnVErWgBM5srg/DA6Seb8xMUSKIkVPdUzRtCOEcjNpI476
	eS/vllVDB/a4ScwwmeUMYZY+dyaiaoKO8RTV83k5CIDdfCH9f1x5vYM2ms7/ePNRlNIZcd
	nsdMmZWR3TIhlRaKG1Pqs1W3QzlE4kFQZPGnQHJZ75465PgCDBpK6+5iTFYejTJxr9fE65
	Sc0Posi1sn3oCnuN02ISQ6wbvv7UuocInQo+LRMkFxXwiFUxBR3XBvDyj2Rhog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLhMVIZ6z9NOUxstX01OHKEOl+mAHIv7x2LahfuW3bw=;
	b=Ls2WUsPQ4Lo2PQE4IWeW1kcWkeSn+BITWIhfAo1KSjweOH7PYLOh4LqNN8eazesVRf6vP5
	bQGDRHV9U9UcpPCQ==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Avoid the read if the count is already updated
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250121152303.3128733-3-kan.liang@linux.intel.com>
References: <20250121152303.3128733-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689553.10177.15768949365370071707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     186dbd9cd489e7f895f909d336c58e4ba2f660a1
Gitweb:        https://git.kernel.org/tip/186dbd9cd489e7f895f909d336c58e4ba2f660a1
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 21 Jan 2025 07:23:02 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:07 +01:00

perf: Avoid the read if the count is already updated

The event may have been updated in the PMU-specific implementation,
e.g., Intel PEBS counters snapshotting. The common code should not
read and overwrite the value.

The PERF_SAMPLE_READ in the data->sample_type can be used to detect
whether the PMU-specific value is available. If yes, avoid the
pmu->read() in the common code. Add a new flag, skip_read, to track the
case.

Factor out a perf_pmu_read() to clean up the code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250121152303.3128733-3-kan.liang@linux.intel.com
---
 include/linux/perf_event.h  |  8 +++++++-
 kernel/events/core.c        | 33 ++++++++++++++++-----------------
 kernel/events/ring_buffer.c |  1 +
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f13..2d07bc1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1062,7 +1062,13 @@ struct perf_output_handle {
 	struct perf_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
-	u64				aux_flags;
+	union {
+		u64			flags;		/* perf_output*() */
+		u64			aux_flags;	/* perf_aux_output*() */
+		struct {
+			u64		skip_read : 1;
+		};
+	};
 	union {
 		void			*addr;
 		unsigned long		head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e0..0f8c559 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1191,6 +1191,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
 }
 
+static inline void perf_pmu_read(struct perf_event *event)
+{
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		event->pmu->read(event);
+}
+
 static void get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
@@ -3473,8 +3479,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4618,15 +4623,8 @@ static void __perf_event_read(void *info)
 
 	pmu->read(event);
 
-	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
-			/*
-			 * Use sibling's PMU rather than @event's since
-			 * sibling could be on different (eg: software) PMU.
-			 */
-			sub->pmu->read(sub);
-		}
-	}
+	for_each_sibling_event(sub, event)
+		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
 
@@ -7444,9 +7442,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
@@ -7459,9 +7456,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
@@ -7520,6 +7516,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1805091..59a52b1 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -185,6 +185,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {

