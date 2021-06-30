Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A823B842A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhF3NxB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbhF3Nv0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:26 -0400
Date:   Wed, 30 Jun 2021 13:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PkpUHEq45AwA3FagqRfLAn2m/V4SbmtSGlx9wfEv2Sk=;
        b=jZD7t8BoUMm6RQxouhYbDQdWTJ2ArLbpvB3BLbfHe/ATlWM79fr0SkaSekWhDsJczEXTay
        sn92cdJNNxUYkWuVPzAKuNSfjuQ2Gc3X/M305nB21UFakMFxEUoPVs0AqSEvORBM1TAMzp
        ROGao6zqlX2d0F1afWEplnFadXo2uidhKAXEl3FdMzN44LkRp+s74QrYK/YoOaDKeM5qVW
        /klPKBkE3icCcnxgqUe4c7Bc7UzCICeHibMQ44h7cF/snuqpEqJUO2G8RcJTVklVgAkdWA
        Y9BtD2YNLF4eTNUoZAsvvRYTer1pGBkCYN1CoMMJjgleJ4mOb1fggYYk0piUHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PkpUHEq45AwA3FagqRfLAn2m/V4SbmtSGlx9wfEv2Sk=;
        b=6xKvE5vMaCtOJ5bNs2cMw+Nctrgydo/GN5DenGUCw5P/vSSqpv9puuiqYVfGxdxiL0JhPn
        hG5eK4TBlqyoZTCQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Remove reporting indirection
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089819.395.16760835560868670033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     19dfdc05ffed960024e175db21c8e11ef96daeee
Gitweb:        https://git.kernel.org/tip/19dfdc05ffed960024e175db21c8e11ef96daeee
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:22 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:15 -07:00

kcsan: Remove reporting indirection

Now that we have separate kcsan_report_*() functions, we can factor the
distinct logic for each of the report cases out of kcsan_report(). While
this means each case has to handle mutual exclusion independently, this
minimizes the conditionality of code and makes it easier to read, and
will permit passing distinct bits of information to print_report() in
future.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: retain comment about lockdep_off() ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 115 +++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 66 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d8441be..ba924f1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -434,13 +434,11 @@ static void print_report(enum kcsan_value_change value_change,
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
 {
-	if (other_info)
-		/*
-		 * Use size to denote valid/invalid, since KCSAN entirely
-		 * ignores 0-sized accesses.
-		 */
-		other_info->ai.size = 0;
-
+	/*
+	 * Use size to denote valid/invalid, since KCSAN entirely ignores
+	 * 0-sized accesses.
+	 */
+	other_info->ai.size = 0;
 	raw_spin_unlock_irqrestore(&report_lock, *flags);
 }
 
@@ -573,61 +571,6 @@ discard:
 	return false;
 }
 
-/*
- * Depending on the report type either sets @other_info and returns false, or
- * awaits @other_info and returns true. If @other_info is not required for the
- * report type, simply acquires @report_lock and returns true.
- */
-static noinline bool prepare_report(unsigned long *flags,
-				    enum kcsan_report_type type,
-				    const struct access_info *ai,
-				    struct other_info *other_info)
-{
-	switch (type) {
-	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
-		prepare_report_producer(flags, ai, other_info);
-		return false;
-	case KCSAN_REPORT_RACE_SIGNAL:
-		return prepare_report_consumer(flags, ai, other_info);
-	default:
-		/* @other_info not required; just acquire @report_lock. */
-		raw_spin_lock_irqsave(&report_lock, *flags);
-		return true;
-	}
-}
-
-static void kcsan_report(const struct access_info *ai, enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, struct other_info *other_info)
-{
-	unsigned long flags = 0;
-
-	kcsan_disable_current();
-
-	/*
-	 * Because we may generate reports when we're in scheduler code, the use
-	 * of printk() could deadlock. Until such time that all printing code
-	 * called in print_report() is scheduler-safe, accept the risk, and just
-	 * get our message out. As such, also disable lockdep to hide the
-	 * warning, and avoid disabling lockdep for the rest of the kernel.
-	 */
-	lockdep_off();
-
-	if (prepare_report(&flags, type, ai, other_info)) {
-		/*
-		 * Never report if value_change is FALSE, only if we it is
-		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
-		 * be done once we know the full stack trace in print_report().
-		 */
-		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-			print_report(value_change, type, ai, other_info);
-
-		release_report(&flags, other_info);
-	}
-
-	lockdep_on();
-	kcsan_enable_current();
-}
-
 static struct access_info prepare_access_info(const volatile void *ptr, size_t size,
 					      int access_type)
 {
@@ -644,22 +587,62 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 			   int watchpoint_idx)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	unsigned long flags;
+
+	kcsan_disable_current();
+	lockdep_off(); /* See kcsan_report_known_origin(). */
 
-	kcsan_report(&ai, KCSAN_VALUE_CHANGE_MAYBE, KCSAN_REPORT_CONSUMED_WATCHPOINT,
-		     &other_infos[watchpoint_idx]);
+	prepare_report_producer(&flags, &ai, &other_infos[watchpoint_idx]);
+
+	lockdep_on();
+	kcsan_enable_current();
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	struct other_info *other_info = &other_infos[watchpoint_idx];
+	unsigned long flags = 0;
 
-	kcsan_report(&ai, value_change, KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
+	kcsan_disable_current();
+	/*
+	 * Because we may generate reports when we're in scheduler code, the use
+	 * of printk() could deadlock. Until such time that all printing code
+	 * called in print_report() is scheduler-safe, accept the risk, and just
+	 * get our message out. As such, also disable lockdep to hide the
+	 * warning, and avoid disabling lockdep for the rest of the kernel.
+	 */
+	lockdep_off();
+
+	if (!prepare_report_consumer(&flags, &ai, other_info))
+		goto out;
+	/*
+	 * Never report if value_change is FALSE, only when it is
+	 * either TRUE or MAYBE. In case of MAYBE, further filtering may
+	 * be done once we know the full stack trace in print_report().
+	 */
+	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
+		print_report(value_change, KCSAN_REPORT_RACE_SIGNAL, &ai, other_info);
+
+	release_report(&flags, other_info);
+out:
+	lockdep_on();
+	kcsan_enable_current();
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	unsigned long flags;
+
+	kcsan_disable_current();
+	lockdep_off(); /* See kcsan_report_known_origin(). */
+
+	raw_spin_lock_irqsave(&report_lock, flags);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, &ai, NULL);
+	raw_spin_unlock_irqrestore(&report_lock, flags);
 
-	kcsan_report(&ai, KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
+	lockdep_on();
+	kcsan_enable_current();
 }
