Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1765E42EDB4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhJOJeI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:34:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbhJOJeH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:34:07 -0400
Date:   Fri, 15 Oct 2021 09:31:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634290320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSoOUtYA7bwy44WSq03/muUyqky9fS+xRlonZ9i09JM=;
        b=Wh6J/4FsqDbmobGreAHEL5CdutB2HjdhaDz+KhKvoJvW1tmYLLN/xgqEbz9Gb+X0ottkUM
        h1rOEr6mHpWg4GkdsuLsYafKp7/UFRjQOqawQw+BneZqRNXM3BEKPDrMCoGt17JlQ140lw
        3wlGfz1rGelIZvkFteh9KMbYsB94gEWyEGEDJfNzwMfy082xXZr1Hemppz0vuXqfJoxxx1
        HHH7Fh6X4f+zc5Si5V+XE+Fl1NBnDyHBvFli6tDMZ7UISOes12HMtoygkx6lcq/lctq/K9
        W93b4z9fvxiL9Zfr6rZ0d93J5MFjRkfptYc1CQVBEqHfcAP5HgOLmu30X5I6IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634290320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSoOUtYA7bwy44WSq03/muUyqky9fS+xRlonZ9i09JM=;
        b=l1BbPEdqAnCSjJIrZpt9kVoYvcJsj+fxObekk4iUZg+IGtzXwZtSaqw+8orkXPLCkif6jA
        ukxyKtRbqBATF3Cw==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add new event for AUX output counter index
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210907163903.11820-2-adrian.hunter@intel.com>
References: <20210907163903.11820-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <163429031961.25758.11911893498592891626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8b8ff8cc3b8155c18162e8b1f70e1230db176862
Gitweb:        https://git.kernel.org/tip/8b8ff8cc3b8155c18162e8b1f70e1230db176862
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 07 Sep 2021 19:39:01 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:31 +02:00

perf/x86: Add new event for AUX output counter index

PEBS-via-PT records contain a mask of applicable counters. To identify
which event belongs to which counter, a side-band event is needed. Until
now, there has been no side-band event, and consequently users were limited
to using a single event.

Add such a side-band event. Note the event is optimised to output only
when the counter index changes for an event. That works only so long as
all PEBS-via-PT events are scheduled together, which they are for a
recording session because they are in a single group.

Also no attribute bit is used to select the new event, so a new
kernel is not compatible with older perf tools.  The assumption
being that PEBS-via-PT is sufficiently esoteric that users will not
be troubled by this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210907163903.11820-2-adrian.hunter@intel.com
---
 arch/x86/events/core.c          |  6 ++++++
 arch/x86/events/intel/core.c    | 16 ++++++++++++++++
 arch/x86/events/perf_event.h    |  1 +
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 30 ++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbe..be33423 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -66,6 +66,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
 DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
 DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_assign, *x86_pmu.assign);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
@@ -1215,6 +1217,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
+	static_call_cond(x86_pmu_assign)(event, idx);
+
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
 	case INTEL_PMC_IDX_FIXED_VLBR:
@@ -2005,6 +2009,8 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_enable, x86_pmu.enable);
 	static_call_update(x86_pmu_disable, x86_pmu.disable);
 
+	static_call_update(x86_pmu_assign, x86_pmu.assign);
+
 	static_call_update(x86_pmu_add, x86_pmu.add);
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87..a555e7c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2402,6 +2402,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		intel_pmu_pebs_disable(event);
 }
 
+static void intel_pmu_assign_event(struct perf_event *event, int idx)
+{
+	if (is_pebs_pt(event))
+		perf_report_aux_output_id(event, idx);
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
 }
 
+static void intel_aux_output_init(void)
+{
+	/* Refer also intel_pmu_aux_output_match() */
+	if (x86_pmu.intel_cap.pebs_output_pt_available)
+		x86_pmu.assign = intel_pmu_assign_event;
+}
+
 static int intel_pmu_aux_output_match(struct perf_event *event)
 {
+	/* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
 	if (!x86_pmu.intel_cap.pebs_output_pt_available)
 		return 0;
 
@@ -6301,6 +6315,8 @@ __init int intel_pmu_init(void)
 	if (is_hybrid())
 		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
 
+	intel_aux_output_init();
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c..76436a5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -726,6 +726,7 @@ struct x86_pmu {
 	void		(*enable_all)(int added);
 	void		(*enable)(struct perf_event *);
 	void		(*disable)(struct perf_event *);
+	void		(*assign)(struct perf_event *event, int idx);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad..126b3a3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1397,6 +1397,7 @@ perf_event_addr_filters(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a..c89535d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1141,6 +1141,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * Data written to the AUX area by hardware due to aux_output, may need
+	 * to be matched to the event by an architecture-specific hardware ID.
+	 * This records the hardware ID, but requires sample_id to provide the
+	 * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
+	 * records from multiple events.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				hw_id;
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b..0e90a50 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9062,6 +9062,36 @@ static void perf_log_itrace_start(struct perf_event *event)
 	perf_output_end(&handle);
 }
 
+void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+{
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	struct perf_aux_event {
+		struct perf_event_header        header;
+		u64				hw_id;
+	} rec;
+	int ret;
+
+	if (event->parent)
+		event = event->parent;
+
+	rec.header.type	= PERF_RECORD_AUX_OUTPUT_HW_ID;
+	rec.header.misc	= 0;
+	rec.header.size	= sizeof(rec);
+	rec.hw_id	= hw_id;
+
+	perf_event_header__init_id(&rec.header, &sample, event);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
+
+	if (ret)
+		return;
+
+	perf_output_put(&handle, rec);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
 {
