Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0C3B15A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWIVb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFWIV3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:29 -0400
Date:   Wed, 23 Jun 2021 08:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsPziWcszOZ6Y66MkCFy+zHnVgjyE3ciD1TrCmGld3A=;
        b=oeLLgJ2tBSjJJliQBPbKYV1y2WkAQaSWWR01ab8v4N9yRyBCk5ECNxwBDvcpXKbh7oX2om
        dArePDW8A073B9ojZwLOXUcaqbAhqe6UL7nRHyFIVAqZkyiF0ifQASNGUykJxPUXyGdr3D
        Wiq/Y6j4sjovc12qmb2tapW6qU2TWEoHKn/4HozD8Jq1+0pe50HCsEkPf2VvP7rihoG4Du
        7yYCAX5+Ba471cV6BhAJe6l2D68nXBPpXrTFeJvWgjwvNOAgnPQzPizzf2Oaq22XK23JYr
        TEIba3tt2Bkz1sEzG3aPKDqo1j+HHofyMJaW6wLaQcneCbfoaIVRxWoaVUnf1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsPziWcszOZ6Y66MkCFy+zHnVgjyE3ciD1TrCmGld3A=;
        b=ivW/sYHORLulC9KbEEHLupGshHeY53g77YmstbJ8kyKRFZ5g3pys5MtRgRmRglITnmWUEA
        1vVQqr7cZWQYMABw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/selftests: Add a selftest for check_irq_usage()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618170110.3699115-5-boqun.feng@gmail.com>
References: <20210618170110.3699115-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <162443634910.395.2271085913562698380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8946ccc25ed22d957ca7f0b6fac1dcf6d25eaf1f
Gitweb:        https://git.kernel.org/tip/8946ccc25ed22d957ca7f0b6fac1dcf6d25eaf1f
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 19 Jun 2021 01:01:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:07 +02:00

locking/selftests: Add a selftest for check_irq_usage()

Johannes Berg reported a lockdep problem which could be reproduced by
the special test case introduced in this patch, so add it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210618170110.3699115-5-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 65 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 2d85aba..5c50b09 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -53,6 +53,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_WW	0x10
 #define LOCKTYPE_RTMUTEX 0x20
 #define LOCKTYPE_LL	0x40
+#define LOCKTYPE_SPECIAL 0x80
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -2744,6 +2745,66 @@ static void local_lock_tests(void)
 	pr_cont("\n");
 }
 
+static void hardirq_deadlock_softirq_not_deadlock(void)
+{
+	/* mutex_A is hardirq-unsafe and softirq-unsafe */
+	/* mutex_A -> lock_C */
+	mutex_lock(&mutex_A);
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_C);
+	spin_unlock(&lock_C);
+	HARDIRQ_ENABLE();
+	mutex_unlock(&mutex_A);
+
+	/* lock_A is hardirq-safe */
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT();
+
+	/* lock_A -> lock_B */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	spin_lock(&lock_B);
+	spin_unlock(&lock_B);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+
+	/* lock_B -> lock_C */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_B);
+	spin_lock(&lock_C);
+	spin_unlock(&lock_C);
+	spin_unlock(&lock_B);
+	HARDIRQ_ENABLE();
+
+	/* lock_D is softirq-safe */
+	SOFTIRQ_ENTER();
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	SOFTIRQ_EXIT();
+
+	/* And lock_D is hardirq-unsafe */
+	SOFTIRQ_DISABLE();
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	SOFTIRQ_ENABLE();
+
+	/*
+	 * mutex_A -> lock_C -> lock_D is softirq-unsafe -> softirq-safe, not
+	 * deadlock.
+	 *
+	 * lock_A -> lock_B -> lock_C -> lock_D is hardirq-safe ->
+	 * hardirq-unsafe, deadlock.
+	 */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_C);
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	spin_unlock(&lock_C);
+	HARDIRQ_ENABLE();
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2872,6 +2933,10 @@ void locking_selftest(void)
 
 	local_lock_tests();
 
+	print_testname("hardirq_unsafe_softirq_safe");
+	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
+	pr_cont("\n");
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
