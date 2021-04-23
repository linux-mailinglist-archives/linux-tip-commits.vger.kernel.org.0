Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878B4368D5B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Apr 2021 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhDWGxf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Apr 2021 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhDWGxe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Apr 2021 02:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576FC061574;
        Thu, 22 Apr 2021 23:52:58 -0700 (PDT)
Date:   Fri, 23 Apr 2021 06:52:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619160777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lUh85XWwxl8Xbep2KvsWrXNxfz0aaYwtoNZ/flrvZA=;
        b=ho9TRxMWsml93t+k+qNEAIfJKqK9tDB8mJedNS+GHag0eHEmbH12tU5bfNc5E6QbYVzTv4
        5JlMx42CQEyZCk74A2+OFXkbr1ApwNnW0Nas8G4iAKd5zEjfcdW+SIwt4e38OmWRLGETLO
        lFsI4MT8Hjpie4YTk2YFj8LxmLxzOU2Hk3q3PKvSOWyaCkVKmjol1gbgXz5sjDgLV1ZmYw
        Z24tG6SDFvr/YEuOOAtECk3G87pFO8OE5qXwitorinSfMPEdoUna7kA5econsJtLH84c1Y
        SDnOVIN/r8DmDQ5VeTwYmjG8t7/6+f7+W6ciJ3EZZaMRvZ9NsjAV8tOzA5/L0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619160777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lUh85XWwxl8Xbep2KvsWrXNxfz0aaYwtoNZ/flrvZA=;
        b=Lt2jBpF8mNVWqZHYs7vX6QGmCDZNbeF083fT/sqRArMao54SXCMbi5aHMSnj2Rr4OqOXBG
        BGfdR/QMnw3C5cDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Fix printk format string
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210421135059.3371701-1-arnd@kernel.org>
References: <20210421135059.3371701-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161916077643.29796.8670414298244363723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f4abe9967c6fdb511ee567e129a014b60945ab93
Gitweb:        https://git.kernel.org/tip/f4abe9967c6fdb511ee567e129a014b60945ab93
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 21 Apr 2021 15:50:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Apr 2021 14:36:03 +02:00

kcsan: Fix printk format string

Printing a 'long' variable using the '%d' format string is wrong
and causes a warning from gcc:

kernel/kcsan/kcsan_test.c: In function 'nthreads_gen_params':
include/linux/kern_levels.h:5:25: error: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Werror=format=]

Use the appropriate format modifier.

Fixes: f6a149140321 ("kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20210421135059.3371701-1-arnd@kernel.org
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index b71751f..8bcffbd 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -984,7 +984,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 		const long min_required_cpus = 2 + min_unused_cpus;
 
 		if (num_online_cpus() < min_required_cpus) {
-			pr_err_once("Too few online CPUs (%u < %d) for test\n",
+			pr_err_once("Too few online CPUs (%u < %ld) for test\n",
 				    num_online_cpus(), min_required_cpus);
 			nthreads = 0;
 		} else if (nthreads >= num_online_cpus() - min_unused_cpus) {
