Return-Path: <linux-tip-commits+bounces-1267-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70288C903C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169F91F21C8B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BB179B2;
	Sat, 18 May 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XJ0kvMs3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24WdP9po"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58ED17582;
	Sat, 18 May 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025423; cv=none; b=DfxwcOeYeRvBiwC+4To3774LSDKDtqTeqKPAkKOCGMm7FTSqigrUJnB2Cpgf7Bmminnypb40XMKnGLg7kxSRmADFYF0g9Il43c6yt12sgXJn0iURzf7KGZSx71/muZ+ymu8zpc8Y41Vw4B27yDsUch++zYNz7pLtR+1J1HptM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025423; c=relaxed/simple;
	bh=cN4taKemZXfix9JfNEyfNhnnzUNu1CKiXassiYzK5/g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O6ujFG0Fp4ngK07DvkN6hRtfeUSfvdSmtq5ZbmpzHPbbBGWo9wZ8prL4dnGxq9DTGBfdLwmJXH+WGWEHL8KvToanqFtUTAICdhOoq8qfuLpCVsHIuq2CmUl/rNTIKc2o4SfSf9zfVqHGdavAqITRmqAWPUNm6IT1QDBImp5WTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XJ0kvMs3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24WdP9po; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 18 May 2024 09:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716025419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+RQLhf8Q7V1V0kAlxyT1Z11xQC04LkQ5kVZhi2K2ws=;
	b=XJ0kvMs3PbW1LswSh487Ys18FkGIMEvZKLAYW2NIV9MQXmHYdKDvJdHXHNZHtXVrZFCMbc
	YbuZS0EEXGb6XsHWkieny5Ih3pWtsRQETTOE+CpawybF0y00UKEf2uHovcWkqCcRtKurl6
	98qW474JIw0s5lUxwBvOYNLXnLEHPKt0CE0P0A+L3FtmQFgvy9OrZl86EeysEscJXZPXlB
	dBQMnPkz/qWzwIddYdRdaxPGq8KwqAWkvP+S1KAqMS6DK0/XeXvKBi2I6mHbQI5tHkGNEU
	2KhzxOnvOOsrhRvF3oHl3FG0I6IpuFqeS0xslY1sR6yHHRGvzPjDejLZ090k3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+RQLhf8Q7V1V0kAlxyT1Z11xQC04LkQ5kVZhi2K2ws=;
	b=24WdP9pox0lXY4BP9mRsFw9HopQEoufDrv21zlVCaPhxgLiS34tz4NETEHl02mqnU0BI6Y
	jM8ay1Qb+/EqPRBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240425101708.5025-1-ubizjak@gmail.com>
References: <20240425101708.5025-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602541885.10875.9262354688213911942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     cd84351c8c1baec86342d784feb884ace007d51c
Gitweb:        https://git.kernel.org/tip/cd84351c8c1baec86342d784feb884ace007d51c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 25 Apr 2024 12:16:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:15:13 +02:00

perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c

Replace this pattern in events/amd/{un,}core.c:

    cmpxchg(*ptr, old, new) == old

.. with the simpler and faster:

    try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240425101708.5025-1-ubizjak@gmail.com
---
 arch/x86/events/amd/core.c   | 4 +++-
 arch/x86/events/amd/uncore.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce4..18bfe34 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -433,7 +433,9 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
 	 * when we come here
 	 */
 	for (i = 0; i < x86_pmu.num_counters; i++) {
-		if (cmpxchg(nb->owners + i, event, NULL) == event)
+		struct perf_event *tmp = event;
+
+		if (try_cmpxchg(nb->owners + i, &tmp, NULL))
 			break;
 	}
 }
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa..0fafe23 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -162,7 +162,9 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	/* if not, take the first available counter */
 	hwc->idx = -1;
 	for (i = 0; i < pmu->num_counters; i++) {
-		if (cmpxchg(&ctx->events[i], NULL, event) == NULL) {
+		struct perf_event *tmp = NULL;
+
+		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
 			hwc->idx = i;
 			break;
 		}
@@ -196,7 +198,9 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	event->pmu->stop(event, PERF_EF_UPDATE);
 
 	for (i = 0; i < pmu->num_counters; i++) {
-		if (cmpxchg(&ctx->events[i], event, NULL) == event)
+		struct perf_event *tmp = event;
+
+		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
 			break;
 	}
 

