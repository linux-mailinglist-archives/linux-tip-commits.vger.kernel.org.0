Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790531DA35
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBQNTp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhBQNS7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D6C0617A9;
        Wed, 17 Feb 2021 05:17:38 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+WKpWCtgBHlUbDq+xtt2lSnLipSTFLq5UmDtvANAhA=;
        b=vzr4Fg1Y54pHmcYJqtzwT9ScXstS8zKqqVHXF658t3pdOfSRpO0I0EntXMn5Sl4dL8hWl8
        zBQjf+tt5Hc9Ast2/GY4WOqcSlrjIzITmnN2P0zvwXJ/MjYiR0pXS1XoJy/5YK8o8hkJAP
        l+PY7UyB2W9Gzo5ut1QXOeeYlJYYzrJk5hJkjihXMPVPHGGGHIip6xtrksj3k/NENHG9D+
        oC2VR08MUKH11CNSZbYulN9F3LeVazcs9sYCel8W8dEWoLEHOdcrQtBUrgrIKCVBWRBbD+
        APFLLxG9wYAeM4wvOGDpY4yvmeVNUT1/T4i+uqStgCt+coiG9SnFKQhtMkV8uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+WKpWCtgBHlUbDq+xtt2lSnLipSTFLq5UmDtvANAhA=;
        b=glBLhW0noa3JJGvxpgF26462qupAHlvUwG7KjmJf6rsTy3IfloCqu3eMoQbVrLNMMYkfgD
        5syThWGhSDl07bBg==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-3-dietmar.eggemann@arm.com>
References: <20210128131040.296856-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161356785632.20312.11413360885700610042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d061ba6bc170045857f3efe0bba5def30188d4d
Gitweb:        https://git.kernel.org/tip/9d061ba6bc170045857f3efe0bba5def30188d4d
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:17 +01:00

sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO

The only remaining use of MAX_USER_PRIO (and USER_PRIO) is the
SCALE_PRIO() definition in the PowerPC Cell architecture's Synergistic
Processor Unit (SPU) scheduler. TASK_USER_PRIO isn't used anymore.

Commit fe443ef2ac42 ("[POWERPC] spusched: Dynamic timeslicing for
SCHED_OTHER") copied SCALE_PRIO() from the task scheduler in v2.6.23.

Commit a4ec24b48dde ("sched: tidy up SCHED_RR") removed it from the task
scheduler in v2.6.24.

Commit 3ee237dddcd8 ("sched/prio: Add 3 macros of MAX_NICE, MIN_NICE and
NICE_WIDTH in prio.h") introduced NICE_WIDTH much later.

With:

  MAX_USER_PRIO = USER_PRIO(MAX_PRIO)

                = MAX_PRIO - MAX_RT_PRIO

       MAX_PRIO = MAX_RT_PRIO + NICE_WIDTH

  MAX_USER_PRIO = MAX_RT_PRIO + NICE_WIDTH - MAX_RT_PRIO

  MAX_USER_PRIO = NICE_WIDTH

MAX_USER_PRIO can be replaced by NICE_WIDTH to be able to remove all the
{*_}USER_PRIO defines.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-3-dietmar.eggemann@arm.com
---
 arch/powerpc/platforms/cell/spufs/sched.c |  2 +-
 include/linux/sched/prio.h                |  9 ---------
 kernel/sched/sched.h                      |  2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d506..aeb7f39 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -72,7 +72,7 @@ static struct timer_list spuloadavg_timer;
 #define DEF_SPU_TIMESLICE	(100 * HZ / (1000 * SPUSCHED_TICK))
 
 #define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_SPU_TIMESLICE)
+	max(x * (MAX_PRIO - prio) / (NICE_WIDTH / 2), MIN_SPU_TIMESLICE)
 
 /*
  * scale user-nice values [ -20 ... 0 ... 19 ] to time slice values:
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index d111f2f..ab83d85 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -27,15 +27,6 @@
 #define PRIO_TO_NICE(prio)	((prio) - DEFAULT_PRIO)
 
 /*
- * 'User priority' is the nice value converted to something we
- * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
- */
-#define USER_PRIO(p)		((p)-MAX_RT_PRIO)
-#define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
-#define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-
-/*
  * Convert nice value [19,-20] to rlimit style value [1,40].
  */
 static inline long nice_to_rlimit(long nice)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f519aba..2185b3b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -140,7 +140,7 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
  * scale_load() and scale_load_down(w) to convert between them. The
  * following must be true:
  *
- *  scale_load(sched_prio_to_weight[USER_PRIO(NICE_TO_PRIO(0))]) == NICE_0_LOAD
+ *  scale_load(sched_prio_to_weight[NICE_TO_PRIO(0)-MAX_RT_PRIO]) == NICE_0_LOAD
  *
  */
 #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
