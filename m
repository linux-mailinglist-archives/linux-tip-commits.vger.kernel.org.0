Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF13EF351
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhHQUO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhHQUOt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:49 -0400
Date:   Tue, 17 Aug 2021 20:14:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ebsH8uLQTQsO248ReLsDvc8hvPLl/kq1nXE776DsaA=;
        b=sG8E4EHWVCi10k9hCB6P9/CLR9oB7xJJ4N4mou+UzEpHaqCwHHxMwTckQX3M3H07ysGTo3
        NLrJpoRlBqpqMKCAJw7YEiB7vi1ncuumwhB5iLsqaNcmHu6LVYv0Wjz3SQDWzLo3kBYXMJ
        hAuhvUR9uwEUCW/jQI0hrIHcREOUz4Hu2PWYbquPPs+gFUVCAtm0UtISeNriHXwCL/BViQ
        w2MVHbQyNtEqqgSWCXsssKYf/TWoJQPbfRylEVUCeJ94OPMI6PW2faAV4pS7Ert7gfTMtl
        95aHjVydz81E1d7naDbqt6/JBD8A6WpLTwoMag08Qo9tIyvYPS5MCzVMujxZMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ebsH8uLQTQsO248ReLsDvc8hvPLl/kq1nXE776DsaA=;
        b=1+gRK8UulaOYrXPgN0pfvYNT5xvKh168h3w2KaZz6S3bQIFEg8m2uehbFsV7l+6nQ8m2R4
        k39ml33bnB695qAg==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Split up ww_mutex_unlock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.340166556@linutronix.de>
References: <20210815211304.340166556@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125405.25758.6314963679933483935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     aaa77de10b7c86fa779b2108802fa9e785fbe2e9
Gitweb:        https://git.kernel.org/tip/aaa77de10b7c86fa779b2108802fa9e785fbe2e9
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 17 Aug 2021 16:19:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:44 +02:00

locking/ww_mutex: Split up ww_mutex_unlock()

Split the ww related part out into a helper function so it can be reused
for a rtmutex based ww_mutex implementation.

[ mingo: Fixed bisection failure. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.340166556@linutronix.de
---
 kernel/locking/mutex.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6cb27c5..070f6f1 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -744,6 +744,20 @@ void __sched mutex_unlock(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_unlock);
 
+static void __ww_mutex_unlock(struct ww_mutex *lock)
+{
+	/*
+	 * The unlocking fastpath is the 0->1 transition from 'locked'
+	 * into 'unlocked' state:
+	 */
+	if (lock->ctx) {
+		MUTEX_WARN_ON(!lock->ctx->acquired);
+		if (lock->ctx->acquired > 0)
+			lock->ctx->acquired--;
+		lock->ctx = NULL;
+	}
+}
+
 /**
  * ww_mutex_unlock - release the w/w mutex
  * @lock: the mutex to be released
@@ -757,17 +771,7 @@ EXPORT_SYMBOL(mutex_unlock);
  */
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-	if (lock->ctx) {
-		MUTEX_WARN_ON(!lock->ctx->acquired);
-		if (lock->ctx->acquired > 0)
-			lock->ctx->acquired--;
-		lock->ctx = NULL;
-	}
-
+	__ww_mutex_unlock(lock);
 	mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
