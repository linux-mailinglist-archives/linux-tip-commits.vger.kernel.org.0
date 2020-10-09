Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1408728842D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgJIH7R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00DC0613DA;
        Fri,  9 Oct 2020 00:58:50 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bp/V7uqSP/4wCgVNbWOdD7j5kIJ4UTzlcRRAI/3jlK0=;
        b=Ga/oettCC33DU6obsJCJYUWK8RwfIH7zgZHm73GODI5B3ngjqFgha7qH405vOz8iTX8J1t
        ShUW1vXjodE9yYUtXaehV/22rM1sP5/4z83/i0bRQmaB/bVZE/9zUT4O/posnXxeuxJ6ZB
        bxSz1zmq4U6I3ob0uN9dtRlZysaFnWBMferT2XDy5th6MKWC8ZHKsbkUzhFNHb9a9nLTZd
        EZD+IvdGZbXmtcgxAtLTfOsHLSi1B3x5RbK41g6WprI+j+5krFpWwfctLer4AoMoJQMw1s
        XNZAzDNb+Y1zWX9+Use1ubTmjKle4DQmQPr5ys46xeetyQl5ixi0JUEhzdds1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bp/V7uqSP/4wCgVNbWOdD7j5kIJ4UTzlcRRAI/3jlK0=;
        b=KYitYRe2dp0XJviHHf4Spd+3UU/wrSd3NllX4NucXnx8HzdASEmSzNftzwlMVmZY8OhbqX
        WaeATOnl96DGxrCg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Simplify debugfs counter to name mapping
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032833.7002.3533085342092541830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     69b2c81bc894606670204f0ae08f406dbcce836d
Gitweb:        https://git.kernel.org/tip/69b2c81bc894606670204f0ae08f406dbcce836d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 31 Jul 2020 10:17:19 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:21 -07:00

kcsan: Simplify debugfs counter to name mapping

Simplify counter ID to name mapping by using an array with designated
inits. This way, we can turn a run-time BUG() into a compile-time static
assertion failure if a counter name is missing.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 023e49c..3a9566a 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -19,6 +19,18 @@
  * Statistics counters.
  */
 static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+static const char *const counter_names[] = {
+	[KCSAN_COUNTER_USED_WATCHPOINTS]		= "used_watchpoints",
+	[KCSAN_COUNTER_SETUP_WATCHPOINTS]		= "setup_watchpoints",
+	[KCSAN_COUNTER_DATA_RACES]			= "data_races",
+	[KCSAN_COUNTER_ASSERT_FAILURES]			= "assert_failures",
+	[KCSAN_COUNTER_NO_CAPACITY]			= "no_capacity",
+	[KCSAN_COUNTER_REPORT_RACES]			= "report_races",
+	[KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN]		= "races_unknown_origin",
+	[KCSAN_COUNTER_UNENCODABLE_ACCESSES]		= "unencodable_accesses",
+	[KCSAN_COUNTER_ENCODING_FALSE_POSITIVES]	= "encoding_false_positives",
+};
+static_assert(ARRAY_SIZE(counter_names) == KCSAN_COUNTER_COUNT);
 
 /*
  * Addresses for filtering functions from reporting. This list can be used as a
@@ -39,24 +51,6 @@ static struct {
 };
 static DEFINE_SPINLOCK(report_filterlist_lock);
 
-static const char *counter_to_name(enum kcsan_counter_id id)
-{
-	switch (id) {
-	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
-	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
-	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
-	case KCSAN_COUNTER_ASSERT_FAILURES:		return "assert_failures";
-	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
-	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
-	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
-	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:	return "unencodable_accesses";
-	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:	return "encoding_false_positives";
-	case KCSAN_COUNTER_COUNT:
-		BUG();
-	}
-	return NULL;
-}
-
 void kcsan_counter_inc(enum kcsan_counter_id id)
 {
 	atomic_long_inc(&counters[id]);
@@ -271,8 +265,7 @@ static int show_info(struct seq_file *file, void *v)
 	/* show stats */
 	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
 	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
-		seq_printf(file, "%s: %ld\n", counter_to_name(i),
-			   atomic_long_read(&counters[i]));
+		seq_printf(file, "%s: %ld\n", counter_names[i], atomic_long_read(&counters[i]));
 
 	/* show filter functions, and filter type */
 	spin_lock_irqsave(&report_filterlist_lock, flags);
