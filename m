Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A562D902C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgLMTBw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgLMTBt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:49 -0500
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BIfsBafeAheDjjUAn4kUg1kghqZtYKwCEbPSqa2+z0g=;
        b=S7yiDnxm6Q4GxbE5ajIEn56rBjStNhXKw+xaLeFUHclVWBbh8l/TwBP7LKP1peayOXE+JH
        cl/c7GA+j5Piz7m7pLawsEaOolxNUUrcjE44yG5k6R8Q6taCIgvpULDmk6qUConZ1vYd0z
        kq+bvlz39t1dXckS5kRTPMRWAdNBEGHxRmuUpzHRv8PpKigtbXPFGthC81xyyBi7cPRNKh
        00D7Ktom+IxptgJfpM5jmwlUtPTvXpsShPb5gynhEg8H1lf0qp5ohxXStd6ySO0kVZYodL
        8nS1jF0r5cB50kcLu+DX7uvnQZbFRjyU4PlzrbXiT/EeEaWlTSD/VRTEw/hzsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BIfsBafeAheDjjUAn4kUg1kghqZtYKwCEbPSqa2+z0g=;
        b=S+xUFXioKyb4abVQIlcbAJq7AXd980WDdgsoGCnkCALxlyZRJEb+1rj5utoImgAa5HM0O/
        QYktXmEN3gHU+6BQ==
From:   "tip-bot2 for Samuel Hernandez" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture/nolibc: Fix a typo in header file
Cc:     Samuel Hernandez <sam.hernandez.amador@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606708.3364.1184156959092248476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6c5b9de2c63b2f513a580c6c80d455350012e99b
Gitweb:        https://git.kernel.org/tip/6c5b9de2c63b2f513a580c6c80d455350012e99b
Author:        Samuel Hernandez <sam.hernandez.amador@gmail.com>
AuthorDate:    Sun, 11 Oct 2020 14:22:31 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:57 -08:00

rcutorture/nolibc: Fix a typo in header file

This fixes a typo. Before this, the AT_FDCWD macro would be defined
regardless of whether or not it's been defined before.

Signed-off-by: Samuel Hernandez <sam.hernandez.amador@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2551e9b..d6d2623 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -231,7 +231,7 @@ struct rusage {
 #define DT_SOCK   12
 
 /* all the *at functions */
-#ifndef AT_FDWCD
+#ifndef AT_FDCWD
 #define AT_FDCWD             -100
 #endif
 
