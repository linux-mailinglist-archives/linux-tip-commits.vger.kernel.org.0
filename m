Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD328845F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgJIH7s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbgJIH6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:49 -0400
Date:   Fri, 09 Oct 2020 07:58:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hKljUu8btbu0z/GhKcNcNXWoaIOgEHkcDsEK6ozoorQ=;
        b=OemX0ADJWcgyDrATRlnNGQb29lH9ofSbRf3S58MJ8iCqSqyrKJ6ndEtX6pBQRxetXxBzcd
        d6cPznf8LtU/yW2S3w/TUwKr6xwr0QZi+OueSgRBl08zCrhyvwS/7+98Uyg6y54lS7Y6sw
        K10qRjzWT0HhyjGWQKQzX0ESoaicnzeGMGCou8rQgNgaMJH69v151pWABOVkoxMYW00x+q
        cyeKazlqjZ1xsyJI+1N49gKIz+reT+kD/7ylqgbRuZg5ZjMLpL3p+II+TDwmXG+9ItTC4d
        COnqS8KZc7tbnblpNvtE6QKB3nsxss4loiE9kRu3wwX/MoH9WlfWskIb+t0X7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hKljUu8btbu0z/GhKcNcNXWoaIOgEHkcDsEK6ozoorQ=;
        b=lsuzIdcHOpPkjueNXe6kCICNzfqGwHrslP84XzVvlsEt6/ZqWVe5ho+54SveQuHee0H+sq
        1j2pYPB7c4abAwAQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Remove debugfs test command
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032735.7002.3488217907800368171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4700ccdf18fa3002d66769b69cf715cc58beea37
Gitweb:        https://git.kernel.org/tip/4700ccdf18fa3002d66769b69cf715cc58beea37
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 31 Jul 2020 10:17:21 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:22 -07:00

kcsan: Remove debugfs test command

Remove the debugfs test command, as it is no longer needed now that we
have the KUnit+Torture based kcsan-test module. This is to avoid
confusion around how KCSAN should be tested, as only the kcsan-test
module is maintained.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 66 +-----------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 116bdd8..de1da1b 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -98,66 +98,6 @@ static noinline void microbenchmark(unsigned long iters)
 	current->kcsan_ctx = ctx_save;
 }
 
-/*
- * Simple test to create conflicting accesses. Write 'test=<iters>' to KCSAN's
- * debugfs file from multiple tasks to generate real conflicts and show reports.
- */
-static long test_dummy;
-static long test_flags;
-static long test_scoped;
-static noinline void test_thread(unsigned long iters)
-{
-	const long CHANGE_BITS = 0xff00ff00ff00ff00L;
-	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
-	cycles_t cycles;
-
-	/* We may have been called from an atomic region; reset context. */
-	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
-
-	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
-	pr_info("test_dummy@%px, test_flags@%px, test_scoped@%px,\n",
-		&test_dummy, &test_flags, &test_scoped);
-
-	cycles = get_cycles();
-	while (iters--) {
-		/* These all should generate reports. */
-		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
-		ASSERT_EXCLUSIVE_WRITER(test_dummy);
-		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
-
-		ASSERT_EXCLUSIVE_BITS(test_flags, ~CHANGE_BITS); /* no report */
-		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
-
-		ASSERT_EXCLUSIVE_BITS(test_flags, CHANGE_BITS); /* report */
-		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
-
-		/* not actually instrumented */
-		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
-		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
-
-		test_flags ^= CHANGE_BITS; /* generate value-change */
-		__kcsan_check_write(&test_flags, sizeof(test_flags));
-
-		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
-		{
-			/* Should generate reports anywhere in this block. */
-			ASSERT_EXCLUSIVE_WRITER_SCOPED(test_scoped);
-			ASSERT_EXCLUSIVE_ACCESS_SCOPED(test_scoped);
-			BUG_ON(!current->kcsan_ctx.scoped_accesses.prev);
-			/* Unrelated accesses. */
-			__kcsan_check_access(&cycles, sizeof(cycles), 0);
-			__kcsan_check_access(&cycles, sizeof(cycles), KCSAN_ACCESS_ATOMIC);
-		}
-		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
-	}
-	cycles = get_cycles() - cycles;
-
-	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
-
-	/* restore context */
-	current->kcsan_ctx = ctx_save;
-}
-
 static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
 {
 	const unsigned long a = *(const unsigned long *)rhs;
@@ -306,12 +246,6 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
-	} else if (str_has_prefix(arg, "test=")) {
-		unsigned long iters;
-
-		if (kstrtoul(&arg[strlen("test=")], 0, &iters))
-			return -EINVAL;
-		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
 		set_report_filterlist_whitelist(true);
 	} else if (!strcmp(arg, "blacklist")) {
