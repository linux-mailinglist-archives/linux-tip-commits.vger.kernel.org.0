Return-Path: <linux-tip-commits+bounces-3762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2031CA4ADB5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A643C170167
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE131EBA09;
	Sat,  1 Mar 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jno5oH6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSCKSw/s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEC1EB189;
	Sat,  1 Mar 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859660; cv=none; b=eUsOLewRTgPEiTCHDxYrI+5LezmHo5izXYDthh3kedwglegqbRkd+Hw+e7US/TrEh1mz6KXSZU2iMqZmE4chlPpgKHXBx/cWFZ5Z9FYFZ8Q3yRX+M8DhLmSI3ThIR+VaaD7NwdIz/7g9jmgehZFTZk3xdA3GMa0o+6HE6Qkvf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859660; c=relaxed/simple;
	bh=p8o3PWQtWmPtFDkHAAQxG/XJMp7eWGSISkXdEbgDFqQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IR3od8YshsYP4Sm7K51e4h/rYvSsrExc+plcknPhl/vZN6pgrAiGMFiSjSUF3OSKwFOVzuckFahKCRkP3QMWX8g1RJ2/mrEocB5Puva1CijcvToDNfpVnre+3n5GWvKz7MXtO1AK+8GNtq5fROkitZhBb24j7j6DA3/x/wQ0dZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jno5oH6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CSCKSw/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+O9V5hZoDolv8Pv7rfBdJAP5SmAhQaf5EsXd9Hyw7s=;
	b=jno5oH6hPKxpA7tpKC+ZZdn81RR6LHdHHvKkc1WWrV7hUNuXcSfNig0sd3ixx9qAKZFdvf
	tRu7qHsfPZ/sF9BARKo6dYw8fp26c8SKvXO6XyN2Km0op+/4+fK3WvGkYNZ0C2NUiPhZVI
	oFNXWFxjsyG91GydAoe27mfuUqPv8VtQNQPyCDiftqPKYp3CgnaEJs4u/6j6JQ7P51dr6w
	Qq9A06cdDj+N9VdPZP0Syq/rowRyOyWRpui2FLmeFpnw15Xv+lJGwrPHvBCuZisi1OWrZx
	+79jyx4AFwLwZI+xXF80Xd0OF5fHcoWNqPtYuXxwL9akEVoQitu57iuctSknzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+O9V5hZoDolv8Pv7rfBdJAP5SmAhQaf5EsXd9Hyw7s=;
	b=CSCKSw/s/aragAPyoZXxGdRHz2BlpnUEsWzaVJv1UOV0iu4VXSvE2iFv/D5UELy6Wy7o2P
	sj894xIM/4ZBLdAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Fix perf_pmu_register() vs. perf_init_event()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135517.858805880@infradead.org>
References: <20241104135517.858805880@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965591.10177.639630120769943871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     003659fec9f6d8c04738cb74b5384398ae8a7e88
Gitweb:        https://git.kernel.org/tip/003659fec9f6d8c04738cb74b5384398ae8a7e88
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:38:42 +01:00

perf/core: Fix perf_pmu_register() vs. perf_init_event()

There is a fairly obvious race between perf_init_event() doing
idr_find() and perf_pmu_register() doing idr_alloc() with an
incompletely initialized PMU pointer.

Avoid by doing idr_alloc() on a NULL pointer to register the id, and
swizzling the real struct pmu pointer at the end using idr_replace().

Also making sure to not set struct pmu members after publishing
the struct pmu, duh.

[ introduce idr_cmpxchg() in order to better handle the idr_replace()
  error case -- if it were to return an unexpected pointer, it will
  already have replaced the value and there is no going back. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135517.858805880@infradead.org
---
 kernel/events/core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 11793d6..823aa08 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11830,6 +11830,21 @@ free_dev:
 static struct lock_class_key cpuctx_mutex;
 static struct lock_class_key cpuctx_lock;
 
+static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
+{
+	void *tmp, *val = idr_find(idr, id);
+
+	if (val != old)
+		return false;
+
+	tmp = idr_replace(idr, new, id);
+	if (IS_ERR(tmp))
+		return false;
+
+	WARN_ON_ONCE(tmp != val);
+	return true;
+}
+
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
@@ -11856,7 +11871,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (type >= 0)
 		max = type;
 
-	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto free_pdc;
 
@@ -11864,6 +11879,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 
 	type = ret;
 	pmu->type = type;
+	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
@@ -11912,14 +11928,22 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	/*
+	 * Now that the PMU is complete, make it visible to perf_try_init_event().
+	 */
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
+		goto free_context;
 	list_add_rcu(&pmu->entry, &pmus);
-	atomic_set(&pmu->exclusive_cnt, 0);
+
 	ret = 0;
 unlock:
 	mutex_unlock(&pmus_lock);
 
 	return ret;
 
+free_context:
+	free_percpu(pmu->cpu_pmu_context);
+
 free_dev:
 	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		device_del(pmu->dev);

