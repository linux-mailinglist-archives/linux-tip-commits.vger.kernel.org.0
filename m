Return-Path: <linux-tip-commits+bounces-3760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25AA4ADB2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5E1881B26
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B301EB1B4;
	Sat,  1 Mar 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhBs+1lZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7bso4rAM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7631E9B3D;
	Sat,  1 Mar 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859658; cv=none; b=CLpqFXxBBAe5RSfTUWl/EUczXedH7JFF/KbfwxjrY3XkTdRnJc1Ezf732KrvIym+rktaWfE8IzRzwWMJZAj68or/yF40uvObrxlRpYN5Q7HoWHapNnlpHxFmWtCHr4BUkfxhK8tRXF/79D5IGA0oCijUiZZxubw5G2ySyZdrrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859658; c=relaxed/simple;
	bh=aFdPjHr0HjJCjUy0lBw283OnUUbizEVq6PkoA3PrA9E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SwKNu58OBokq/lMD6vLjMFbvtBINF4Bod63K1rOAj3BerNW9Vr4MgPc4rxI3IVlTpZeROD/E/K82hqYdggbsTI5b86AANt2vMvIyeRTCaiEpM4sjQ+Fs0TiTgMWAxgziskwA0mwv6FTGcKaILqHvHGB7ecyQOocZomf71SflZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhBs+1lZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7bso4rAM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiqVn2GOYOPPFcWo8OZZZ3grDEK1XwooHp0eUQ3Lqew=;
	b=GhBs+1lZZSUEzVwhPoOIor1oJIm9cG2JDoAjnL3se1BAWx1DBPIfN4k1Ik9R3yjvhw8/O9
	f1i543vZt1uRNEKojF+0J3QeQlp4buwGScZ9u3ZoVGxYgnR7AIotwk+IN1zvA46zBQlofK
	E4EgWCKr5w4YV14n2DGpp+HTGi2MiXcQeF4uQ82n5WrylfIvwfESw/I75ejeOthAi6DwmC
	utygYQwBKu+ULiaeB+lBrQVpMANtMSmejYPX0a6xDxQffYLWLVD91tU7MIJdDFkTlUNLET
	0lgvk5fgdk0KlqHytmj+tny16s3dOIN/+FxZlhH8wL/mY6GJuNA0cgZdgDjaIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiqVn2GOYOPPFcWo8OZZZ3grDEK1XwooHp0eUQ3Lqew=;
	b=7bso4rAM5zgYZaIb7tfH+n0MPKLyKsB8ZI61wpSojIGZDCtTTgihXtr61oKT0ntJTplmm2
	oz4AJw9UtgO3dTCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Simplify the perf_pmu_register() error path
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.090915501@infradead.org>
References: <20241104135518.090915501@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965505.10177.16335629969425990496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e6b17cfd528d141b69b5a1b948f6bf619c922bf4
Gitweb:        https://git.kernel.org/tip/e6b17cfd528d141b69b5a1b948f6bf619c922bf4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:54:05 +01:00

perf/core: Simplify the perf_pmu_register() error path

The error path of perf_pmu_register() is of course very similar to a
subset of perf_pmu_unregister(). Extract this common part in
perf_pmu_free() and simplify things.

[ mingo: Forward ported it ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.090915501@infradead.org
---
 kernel/events/core.c | 67 +++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1b8b1c8..ee5cdd6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11675,11 +11675,6 @@ static int perf_event_idx_default(struct perf_event *event)
 	return 0;
 }
 
-static void free_pmu_context(struct pmu *pmu)
-{
-	free_percpu(pmu->cpu_pmu_context);
-}
-
 /*
  * Let userspace know that this PMU supports address range filtering:
  */
@@ -11885,6 +11880,7 @@ del_dev:
 
 free_dev:
 	put_device(pmu->dev);
+	pmu->dev = NULL;
 	goto out;
 }
 
@@ -11906,25 +11902,38 @@ static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
 	return true;
 }
 
+static void perf_pmu_free(struct pmu *pmu)
+{
+	free_percpu(pmu->pmu_disable_count);
+	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
+		if (pmu->nr_addr_filters)
+			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
+	free_percpu(pmu->cpu_pmu_context);
+}
+
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
 
+	pmu->type = -1;
+
 	mutex_lock(&pmus_lock);
 	ret = -ENOMEM;
 	pmu->pmu_disable_count = alloc_percpu(int);
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
-	pmu->type = -1;
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
 		ret = -EINVAL;
-		goto free_pdc;
+		goto free;
 	}
 
 	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
 		ret = -EINVAL;
-		goto free_pdc;
+		goto free;
 	}
 
 	pmu->name = name;
@@ -11934,24 +11943,23 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 
 	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto free_pdc;
+		goto free;
 
 	WARN_ON(type >= 0 && ret != type);
 
-	type = ret;
-	pmu->type = type;
+	pmu->type = ret;
 	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free_idr;
+			goto free;
 	}
 
 	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
-		goto free_dev;
+		goto free;
 
 	for_each_possible_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
@@ -11992,8 +12000,10 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
-	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
-		goto free_context;
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu)) {
+		ret = -EINVAL;
+		goto free;
+	}
 	list_add_rcu(&pmu->entry, &pmus);
 
 	ret = 0;
@@ -12002,20 +12012,10 @@ unlock:
 
 	return ret;
 
-free_context:
-	free_percpu(pmu->cpu_pmu_context);
-
-free_dev:
-	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
-		device_del(pmu->dev);
-		put_device(pmu->dev);
-	}
-
-free_idr:
-	idr_remove(&pmu_idr, pmu->type);
-
-free_pdc:
-	free_percpu(pmu->pmu_disable_count);
+free:
+	if (pmu->type >= 0)
+		idr_remove(&pmu_idr, pmu->type);
+	perf_pmu_free(pmu);
 	goto unlock;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
@@ -12034,14 +12034,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
-	free_percpu(pmu->pmu_disable_count);
-	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
-		if (pmu->nr_addr_filters)
-			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
-		device_del(pmu->dev);
-		put_device(pmu->dev);
-	}
-	free_pmu_context(pmu);
+	perf_pmu_free(pmu);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 

