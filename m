Return-Path: <linux-tip-commits+bounces-1784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47093F28C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE471C21D53
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A32144306;
	Mon, 29 Jul 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yScXZ2XC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ec/ptAcY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956A143C4A;
	Mon, 29 Jul 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248691; cv=none; b=T86GouETHRDUqUma5MRf9Xg37Xkl6EmImY2swZKbESc0FIMQeJBLPlUkuXuP6WR7Y97UvODHq5llnN+hIOTIpCgQwN0E08y2YC6PTB2OU7f1b9AQNxSf75okk3Xsw2qYpbULz5Q3vXIB0FZ1vy84HI7q/c3r2X3tSB52Yhy0g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248691; c=relaxed/simple;
	bh=mUgzmpq8aqkI2ActPXZcFigbfhQGjW8qsCOEnRYhxf0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pgtRP+RgD/hU3cObjmps1tKvFm7LaeFjhKezgBM9+A6M3iUq/+p8fAihCIhsAjBQPGWzPToWyEBF3X9RW/o27Zqx9+MfomxupE7TeMJuXIOrqAJWdfY46ov9DTNmjmrF6vK0KiboK6Bm/WUQO29DKnbHSusR2PxOdylP7bBYEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yScXZ2XC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ec/ptAcY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:24:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VoNeuAs4QcCyEZZNxyCJ70KHC8cv/O7zhgST6BJe78=;
	b=yScXZ2XCoNS+nEowbTF7HjGl21JeusvhLgj3ttKxEJ1k2cihergaaqBbYRPfkuPyJoJfHl
	vRrLofdOQMGo4al7Fdh2qgcc2J68pYdUNTipSGsuxnMEDAMdl0pUCa6NR0GeowOgzSZrgc
	ihQ7Sua2gEyxKCcMWMo1ZpSy9r3GkAqzhuYFMPJix/HEUE9w5m4gKSEfnlTpYdpMDkFuNO
	300sDHBHCQHlMmqTwHRa1xRjBv7vmF9M38nqRz26wZ/XjQBwLcA4BY8IsjDQsYtPMPfkN3
	8Ambz0VSDt6hmeDC+BEW6RH2rgVZJ5tGjMUENh+q3PWTbYNL7lPAIEiMBX9pPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VoNeuAs4QcCyEZZNxyCJ70KHC8cv/O7zhgST6BJe78=;
	b=ec/ptAcYOs/lUC9HHsU7IEUl0lNLOpOpHrArk7/4p/ArxgzWPt5STViv+fwvjkWOaVr0NV
	lymO3s/yXhjRjiDg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Add support for pause / resume
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240715160712.127117-4-adrian.hunter@intel.com>
References: <20240715160712.127117-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224868781.2215.8261334240797060161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6a45d8847597727960020d9c38faa0b43407be4b
Gitweb:        https://git.kernel.org/tip/6a45d8847597727960020d9c38faa0b43407be4b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 15 Jul 2024 19:07:02 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:16:24 +02:00

perf/x86/intel/pt: Add support for pause / resume

Prevent tracing to start if aux_paused.

Implement support for PERF_EF_PAUSE / PERF_EF_RESUME. When aux_paused, stop
tracing. When not aux_paused, only start tracing if it isn't currently
meant to be stopped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20240715160712.127117-4-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 69 +++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h |  4 ++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a..a35caec 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 ctl = event->hw.aux_config;
 
+	if (READ_ONCE(event->hw.aux_paused))
+		return;
+
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
@@ -534,7 +537,21 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.aux_config = reg;
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	barrier();
+	WRITE_ONCE(pt->resume_allowed, 1);
+	barrier();
 	pt_config_start(event);
+	barrier();
+	/*
+	 * Allow pause after starting so its pt_config_stop() doesn't race with
+	 * pt_config_start().
+	 */
+	WRITE_ONCE(pt->pause_allowed, 1);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1511,6 +1528,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1519,6 +1537,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1573,6 +1592,26 @@ static void pt_event_start(struct perf_event *event, int mode)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	struct pt_buffer *buf;
 
+	if (mode & PERF_EF_RESUME) {
+		if (READ_ONCE(pt->resume_allowed)) {
+			u64 status;
+
+			/*
+			 * Only if the trace is not active and the error and
+			 * stopped bits are clear, is it safe to start, but a
+			 * PMI might have just cleared these, so resume_allowed
+			 * must be checked again also.
+			 */
+			rdmsrl(MSR_IA32_RTIT_STATUS, status);
+			if (!(status & (RTIT_STATUS_TRIGGEREN |
+					RTIT_STATUS_ERROR |
+					RTIT_STATUS_STOPPED)) &&
+			   READ_ONCE(pt->resume_allowed))
+				pt_config_start(event);
+		}
+		return;
+	}
+
 	buf = perf_aux_output_begin(&pt->handle, event);
 	if (!buf)
 		goto fail_stop;
@@ -1601,6 +1640,12 @@ static void pt_event_stop(struct perf_event *event, int mode)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 
+	if (mode & PERF_EF_PAUSE) {
+		if (READ_ONCE(pt->pause_allowed))
+			pt_config_stop(event);
+		return;
+	}
+
 	/*
 	 * Protect against the PMI racing with disabling wrmsr,
 	 * see comment in intel_pt_interrupt().
@@ -1608,6 +1653,15 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 0);
 	barrier();
 
+	/*
+	 * Prevent a resume from attempting to restart tracing, or a pause
+	 * during a subsequent start. Do this after clearing handle_nmi so that
+	 * pt_event_snapshot_aux() will not re-allow them.
+	 */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
+
 	pt_config_stop(event);
 
 	if (event->hw.state == PERF_HES_STOPPED)
@@ -1657,6 +1711,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	if (WARN_ON_ONCE(!buf->snapshot))
 		return 0;
 
+	/* Prevent pause/resume from attempting to start/stop tracing */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
 	/*
 	 * There is no PT interrupt in this mode, so stop the trace and it will
 	 * remain stopped while the buffer is copied.
@@ -1676,8 +1734,13 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	 * Here, handle_nmi tells us if the tracing was on.
 	 * If the tracing was on, restart it.
 	 */
-	if (READ_ONCE(pt->handle_nmi))
+	if (READ_ONCE(pt->handle_nmi)) {
+		WRITE_ONCE(pt->resume_allowed, 1);
+		barrier();
 		pt_config_start(event);
+		barrier();
+		WRITE_ONCE(pt->pause_allowed, 1);
+	}
 
 	return ret;
 }
@@ -1793,7 +1856,9 @@ static __init int pt_init(void)
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
-	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index f5e46c0..84246c8 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -117,6 +117,8 @@ struct pt_filters {
  * @filters:		last configured filters
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
+ * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
+ * @resume_allowed:	PERF_EF_RESUME is allowed to start tracing
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
@@ -125,6 +127,8 @@ struct pt {
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	int			pause_allowed;
+	int			resume_allowed;
 	u64			output_base;
 	u64			output_mask;
 };

