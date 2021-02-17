Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85131DA25
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhBQNSn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhBQNSU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:20 -0500
Date:   Wed, 17 Feb 2021 13:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ+rPM7r7HXBa8dLVmBMjucIfa1fBxf33RH9G+idF18=;
        b=v8YCdGa1gHXlR/6Q/K/GELASwDBpZMuQvRg+2jlvBScR8SKSIIwD1dk8kr15nNJ/zSDKZj
        Qq1u7PvcU24W/j9uDvAhK4+RkCxO2BstLxdbAUlp0j7XM6s9hwrSMqRuf/2Zb/UeWkZJtn
        0Lhgu4Owy3bOYlhbjUzbnpf7fQjchJoj8lKq9yFIcnBu78a1IJpAA/m8KZJKZVw+1zmHev
        YC2FECQErYksTSO21p8zOTsSnAfhyxx8GN6Z+GnsMYkpn4fh9hbeOYAkj4VFBvTDM0PmLS
        e9daQ/4oPrMiVkFOJOnhCptgK/j9CUrSh+izaXxzOwBLGq0sFsOQ13cHHPPEwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ+rPM7r7HXBa8dLVmBMjucIfa1fBxf33RH9G+idF18=;
        b=tqGS471dOMWk1R00SwASJhCeAya2TTtrM7YWxOLVkx9lEvJ6B83koiBFIjbRQls3KwDTBF
        Nr/3xFjmW67Op7DA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove MAX_USER_RT_PRIO
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-2-dietmar.eggemann@arm.com>
References: <20210128131040.296856-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161356785658.20312.1229231822797112292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ae18ad281e825993d190073d0ae2ea35dee27ee1
Gitweb:        https://git.kernel.org/tip/ae18ad281e825993d190073d0ae2ea35dee27ee1
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:11 +01:00

sched: Remove MAX_USER_RT_PRIO

Commit d46523ea32a7 ("[PATCH] fix MAX_USER_RT_PRIO and MAX_RT_PRIO")
was introduced due to a a small time period in which the realtime patch
set was using different values for MAX_USER_RT_PRIO and MAX_RT_PRIO.

This is no longer true, i.e. now MAX_RT_PRIO == MAX_USER_RT_PRIO.

Get rid of MAX_USER_RT_PRIO and make everything use MAX_RT_PRIO
instead.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-2-dietmar.eggemann@arm.com
---
 include/linux/sched/prio.h |  9 +--------
 kernel/sched/core.c        |  7 +++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index 7d64fea..d111f2f 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -11,16 +11,9 @@
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
  * values are inverted: lower p->prio value means higher priority.
- *
- * The MAX_USER_RT_PRIO value allows the actual maximum
- * RT priority to be separate from the value exported to
- * user-space.  This allows kernel threads to set their
- * priority to a value higher than any user task. Note:
- * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 
-#define MAX_USER_RT_PRIO	100
-#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define MAX_RT_PRIO		100
 
 #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c789dc..f0b0b67 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5911,11 +5911,10 @@ recheck:
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
+	 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
 	 * SCHED_BATCH and SCHED_IDLE is 0.
 	 */
-	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
-	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
+	if (attr->sched_priority > MAX_RT_PRIO-1)
 		return -EINVAL;
 	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
@@ -6983,7 +6982,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = MAX_USER_RT_PRIO-1;
+		ret = MAX_RT_PRIO-1;
 		break;
 	case SCHED_DEADLINE:
 	case SCHED_NORMAL:
