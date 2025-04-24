Return-Path: <linux-tip-commits+bounces-5120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B918FA9B646
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230C94A879E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739E28F535;
	Thu, 24 Apr 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HjOx51P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtKqlk93"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732728F52A;
	Thu, 24 Apr 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518929; cv=none; b=QKTvetxLoK8kB0sfNUr2AV4YRny6GYrunohcxTPDztfneYDml5BNmuKw4LDfp9mdR5TdLkaTLES0bZzKdVM6ArC/HkwjKdXJsKjvzddu30k2yA4Me6NcBeUeggT6H4DsO8bC9DWs4DSAOdidxKP5FbGu2vvzwq80XFyGzFpOTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518929; c=relaxed/simple;
	bh=woYzcTWQ9ynNllZVZG+Zzbl6e/J9v0hUUflRP2UGZgg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dncElLidHR7NUYVCnRg4joPiqE2iAS8EfrExCmhyltEjhb/TYp54a3Rr+vF9pOhAAIoOrYYkYps4pLM5u18KVVKO+T2dtqfN52oMpphyClAHgQGzuBeIR76zBsv5g3KhYA6IvG9hFeShsHlqez9n5/fSgoX43BS14LzAuY4kDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HjOx51P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtKqlk93; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 18:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745518924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqI34PQMBxfbQ34aVcvLVNR1deMQ/7aazM2XE58q+iU=;
	b=1HjOx51PmXmsvRW67cSEasgHzOZL44xqiE2VJFkpcaMsaZThgCsKcU0hg2YFNSBcpF6ag7
	55wtKaqBfyGl8OM36p/+ZCh1tgPcbyzHiO38DisSO99iGYUoC3MYm6PLBvSgS+oCXKL1yG
	2mNbFIf9COffiw+YyzWBr1tC9TGdUbPvA0t/a5jL9KMXvETyyVJ5DzGAzVYaTR51AeeJqB
	vUfTOfHs3lWc2zVb4ugXr4BjsgFEfhudd2bV3H+h4BC1+Fqk03948fxdtEHDQJFw659jVZ
	KcOADMeRs8OdR3RHk3cL75N0PQeeB3Grcrz4uVV0+jgKSQEKgtw129GxHNpPvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745518924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqI34PQMBxfbQ34aVcvLVNR1deMQ/7aazM2XE58q+iU=;
	b=rtKqlk937nf9D5qPt2h87BQgnyIjG8RStUnIedzviyCZvMWQCP73ca5dG0ZzynwKH7bysb
	ulGErGDfZqDmKTCg==
From: "tip-bot2 for Luo Gengkun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix non-sampling (counting) events on
 certain x86 platforms
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174551892205.31282.8764078433432267645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1a97fea9db9e9b9c4839d4232dde9f505ff5b4cc
Gitweb:        https://git.kernel.org/tip/1a97fea9db9e9b9c4839d4232dde9f505ff5b4cc
Author:        Luo Gengkun <luogengkun@huaweicloud.com>
AuthorDate:    Wed, 23 Apr 2025 06:47:24 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Apr 2025 20:15:04 +02:00

perf/x86: Fix non-sampling (counting) events on certain x86 platforms

Perf doesn't work at perf stat for hardware events on certain x86 platforms:

 $perf stat -- sleep 1
 Performance counter stats for 'sleep 1':
             16.44 msec task-clock                       #    0.016 CPUs utilized
                 2      context-switches                 #  121.691 /sec
                 0      cpu-migrations                   #    0.000 /sec
                54      page-faults                      #    3.286 K/sec
   <not supported>	cycles
   <not supported>	instructions
   <not supported>	branches
   <not supported>	branch-misses

The reason is that the check in x86_pmu_hw_config() for sampling events is
unexpectedly applied to counting events as well.

It should only impact x86 platforms with limit_period used for non-PEBS
events. For Intel platforms, it should only impact some older platforms,
e.g., HSW, BDW and NHM.

Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250423064724.3716211-1-luogengkun@huaweicloud.com
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6866cc5..3a4f031 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (!event->attr.freq && x86_pmu.limit_period) {
+	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)

