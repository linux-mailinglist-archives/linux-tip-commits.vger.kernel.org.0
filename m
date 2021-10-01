Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95341F05F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbhJAPH0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354824AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C18C0613E2;
        Fri,  1 Oct 2021 08:05:34 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v666qz0aF3dnHd2oy+coyfwplxK20VqGR7jP/Kjl/gE=;
        b=Tn53R7NOfVaop+TuYoBe5GoKru2gyRlEdza2JZCTvNpAEDaxy+msOwMpL1Wu4UTZNkuwyG
        RtQzqArVpfpXCmXRZXR7TSxQcFY6BJIeZSFMdymh7cpqAs5ND/0aH1Ykjp8nNPrNvsWnWZ
        Wqib1pAuSJm5UhBkRiHihuRZUD3NgPBX1IM2x/zbztSe5myYYlBQkiGkQFecxHhGIU6IqY
        ceOP+ZWGmzHjkX9WUbgzPcU2HBmNpsyuRlnOi9g9/ou0dCfujMmx412Q8TSUOOEW/7lGzI
        5cPeI+pcw13IVKA6tQjCW2gMK/xdLCZ2esgIXB6AqRA1aaBxixKtXJILvCKefQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v666qz0aF3dnHd2oy+coyfwplxK20VqGR7jP/Kjl/gE=;
        b=uHF6NYptxkfFWNTvjgB5DVxVipCLqKnrlB11xkAADufv39gWmFIAxdAYBCNskgY7roXNne
        3VBT/wdKB0IYDUBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Make cond_resched_*lock() variants
 consistent vs. might_sleep()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165357.991262778@linutronix.de>
References: <20210923165357.991262778@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310073245.25758.4143185315282997401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7b5ff4bb9adc53cfbf7ac9ba7820ccf0cd7c070a
Gitweb:        https://git.kernel.org/tip/7b5ff4bb9adc53cfbf7ac9ba7820ccf0cd7c070a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:50 +02:00

sched: Make cond_resched_*lock() variants consistent vs. might_sleep()

Commit 3427445afd26 ("sched: Exclude cond_resched() from nested sleep
test") removed the task state check of __might_sleep() for
cond_resched_lock() because cond_resched_lock() is not a voluntary
scheduling point which blocks. It's a preemption point which requires the
lock holder to release the spin lock.

The same rationale applies to cond_resched_rwlock_read/write(), but those
were not touched.

Make it consistent and use the non-state checking __might_resched() there
as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165357.991262778@linutronix.de
---
 include/linux/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b38f002..7a989f2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2051,14 +2051,14 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_lock(lock);					\
 })
 
-#define cond_resched_rwlock_read(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_read(lock);			\
+#define cond_resched_rwlock_read(lock) ({				\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_read(lock);				\
 })
 
-#define cond_resched_rwlock_write(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_write(lock);			\
+#define cond_resched_rwlock_write(lock) ({				\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_write(lock);				\
 })
 
 static inline void cond_resched_rcu(void)
