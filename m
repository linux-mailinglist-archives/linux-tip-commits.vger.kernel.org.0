Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD46341D73
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSMye (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCSMyU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:54:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0FC06174A;
        Fri, 19 Mar 2021 05:54:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616158458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLH+63NUW9vCUc/8lscpEgmRtCnnAgdwpveAhoMFavc=;
        b=ufoBnAfJnk4DV3hczCc7FOhXQzIVYfZfQV2hdpxAfHTsJvcE2xHJQrlj2IiMWliYDurXOq
        Uv3//XY4BlAiyebZjk+DWPIzb+g2qmE4HuBY2Xc12BulB9ZTCQMWbKU/Z+rFxS/7UeLfjL
        PC6s35GpYp9RBjEYx5TrSINuqyHLVF6/BlBqQJL3btyagBwFrNItgbdseP3zaE7nQEzrfA
        e7ckUnXFNpdlE8y+kq0kK4c5G10ycURXwlsEbiYHldSGFy8q423ZxdA9HdHSbn4zO1XGBc
        2uc2Ncop5DWiNFobUhApFYS2ilK0uLp2y/Yn/43T/5NsYrVyK8dmYV6Mhv55PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616158458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLH+63NUW9vCUc/8lscpEgmRtCnnAgdwpveAhoMFavc=;
        b=aB4I9Mo5yq1Eaj4PyPFQr6PTx6Fb1rsdinFqg/yXUY+7S/YpLtm+QMdrjiy3Qn5IHi87vz
        YESrXDqfUnGcDJAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318172814.4400-4-longman@redhat.com>
References: <20210318172814.4400-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161615845745.398.7001564993438139104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5261ced47f8e89173c3b015f6152a05f11a418c3
Gitweb:        https://git.kernel.org/tip/5261ced47f8e89173c3b015f6152a05f11a418c3
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 18 Mar 2021 13:28:12 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 19 Mar 2021 12:13:10 +01:00

locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro

The current DEFINE_WW_MUTEX() macro fails to properly set up the lockdep
key of the ww_mutexes causing potential circular locking dependency
splat. Though it is possible to add more macro magic to make it work,
but the result is rather ugly.

Since locktorture was the only user of DEFINE_WW_MUTEX() and the
previous commit has just removed its use. It is easier to just remove
the macro to force future users of ww_mutexes to use ww_mutex_init()
for initialization.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210318172814.4400-4-longman@redhat.com
---
 include/linux/ww_mutex.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 6ecf2a0..b77f39f 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -48,39 +48,26 @@ struct ww_acquire_ctx {
 #endif
 };
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __WW_CLASS_MUTEX_INITIALIZER(lockname, class) \
-		, .ww_class = class
-#else
-# define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
-#endif
-
 #define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
 		{ .stamp = ATOMIC_LONG_INIT(0) \
 		, .acquire_name = #ww_class "_acquire" \
 		, .mutex_name = #ww_class "_mutex" \
 		, .is_wait_die = _is_wait_die }
 
-#define __WW_MUTEX_INITIALIZER(lockname, class) \
-		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
-		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
-
 #define DEFINE_WD_CLASS(classname) \
 	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
 
 #define DEFINE_WW_CLASS(classname) \
 	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
 
-#define DEFINE_WW_MUTEX(mutexname, ww_class) \
-	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
-
 /**
  * ww_mutex_init - initialize the w/w mutex
  * @lock: the mutex to be initialized
  * @ww_class: the w/w class the mutex should belong to
  *
  * Initialize the w/w mutex to unlocked state and associate it with the given
- * class.
+ * class. Static define macro for w/w mutex is not provided and this function
+ * is the only way to properly initialize the w/w mutex.
  *
  * It is not allowed to initialize an already locked mutex.
  */
