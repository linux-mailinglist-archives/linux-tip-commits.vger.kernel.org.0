Return-Path: <linux-tip-commits+bounces-2869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66B9D21CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0292B21A3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535B19882B;
	Tue, 19 Nov 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsR7/cY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElCIbnSz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C2146D53;
	Tue, 19 Nov 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006137; cv=none; b=HCrGeRWldSYlPWuphKUPjKMBISP1TtNuPQBmvqsmwvR3A62faeOHwbbutZ5bxbQM0+5vqytHNmfbDJy/jwBFa0+KImUaLig1JNCVSmwaniTK67k4wuQUnwDaJgtu5z6fC/nW/xFfwZBolPKtjPgQq6EyqA3L5lYAhcYIO6V3Jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006137; c=relaxed/simple;
	bh=Ou22IvXvPZ0RTg5qPiflwtBzYutcw9QiqB3OybQ+b18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WFbBLWcwVfYn4+4E4HHgg26jDYhN7UzZbLZjAD645e8rYpx+4GM30BWhSOsTGcjBFuPPX2HtJtDq1c7nX3c0ykjdzDCp/2ayIWJ/6GUvzbv8SN4LU63SSkwDzV4j0jkW6OS5Uv6hoHbupofO8DU8jBWvo8bvOXeGr0ThO8GqSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsR7/cY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElCIbnSz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 08:48:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732006130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jLFLnYZkej73J44hvQQGnqmpU9dBF8CVnAUjTOjWN8=;
	b=gsR7/cY5JNb++kmSaOKClEtkcDuDLja0F8Xi0X45fOeE/tiGhnoKXIpDzatU2f3mt91Op4
	FIwqdyiaG+kIcn+xeuviObc2ixD2qKP8z3Sec6Ho+qLDE9m0dvngrm4rnJ9RyWzAL207KP
	ZhuP8zHUhUOYkLbiHwtQ/AHROuHN8OGraXIbqpPqRpsULbsyLezo+PAw4fGDIfkd2SyQt/
	495s+B1zDJ6Pn15c1rFu9ZlgiQdAbs2wZfJ0cKB7FUg/8RtzWGND0O3sm3uoP3uVhsJFQH
	nmqsMshYetGn5nXIU6S/SU/RJKU7tu2UbIeVDBwR05hP9OFM7o07rmIFzk+X9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732006130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jLFLnYZkej73J44hvQQGnqmpU9dBF8CVnAUjTOjWN8=;
	b=ElCIbnSzkUuBWkzRGk61RlJ0flYPkyGrsQABCU9hyNQaCyLNwyWZWmMEiICAMqtQXzcRYR
	1PU7oFmoBd+O1+Dg==
From: "tip-bot2 for Yabin Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Check sample_type in perf_sample_save_callchain
Cc: Namhyung Kim <namhyung@kernel.org>, Yabin Cui <yabinc@google.com>,
 Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240515193610.2350456-3-yabinc@google.com>
References: <20240515193610.2350456-3-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173200612962.412.14983453826690347800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f226805bc5f60adf03783d8e4cbfe303ccecd64e
Gitweb:        https://git.kernel.org/tip/f226805bc5f60adf03783d8e4cbfe303ccecd64e
Author:        Yabin Cui <yabinc@google.com>
AuthorDate:    Wed, 15 May 2024 12:36:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2024 09:23:42 +01:00

perf/core: Check sample_type in perf_sample_save_callchain

Check sample_type in perf_sample_save_callchain() to prevent
saving callchain data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240515193610.2350456-3-yabinc@google.com
---
 arch/x86/events/amd/ibs.c  | 3 +--
 arch/x86/events/intel/ds.c | 6 ++----
 include/linux/perf_event.h | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c3a2f6f..f029396 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1129,8 +1129,7 @@ fail:
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(&data, event, iregs);
+	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8afc4ad..4990a24 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1789,8 +1789,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1957,8 +1956,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f7c0a3f..3ac202d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1279,6 +1279,11 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 

