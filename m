Return-Path: <linux-tip-commits+bounces-3354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D9A30F35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E0F18832FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28977252918;
	Tue, 11 Feb 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y52hG4aY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhHP9LGW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331324E4B6;
	Tue, 11 Feb 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286372; cv=none; b=QII3vEcutlIOVTHQWD4mr6VfG+ye0fXxj/VlmJUFdaO/uw0DZfyZ6yQ7j3Ws9uDcmPoeO8xs/GWH+DGVIrRWAL16qJSA5jzKyDiz7dJTTYtH16ZV0wvwbpwU08FGB9DPbiRBOGBAQfTIGTtUYs1sthxt2d++7MpbJNV+CFmk02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286372; c=relaxed/simple;
	bh=4B+g3tK9aMfxImDYzfKInCcDdUZK8W55/5LWe/RgXW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=msiZXK8tl7HAiAZelcO0y2CNV/YhFXeMcoA5xTSAku5WMxOuOUBVxtDQ+AnJ9fFSaOjPEmEaQ48CEkqorOP1y10L+5s3a3Y94yr1kO68sOhQMwD32Q4lyckasWJtPPd4kFvn94SPk7VI7wUx7uFcIPKiEqrKg95/YsezYn2/1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y52hG4aY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhHP9LGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Feb 2025 15:06:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739286368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcScyRaVnQ5xb4TwKecBkcpqWVZ8pXQZjuAH5zTPMCI=;
	b=Y52hG4aYOLSZwSw0lf/dVh0933W3yOxodcNSBo0PPq7FupJthqacMKv0tDLftV0FFdwB5q
	zMM1fV1UAoJFCecFHploI4vy0qo0fQZuJCcGy6og4b9SIyWfbxj5Lx9lilJlPk00LoBayV
	5Wsp8XSTyBRAJu76qLiyqXwhh5tY/IQjdDYeSm7coTwEd9BdzBLA12XTwsdVZSisGiKeSs
	KMZhdjV2Umk5uzycoAo2o6ghNRsDGfmI4p+aYd2nFhhG/dRSdScItJIn0CFIYjHFliGVSf
	KRwQMPXiP7tD9uEV7oD070e5IeF5FIuCCC9YGChphLkMzIBnU0q7fEh7v1OcBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739286368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcScyRaVnQ5xb4TwKecBkcpqWVZ8pXQZjuAH5zTPMCI=;
	b=bhHP9LGWNTKuK/BX3dYUwbVeTCv4toFPyKc47xeZre4C5s3AJeTFzmZusNTDbIYC43WLW1
	8xtCSWBDhpCmRQAQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Fix the error checking order
Cc: Koichiro Den <koichiro.den@canonical.com>,
 Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250129080513.30353-1-dhananjay.ugwekar@amd.com>
References: <20250129080513.30353-1-dhananjay.ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173928636768.10177.18009351351852464312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     469c76a83bb9f6b2c7b2989c46617c4fe01fee79
Gitweb:        https://git.kernel.org/tip/469c76a83bb9f6b2c7b2989c46617c4fe01fee79
Author:        Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
AuthorDate:    Wed, 29 Jan 2025 08:05:14 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:47:25 +01:00

perf/x86/rapl: Fix the error checking order

After the commit b4943b8bfc41 ("perf/x86/rapl: Add core energy counter
support for AMD CPUs"), the default "perf record"/"perf top" command is
broken in systems where there isn't a PMU registered for type
PERF_TYPE_RAW.

This is due to the change in order of error checks in rapl_pmu_event_init()
Due to which we return -EINVAL instead of -ENOENT, when we reach here from
the fallback loop in perf_init_event().

Move the "PMU and event type match" back to the beginning of the function
so that we return -ENOENT early on.

Closes: https://lore.kernel.org/all/uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk/
Fixes: b4943b8bfc41 ("perf/x86/rapl: Add core energy counter support for AMD CPUs")
Reported-by: Koichiro Den <koichiro.den@canonical.com>
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250129080513.30353-1-dhananjay.ugwekar@amd.com
---
 arch/x86/events/rapl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d3bb386..4952faf 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	unsigned int rapl_pmu_idx;
 	struct rapl_pmus *rapl_pmus;
 
+	/* only look at RAPL events */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
 	/* unsupported modes and filters */
 	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
@@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	rapl_pmus_scope = rapl_pmus->pmu.scope;
 
 	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
-		/* only look at RAPL package events */
-		if (event->attr.type != rapl_pmus_pkg->pmu.type)
-			return -ENOENT;
-
 		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
 		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 			return -EINVAL;
@@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		bit = cfg - 1;
 		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
-		/* only look at RAPL core events */
-		if (event->attr.type != rapl_pmus_core->pmu.type)
-			return -ENOENT;
-
 		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
 		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 			return -EINVAL;

