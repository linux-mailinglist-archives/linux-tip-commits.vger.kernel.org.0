Return-Path: <linux-tip-commits+bounces-5145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C0AA4A7E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C66116E34D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1025A2C5;
	Wed, 30 Apr 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+gbLnBS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2s59pd8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B32211A35;
	Wed, 30 Apr 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014335; cv=none; b=bC0rwKODnNk/VZG4Sc4YyUsPgbLxddgcLd9836XgU7SuB8py5x8eIGE9ZQh5hQ8hKu3sbVCMj0VE0a9yVRpf2ZdVJkELO9XibFNPPNvv5uKctsFWAQCJDLLVqmj5u08uzFkjTABJKXgaSgqZkCZwWoBEDZpYnZZ4mutcmjWfSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014335; c=relaxed/simple;
	bh=TzuwJpXNeevXE7/Ff0wCefQeVKVKnRYwAPMXEEz0H+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vd6WdbUnHJEvjdsrJ6b6qVK11s59LUnCKP1EMHwFr+xmkO4XIZjLjUeZ7t8+QZIMaUOUWZDF2jLi4uyMHd4dyI3pgdvFTpg+Hi9irZXys0bYDO9Gy7KsvpSTgb+cG98yELd4knT6xf6p9gyrNctm7LA2sb4hrGc//jZ6zi0Q10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+gbLnBS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X2s59pd8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tDTd9PjKMsgm9qH+AiJd/bRqshi47m/Nn2NZga1Nms=;
	b=c+gbLnBSIKqWN6NaI90lIiW6Q6DCS74SQls0ifVFbmUrKeUkRPME5075jGFMgWRYzMqn04
	Xuv7s0Lm+6Cmdq0+PQkktH9bGFhT1j3H8cCNOM4hcuIc0tgVu2FShGwsycUvgo8FQ3KGIe
	XgCSK+2oAt42NTcY+KOeNNXufsuqQ34toWuxHUxL25DeW0r/ZMAyVs/Y4sDAIq4k3vIoBD
	O0cWIoMjpjuaZkSsP34oHugNYLTxydXfbpOBX2JyEaBPwV+vGvZXHxww2jDdDiDwkfTTH0
	lCAOvCnyHiLiHDiUctDdxtGfLgM4vND2hmpal5qPDgkdWtqFYqDVjwgnN2+1Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tDTd9PjKMsgm9qH+AiJd/bRqshi47m/Nn2NZga1Nms=;
	b=X2s59pd8JU+1GHQdSm+rYXrUbu9dymAWLszkqnX0/FFJjpEwZGviJOoubIN4Zbmak5dTnV
	qPeQTRUILYxieYCQ==
From: "tip-bot2 for Qing Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Fix broken throttling when max_samples_per_tick=1
Cc: Qing Wang <wangqing7171@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250405141635.243786-3-wangqing7171@gmail.com>
References: <20250405141635.243786-3-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601433122.22196.14323067984901288886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f51972e6f8b9a737b2b3eb588069acb538fa72de
Gitweb:        https://git.kernel.org/tip/f51972e6f8b9a737b2b3eb588069acb538fa72de
Author:        Qing Wang <wangqing7171@gmail.com>
AuthorDate:    Sat, 05 Apr 2025 22:16:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:22 +02:00

perf/core: Fix broken throttling when max_samples_per_tick=1

According to the throttling mechanism, the pmu interrupts number can not
exceed the max_samples_per_tick in one tick. But this mechanism is
ineffective when max_samples_per_tick=1, because the throttling check is
skipped during the first interrupt and only performed when the second
interrupt arrives.

Perhaps this bug may cause little influence in one tick, but if in a
larger time scale, the problem can not be underestimated.

When max_samples_per_tick = 1:
Allowed-interrupts-per-second max-samples-per-second  default-HZ  ARCH
200                           100                     100         X86
500                           250                     250         ARM64
...
Obviously, the pmu interrupt number far exceed the user's expect.

Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250405141635.243786-3-wangqing7171@gmail.com
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c69a1a..05136e8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10065,14 +10065,14 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle &&
-			     hwc->interrupts > max_samples_per_tick)) {
-			__this_cpu_inc(perf_throttled_count);
-			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-			hwc->interrupts = MAX_INTERRUPTS;
-			perf_log_throttle(event, 0);
-			ret = 1;
-		}
+	}
+
+	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
+		__this_cpu_inc(perf_throttled_count);
+		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
+		hwc->interrupts = MAX_INTERRUPTS;
+		perf_log_throttle(event, 0);
+		ret = 1;
 	}
 
 	if (event->attr.freq) {

