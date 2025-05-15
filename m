Return-Path: <linux-tip-commits+bounces-5553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B231AB8D6A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF363A5B10
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3641C700B;
	Thu, 15 May 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZZZcZcc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PC7qBIt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A7AD51;
	Thu, 15 May 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329385; cv=none; b=rN5qebyqcRvkbqa7rbcY2kCy3RkY4vlGKb+NZdAorozQ5xXqonhJDOn/yuMXnKal6BQATljhmd9C6Bab6k7RzU75v5aiNmFGYtSNs3u+vkcIAeaeiIr45ahEeYiLyTzsMqF6MM779qiyf/+V5x77bvRGRueMcoha7pn6KUt5jYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329385; c=relaxed/simple;
	bh=Fk3SNjOQl5n572aBGShDvtH1dwB39eoOtRx0QX27chc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pt/D9UuZUmNLGrrS0/VwRonM2XUcLeQazfHYWFKWgK3rR6SO/Nq0BkXUT+IKbKRXlM9QToLGOUlZYNajaiGngAs+rZMNjFffu79iaf6ttPefnSbC/R/NzOrNLQZUmpm00DZoN5SQ7atWX15HlZU0LnpXsKbCbMGOS23EN0GVRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZZZcZcc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PC7qBIt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:16:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOSTLkShmHcYTIcGCqmHFZB7ONPLYdu3auhuzh3F9T4=;
	b=iZZZcZccGcsay/q6q8BCnedFHW8g/cfJqpJpeQZQT3nOxgxkiEJXd5AjAkyucom9E/6Xur
	4XyaQhO/hQK20Nx2cde17Cjvr4SqtR22uXgsdJQfoosSNAmkE8NcNh4zl+gVWnVFl0VjwI
	HWkbG3Wdan0VI80eC87dooig1QNscFsCYj26OvPYmOqHHlqx5T+5bIFKrjJhD/R/gO2Sxh
	p9KPvgQyoYMuFuitEVKm+DMco3FK1w78xQInazp72NdyZ9P3p9/BEzl8aiRpEntt+FRnUI
	2GonvtRJu/ELKEeIV8VU8V93jtuKquslO9G9Z/z11XKCSZU7HbdLw/5EAWQblA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOSTLkShmHcYTIcGCqmHFZB7ONPLYdu3auhuzh3F9T4=;
	b=0PC7qBItIzbnyOu5Nn4TEp/qAzOzlBrYsG8jOF6NREUvDRwEPFrVfYG+PaaP7MIS2krql4
	Z2mqTXDpLXJVRRCg==
From: "tip-bot2 for Yabin Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/aux: Allocate non-contiguous AUX pages by default
Cc: Yabin Cui <yabinc@google.com>, Ingo Molnar <mingo@kernel.org>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508232642.148767-1-yabinc@google.com>
References: <20250508232642.148767-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732938003.406.16237856249710775197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     18049c8cff9cc89daadc4df6975f7d9069638926
Gitweb:        https://git.kernel.org/tip/18049c8cff9cc89daadc4df6975f7d9069638926
Author:        Yabin Cui <yabinc@google.com>
AuthorDate:    Thu, 08 May 2025 16:26:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:07:19 +02:00

perf/aux: Allocate non-contiguous AUX pages by default

perf always allocates contiguous AUX pages based on aux_watermark.
However, this contiguous allocation doesn't benefit all PMUs. For
instance, ARM SPE and TRBE operate with virtual pages, and Coresight
ETR allocates a separate buffer. For these PMUs, allocating contiguous
AUX pages unnecessarily exacerbates memory fragmentation. This
fragmentation can prevent their use on long-running devices.

This patch modifies the perf driver to be memory-friendly by default,
by allocating non-contiguous AUX pages. For PMUs requiring contiguous
pages (Intel BTS and some Intel PT), the existing
PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
require but can benefit from contiguous pages (some Intel PT), a new
capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
existing behavior.

Signed-off-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250508232642.148767-1-yabinc@google.com
---
 arch/x86/events/intel/pt.c  |  2 ++
 include/linux/perf_event.h  |  1 +
 kernel/events/ring_buffer.c | 29 ++++++++++++++++++++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fa37565..25ead91 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1863,6 +1863,8 @@ static __init int pt_init(void)
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
+	else
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 947ad12..a96c00e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -303,6 +303,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
 
 /**
  * pmu::scope
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5130b11..d2aef87 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -679,7 +679,15 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order;
+	bool use_contiguous_pages = event->pmu->capabilities & (
+		PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
+	/*
+	 * Initialize max_order to 0 for page allocation. This allocates single
+	 * pages to minimize memory fragmentation. This is overridden if the
+	 * PMU needs or prefers contiguous pages (use_contiguous_pages = true).
+	 */
+	int max_order = 0;
+	int ret = -ENOMEM;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
@@ -689,8 +697,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	if (!overwrite) {
 		/*
-		 * Watermark defaults to half the buffer, and so does the
-		 * max_order, to aid PMU drivers in double buffering.
+		 * Watermark defaults to half the buffer, to aid PMU drivers
+		 * in double buffering.
 		 */
 		if (!watermark)
 			watermark = min_t(unsigned long,
@@ -698,16 +706,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
-		 * Use aux_watermark as the basis for chunking to
-		 * help PMU drivers honor the watermark.
+		 * If using contiguous pages, use aux_watermark as the basis
+		 * for chunking to help PMU drivers honor the watermark.
 		 */
-		max_order = get_order(watermark);
+		if (use_contiguous_pages)
+			max_order = get_order(watermark);
 	} else {
 		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
+		 * If using contiguous pages, we need to start with the
+		 * max_order that fits in nr_pages, not the other way around,
+		 * hence ilog2() and not get_order.
 		 */
-		max_order = ilog2(nr_pages);
+		if (use_contiguous_pages)
+			max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
 

