Return-Path: <linux-tip-commits+bounces-3867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58313A4D73A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE18217628D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0131FF60A;
	Tue,  4 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMJ6LT5n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s24pm0cE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A81FF1A4;
	Tue,  4 Mar 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078627; cv=none; b=YVIvXFpxkFMYdI0iybIB69b+gWJeB5Dr/UDcEfR2/PvmTcX2qsmQk1803VBtUgCrpKS5KSFc8XbzwVscNNcBgZdGlDZx7fwnYplbLw/MrJjPiqta2cLR7SIRH4IdT6Y0Aj+yrdeGhSoGw8d1uHUkLGy5SmhDfJlQyWbHzgPFky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078627; c=relaxed/simple;
	bh=5aZLGmEL9CHHCJ4WzzXyCo/fxwsThQsI/Ea/PpZZEeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=otV3jupcPJAHRsdwIK6ZqG0kmYMQWrr5OCODUcIUo4D1VqpL/Mv5ve3jO6FAQo9KjY7VRUSk4XokjMjBQnlOKNBcODlGl8Z421MNobhON/SdNq9WVo2qJMSzW+BJdYzA0N+h61mc/JI9JnYLDRXp41RGcN/bBZx/LAWiQvQ0zLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BMJ6LT5n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s24pm0cE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1PlM+kJ8uibisaKPhwmHIGoqwWJ/DCqq5m3ATITQeA=;
	b=BMJ6LT5nML57952aKBQA/FGv8oHR/XLFKCpPDELkJAMG6QgBn5tS/AWmyNL1FhsQ5Waa9t
	gg5zHUBgbUVnmVfkKFy/hrFwDUNbqLf7T8n/RcAdpwb1FSMA7cvBy2Qvi881dB5bZCPCzL
	1hRBOHi+lUT7Fz6zl+7r1hNN0BN9McUrk33M9tb/kEsW8dOCyxwqZ6SPM7eHWkHB9yyS4o
	HTsyXjAVR2gn7mB9fW6uiUCao7DmC3nOGaCc/KN/yA8F9jicIYZwqYEx0I9JfQHC1BYwQi
	l5mI+2JnyT7ECt+xppODjt1+J85wbqO7KQ1/MNjwJtyLEwRV2V6IwWPn/dKSWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1PlM+kJ8uibisaKPhwmHIGoqwWJ/DCqq5m3ATITQeA=;
	b=s24pm0cEXtToDr4FuCM/dDQtRkdPKnY2Wd5n5kXL6UUVUqUGp6k25RAzZjvwpDLLOb17A5
	0IPb3kYcww6BvmBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Merge struct pmu::pmu_disable_count into
 struct perf_cpu_pmu_context::pmu_disable_count
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.518730578@infradead.org>
References: <20241104135518.518730578@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862346.14745.5576020958152188502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4baeb0687abf5eca3f7ab8b147c27cce82ec49ea
Gitweb:        https://git.kernel.org/tip/4baeb0687abf5eca3f7ab8b147c27cce82ec49ea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:47 +01:00

perf/core: Merge struct pmu::pmu_disable_count into struct perf_cpu_pmu_context::pmu_disable_count

Because it makes no sense to have two per-cpu allocations per pmu.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.518730578@infradead.org
---
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8c0117b..5f293e6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -343,7 +343,6 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
@@ -1031,6 +1030,7 @@ struct perf_cpu_pmu_context {
 
 	int				active_oncpu;
 	int				exclusive;
+	int				pmu_disable_count;
 
 	raw_spinlock_t			hrtimer_lock;
 	struct hrtimer			hrtimer;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 348a379..8321b71 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1219,21 +1219,22 @@ static int perf_mux_hrtimer_restart_ipi(void *arg)
 
 void perf_pmu_disable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!--(*count))
 		pmu->pmu_enable(pmu);
 }
 
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	WARN_ON_ONCE(*count == 0);
 }
 
 static inline void perf_pmu_read(struct perf_event *event)
@@ -11906,7 +11907,6 @@ static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
 
 static void perf_pmu_free(struct pmu *pmu)
 {
-	free_percpu(pmu->pmu_disable_count);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11925,10 +11925,6 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 	struct pmu *pmu __free(pmu_unregister) = _pmu;
 	guard(mutex)(&pmus_lock);
 
-	pmu->pmu_disable_count = alloc_percpu(int);
-	if (!pmu->pmu_disable_count)
-		return -ENOMEM;
-
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
 		return -EINVAL;
 

