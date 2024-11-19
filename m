Return-Path: <linux-tip-commits+bounces-2870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778B9D21CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7F1F22746
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F260199EAF;
	Tue, 19 Nov 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2BLRGXi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZ/BktbQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E805194A60;
	Tue, 19 Nov 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006137; cv=none; b=jNJtx+2IBNQk/g+EfWaTM9IFXSTsHN/WnKONlTAmeOP0JMtG5FPKVK2QNe5F0ujXb4JN0Q8yKdor+4CgPNpXnwZlpHLcDFk4xEudNcqYJkgPlFCG/j5UT6oD+WdK+A1ncfSiljT8anjNAO5j+O61G+4gbC6a+oyYkkg9zC8EZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006137; c=relaxed/simple;
	bh=Hc+St6+nNgv/UcufXgRaCISvujNcbb+Ph9XMQVgkf0Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZNPYAnvxKHES0QDJsUTv/uyxjfA1Q7OE35QcexOYm3wvoIFXZ+eCoviAMtXdWN46iEeE0Bb2t9AeVwagSUzhbpXAr6JAjjjxe+M8l3lf6OEZy//2ujKE3GGZfHMDObYwpatozq89YQ63yATMlGzrQlhzldGzwMyQPrrZCnP3Hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2BLRGXi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZ/BktbQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 08:48:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732006130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG2dFAA0ezKx7cjEB7fpOqQ/+zr/XkWCttf1OmA1vp8=;
	b=A2BLRGXiKwYak1qxaDIfWgID/eN74UPnFd8W1D5DXER/ZLAtnAssOnhI/Pmg1gaN+NIQDp
	VmCEn07TTq1nDn8RbRf43CLkEl022h88b3IbgwVnzEkbP0YJcJumiW3Tx6ZnIcF8mWmHIw
	WnCgw8CqdjY6ipkGOY2dEZwh7rm2PyFch7Hb8v/Lll3a7ViVdziLnrvkUOvhwrLdIwi/Yd
	i51ombpeIgEOZ0WJejYNOcIcb3u6lL9COX5KXiuM7OFhosndDfy75k5T7aHpG5yBGngyLc
	AxV8Sb5rxrjQ4wFMhNXm+gKXLv/SQ7OJZi2y0USsp/hSjEJRl+PoR48dqgPaOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732006130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG2dFAA0ezKx7cjEB7fpOqQ/+zr/XkWCttf1OmA1vp8=;
	b=wZ/BktbQPOgnQvL7AFob+GiHcP+/aack7PxDfPhKxyjM2nfh42u9Pmn7xQAsH/ojMNqe9Y
	mEKN5FLiWpU2S5Bw==
From: "tip-bot2 for Yabin Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Check sample_type in perf_sample_save_brstack
Cc: Namhyung Kim <namhyung@kernel.org>, Yabin Cui <yabinc@google.com>,
 Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240515193610.2350456-4-yabinc@google.com>
References: <20240515193610.2350456-4-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173200612891.412.3701761326460054209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     faac6f105ef169e2e5678c14e1ffebf2a7d780b6
Gitweb:        https://git.kernel.org/tip/faac6f105ef169e2e5678c14e1ffebf2a7d780b6
Author:        Yabin Cui <yabinc@google.com>
AuthorDate:    Wed, 15 May 2024 12:36:09 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2024 09:23:42 +01:00

perf/core: Check sample_type in perf_sample_save_brstack

Check sample_type in perf_sample_save_brstack() to prevent
saving branch stack data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240515193610.2350456-4-yabinc@google.com
---
 arch/x86/events/amd/core.c |  3 +--
 arch/x86/events/core.c     |  3 +--
 arch/x86/events/intel/ds.c |  3 +--
 include/linux/perf_event.h | 15 ++++++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b4a1a25..30d6ceb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1001,8 +1001,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c75c482..8f218ac 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1707,8 +1707,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4990a24..acfd872 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1888,8 +1888,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3ac202d..bf831b1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1320,6 +1320,11 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_RAW;
 }
 
+static inline bool has_branch_stack(struct perf_event *event)
+{
+	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
 					    struct perf_branch_stack *brs,
@@ -1327,6 +1332,11 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_BRANCH_STACK))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
@@ -1716,11 +1726,6 @@ static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
 # define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 #endif
 
-static inline bool has_branch_stack(struct perf_event *event)
-{
-	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
-}
-
 static inline bool needs_branch_stack(struct perf_event *event)
 {
 	return event->attr.branch_sample_type != 0;

