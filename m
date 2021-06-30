Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916AA3B843B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhF3Nxo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhF3Nvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:52 -0400
Date:   Wed, 30 Jun 2021 13:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I2fOARb9K7ZD1h6iLx7gjGIIsC7lKP7rvG3T0Ll4hSY=;
        b=FMRHrPoslFaKbuZFM7TepjtMp28fy/otaAgOp0gKKl+kd50RLJgp7eRoq3HJcZPbo1mlev
        KIlrZ9+aIeSTaE1G0e8YhAzIlZ3nWPUJg/h67r2yA8O2vveIr/lOsTYsUHsBUksFGaTS3k
        hX70QcJD4P/ol36oJCXCNSOq28eVLclDJQ1oZRVYdENemD0T0MHA86jLyUd/WHLSDuVZws
        pPXCRnnsJFoPJxwPmjXM1ni3etda9YkkZ2LfRrjNqYAvSP7DAWAGeUkMp22hn0VKvxsL0S
        VI/yJSKiMgPNyfygx5tl9M8Xr86SqMJilJIOMc/hInRImuhKd7uDtLkG7S1cqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060900;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I2fOARb9K7ZD1h6iLx7gjGIIsC7lKP7rvG3T0Ll4hSY=;
        b=CuJ3JKtUDAqDvjVcnF2usDUchrrQCqmgAPDYgjvveoCZW+YVjLEQvI6J9PQwSTf+lw83Lp
        DWWETuUA6WJlOSDw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Refactor passing watchpoint/other_info
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089977.395.8311383651039766022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     95f7524d7f0c6fddbc24fb623d61b7d508626f41
Gitweb:        https://git.kernel.org/tip/95f7524d7f0c6fddbc24fb623d61b7d508626f41
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:19 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:14 -07:00

kcsan: Refactor passing watchpoint/other_info

The `watchpoint_idx` argument to kcsan_report() isn't meaningful for
races which were not detected by a watchpoint, and it would be clearer
if callers passed the other_info directly so that a NULL value can be
passed in this case.

Given that callers manipulate their watchpoints before passing the index
into kcsan_report_*(), and given we index the `other_infos` array using
this before we sanity-check it, the subsequent sanity check isn't all
that useful.

Let's remove the `watchpoint_idx` sanity check, and move the job of
finding the `other_info` out of kcsan_report().

Other than the removal of the check, there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 5232bf2..88225f6 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -600,7 +600,7 @@ static noinline bool prepare_report(unsigned long *flags,
 
 static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 			 enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, int watchpoint_idx)
+			 enum kcsan_report_type type, struct other_info *other_info)
 {
 	unsigned long flags = 0;
 	const struct access_info ai = {
@@ -610,12 +610,8 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		.task_pid	= in_task() ? task_pid_nr(current) : -1,
 		.cpu_id		= raw_smp_processor_id()
 	};
-	struct other_info *other_info = type == KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
-					? NULL : &other_infos[watchpoint_idx];
 
 	kcsan_disable_current();
-	if (WARN_ON(watchpoint_idx < 0 || watchpoint_idx >= ARRAY_SIZE(other_infos)))
-		goto out;
 
 	/*
 	 * Because we may generate reports when we're in scheduler code, the use
@@ -642,7 +638,6 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	}
 
 	lockdep_on();
-out:
 	kcsan_enable_current();
 }
 
@@ -650,18 +645,18 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 			   int watchpoint_idx)
 {
 	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
-		     KCSAN_REPORT_CONSUMED_WATCHPOINT, watchpoint_idx);
+		     KCSAN_REPORT_CONSUMED_WATCHPOINT, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
 	kcsan_report(ptr, size, access_type, value_change,
-		     KCSAN_REPORT_RACE_SIGNAL, watchpoint_idx);
+		     KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
 	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
-		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, 0);
+		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
 }
