Return-Path: <linux-tip-commits+bounces-2915-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6079E0000
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9D0281453
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A5205AA0;
	Mon,  2 Dec 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVkrUGNm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqoWAmH6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27720409C;
	Mon,  2 Dec 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138066; cv=none; b=N+i95skYH+mTjZ8YMDJIVEJ9Pbw85BzcC2UCc8lWtg5OKy23fsnR6L2y6R3ZE9GwOw5T0Pmnllq2K9/9S1XrA6M9+UIzTGUlIPsQV44kf9qFcRsUGlfGADC9Mfeb2zHW+bl62vr9VeUgCN6szv5G9zG3ToiqQ1VnYsX4n8ZUC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138066; c=relaxed/simple;
	bh=zZpgJZjIEnoTsRwMvT9tmgI44th/5FrP7wwiYapkIpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VK1AlA0IJVR+2SP9DPE7/4aA5CkHFub8OYXDyLOfxrXDA8+dsTouk+wRPjocxUkm+SzrqlETrl5JaBlBC6x5apqLkhL7i7qNRzCpXGrCDd9lPFbeGnVysvsg+CIzeZXjoQPjE5aiu3hV0Cp3YaS4z11Gc8bY7dBvp8eC9FI6buM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVkrUGNm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqoWAmH6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dZ1hjAedscyazHjRXlD8lPbhCABbV4EkknJ45EeKho=;
	b=FVkrUGNm3PL7DUiWdAoUe2E54056VyLoFobUoTrB9j3Im/r94R5KGQXc5GTrm2m7chQZbA
	D5uq0vucuWv3QJayNVW6DOLdlBn89AbCOZYmWfFw6SXU253//F6sBBToQSgHDr1AYYQCo7
	m0pRW6dYmvq38qUjYcnetvDqWwJDxFItZ+XSL79Kb4S7HPnNuInFiDfWnsasHTB4qsMDoA
	4jcOSdZweHxsTXNudxj/QtzDkE5xD4VRyoHOAx0MQWPb5aIC8SZJbI1QyCo9yzQVrsgYv1
	x81SESqahIzJRRG0FOymYDM4M2TLaP5E7KKxp2hs2GAYQIsudt2q2lluaWPOkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dZ1hjAedscyazHjRXlD8lPbhCABbV4EkknJ45EeKho=;
	b=iqoWAmH6bkRq0+nGTlsuiufYOXx+bluXZE2gXKaiQT8lWyXTH8KSAUyAixV9ktG+zb+n4J
	N0h5JGZE12FhnWAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Clarify adaptive PEBS processing
Cc: Stephane Eranian <eranian@google.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119135504.1463839-3-kan.liang@linux.intel.com>
References: <20241119135504.1463839-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313806137.412.15982953324191121188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7087bfb0adc9a12ec3b463b1d38072c5efce5d6c
Gitweb:        https://git.kernel.org/tip/7087bfb0adc9a12ec3b463b1d38072c5efce5d6c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 05:55:02 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:34 +01:00

perf/x86/intel/ds: Clarify adaptive PEBS processing

Modify the pebs_basic and pebs_meminfo structs to make the bitfields
more explicit to ease readability of the code.

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241119135504.1463839-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c        | 43 +++++++++++++-----------------
 arch/x86/include/asm/perf_event.h | 16 +++++++++--
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 34cba39..450f318 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1915,8 +1915,6 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 }
 
 #define PEBS_LATENCY_MASK			0xffff
-#define PEBS_CACHE_LATENCY_OFFSET		32
-#define PEBS_RETIRE_LATENCY_OFFSET		32
 
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
@@ -1930,8 +1928,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct pebs_basic *basic = __pebs;
 	void *next_record = basic + 1;
-	u64 sample_type;
-	u64 format_size;
+	u64 sample_type, format_group;
 	struct pebs_meminfo *meminfo = NULL;
 	struct pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
@@ -1943,7 +1940,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_regs->xmm_regs = NULL;
 
 	sample_type = event->attr.sample_type;
-	format_size = basic->format_size;
+	format_group = basic->format_group;
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
@@ -1964,7 +1961,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
-			data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+			data->weight.var3_w = basic->retire_latency;
 		else
 			data->weight.var3_w = 0;
 	}
@@ -1974,12 +1971,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
 	 * Save the pointer here but process later.
 	 */
-	if (format_size & PEBS_DATACFG_MEMINFO) {
+	if (format_group & PEBS_DATACFG_MEMINFO) {
 		meminfo = next_record;
 		next_record = meminfo + 1;
 	}
 
-	if (format_size & PEBS_DATACFG_GP) {
+	if (format_group & PEBS_DATACFG_GP) {
 		gprs = next_record;
 		next_record = gprs + 1;
 
@@ -1992,14 +1989,13 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 
-	if (format_size & PEBS_DATACFG_MEMINFO) {
+	if (format_group & PEBS_DATACFG_MEMINFO) {
 		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
-			u64 weight = meminfo->latency;
+			u64 latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+					meminfo->cache_latency : meminfo->mem_latency;
 
-			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY) {
-				data->weight.var2_w = weight & PEBS_LATENCY_MASK;
-				weight >>= PEBS_CACHE_LATENCY_OFFSET;
-			}
+			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
+				data->weight.var2_w = meminfo->instr_latency;
 
 			/*
 			 * Although meminfo::latency is defined as a u64,
@@ -2007,12 +2003,13 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			 * in practice on Ice Lake and earlier platforms.
 			 */
 			if (sample_type & PERF_SAMPLE_WEIGHT) {
-				data->weight.full = weight ?:
+				data->weight.full = latency ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			} else {
-				data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
+				data->weight.var1_dw = (u32)latency ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			}
+
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
@@ -2033,16 +2030,16 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
-	if (format_size & PEBS_DATACFG_XMMS) {
+	if (format_group & PEBS_DATACFG_XMMS) {
 		struct pebs_xmm *xmm = next_record;
 
 		next_record = xmm + 1;
 		perf_regs->xmm_regs = xmm->xmm;
 	}
 
-	if (format_size & PEBS_DATACFG_LBRS) {
+	if (format_group & PEBS_DATACFG_LBRS) {
 		struct lbr_entry *lbr = next_record;
-		int num_lbr = ((format_size >> PEBS_DATACFG_LBR_SHIFT)
+		int num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT)
 					& 0xff) + 1;
 		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
@@ -2052,11 +2049,11 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
-	WARN_ONCE(next_record != __pebs + (format_size >> 48),
-			"PEBS record size %llu, expected %llu, config %llx\n",
-			format_size >> 48,
+	WARN_ONCE(next_record != __pebs + basic->format_size,
+			"PEBS record size %u, expected %llu, config %llx\n",
+			basic->format_size,
 			(u64)(next_record - __pebs),
-			basic->format_size);
+			format_group);
 }
 
 static inline void *
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index d95f902..cb9c467 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -422,7 +422,9 @@ static inline bool is_topdown_idx(int idx)
  */
 
 struct pebs_basic {
-	u64 format_size;
+	u64 format_group:32,
+	    retire_latency:16,
+	    format_size:16;
 	u64 ip;
 	u64 applicable_counters;
 	u64 tsc;
@@ -431,7 +433,17 @@ struct pebs_basic {
 struct pebs_meminfo {
 	u64 address;
 	u64 aux;
-	u64 latency;
+	union {
+		/* pre Alder Lake */
+		u64 mem_latency;
+		/* Alder Lake and later */
+		struct {
+			u64 instr_latency:16;
+			u64 pad2:16;
+			u64 cache_latency:16;
+			u64 pad3:16;
+		};
+	};
 	u64 tsx_tuning;
 };
 

