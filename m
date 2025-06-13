Return-Path: <linux-tip-commits+bounces-5820-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245AAD84D5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826B3189B589
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C825291C17;
	Fri, 13 Jun 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFojpYiL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnbdDUU6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E126B75A;
	Fri, 13 Jun 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800266; cv=none; b=k95fnpDdOt3IVF7obgZz9f+d0NxZHJFuSGpiOpSkBAxr15Amvh8W0KA71id5nyi1I4LCkNwkRTIQxrRPgEPjoKHpCSG+3JPQ58GCs7rlasH5WHYProGe21AxY3HLANxVNwSY5BHm+pxAgba3qasunONklkexe1ZrHfAupjMg2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800266; c=relaxed/simple;
	bh=O4kMdqutszIvXEJ/yLNq9owymToObhrbLLZF86nCmic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kN4YmGPF1tf1HopEYjaBtRQbIITkMk/MetAhXgyCfUo8DulCMt4e7GxhIF1XiO7FbTnwE/fstpi3eBvD3fJ/zF2m8saWxSVkDEkugEGj9EvgsNL2caR1YOfmY2ma1EJguy0gpadEJFi9fmMbw9QfRABIzOTjtInh7PfKf5VtXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFojpYiL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnbdDUU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zUvLRUwt3M2SABbsBu6Qalqd1tT1kz5NzwaOBE135c=;
	b=GFojpYiLNLyRuiLfd/+S69MfUjfO45fiRVqbQXeuXuvz3pNMGEyTPzleXtH0ta4CurxfOO
	czXqX8aq7ahxodi6+x13isKKfhOElneGf5/03s2bZBUBHqYdJGKVkXNpy/rJCQKrSEeqj4
	4AGQI7VWxi/9Prey/alBBg69Lq9u1MQk1hYq06P3lyAZWhlri8G9HJjFS76nAtIYBMen/i
	4yAbkAOPfd2NPjONRG8jtjcmmLh+oe2SsHqDEPwb7afAGAGBqb/WRb8/ArXwZdJ6o5MaGy
	c2phef8RnfxkbPMEpfq4VolN1ZhV9e0jl53Qzs6al9R6FaVbQhBL6IxMPhdL+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zUvLRUwt3M2SABbsBu6Qalqd1tT1kz5NzwaOBE135c=;
	b=tnbdDUU6jsBQuQICxEo3KnqoH9x3SAp1fc7mjOBn3g4lAbbp6zNV0tjG1JUDG+6PcEfYgl
	vqb3G1s8ItBFWHCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/cpufreq_schedutil.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-5-mingo@kernel.org>
References: <20250528080924.2273858-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025901.406.4637670198335273101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8bb9b0c5aeb9594bc1039e38d15b14d2a055cf3a
Gitweb:        https://git.kernel.org/tip/8bb9b0c5aeb9594bc1039e38d15b14d2a055cf3a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:15 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/cpufreq_schedutil.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-5-mingo@kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3d7e9cc..0ab5f9d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -382,9 +382,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 	sg_cpu->saved_idle_calls = idle_calls;
 	return ret;
 }
-#else
+#else /* !CONFIG_NO_HZ_COMMON: */
 static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
-#endif /* CONFIG_NO_HZ_COMMON */
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
  * Make sugov_should_update_freq() ignore the rate limit when DL

