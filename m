Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B217C190892
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCXJLL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:11:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgCXJLK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaT-0007YQ-JH; Tue, 24 Mar 2020 10:11:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B5861C04CC;
        Tue, 24 Mar 2020 10:11:00 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:59 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] iov_iter: Use generic instrumented.h
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105995.28353.8172845313356858693.tip-bot2@tip-bot2>
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

Commit-ID:     d0ef4c360f7ea33905539b9b36fa2273915703f0
Gitweb:        https://git.kernel.org/tip/d0ef4c360f7ea33905539b9b36fa2273915703f0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 21 Jan 2020 17:05:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:41:55 +01:00

iov_iter: Use generic instrumented.h

This replaces the kasan instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/iov_iter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf..bf538c2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -8,6 +8,7 @@
 #include <linux/splice.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
+#include <linux/instrumented.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -138,7 +139,7 @@
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
@@ -147,7 +148,7 @@ static int copyout(void __user *to, const void *from, size_t n)
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (access_ok(from, n)) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		n = raw_copy_from_user(to, from, n);
 	}
 	return n;
@@ -639,7 +640,7 @@ EXPORT_SYMBOL(_copy_to_iter);
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = copy_to_user_mcsafe((__force void *) to, from, n);
 	}
 	return n;
