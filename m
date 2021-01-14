Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66712F5FFF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbhANLaJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbhANL3m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:42 -0500
Date:   Thu, 14 Jan 2021 11:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QlWsxJaS95lKovzhAVl6IMlEUBbz+ptCrexLIueNb14=;
        b=IpsuHUfob4pCRhgLlPaTPyW0Rr1Qq190lVdcz4+6R05U7HQmZf/Cjt+q3C84o0Hb3YDWz8
        6NlXwlnq7XQ+FHyXZWI06DsIjClLtnmr/xRUySRY6SzNcBqv+5GFDSukvO32Xg5tx5k6fR
        XS48F/rJngrKToqSCFJiJp1C4qQ9C9HvD1DPuYVmuYj+L+tmckgGpKGzLILdblMfFyTSeV
        aNEd/2DCS42wQIds1yxzZ6s9BmBqaCAMdM4eXfeaJB6tuZVn0iWm1Z28YoTueXRrYZ/g7w
        rnGWBb7qrwoVbBEwfrfnq98MJIu7kI6zfGYJPBIsR/4ggvGZK7ZeZ0PF/QijAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QlWsxJaS95lKovzhAVl6IMlEUBbz+ptCrexLIueNb14=;
        b=/0nXc3rmSpV1a1r+hzFhRLe1gWuDOfmSaMZbKY+B3V+zVy/cT/zNDR5RZl3GPn+m20cyZc
        kOWvgDdE6EiDrTBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/selftests: More granular debug_locks_verbose
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373969.414.13547086625704434671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5831c0f71d6664c6aa7b58ba969bf645c89ecb85
Gitweb:        https://git.kernel.org/tip/5831c0f71d6664c6aa7b58ba969bf645c89ecb85
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Dec 2020 16:42:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:16 +01:00

locking/selftests: More granular debug_locks_verbose

Showing all tests all the time is tiresome.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++++-----
 lib/locking-selftest.c                          |  5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..611a5c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -802,13 +802,14 @@
 			insecure, please do not use on production kernels.
 
 	debug_locks_verbose=
-			[KNL] verbose self-tests
-			Format=<0|1>
+			[KNL] verbose locking self-tests
+			Format: <int>
 			Print debugging info while doing the locking API
 			self-tests.
-			We default to 0 (no extra messages), setting it to
-			1 will print _a lot_ more information - normally
-			only useful to kernel developers.
+			Bitmask for the various LOCKTYPE_ tests. Defaults to 0
+			(no extra messages), setting it to -1 (all bits set)
+			will print _a_lot_ more information - normally only
+			useful to lockdep developers.
 
 	debug_objects	[KNL] Enable object debugging
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 23376ee..3306f43 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1390,6 +1390,8 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 
 	WARN_ON(irqs_disabled());
 
+	debug_locks_silent = !(debug_locks_verbose & lockclass_mask);
+
 	testcase_fn();
 	/*
 	 * Filter out expected failures:
@@ -1410,7 +1412,7 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	}
 	testcase_total++;
 
-	if (debug_locks_verbose)
+	if (debug_locks_verbose & lockclass_mask)
 		pr_cont(" lockclass mask: %x, debug_locks: %d, expected: %d\n",
 			lockclass_mask, debug_locks, expected);
 	/*
@@ -2674,7 +2676,6 @@ void locking_selftest(void)
 	printk("  --------------------------------------------------------------------------\n");
 
 	init_shared_classes();
-	debug_locks_silent = !debug_locks_verbose;
 	lockdep_set_selftest_task(current);
 
 	DO_TESTCASE_6R("A-A deadlock", AA);
