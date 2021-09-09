Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880CD404717
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhIIIfy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhIIIfx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 04:35:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C6C061575;
        Thu,  9 Sep 2021 01:34:44 -0700 (PDT)
Date:   Thu, 09 Sep 2021 08:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631176482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80QALolpCs7AaTRTKPDWXh+r0eyW85Gk82eTC53eMPI=;
        b=WUCpLxMzdK3se/kKe+cGQdxJecKcpXqI/3a5bpJ6ab5CtD86aXHJ+wVL2s6iIhPsn1VIIf
        hLjeuSW/5JjLfGcBUFMCA/ztYcmp1OvSmmMWxK7gj/3EU0KFuKKbhPYkRlH2/8LU0zgLqB
        vOk7yOtb9iG956q+Un/q4n8mNr2R4xNpl+2jRTvZ9UMM3gKOjWZFpuIC+l8kZrDLA09Uvn
        DbQvh8Vo5lQdfj9S3MWDUkTJQTEKvfxeYk65kYO8HhNHnMgcq/hs0lEQh+GA8N8PgxypwL
        DrrmODycdhTsBsdEeQEMCbB5y02qqzT6dtRiBLpS/NJjyy28ti4ksi5dBCNk3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631176482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80QALolpCs7AaTRTKPDWXh+r0eyW85Gk82eTC53eMPI=;
        b=AFZ5wdrtNb/depnNpKLuv0tU30vHuHBqydht30pbQqaBCPk542QrgSlWQ54c45FnOVr3A4
        149EmsIc7zPm9tCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rtmutex: Fix ww_mutex deadlock check
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YS9La56fHMiCCo75@hirez.programming.kicks-ass.net>
References: <YS9La56fHMiCCo75@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163117648132.25758.8161104732621115882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     e5480572706da1b2c2dc2c6484eab64f92b9263b
Gitweb:        https://git.kernel.org/tip/e5480572706da1b2c2dc2c6484eab64f92b9263b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Sep 2021 11:44:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Sep 2021 10:31:22 +02:00

locking/rtmutex: Fix ww_mutex deadlock check

Dan reported that rt_mutex_adjust_prio_chain() can be called with
.orig_waiter == NULL however commit a055fcc132d4 ("locking/rtmutex: Return
success on deadlock for ww_mutex waiters") unconditionally dereferences it.

Since both call-sites that have .orig_waiter == NULL don't care for the
return value, simply disable the deadlock squash by adding the NULL check.

Notably, both callers use the deadlock condition as a termination condition
for the iteration; once detected, it is sure that (de)boosting is done.
Arguably step [3] would be a more natural termination point, but it's
dubious whether adding a third deadlock detection state would improve the
code.

Fixes: a055fcc132d4 ("locking/rtmutex: Return success on deadlock for ww_mutex waiters")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/YS9La56fHMiCCo75@hirez.programming.kicks-ass.net

---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8eabdc7..6bb116c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -753,7 +753,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * other configuration and we fail to report; also, see
 		 * lockdep.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
 			ret = 0;
 
 		raw_spin_unlock(&lock->wait_lock);
