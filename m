Return-Path: <linux-tip-commits+bounces-5040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F7A91D30
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EF51894310
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A95248875;
	Thu, 17 Apr 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGcj5KFa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRiS7Who"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A324C08F;
	Thu, 17 Apr 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894900; cv=none; b=PZz5hAmODhnz0Wk2tgEjUnH+eVClRaqTN7h7woRhowNlsIC/WFD1pF25bFdUfTW40oWDuLf/QmsbcbUlC3DGDE+7WHoBBHzRR5mhd83WmYfBxRweUDIChAEByIwD9fkgThEZgRS/uNfE3tD5gFzt1eUHInvCpJqE/j9EUyB3kRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894900; c=relaxed/simple;
	bh=6ApNsHfCsKfOVKw2a5oiFRlzxfSPM2OKTz5jTFMH/v0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PRPwnF7+SOg2DjSMrJg79XfoRZHDllRn7CrstJfFCDkEo+2O0Wdxv7S9HMKndnve9PXqRz3qKR5Z6I7EkIcRVAhYA01JBHV3gh2vKk+QY2FTbg0DO02w+GXRr5P3qYVdeg5CFgpWa7Ft9qJpR7Cj8Noo7lrYkW4xWMvyw1zYklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGcj5KFa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRiS7Who; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Pz3NDfy2sBA69YJvQsHnlEnlfKWy65+H66rR/+C8g=;
	b=uGcj5KFaotLfylT8MjlvQhd2Tm1vMjSVphKtk8sk3xJaEsa0Si347/vELpM0/5egRFlt5M
	u6dNLmtza9XIPiOc5SLJ9woucaTXsJiK6OTcIVnSXW2T/e9dC6u5vGUqrxen0Vjj3eCaIS
	u7sGLL0rQn3cGbHs+80Nenluo5y8YADo2feHnZSg8iIzLbsv/7+ScLsqoajk3eu6iwC6Dn
	i2rAyWJaGq/C+e+06Pa+Yng9VQrZfQxouX/u12ErCLK7fmLoWriKz+57yQ8tbMVkbPyMV9
	8CJ2nALuJogkoWOzh7J/NLhUAUWF9cnr5Pa8SLGYAjj+6/kUvKwMbUXNzoGd+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Pz3NDfy2sBA69YJvQsHnlEnlfKWy65+H66rR/+C8g=;
	b=PRiS7WhohIDNL5JOZTtdCwv4pfXw947kjQD3fO3hti7zXrONd+2KcxXAeld5hwuG9L57z8
	XdTsMOepC5bhcEDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix perf-stat / read()
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417080725.GH38216@noisy.programming.kicks-ass.net>
References: <20250417080725.GH38216@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489552.31282.17349657227055142868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f6938a562a6249000de211a710807ebf0b8fdf26
Gitweb:        https://git.kernel.org/tip/f6938a562a6249000de211a710807ebf0b8fdf26
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 20:50:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:15 +02:00

perf/core: Fix perf-stat / read()

In the zeal to adjust all event->state checks to include the new
REVOKED state, one adjustment was made in error. Notably it resulted
in read() on the perf filedesc to stop working for any state lower
than ERROR, specifically EXIT.

This leads to problems with (among others) perf-stat, which wants to
read the counts after a program has finished execution.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Reported-by: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Reported-by: James Clark <james.clark@linaro.org>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/77036114-8723-4af9-a068-1d535f4e2e81@linaro.org
Link: https://lore.kernel.org/r/20250417080725.GH38216@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2eb9cd5..e4d7a0c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6021,7 +6021,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
-	if (event->state <= PERF_EVENT_STATE_ERROR)
+	if (event->state == PERF_EVENT_STATE_ERROR)
 		return 0;
 
 	if (count < event->read_size)

