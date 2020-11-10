Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5B2AD6A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgKJMpm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgKJMp0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:26 -0500
Date:   Tue, 10 Nov 2020 12:45:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+wEO3yfCgEOcatsOGq3nf8Xr0KlnOeyqFrHKdprLKg=;
        b=oJJCf4SvXJJWEj/ukdZ0zh7uEF6CL5174TY4L87ZKzBJ4YxEpOLGwXtrve66oO4TvU9ksH
        B7rJH2x4WblK4QrdOMHqJWCN+iuu1L4E8qiLeG7pZZhb5kqVz+iQ7NKMIGDlozAtgmI8bb
        3vnOyxnoaYEYQlWY6oQ4Y8WPge8CAUj7rJvmY9/2UHMIDB6JADGEKaASEmB7MKMk/Gqgt9
        oWJ1ecl0mQt9AZvrLxtZhdiZ9bkhQ8mLMrWqGFt/0w1UPXwk9r7pNNKyde+1QiVR2qRPRb
        bZugy8YbnFskB9FRl5O1g0ld7X2LMwCGfACvrTf1nNSsVsH2QqOiCtoELt9o9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+wEO3yfCgEOcatsOGq3nf8Xr0KlnOeyqFrHKdprLKg=;
        b=+CtYae1ibyF1kqPPNFj804T2w90h379dmUygyzioyLq1mqiPSny5HcZ+XNH0SFKiMxGSGZ
        nCtPnIuzc1JCNyCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Reduce stack usage of perf_output_begin()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151954.985416146@infradead.org>
References: <20201030151954.985416146@infradead.org>
MIME-Version: 1.0
Message-ID: <160501232293.11244.420564850722679107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     267fb27352b6fc9fdbad753127a239f75618ecbc
Gitweb:        https://git.kernel.org/tip/267fb27352b6fc9fdbad753127a239f75618ecbc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 15:50:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:33 +01:00

perf: Reduce stack usage of perf_output_begin()

__perf_output_begin() has an on-stack struct perf_sample_data in the
unlikely case it needs to generate a LOST record. However, every call
to perf_output_begin() must already have a perf_sample_data on-stack.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201030151954.985416146@infradead.org
---
 arch/powerpc/perf/imc-pmu.c     |  2 +-
 arch/s390/kernel/perf_cpum_sf.c |  2 +-
 arch/x86/events/intel/ds.c      |  4 ++--
 include/linux/perf_event.h      |  7 +++++--
 kernel/events/core.c            | 32 +++++++++++++++++---------------
 kernel/events/ring_buffer.c     | 20 +++++++++++---------
 6 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ed4fcc..7b25548 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1336,7 +1336,7 @@ static void dump_trace_imc_data(struct perf_event *event)
 			/* If this is a valid record, create the sample */
 			struct perf_output_handle handle;
 
-			if (perf_output_begin(&handle, event, header.size))
+			if (perf_output_begin(&handle, &data, event, header.size))
 				return;
 
 			perf_output_sample(&handle, &header, &data, event);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 4f9e462..00255ae 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -672,7 +672,7 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 	rcu_read_lock();
 
 	perf_prepare_sample(&header, data, event, regs);
-	if (perf_output_begin(&handle, event, header.size))
+	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
 	/* Update the process ID (see also kernel/events/core.c) */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315d..cd2ae14 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -642,8 +642,8 @@ int intel_pmu_drain_bts_buffer(void)
 	rcu_read_lock();
 	perf_prepare_sample(&header, &data, event, &regs);
 
-	if (perf_output_begin(&handle, event, header.size *
-			      (top - base - skip)))
+	if (perf_output_begin(&handle, &data, event,
+			      header.size * (top - base - skip)))
 		goto unlock;
 
 	for (at = base; at < top; at++) {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d27..b775ae0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1400,11 +1400,14 @@ perf_event_addr_filters(struct perf_event *event)
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
+			     struct perf_sample_data *data,
 			     struct perf_event *event, unsigned int size);
 extern int perf_output_begin_forward(struct perf_output_handle *handle,
-				    struct perf_event *event,
-				    unsigned int size);
+				     struct perf_sample_data *data,
+				     struct perf_event *event,
+				     unsigned int size);
 extern int perf_output_begin_backward(struct perf_output_handle *handle,
+				      struct perf_sample_data *data,
 				      struct perf_event *event,
 				      unsigned int size);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a29ab0..fc681c7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7186,6 +7186,7 @@ __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
 		    int (*output_begin)(struct perf_output_handle *,
+					struct perf_sample_data *,
 					struct perf_event *,
 					unsigned int))
 {
@@ -7198,7 +7199,7 @@ __perf_event_output(struct perf_event *event,
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	err = output_begin(&handle, event, header.size);
+	err = output_begin(&handle, data, event, header.size);
 	if (err)
 		goto exit;
 
@@ -7264,7 +7265,7 @@ perf_event_read_event(struct perf_event *event,
 	int ret;
 
 	perf_event_header__init_id(&read_event.header, &sample, event);
-	ret = perf_output_begin(&handle, event, read_event.header.size);
+	ret = perf_output_begin(&handle, &sample, event, read_event.header.size);
 	if (ret)
 		return;
 
@@ -7533,7 +7534,7 @@ static void perf_event_task_output(struct perf_event *event,
 
 	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7636,7 +7637,7 @@ static void perf_event_comm_output(struct perf_event *event,
 		return;
 
 	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
 
 	if (ret)
@@ -7736,7 +7737,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 
 	perf_event_header__init_id(&namespaces_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7863,7 +7864,7 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&cgroup_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7989,7 +7990,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	}
 
 	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -8299,7 +8300,7 @@ void perf_event_aux_event(struct perf_event *event, unsigned long head,
 	int ret;
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
@@ -8333,7 +8334,7 @@ void perf_log_lost_samples(struct perf_event *event, u64 lost)
 
 	perf_event_header__init_id(&lost_samples_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
 	if (ret)
 		return;
@@ -8388,7 +8389,7 @@ static void perf_event_switch_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&se->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, se->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event, se->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8463,7 +8464,7 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 
 	perf_event_header__init_id(&throttle_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
 	if (ret)
 		return;
@@ -8506,7 +8507,7 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&ksymbol_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8596,7 +8597,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&bpf_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, data, event,
 				bpf_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8705,7 +8706,8 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event,
+				text_poke_event->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8786,7 +8788,7 @@ static void perf_log_itrace_start(struct perf_event *event)
 	rec.tid	= perf_event_tid(event, current);
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 192b8ab..ef91ae7 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -147,6 +147,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 
 static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
+		    struct perf_sample_data *data,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
 {
@@ -237,18 +238,16 @@ __perf_output_begin(struct perf_output_handle *handle,
 	handle->size = (1UL << page_shift) - offset;
 
 	if (unlikely(have_lost)) {
-		struct perf_sample_data sample_data;
-
 		lost_event.header.size = sizeof(lost_event);
 		lost_event.header.type = PERF_RECORD_LOST;
 		lost_event.header.misc = 0;
 		lost_event.id          = event->id;
 		lost_event.lost        = local_xchg(&rb->lost, 0);
 
-		perf_event_header__init_id(&lost_event.header,
-					   &sample_data, event);
+		/* XXX mostly redundant; @data is already fully initializes */
+		perf_event_header__init_id(&lost_event.header, data, event);
 		perf_output_put(handle, lost_event);
-		perf_event__output_id_sample(event, handle, &sample_data);
+		perf_event__output_id_sample(event, handle, data);
 	}
 
 	return 0;
@@ -263,22 +262,25 @@ out:
 }
 
 int perf_output_begin_forward(struct perf_output_handle *handle,
-			     struct perf_event *event, unsigned int size)
+			      struct perf_sample_data *data,
+			      struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, false);
+	return __perf_output_begin(handle, data, event, size, false);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
+			       struct perf_sample_data *data,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, true);
+	return __perf_output_begin(handle, data, event, size, true);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
+		      struct perf_sample_data *data,
 		      struct perf_event *event, unsigned int size)
 {
 
-	return __perf_output_begin(handle, event, size,
+	return __perf_output_begin(handle, data, event, size,
 				   unlikely(is_write_backward(event)));
 }
 
