Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3091908A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCXJLH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:11:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgCXJLG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaR-0007Xl-9g; Tue, 24 Mar 2020 10:11:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D9C81C0475;
        Tue, 24 Mar 2020 10:10:59 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:59 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Add docbook header for data_race()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105916.28353.16249742968546516818.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     7ad900d35b49af5a05f595d2274c32e69e01b055
Gitweb:        https://git.kernel.org/tip/7ad900d35b49af5a05f595d2274c32e69e01b055
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 03 Feb 2020 14:42:18 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:42:04 +01:00

kcsan: Add docbook header for data_race()

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/compiler.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8c0beb1..c1bdf37 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -315,13 +315,15 @@ unsigned long read_word_at_a_time(const void *addr)
 
 #include <linux/kcsan.h>
 
-/*
- * data_race(): macro to document that accesses in an expression may conflict with
- * other concurrent accesses resulting in data races, but the resulting
- * behaviour is deemed safe regardless.
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design.
  *
- * This macro *does not* affect normal code generation, but is a hint to tooling
- * that data races here should be ignored.
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.
  */
 #define data_race(expr)                                                        \
 	({                                                                     \
