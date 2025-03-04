Return-Path: <linux-tip-commits+bounces-3871-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BCA4D755
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D051894838
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA6200112;
	Tue,  4 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jl3miD1h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZd472jg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8D1FF7B6;
	Tue,  4 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078629; cv=none; b=SIGlKZpmMzmANtedc+nJb0vRzrEmyfodUcW5tZZ+OBgBGQ/Nu9J5VSxzFgTMkErmO8hFprQg2s6spJCeibQv9wKo9QfJ8ALQwewS2vfwgSdhO+90ydJ/de8hbjYbWlkF+iwAIKZx3Q66RHDmKc2nIYDZw27nBYi/BseHWZcu39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078629; c=relaxed/simple;
	bh=tTLNkw9UR+Ew91hPZTxYJLMyrNyvgny45PnO1KMRiwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=POhQhGnlUWZIfzE2k2XljuhXanHz4Xv3FyLedkoljDyvN4CjQMJlDdgXb9LVhjrUUUmkhCwe/XYuq1mFRICAp5kNX3ntOoBwiZM/KLGbLI/Quuepg6q3bs84aNsv+qfncdOIwHdxK+OYVz3cRDLV1orwEPIychC7mvjPaSGQsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jl3miD1h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZd472jg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fm7MIFN8rUstK8p3ENSxLJzP9FkW7uMauaXM6M9XaMg=;
	b=jl3miD1hjDqERHBmvrD/o1UYGcRLOF6SACmPqtnDiNQYXf5m+md7vXsUFfwFRB+cJTVYaZ
	lh84O7D+7y6SWNyoa7uBb26zxrBsmuckct5MYe3Vxy53mxTXydWYJPwS7kTfPQyyUV8C+W
	MBNOHMMhygHUjngKmUhqKUEVXMi7dmj6ODMptSEK4oi4atnSFhdzk08R2MwWmLY5kUtYZq
	a3RjKW+WopJO3CDrtEcFYVX/z2KFbbl/NdZtDvuUfLVZySheHRHBpJuOel8mjVP4OVBphZ
	QzWHjRapmuYNMrEGqpFy8BeGSzao9H6zOEZRtEDlA2D3xjp8W4W7uRt8wHCEpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fm7MIFN8rUstK8p3ENSxLJzP9FkW7uMauaXM6M9XaMg=;
	b=wZd472jgKDZl2E+oWWT03kceb0OcwTkZF+1bAiCECBHaKs2Stb+JAgKnys6DTcP3zXkWwK
	c1H4CSpBGnIhJiDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify perf_pmu_register()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.198937277@infradead.org>
References: <20241104135518.198937277@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862567.14745.10433977133332362551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6c8b0b835f003647e593c08331a4dd2150d5eb0e
Gitweb:        https://git.kernel.org/tip/6c8b0b835f003647e593c08331a4dd2150d5eb0e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:29 +01:00

perf/core: Simplify perf_pmu_register()

Using the previously introduced perf_pmu_free() and a new IDR helper,
simplify the perf_pmu_register error paths.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.198937277@infradead.org
---
 include/linux/idr.h  | 17 ++++++++++-
 kernel/events/core.c | 71 +++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index da5f5fa..cd729be 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <linux/cleanup.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
@@ -124,6 +125,22 @@ void *idr_get_next_ul(struct idr *, unsigned long *nextid);
 void *idr_replace(struct idr *, void *, unsigned long id);
 void idr_destroy(struct idr *);
 
+struct __class_idr {
+	struct idr *idr;
+	int id;
+};
+
+#define idr_null ((struct __class_idr){ NULL, -1 })
+#define take_idr_id(id) __get_and_null(id, idr_null)
+
+DEFINE_CLASS(idr_alloc, struct __class_idr,
+	     if (_T.id >= 0) idr_remove(_T.idr, _T.id),
+	     ((struct __class_idr){
+	     	.idr = idr,
+		.id = idr_alloc(idr, ptr, start, end, gfp),
+	     }),
+	     struct idr *idr, void *ptr, int start, int end, gfp_t gfp);
+
 /**
  * idr_init_base() - Initialise an IDR.
  * @idr: IDR handle.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ee5cdd6..215dad5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11914,52 +11914,49 @@ static void perf_pmu_free(struct pmu *pmu)
 	free_percpu(pmu->cpu_pmu_context);
 }
 
-int perf_pmu_register(struct pmu *pmu, const char *name, int type)
+DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
+
+int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 {
-	int cpu, ret, max = PERF_TYPE_MAX;
+	int cpu, max = PERF_TYPE_MAX;
 
-	pmu->type = -1;
+	struct pmu *pmu __free(pmu_unregister) = _pmu;
+	guard(mutex)(&pmus_lock);
 
-	mutex_lock(&pmus_lock);
-	ret = -ENOMEM;
 	pmu->pmu_disable_count = alloc_percpu(int);
 	if (!pmu->pmu_disable_count)
-		goto unlock;
+		return -ENOMEM;
 
-	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
+		return -EINVAL;
 
-	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE,
+		      "Can not register a pmu with an invalid scope.\n"))
+		return -EINVAL;
 
 	pmu->name = name;
 
 	if (type >= 0)
 		max = type;
 
-	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
-	if (ret < 0)
-		goto free;
+	CLASS(idr_alloc, pmu_type)(&pmu_idr, NULL, max, 0, GFP_KERNEL);
+	if (pmu_type.id < 0)
+		return pmu_type.id;
 
-	WARN_ON(type >= 0 && ret != type);
+	WARN_ON(type >= 0 && pmu_type.id != type);
 
-	pmu->type = ret;
+	pmu->type = pmu_type.id;
 	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
-		ret = pmu_dev_alloc(pmu);
+		int ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
-	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
-		goto free;
+		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
@@ -12000,32 +11997,22 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
-	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu)) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
+		return -EINVAL;
 	list_add_rcu(&pmu->entry, &pmus);
 
-	ret = 0;
-unlock:
-	mutex_unlock(&pmus_lock);
-
-	return ret;
-
-free:
-	if (pmu->type >= 0)
-		idr_remove(&pmu_idr, pmu->type);
-	perf_pmu_free(pmu);
-	goto unlock;
+	take_idr_id(pmu_type);
+	_pmu = no_free_ptr(pmu); // let it rip
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	mutex_lock(&pmus_lock);
-	list_del_rcu(&pmu->entry);
-	idr_remove(&pmu_idr, pmu->type);
-	mutex_unlock(&pmus_lock);
+	scoped_guard (mutex, &pmus_lock) {
+		list_del_rcu(&pmu->entry);
+		idr_remove(&pmu_idr, pmu->type);
+	}
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so

