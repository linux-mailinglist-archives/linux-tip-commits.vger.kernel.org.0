Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC293F98FF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Aug 2021 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbhH0McQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0McQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 08:32:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5351C061757;
        Fri, 27 Aug 2021 05:31:26 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:31:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630067483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dNds+p81oOhH7oHWAqK8Q92dBIuf/+LRRcNobpxs60=;
        b=qMCO9RNb5PhVE+8zGlgK/mfA9o9f+Ffwx5V59wDHnWIp5CiWmgorNijMOX8YYOijdUiI3Y
        R4+Dw+h2qT37iNpe1VQxL/jrlAb/rJ852CZ4Gewu+nr1pWJC9r/yT8xtJRupip/gj4zXp9
        zxgC+pBHN+5vfYcZt/Ori32HlihOLBeybRrA9vSghHZKu9HkYUdTGS7r1S75U/kKDP8ULB
        o3mw8Wk1Xn+Tt4F31fQcyhcIfiZiWijxulJdwDl/6rI3zGDpjD2h8USP4iBFM5oBcXqxY3
        65x8d/yIffifAWRQQ0ew4bA95m8Ia1VHDaLHFsqu2my75D4WhxrmyR1l7YLHgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630067483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dNds+p81oOhH7oHWAqK8Q92dBIuf/+LRRcNobpxs60=;
        b=Ga7hPlPIf8CZKPlMty8B17nnDJssi3SXUVLh6lLBZWXuYPknLgk6d24cq072QHcOH6X58j
        vktM9e0Hf+SFlmDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Return success on deadlock for
 ww_mutex waiters
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
References: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163006748096.25758.17545186547817495348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a055fcc132d4c25b96d1115aea514258810dc6fc
Gitweb:        https://git.kernel.org/tip/a055fcc132d4c25b96d1115aea514258810dc6fc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Aug 2021 10:48:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Aug 2021 14:28:49 +02:00

locking/rtmutex: Return success on deadlock for ww_mutex waiters

ww_mutexes can legitimately cause a deadlock situation in the lock graph
which is resolved afterwards by the wait/wound mechanics. The rtmutex chain
walk can detect such a deadlock and returns EDEADLK which in turn skips the
wait/wound mechanism and returns EDEADLK to the caller. That's wrong
because both lock chains might get EDEADLK or the wrong waiter would back
out.

Detect that situation and return 'success' in case that the waiter which
initiated the chain walk is a ww_mutex with context. This allows the
wait/wound mechanics to resolve the situation according to the rules.

[ tglx: Split it apart and added changelog ]

Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Fixes: add461325ec5 ("locking/rtmutex: Extend the rtmutex core to support ww_mutex")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net
---
 kernel/locking/rtmutex.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3c1ba7b..8eabdc7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -742,8 +742,21 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
+
+		/*
+		 * When the deadlock is due to ww_mutex; also see above. Don't
+		 * report the deadlock and instead let the ww_mutex wound/die
+		 * logic pick which of the contending threads gets -EDEADLK.
+		 *
+		 * NOTE: assumes the cycle only contains a single ww_class; any
+		 * other configuration and we fail to report; also, see
+		 * lockdep.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+			ret = 0;
+
+		raw_spin_unlock(&lock->wait_lock);
 		goto out_unlock_pi;
 	}
 
