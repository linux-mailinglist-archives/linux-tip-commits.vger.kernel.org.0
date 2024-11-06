Return-Path: <linux-tip-commits+bounces-2764-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353469BE4B5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590F81C235EC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E801DE4F6;
	Wed,  6 Nov 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWgrEl8Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6oDxKC8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD491DE4EA;
	Wed,  6 Nov 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890108; cv=none; b=pBqypMoFK/kmxFRYOD67xfnO5Nd8GQAI7AUKHZMt3nvDQFI0DdvS39emP6qpAafbjPPPna7dKS6ABi9EQ0Pb83XS+5SuDziEMR9ngBzQRPJjik5/6FDR+fDOHsyWkCW31XYku16NWc8VdvAVHlsNCvUyeSd+CME5gsaQ7mte4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890108; c=relaxed/simple;
	bh=RH+P9d4Jb5rHKZD7KqZXJ+Ylt+QD7kJIArEKN92dKDA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CTah4dpI169L6K6Eis0XicLrKssw2gLHsT82U19kkfpgfV8AneisKV6U22C9rRtcjS/ePeQnTKgbaRWUIyMjJPhoKSo34/UG3Ihn6Lb7wT6YC1yWvb1/hoZQXjU5UiMVWFP+6jM8Fz5H6bzSNvyoNO+XLv+YwpAtROWWOoNL5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWgrEl8Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6oDxKC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Fa6M2fnop3VuvpY6tx7dkXuN01T3hNadJF77tyGtY=;
	b=rWgrEl8YEfvL1iXhwAz6enuSwwEyTnDu2jsaRyfZEnM5XKYpQ3QMDOUtaoPvMg5iYnCrEF
	5wbShHNtUWUdlPsmvl8M9pLdxuswxMNnBjaMiiLZtRDfvWjYTEwTXJbh7IKQqBQNWqOyOM
	g5NPcmrUBrBhS1/1ojqwU6pq0+lYKy8fb8k+BpNyLleZZQTBSIIo9scsPou3yXyvzSEhW9
	gbAY14ZZM+XFxRwQn+OkGJwnLRwIJ1tkfo8rtKbvaTvdsQMa8+xWZmA7BEyBaKPvyOVS6w
	0MErF+aBFIvJiGfeW1iB6hjAjxL108p8wuX3ZgX75mzm/Vi5NKdgcScSNzg/nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Fa6M2fnop3VuvpY6tx7dkXuN01T3hNadJF77tyGtY=;
	b=h6oDxKC8g+i/Fk9tqK8kkbvNsLjMophYixWeurWNCxPsfGkgwqNjdN2tvN4XcDGuFhOrD8
	fYdCyrkbpavLgpAA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Add support for pause / resume
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022155920.17511-4-adrian.hunter@intel.com>
References: <20241022155920.17511-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089010397.32228.2658059574736833486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     08c7454ceb948d773fcd0ff7b6fb9c315e2f801a
Gitweb:        https://git.kernel.org/tip/08c7454ceb948d773fcd0ff7b6fb9c315e2f801a
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 22 Oct 2024 18:59:09 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:44 +01:00

perf/x86/intel/pt: Add support for pause / resume

Prevent tracing to start if aux_paused.

Implement support for PERF_EF_PAUSE / PERF_EF_RESUME. When aux_paused, stop
tracing. When not aux_paused, only start tracing if it isn't currently
meant to be stopped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20241022155920.17511-4-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 73 +++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h |  4 ++-
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a087bc0..4b0373b 100644
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
@@ -534,7 +537,24 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.aux_config = reg;
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	barrier();
+	WRITE_ONCE(pt->resume_allowed, 1);
+	/* Configuration is complete, it is now OK to handle an NMI */
+	barrier();
+	WRITE_ONCE(pt->handle_nmi, 1);
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
@@ -1516,6 +1536,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1524,6 +1545,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1578,6 +1600,26 @@ static void pt_event_start(struct perf_event *event, int mode)
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
@@ -1588,7 +1630,6 @@ static void pt_event_start(struct perf_event *event, int mode)
 			goto fail_end_stop;
 	}
 
-	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
 	pt_config_buffer(buf);
@@ -1606,6 +1647,12 @@ static void pt_event_stop(struct perf_event *event, int mode)
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
@@ -1613,6 +1660,15 @@ static void pt_event_stop(struct perf_event *event, int mode)
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
@@ -1662,6 +1718,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	if (WARN_ON_ONCE(!buf->snapshot))
 		return 0;
 
+	/* Prevent pause/resume from attempting to start/stop tracing */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
 	/*
 	 * There is no PT interrupt in this mode, so stop the trace and it will
 	 * remain stopped while the buffer is copied.
@@ -1681,8 +1741,13 @@ static long pt_event_snapshot_aux(struct perf_event *event,
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
@@ -1798,7 +1863,9 @@ static __init int pt_init(void)
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
index a1b6c04..7ee94fc 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -119,6 +119,8 @@ struct pt_filters {
  * @filters:		last configured filters
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
+ * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
+ * @resume_allowed:	PERF_EF_RESUME is allowed to start tracing
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
@@ -127,6 +129,8 @@ struct pt {
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	int			pause_allowed;
+	int			resume_allowed;
 	u64			output_base;
 	u64			output_mask;
 };

