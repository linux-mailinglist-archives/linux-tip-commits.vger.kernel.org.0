Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C63B8435
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhF3Nxc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbhF3Nvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:47 -0400
Date:   Wed, 30 Jun 2021 13:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pm1d/Ve1RGgg9lg8GqnKPbjxiV/GLp5H7Q+mhuvHDeE=;
        b=M8mtWwXhL44iDEhaSmSA7GBGLpU+JAzjNS3LfYjODZ82djr+wAy3G4YY1Gpp4XGjl0r92u
        itvmEWuZbF1NrJBcwJ2QI76BBhqggfdMjsD8k6ntgB59IpukadI4sMJxu29EnN+X/sA1kO
        Rpjza+6EG3Jh/xx65oA/vBAs+leS58xs48V1xIJdcDHdmmD7mX1DBORYTGiLhoBKuTidoa
        XRbpKfeEUF6gJXhl/7KYHy5YrSLZLEAiGHYC9YosHu0DBkPbVW7ovYKvCXW8NzqMgRprI9
        85wMta8I2gJJL5imm24vbvQNJ6L9+hBQOZdeLjI81DvDldy+GDsfGbPJ48sQOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pm1d/Ve1RGgg9lg8GqnKPbjxiV/GLp5H7Q+mhuvHDeE=;
        b=P7OkdsJ74ZDmj1Y3iNg+oG7k0DDOURxPRJYwi4O4XZaP93vAkmu/HiQhrlXKyOGQJWLnHi
        vOq2nxRP1H6JeQDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Refactor access_info initialization
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506089871.395.4153202446341562525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     39b2e763f2defe326e960daefb7fe6acbb2a95b1
Gitweb:        https://git.kernel.org/tip/39b2e763f2defe326e960daefb7fe6acbb2a95b1
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:21 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:15 -07:00

kcsan: Refactor access_info initialization

In subsequent patches we'll want to split kcsan_report() into distinct
handlers for each report type. The largest bit of common work is
initializing the `access_info`, so let's factor this out into a helper,
and have the kcsan_report_*() functions pass the `aaccess_info` as a
parameter to kcsan_report().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 8bfa970..d8441be 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -596,18 +596,10 @@ static noinline bool prepare_report(unsigned long *flags,
 	}
 }
 
-static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change,
+static void kcsan_report(const struct access_info *ai, enum kcsan_value_change value_change,
 			 enum kcsan_report_type type, struct other_info *other_info)
 {
 	unsigned long flags = 0;
-	const struct access_info ai = {
-		.ptr		= ptr,
-		.size		= size,
-		.access_type	= access_type,
-		.task_pid	= in_task() ? task_pid_nr(current) : -1,
-		.cpu_id		= raw_smp_processor_id()
-	};
 
 	kcsan_disable_current();
 
@@ -620,14 +612,14 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	 */
 	lockdep_off();
 
-	if (prepare_report(&flags, type, &ai, other_info)) {
+	if (prepare_report(&flags, type, ai, other_info)) {
 		/*
 		 * Never report if value_change is FALSE, only if we it is
 		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
 		 * be done once we know the full stack trace in print_report().
 		 */
 		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-			print_report(value_change, type, &ai, other_info);
+			print_report(value_change, type, ai, other_info);
 
 		release_report(&flags, other_info);
 	}
@@ -636,22 +628,38 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	kcsan_enable_current();
 }
 
+static struct access_info prepare_access_info(const volatile void *ptr, size_t size,
+					      int access_type)
+{
+	return (struct access_info) {
+		.ptr		= ptr,
+		.size		= size,
+		.access_type	= access_type,
+		.task_pid	= in_task() ? task_pid_nr(current) : -1,
+		.cpu_id		= raw_smp_processor_id()
+	};
+}
+
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
 			   int watchpoint_idx)
 {
-	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
-		     KCSAN_REPORT_CONSUMED_WATCHPOINT, &other_infos[watchpoint_idx]);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, KCSAN_VALUE_CHANGE_MAYBE, KCSAN_REPORT_CONSUMED_WATCHPOINT,
+		     &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
-	kcsan_report(ptr, size, access_type, value_change,
-		     KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, value_change, KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
-	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
-		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
 }
