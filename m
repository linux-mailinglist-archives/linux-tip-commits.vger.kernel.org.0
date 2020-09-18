Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32526F88C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRImK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRImK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:42:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57DBC06174A;
        Fri, 18 Sep 2020 01:42:09 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:42:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600418528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6SBoJ5EetJoOSSECb0DXtN7B2rR7aqkSaGgwV3hXh0=;
        b=kZJfZ8J978I2fHKg5lEFuzZzHs4JuI5z+1mrF4n1sEcw224olHYSFARNWbRB3/SQVHVLv4
        Rb4h9D7PwMUucCYbyAyS8Mvpt3od30kVaJ1VYfhLxIht3tGp1TPfzCyQusMEQf9j2pmlrR
        QUA/MAlJT+0J/7cndEc0IuwnzakrAM99hwNBT+EnLRosTQEnjY12LtAcJstgkoDTBUGAWN
        NhgZ+UYTKD9ishlKmXLnT+/P4424hkFueYTi9wUV0Y/qx0pJ6pf7T+xbYAxPXeJviql4bt
        7NlnxiAZQRMczFY6oYjGfl6o5iMG6iBTayVB3vfk9y0PUt1f3xs3UFD6AfreeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600418528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6SBoJ5EetJoOSSECb0DXtN7B2rR7aqkSaGgwV3hXh0=;
        b=JnEbgLaoyAc86HY+12UmQalbMinKG8UHMJG1UndrFwy1FWlw5DZAMWxEycEixHdX9LDUEA
        eP+qfoxBqt+aCiDw==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Unbreak lockdep
Cc:     Qian Cai <cai@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200915143028.GB2674@hirez.programming.kicks-ass.net>
References: <20200915143028.GB2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160041852742.15536.14750436211146195940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     267580db047ef428a70bef8287ca62c5a450c139
Gitweb:        https://git.kernel.org/tip/267580db047ef428a70bef8287ca62c5a450c139
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Tue, 15 Sep 2020 16:30:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Sep 2020 16:26:58 +02:00

seqlock: Unbreak lockdep

seqcount_LOCKNAME_init() needs to be a macro due to the lockdep
annotation in seqcount_init(). Since a macro cannot define another
macro, we need to effectively revert commit: e4e9ab3f9f91 ("seqlock:
Fold seqcount_LOCKNAME_init() definition").

Fixes: e4e9ab3f9f91 ("seqlock: Fold seqcount_LOCKNAME_init() definition")
Reported-by: Qian Cai <cai@redhat.com>
Debugged-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qian Cai <cai@redhat.com>
Link: https://lkml.kernel.org/r/20200915143028.GB2674@hirez.programming.kicks-ass.net
---
 include/linux/seqlock.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f73c7eb..76e44e6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -173,6 +173,19 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @lock:	Pointer to the associated lock
  */
 
+#define seqcount_LOCKNAME_init(s, _lock, lockname)			\
+	do {								\
+		seqcount_##lockname##_t *____s = (s);			\
+		seqcount_init(&____s->seqcount);			\
+		__SEQ_LOCK(____s->lock = (_lock));			\
+	} while (0)
+
+#define seqcount_raw_spinlock_init(s, lock)	seqcount_LOCKNAME_init(s, lock, raw_spinlock)
+#define seqcount_spinlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, spinlock)
+#define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock);
+#define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex);
+#define seqcount_ww_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, ww_mutex);
+
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
  * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
@@ -190,13 +203,6 @@ typedef struct seqcount_##lockname {					\
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
-static __always_inline void						\
-seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
-{									\
-	seqcount_init(&s->seqcount);					\
-	__SEQ_LOCK(s->lock = lock);					\
-}									\
-									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -284,8 +290,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
-#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
