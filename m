Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7C3B8436
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhF3Nxc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhF3Nvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:47 -0400
Date:   Wed, 30 Jun 2021 13:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yfP3M5mwAECN79v6ignZSk8wdhNCEjdOlnLdsEkJb0k=;
        b=0MG0OBfblPEozROVO32orLE9Jw0TaaTM/8OkeXFN2bxIVFglMcAHHD95/ZAwfF8t34Ex0d
        YX5x+MO1X9NWYrd73JSOudhLR1WtVx01hVi+LQj9Uq83Vz8KdyveN3nFjXu9K8goto2nZA
        lnpNkR9YI36uME/uQowu6tXhFiQkbkThj+KFjQIxqSgy8bbLJpRFZh49CrVVpc9AZl+Tvl
        8px30c3pDCHENXV6bd3hsUStJJLbNoSOLyh96Vzuf2U5WzUv6rmBNZONgzg6yZbirFBGuF
        89AdqqjfX1VCCc0CG1ysx1ag3FUWNrb12T0L0RO7X8y0FSB5ukTNZQkEpNRBJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yfP3M5mwAECN79v6ignZSk8wdhNCEjdOlnLdsEkJb0k=;
        b=uV3cW8mXCyVBRZs4MvRyGFojOY68faQITt99g1PHskqj9/7n65C0Z6e3DT442dG7rNEEIw
        fIE68mq7m1mzKgBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Fold panic() call into print_report()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089923.395.6417061560023310641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     97aa6139e1b506795ab19941b1c3851042199788
Gitweb:        https://git.kernel.org/tip/97aa6139e1b506795ab19941b1c3851042199788
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:20 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:14 -07:00

kcsan: Fold panic() call into print_report()

So that we can add more callers of print_report(), lets fold the panic()
call into print_report() so the caller doesn't have to handle this
explicitly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 88225f6..8bfa970 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -325,10 +325,7 @@ static void print_verbose_info(struct task_struct *task)
 	print_irqtrace_events(task);
 }
 
-/*
- * Returns true if a report was generated, false otherwise.
- */
-static bool print_report(enum kcsan_value_change value_change,
+static void print_report(enum kcsan_value_change value_change,
 			 enum kcsan_report_type type,
 			 const struct access_info *ai,
 			 const struct other_info *other_info)
@@ -344,7 +341,7 @@ static bool print_report(enum kcsan_value_change value_change,
 	 * Must check report filter rules before starting to print.
 	 */
 	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
-		return false;
+		return;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
 		other_skipnr = get_stack_skipnr(other_info->stack_entries,
@@ -353,11 +350,11 @@ static bool print_report(enum kcsan_value_change value_change,
 
 		/* @value_change is only known for the other thread */
 		if (skip_report(value_change, other_frame))
-			return false;
+			return;
 	}
 
 	if (rate_limit_report(this_frame, other_frame))
-		return false;
+		return;
 
 	/* Print report header. */
 	pr_err("==================================================================\n");
@@ -431,7 +428,8 @@ static bool print_report(enum kcsan_value_change value_change,
 	dump_stack_print_info(KERN_DEFAULT);
 	pr_err("==================================================================\n");
 
-	return true;
+	if (panic_on_warn)
+		panic("panic_on_warn set ...\n");
 }
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
@@ -628,11 +626,8 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
 		 * be done once we know the full stack trace in print_report().
 		 */
-		bool reported = value_change != KCSAN_VALUE_CHANGE_FALSE &&
-				print_report(value_change, type, &ai, other_info);
-
-		if (reported && panic_on_warn)
-			panic("panic_on_warn set ...\n");
+		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
+			print_report(value_change, type, &ai, other_info);
 
 		release_report(&flags, other_info);
 	}
