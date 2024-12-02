Return-Path: <linux-tip-commits+bounces-2914-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC29DFFFD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49A4280356
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F3204F73;
	Mon,  2 Dec 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxhDuiRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="scRQ5waw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D02036EB;
	Mon,  2 Dec 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138065; cv=none; b=NzHMJySshKtVTkFF9S8lURndsJEHNMTNA0VOacS/adfn2HiI5MIJ+XHddOj+DVZb77RIqp8aqTS3S/KCbqNSZDaoS5aoIrxuEQMtAqdQESeGQ1aQwZuskEFjPFKYcXuiVgEqYMqJ0nYbYWU5it4KzIWWxpBNnVYNRNgypk4aOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138065; c=relaxed/simple;
	bh=JDdS03JRFkVVeb2CaCexhWUqX59VCJVYhjm87U9EA38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJvDJ+9oeHMWRsmoZtPDY+r2masjxTUnDX4uImVqAVCORvcGrhfvkzwI+uwzE/YVi+MimpFCjV3N/AA6HGQLN5zQFde9SFVswlHqM/NTYgBhHakgikSud+znwaKaOkScTJQXLAbsnGOu8V02WLGJ+VJor0mEPeT44/qyAABQX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxhDuiRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=scRQ5waw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWU220V+xC/KKN4NjzwIy/bSUExRrUP6aJguL2f6rNQ=;
	b=gxhDuiRyOr9TMNJ12sIdthDdxRKMN1dQ106o1fUtqF9dS5nWgM6QX8BX0FnBymNSYbz4hk
	yAIIAMQOHSxIUV9lwU3ID3Zbqc190xiiDqziusNVjgT0JZ70vVCfC8VHiO4OMk+I1Yrbhf
	P/ZfaQIkKoAuGpzqXBi85K+1olc/U/PkZyFX7XsH3Zpq5hT08PdUJs2KZ2Ds75rRDAsZ/R
	kXht06RYwBfwi2o/eqQGv1+wC61t+4+Vy70gB0ItRG/356QyKQRvcADhkhOOudK8qGBLil
	lr4V9zjUcQQD0tB2PnExiTUQMFyfIQ5AxHJTHwS6oahGHfKX3CqqCdfhzlatZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWU220V+xC/KKN4NjzwIy/bSUExRrUP6aJguL2f6rNQ=;
	b=scRQ5waw//X6JTfD4QcD7wHH+oyek76vscAv0zje5phNjALc4VUG9Cj9f0x99/4Q343mPo
	dNNA99femFXLZ2DA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Factor out functions for PEBS
 records processing
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119135504.1463839-4-kan.liang@linux.intel.com>
References: <20241119135504.1463839-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313806064.412.14020298805156028448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3c00ed344cef4dbb57d8769b961af414132a173a
Gitweb:        https://git.kernel.org/tip/3c00ed344cef4dbb57d8769b961af414132a173a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 05:55:03 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:34 +01:00

perf/x86/intel/ds: Factor out functions for PEBS records processing

Factor out functions to process normal and the last PEBS records, which
can be shared with the later patch.

Move the event updating related codes (intel_pmu_save_and_restart())
to the end, where all samples have been processed.
For the current usage, it doesn't matter when perf updates event counts
and reset the counter. Because all counters are stopped when the PEBS
buffer is drained.
Drop the return of the !intel_pmu_save_and_restart(event) check. Because
it never happen. The intel_pmu_save_and_restart(event) only returns 0,
when !hwc->event_base or the period_left > 0.
- The !hwc->event_base is impossible for the PEBS event, since the PEBS
  event is only available on GP and fixed counters, which always have
  a valid hwc->event_base.
- The check only happens for the case of non-AUTO_RELOAD and single
  PEBS, which implies that the event must be overflowed. The period_left
  must be always <= 0 for an overflowed event after the
  x86_pmu_update().

Co-developed-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241119135504.1463839-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 109 ++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 450f318..79a3467 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2164,46 +2164,33 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	return 0;
 }
 
+typedef void (*setup_fn)(struct perf_event *, struct pt_regs *, void *,
+			 struct perf_sample_data *, struct pt_regs *);
+
+static struct pt_regs dummy_iregs;
+
 static __always_inline void
 __intel_pmu_pebs_event(struct perf_event *event,
 		       struct pt_regs *iregs,
+		       struct pt_regs *regs,
 		       struct perf_sample_data *data,
-		       void *base, void *top,
-		       int bit, int count,
-		       void (*setup_sample)(struct perf_event *,
-					    struct pt_regs *,
-					    void *,
-					    struct perf_sample_data *,
-					    struct pt_regs *))
+		       void *at,
+		       setup_fn setup_sample)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct hw_perf_event *hwc = &event->hw;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
-	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	static struct pt_regs dummy_iregs;
-
-	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
-	} else if (!intel_pmu_save_and_restart(event))
-		return;
-
-	if (!iregs)
-		iregs = &dummy_iregs;
+	setup_sample(event, iregs, at, data, regs);
+	perf_event_output(event, data, regs);
+}
 
-	while (count > 1) {
-		setup_sample(event, iregs, at, data, regs);
-		perf_event_output(event, data, regs);
-		at += cpuc->pebs_record_size;
-		at = get_next_pebs_record_by_bit(at, top, bit);
-		count--;
-	}
+static __always_inline void
+__intel_pmu_pebs_last_event(struct perf_event *event,
+			    struct pt_regs *iregs,
+			    struct pt_regs *regs,
+			    struct perf_sample_data *data,
+			    void *at,
+			    int count,
+			    setup_fn setup_sample)
+{
+	struct hw_perf_event *hwc = &event->hw;
 
 	setup_sample(event, iregs, at, data, regs);
 	if (iregs == &dummy_iregs) {
@@ -2222,6 +2209,44 @@ __intel_pmu_pebs_event(struct perf_event *event,
 		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
+
+	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
+		/*
+		 * Now, auto-reload is only enabled in fixed period mode.
+		 * The reload value is always hwc->sample_period.
+		 * May need to change it, if auto-reload is enabled in
+		 * freq mode later.
+		 */
+		intel_pmu_save_and_restart_reload(event, count);
+	} else
+		intel_pmu_save_and_restart(event);
+}
+
+static __always_inline void
+__intel_pmu_pebs_events(struct perf_event *event,
+			struct pt_regs *iregs,
+			struct perf_sample_data *data,
+			void *base, void *top,
+			int bit, int count,
+			setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	void *at = get_next_pebs_record_by_bit(base, top, bit);
+	int cnt = count;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	while (cnt > 1) {
+		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
+		at += cpuc->pebs_record_size;
+		at = get_next_pebs_record_by_bit(at, top, bit);
+		cnt--;
+	}
+
+	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -2258,8 +2283,8 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
-			       setup_pebs_fixed_sample_data);
+	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
+				setup_pebs_fixed_sample_data);
 }
 
 static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
@@ -2390,9 +2415,9 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, data, base,
-					       top, bit, counts[bit],
-					       setup_pebs_fixed_sample_data);
+			__intel_pmu_pebs_events(event, iregs, data, base,
+						top, bit, counts[bit],
+						setup_pebs_fixed_sample_data);
 		}
 	}
 }
@@ -2444,9 +2469,9 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
-		__intel_pmu_pebs_event(event, iregs, data, base,
-				       top, bit, counts[bit],
-				       setup_pebs_adaptive_sample_data);
+		__intel_pmu_pebs_events(event, iregs, data, base,
+					top, bit, counts[bit],
+					setup_pebs_adaptive_sample_data);
 	}
 }
 

