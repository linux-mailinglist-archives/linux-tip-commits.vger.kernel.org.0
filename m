Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE23BF6F8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhGHIpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Jul 2021 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhGHIpT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87414C06175F;
        Thu,  8 Jul 2021 01:42:37 -0700 (PDT)
Date:   Thu, 08 Jul 2021 08:42:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625733756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpI/AdLvhixUN2krHAlDAeBA4Dimk7VqlkFRK6/XjRA=;
        b=cxLUb9PrXvbwko+Ypfy0AQ2S7chYZ7FIwlJwohaTvs9/UFkqClevCHTwr/hDvsOLiOO/t2
        ipnoJ2kRJXYQmAbuuR+AueTLnQpYtXR2ICuMrU5z0haYhZ5LPthNnXWjydA2meHIQERZWD
        hquPAZjXRdpfqqDNSFEYYXQfneBNOjHQBGXn70h9PwHlBye6Yr5Is0T49JpA4K0YuWJpd7
        420adGSwVJ6/V5cS+yQoBJamhQekHX9Y5HArtqXXNg29dlE35Jie0/6N0SvyMRxJWWrtHG
        4T5UXkBBifk4NI7UL8OJtBAfjXK7sSXYnvuE746NkJpJNU7eqrUPYxI7VY6BcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625733756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpI/AdLvhixUN2krHAlDAeBA4Dimk7VqlkFRK6/XjRA=;
        b=BT7jO8OhN0+VoWd2TJem4g4O8TtvDKL3yI1TCq7bw1EOZiE7Hd0mkun/TdJS7vgzE/SNpg
        wJO+5fUmS+CAzVDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Fix HANDOFF condition
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210630154114.896786297@infradead.org>
References: <20210630154114.896786297@infradead.org>
MIME-Version: 1.0
Message-ID: <162573375542.395.13930081717267627387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     048661a1f963e9517630f080687d48af79ed784c
Gitweb:        https://git.kernel.org/tip/048661a1f963e9517630f080687d48af79ed784c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Jun 2021 17:35:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Jul 2021 13:53:24 +02:00

locking/mutex: Fix HANDOFF condition

Yanfei reported that setting HANDOFF should not depend on recomputing
@first, only on @first state. Which would then give:

  if (ww_ctx || !first)
    first = __mutex_waiter_is_first(lock, &waiter);
  if (first)
    __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);

But because 'ww_ctx || !first' is basically 'always' and the test for
first is relatively cheap, omit that first branch entirely.

Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>
Link: https://lore.kernel.org/r/20210630154114.896786297@infradead.org
---
 kernel/locking/mutex.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cab7163..8c3d499 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -909,7 +909,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
 	struct mutex_waiter waiter;
-	bool first = false;
 	struct ww_mutex *ww;
 	int ret;
 
@@ -988,6 +987,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	set_current_state(state);
 	for (;;) {
+		bool first;
+
 		/*
 		 * Once we hold wait_lock, we're serialized against
 		 * mutex_unlock() handing the lock off to us, do a trylock
@@ -1016,15 +1017,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
-		/*
-		 * ww_mutex needs to always recheck its position since its waiter
-		 * list is not FIFO ordered.
-		 */
-		if (ww_ctx || !first) {
-			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
+		first = __mutex_waiter_is_first(lock, &waiter);
+		if (first)
+			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 
 		set_current_state(state);
 		/*
