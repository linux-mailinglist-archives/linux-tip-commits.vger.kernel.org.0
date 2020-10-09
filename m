Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C06288461
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgJIH7s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbgJIH6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:49 -0400
Date:   Fri, 09 Oct 2020 07:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=S8IlgOZuI9m/PGHM1WD/+sRrI3/n+UZWT4Sr39/K1K8=;
        b=ybIR7HQ65JPXY501LlQcGaGhzOquWQ2he4izs3rYNQRplbsSNhoKLSdzk5L6gA8xBDiyUG
        HeWu4sjB/VaDAAlZyYh7rO9N0BaffCbWc9d1/rsri+a3/V8lmsGtt/P1VIQL662agu9pt0
        HVL/SyO+Ze2SKCnVyRiDyHk2XBJxCG39nOsAvD3MubcWMv+i18+sXu01hi2Qb4uO25IpUB
        Nl73uS+aOOHhEigvIOQbGc8KR9FEnDX78DW6ZzqB7xnTn80bpFcxUe7DmsdZgifVGk8aWi
        FWvE0lAsRzvMEtA36HFEVJD1WrtKVt0hHX74nxTveAY/nScIPaS06diggzK/mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=S8IlgOZuI9m/PGHM1WD/+sRrI3/n+UZWT4Sr39/K1K8=;
        b=GR7UZQo7DCZhE6GqD3yoSfWvu0DF+NqVh4jhgW1g3dkLKa21UZrCTBPqEe8d6P10zyDSZk
        6FuYXIJ7Rvk7l0BA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Use pr_fmt for consistency
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032634.7002.1620064892078904764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     178a1877d782c034f466edd80e30a107af5469df
Gitweb:        https://git.kernel.org/tip/178a1877d782c034f466edd80e30a107af5469df
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 31 Jul 2020 10:17:23 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:23 -07:00

kcsan: Use pr_fmt for consistency

Use the same pr_fmt throughout for consistency. [ The only exception is
report.c, where the format must be kept precisely as-is. ]

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c  | 8 +++++---
 kernel/kcsan/selftest.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index de1da1b..6c4914f 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/atomic.h>
 #include <linux/bsearch.h>
 #include <linux/bug.h>
@@ -80,7 +82,7 @@ static noinline void microbenchmark(unsigned long iters)
 	 */
 	WRITE_ONCE(kcsan_enabled, false);
 
-	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+	pr_info("%s begin | iters: %lu\n", __func__, iters);
 
 	cycles = get_cycles();
 	while (iters--) {
@@ -91,7 +93,7 @@ static noinline void microbenchmark(unsigned long iters)
 	}
 	cycles = get_cycles() - cycles;
 
-	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+	pr_info("%s end   | cycles: %llu\n", __func__, cycles);
 
 	WRITE_ONCE(kcsan_enabled, was_enabled);
 	/* restore context */
@@ -154,7 +156,7 @@ static ssize_t insert_report_filterlist(const char *func)
 	ssize_t ret = 0;
 
 	if (!addr) {
-		pr_err("KCSAN: could not find function: '%s'\n", func);
+		pr_err("could not find function: '%s'\n", func);
 		return -ENOENT;
 	}
 
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index d26a052..d98bc20 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
@@ -116,16 +118,16 @@ static int __init kcsan_selftest(void)
 		if (do_test())                                                 \
 			++passed;                                              \
 		else                                                           \
-			pr_err("KCSAN selftest: " #do_test " failed");         \
+			pr_err("selftest: " #do_test " failed");               \
 	} while (0)
 
 	RUN_TEST(test_requires);
 	RUN_TEST(test_encode_decode);
 	RUN_TEST(test_matching_access);
 
-	pr_info("KCSAN selftest: %d/%d tests passed\n", passed, total);
+	pr_info("selftest: %d/%d tests passed\n", passed, total);
 	if (passed != total)
-		panic("KCSAN selftests failed");
+		panic("selftests failed");
 	return 0;
 }
 postcore_initcall(kcsan_selftest);
