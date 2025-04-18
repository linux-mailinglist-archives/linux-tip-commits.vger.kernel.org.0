Return-Path: <linux-tip-commits+bounces-5064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043DA934D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438B9172624
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01782550DA;
	Fri, 18 Apr 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txD7MC4z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZiJW5Qj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1E8C0E;
	Fri, 18 Apr 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965922; cv=none; b=Dsbz9/sKl8Nk03nqlTRI+UqlFbiNP6RUDHl6S8xY1SHxdtZ7TaG9WQFapoaBt8HfmLcU5oWEAMpVFu8Qn2fgDw2wxgF+QFNNrRmYK/ICncf/smDqn/5s7tuOJ4lVDDZWfw5j4b2JNFtnn2pVT5arRNC0fkgLi2o8c52WyLGefX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965922; c=relaxed/simple;
	bh=FWUhiALVE7CEc3cIfcL5ovVCpqjUtarZj4j1Pq4AwRI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e7taZo1fauLe0PlHE0xkEg99Xk89w4OMISB/KedUpl+H5EYQuS99ZeJyIPf84o2XmQd9zFhVYjdEZX60asmRw4Yv3TK1u8LLExnqIcxae2npurf9i48vOpKUa2NQwg0IxKVfya2a78DRyD2W25vMcIzrbST4Eps07sLz3Ypf31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txD7MC4z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZiJW5Qj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:45:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFo6X9dFJGOXVcZbtCX2G68w5mPOAd5r4zBcld39eUQ=;
	b=txD7MC4zzUnRUWK/228OrEul221HYzXd6Isldz5gr9a+bTKZQGFA6HnFDt5v0KptkQbZYP
	hx/4SIn+Br4IYhcXPUP+yrsjuQVRaOBvpKBaNrNo/hpQPgUAkLjSqYnos7XEjq3VVzG2cU
	VGVadxXJ45sRgfiDC8z6Re74jR58hkUCUKu9jLD7W1X9L+c0yaCOaVwiN7S7+QoO5Nl0Dh
	kITj/JaHvNgFsVWpU0HQd9jpN6Q8GOK5NfZnFLfcW1CNb2d3d3kqX6pQw4O+h1LBGIiqXp
	QQnhubXqPN8MoF7HPh7KK5rOuRO9bpkG2xdwvs45um6w0qwcfEfX3VwprmXKaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFo6X9dFJGOXVcZbtCX2G68w5mPOAd5r4zBcld39eUQ=;
	b=TZiJW5QjC7iWHo/m/FgLcOS9EI1Qc1ywL9uzSyw5gWdf1AOzVWSBIsnOldzoqYPLkhsaPX
	pN8Lv3Q5/nXoWvAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd/uncore: Prevent UMC counters from saturating
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Song Liu <song@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdee9c8af2c6d66814cf4c6224529c144c620cf2c=2E17449?=
 =?utf-8?q?06694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cdee9c8af2c6d66814cf4c6224529c144c620cf2c=2E174490?=
 =?utf-8?q?6694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496591397.31282.705789021676536158.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2492e5aba2be064d0604ae23ae0770ecc0168192
Gitweb:        https://git.kernel.org/tip/2492e5aba2be064d0604ae23ae0770ecc0168192
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:03 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:35:34 +02:00

perf/x86/amd/uncore: Prevent UMC counters from saturating

Unlike L3 and DF counters, UMC counters (PERF_CTRs) set the Overflow bit
(bit 48) and saturate on overflow. A subsequent pmu->read() of the event
reports an incorrect accumulated count as there is no difference between
the previous and the current values of the counter.

To avoid this, inspect the current counter value and proactively reset
the corresponding PERF_CTR register on every pmu->read(). Combined with
the periodic reads initiated by the hrtimer, the counters never get a
chance saturate but the resolution reduces to 47 bits.

Fixes: 25e56847821f ("perf/x86/amd/uncore: Add memory controller support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/dee9c8af2c6d66814cf4c6224529c144c620cf2c.1744906694.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 70e0af3..d328de1 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -956,6 +956,39 @@ static void amd_uncore_umc_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
+static void amd_uncore_umc_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new, shift;
+	s64 delta;
+
+	shift = COUNTER_SHIFT + 1;
+	prev = local64_read(&hwc->prev_count);
+
+	/*
+	 * UMC counters do not have RDPMC assignments. Read counts directly
+	 * from the corresponding PERF_CTR.
+	 */
+	rdmsrl(hwc->event_base, new);
+
+	/*
+	 * Unlike the other uncore counters, UMC counters saturate and set the
+	 * Overflow bit (bit 48) on overflow. Since they do not roll over,
+	 * proactively reset the corresponding PERF_CTR when bit 47 is set so
+	 * that the counter never gets a chance to saturate.
+	 */
+	if (new & BIT_ULL(63 - COUNTER_SHIFT)) {
+		wrmsrl(hwc->event_base, 0);
+		local64_set(&hwc->prev_count, 0);
+	} else {
+		local64_set(&hwc->prev_count, new);
+	}
+
+	delta = (new << shift) - (prev << shift);
+	delta >>= shift;
+	local64_add(delta, &event->count);
+}
+
 static
 void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -1034,7 +1067,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.del		= amd_uncore_del,
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
-				.read		= amd_uncore_read,
+				.read		= amd_uncore_umc_read,
 				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 				.module		= THIS_MODULE,
 			};

