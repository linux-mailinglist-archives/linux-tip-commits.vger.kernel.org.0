Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6907D288431
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbgJIH7S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF6C0613D8;
        Fri,  9 Oct 2020 00:58:48 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/jwhMXAvLvOI00Z2Irb8+KL4ZbHfhYnP075EN31CjfY=;
        b=I+gHl+AvnxQufOm+k6aZLCQ/b+54KtakF3HCQKcaVqVZpkh67aWUJWf1C5W9DvdCf7Vhpn
        x76F5f74SrCsvELIBSp2LW7130ZKUE9l9nrhenU4pP8UmxQ3kbC0wGIRGzWNwBb08I9PrF
        7DlMqSA5pU8cCkIZYkLzpdb7CEKgf6Lvfqso/nmgLOU+jJMj7aMXEw0WbbP9gfDaWRuqsX
        vPJdE74roZlLOD50bWRgAQfNm/pAEIGhpBaMmAVBC4Eors6ALEBcElVlGK0atQyOWlqA5C
        ut4GPyIsJswM9xFI/LgyLesQon+6ybx/+x53sI+dH8IypYmwdm7HnstiukluXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/jwhMXAvLvOI00Z2Irb8+KL4ZbHfhYnP075EN31CjfY=;
        b=SkRz+DugaCH7LCS8bHX6aJMBLCGnnmn3jn8H+kUgfXolwBWwdL1i2nP5ZfnuUBEh4rNbvq
        RB+g6aU9C/0VO9Bw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Show message if enabled early
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032685.7002.12841144360260947194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2778793072c31e3eb33842f3bd7da82dfc7efc6b
Gitweb:        https://git.kernel.org/tip/2778793072c31e3eb33842f3bd7da82dfc7efc6b
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 31 Jul 2020 10:17:22 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:22 -07:00

kcsan: Show message if enabled early

Show a message in the kernel log if KCSAN was enabled early.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 99e5044..b176400 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
@@ -463,7 +465,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
 		kcsan_disable_current();
-		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
+		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
 		       is_write ? "write" : "read", size, ptr,
 		       watchpoint_slot((unsigned long)ptr),
 		       encode_watchpoint((unsigned long)ptr, size, is_write));
@@ -623,8 +625,10 @@ void __init kcsan_init(void)
 	 * We are in the init task, and no other tasks should be running;
 	 * WRITE_ONCE without memory barrier is sufficient.
 	 */
-	if (kcsan_early_enable)
+	if (kcsan_early_enable) {
+		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
+	}
 }
 
 /* === Exported interface =================================================== */
