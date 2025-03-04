Return-Path: <linux-tip-commits+bounces-3869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77EFA4D741
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412143AA39E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD11FFC65;
	Tue,  4 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbDD9ZJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMVEgoma"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B01FF612;
	Tue,  4 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078629; cv=none; b=dRMLwXHQexszLXBO/wXy/xdERPVynDE4flXHThI0KPa0A51ACbFs0qWLqyetQtB6Hr6tZR/+GduHmrYWaCdrA8AIMmSOk/rd55nsik1nVJuzYNDtNpEPYOTwH3KhJRUIedSkLMWUQXSRPHKCPtCXjgpt+4KSA+OfVYGpnJsoU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078629; c=relaxed/simple;
	bh=LNMIcbcZQR2OXRIriGHiYfj4FDAJt+daTFSbSBDfNnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QRp0GhiGycNizO4ksMXExU+FvGOsayTegSSG2jJo/o5m+J7L0pjWY72v2wELK0WfZ4ywfqH1cKkoog7ggh8L9pC+HCzi9WMs3HQGVslZ1mZjewXE90USehV+u0AlvpEYwgjb4Z20uJ/If47svXF+fl0HejgbvI4tGpgahPb8lHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbDD9ZJh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BMVEgoma; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChC2i2N1N+s+r04aP94MURIVHIUGhRlTudz5cCoJSU4=;
	b=RbDD9ZJhVNCJUv1g6Tv9FtGcXHIyYWp8kRYRacl7Smx6HXfCBx0UyIVdCVIekOFOaZFfNV
	DEwemXo+q9NsJFyGufOEgNDAF4RwXEzMOUctgu+k2IGKAGyoopd70L3A2H4DHWRJvzFeRs
	BE952ID+FVFIwGaptqc5C6JFOP4zMWXk45B1A7c7GV5RAk2bi7Uf88kVGnZGOeVyiZC2xI
	lPEYm0fkW5NdChljeKfGZco/tB3UjPAesVnKhRzFBCFH45F444k4HHuETLVGeQ5wmVVnqO
	LhAYou/OCiMyDZGCAl3YglL6daS4pIenwlj/CMME8kQBaZx8KjmnAd569bWOow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChC2i2N1N+s+r04aP94MURIVHIUGhRlTudz5cCoJSU4=;
	b=BMVEgomaryzb3dOZQxx3qIuRDcT1fqXMYEYwfSw9x/oGYFk3kHe2+H+K9iRWgbhWhlgVEj
	adh2WxzDosFoemBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify perf_init_event()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.302444446@infradead.org>
References: <20241104135518.302444446@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862498.14745.12575934163190392365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     caf8b765d453198d4ca5305d9e207535934b6e3b
Gitweb:        https://git.kernel.org/tip/caf8b765d453198d4ca5305d9e207535934b6e3b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:32 +01:00

perf/core: Simplify perf_init_event()

Use the <linux/cleanup.h> guard() and scoped_guard() infrastructure
to simplify the control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20241104135518.302444446@infradead.org
---
 kernel/events/core.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 215dad5..fd35236 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12101,10 +12101,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 static struct pmu *perf_init_event(struct perf_event *event)
 {
 	bool extended_type = false;
-	int idx, type, ret;
 	struct pmu *pmu;
+	int type, ret;
 
-	idx = srcu_read_lock(&pmus_srcu);
+	guard(srcu)(&pmus_srcu);
 
 	/*
 	 * Save original type before calling pmu->event_init() since certain
@@ -12117,7 +12117,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		pmu = event->parent->pmu;
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 	}
 
 	/*
@@ -12136,13 +12136,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
-	rcu_read_lock();
-	pmu = idr_find(&pmu_idr, type);
-	rcu_read_unlock();
+	scoped_guard (rcu)
+		pmu = idr_find(&pmu_idr, type);
 	if (pmu) {
 		if (event->attr.type != type && type != PERF_TYPE_RAW &&
 		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
+			return ERR_PTR(-ENOENT);
 
 		ret = perf_try_init_event(pmu, event);
 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
@@ -12151,27 +12150,21 @@ again:
 		}
 
 		if (ret)
-			pmu = ERR_PTR(ret);
+			return ERR_PTR(ret);
 
-		goto unlock;
+		return pmu;
 	}
 
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
+		if (ret != -ENOENT)
+			return ERR_PTR(ret);
 	}
-fail:
-	pmu = ERR_PTR(-ENOENT);
-unlock:
-	srcu_read_unlock(&pmus_srcu, idx);
 
-	return pmu;
+	return ERR_PTR(-ENOENT);
 }
 
 static void attach_sb_event(struct perf_event *event)

