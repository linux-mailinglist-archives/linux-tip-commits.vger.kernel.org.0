Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE13319EA8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBLMjx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhBLMia (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41FC061793;
        Fri, 12 Feb 2021 04:37:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z0CYi+y57dAUEgVCA/aH8I0qXnEY+eS5dugTEQdnZfc=;
        b=kMg20tn03UqsyWq4lVcNK10Ebv4DiqcbR6+Epl2Ulpn3MGPFAmlqwVij6fnMjqP7QqedFA
        mKrpWicNPScqv9Y4MU3FwLSWBbtRXax12UYFh+h+Esmd67uHtMFpR0GDO1KxGOXFQgwxIy
        0eHWy3Dl3+WMwOnFybiBGmrDxDnECJEM/JFqmzRDNf1zr436r/4rhYRp8MMq6z2cwyqgA/
        CKv4lBL+/8eZ5lFCUKSjQewMIhPSugqoQ/pnoPtDGWSeLji8KpBJfQL4MmEoBHyZEdATuf
        0YKif5LfHimQTJO14qf8ujnqOOyXbFlwugH3LvK3alq+cxWSCdZ8r0CmxXHe+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z0CYi+y57dAUEgVCA/aH8I0qXnEY+eS5dugTEQdnZfc=;
        b=F+xVTpLKgPFBvML4CJjV0XlFHH+hZSBIvfLxRkcanyqi5yFI46ib2oogzJsiDClsQFl2sX
        6uS3f0kujRU51ECQ==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Get timeval, timespec and timezone from
 linux/time.h
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342575.23325.7710961286690258494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     70ca7aea50a27f03aa7e4cc6ee68940d13cbcd17
Gitweb:        https://git.kernel.org/tip/70ca7aea50a27f03aa7e4cc6ee68940d13cbcd17
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:28 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:45 -08:00

tools/nolibc: Get timeval, timespec and timezone from linux/time.h

The definitions of timeval(), timespec() and timezone() conflict with
linux/time.h when building, so this commit takes them directly from
linux/time.h. This is a port of nolibc's upstream commit dc45f5426b0c
to the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 833693f..611d9d1 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -94,6 +94,7 @@
 #include <asm/errno.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
+#include <linux/time.h>
 
 #define NOLIBC
 
@@ -152,24 +153,6 @@ struct pollfd {
 	short int revents;
 };
 
-/* for select() */
-struct timeval {
-	long    tv_sec;
-	long    tv_usec;
-};
-
-/* for pselect() */
-struct timespec {
-	long    tv_sec;
-	long    tv_nsec;
-};
-
-/* for gettimeofday() */
-struct timezone {
-	int tz_minuteswest;
-	int tz_dsttime;
-};
-
 /* for getdents64() */
 struct linux_dirent64 {
 	uint64_t       d_ino;
