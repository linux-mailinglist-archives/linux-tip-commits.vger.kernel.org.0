Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA4337F884
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhEMNTe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhEMNSr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BEC061763;
        Thu, 13 May 2021 06:17:35 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoZGNtpT7J9Ukr34M6cTRSHUYsCi8hXA8RtxyEBUWik=;
        b=YrVlZ5Nvp3uW01CKTL6AjrGVvR59M7m12BNSJXkdC+BmW3qc6IQzGrhGx+rCvjDKSXOHk3
        8thZKQZHmhKW3AQ8WFjNw2m81odzxqB5SqIE/dlvCLFktDORjBMSILn4LECGDWYOXnwER/
        OBZXcJbID6Qn4qhCM4o5al0Twel0xuARy7DoLahIA8IjqULXoQuQuVnSSv7ATvq+dg3DXl
        +ciCnE2lGxBvE0fIlG9WAAWTEitcG8GeD24nidOHlp4SFs757lnfGQ7Jn2ApaQk6IlbR2v
        KviBSgUUV4lGmmKWrUN6+EYVtPpLuPol5+i1XcmjJh7xeJQO1aof0l7FwT5p5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoZGNtpT7J9Ukr34M6cTRSHUYsCi8hXA8RtxyEBUWik=;
        b=BNeHwPJ+qBpc3L3kulal/KUVMRQsRwTvSj+rnER7te6qVwK88roTSeQNq2vhnL68xZ3QsF
        sndRDa3zK4hKnDDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Remove superflous check for
 CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-4-frederic@kernel.org>
References: <20210512232924.150322-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184904.29796.4999933388579094630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     3f624314b3f7c580aa5844a8930befd71e2a287c
Gitweb:        https://git.kernel.org/tip/3f624314b3f7c580aa5844a8930befd71e2a287c
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 13 May 2021 01:29:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:21 +02:00

tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE

The vtime_accounting_enabled_this_cpu() early check already makes what
follows as dead code in the case of CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
No need to keep the ifdeferry around.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-4-frederic@kernel.org
---
 kernel/time/tick-sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 05c1ce1..1afa759 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1196,7 +1196,6 @@ unsigned long tick_nohz_get_idle_calls(void)
 
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
 	if (vtime_accounting_enabled_this_cpu())
@@ -1212,7 +1211,6 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 	 */
 	if (ticks && ticks < LONG_MAX)
 		account_idle_ticks(ticks);
-#endif
 }
 
 void tick_nohz_idle_restart_tick(void)
