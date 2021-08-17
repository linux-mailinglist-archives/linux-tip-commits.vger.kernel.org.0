Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CEC3EF3AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhHQURS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhHQUPy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC665C0619FE;
        Tue, 17 Aug 2021 13:14:34 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/f2KZ5rlkjnuQxHt54PlSSTpnyj/ONZ+mWKg6ZoUTEI=;
        b=KRFSzNuNktqNNsFUJE40HgO+a8SevYWwdBpv9mJtbRbtv3sohf2paWv5F5cSgFBNyINkJo
        bmyy/CNPQMobBRKkfWNG7DHl+5K4I7QwDAmr+yugh1VdcciQltgiqH8+YTn/y1BGNSDLyn
        s1X8vOvcrWThYjQik/fQOiiCX+B5p5aSAg0yucBJDbry8Q4Xd2yusigrjlsYSh5uUVHrLG
        aSG5gr3jTFntvT7omR9JxmbnapCpY4yNa6LUojBIxYC0Te40NGYvjIZlxFO3M3kkLdbmWm
        eLt2GVkrmxN6RYIyXxu7oSV5yrnCzaRsJj9dWX/zEeaWrIs5C8jJznrjV2x/9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/f2KZ5rlkjnuQxHt54PlSSTpnyj/ONZ+mWKg6ZoUTEI=;
        b=wlf0hfu/ruNFZS/Rg93gxkNT4eo9llhP8okrrzk/eQ17qGr8mICdE3icpS07o5/K1H72pO
        vkg27Jf5Uhb4eqBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove rt_mutex_is_locked()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.552218335@linutronix.de>
References: <20210815211302.552218335@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127228.25758.10000156452025884519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f07ec52202ca5bfc79d30ca7c54f86454eb1a9b0
Gitweb:        https://git.kernel.org/tip/f07ec52202ca5bfc79d30ca7c54f86454eb1a9b0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:27:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:00:08 +02:00

locking/rtmutex: Remove rt_mutex_is_locked()

There are no more users left.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.552218335@linutronix.de
---
 include/linux/rtmutex.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 87b325a..cb0f441 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -72,17 +72,6 @@ do { \
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner != NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
