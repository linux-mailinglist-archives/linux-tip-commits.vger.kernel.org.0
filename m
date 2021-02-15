Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA71631BB9E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhBOO5V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F26C061356;
        Mon, 15 Feb 2021 06:55:49 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4XrH1XIqYpCJQyRFW+hhzPMwGcfJtn3HFK8Byjr2hNc=;
        b=h0/HSTZdrLEBuSx0m7lb/RhAReZRoorywvfM/eAnCR+vCugVrWsLs9i9u77eD2g6/Mdnh5
        8RBmAilspg+mUtWPImsVqXAQgqJ3V7YbgB03usTsCGifLGuFDMZkdPx9xyOakVrzvR7RxN
        ZTwRmJC/ekD3fT1H1zIQ4KMhU1u0uEjln8dqdH3ZMMbDTP+t1ve0tFzevMK1Bp4xrN+KmF
        IEQsCiok6rUgIlxXKZKa01X3hc6XVcxfR/iYhJ8hW6Y/gWXe7h1SczCwfvfkyIe7E1qmLo
        Hdgzw27rj6DxUvs1cN4S/bnXzAswqclbj0LH9JpPmx6ee0pDDg7IpZehD1PZ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4XrH1XIqYpCJQyRFW+hhzPMwGcfJtn3HFK8Byjr2hNc=;
        b=/fLiIJrK0rmIeQUu0nHjRnvjvFAhrfbaXHPbeY8IHEjJuyJ4df0rUMwea7RXnC9wKG52VD
        m9H84R7d7a/RldDw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Introduce kfree_rcu() single-argument macro
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094697.20312.16589056476708309932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5130b8fd06901c1b3a4bd0d0f5c5ea99b2b0a6f0
Gitweb:        https://git.kernel.org/tip/5130b8fd06901c1b3a4bd0d0f5c5ea99b2b0a6f0
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Fri, 20 Nov 2020 12:49:16 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:42:04 -08:00

rcu: Introduce kfree_rcu() single-argument macro

There is a kvfree_rcu() single argument macro that handles pointers
returned by kvmalloc(). Even though it also handles pointer returned by
kmalloc(), readability suffers.

This commit therefore updates the kfree_rcu() macro to explicitly pair
with kmalloc(), thus improving readability.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de08264..b95373e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -851,8 +851,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr:	pointer to kfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ * @ptr: pointer to kfree for both single- and double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr,
+ *       but only for double-argument invocations.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -875,13 +876,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf)						\
-do {									\
-	typeof (ptr) ___p = (ptr);					\
-									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
-} while (0)
+#define kfree_rcu kvfree_rcu
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
@@ -913,7 +908,14 @@ do {									\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
-#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_2(ptr, rhf)					\
+do {									\
+	typeof (ptr) ___p = (ptr);					\
+									\
+	if (___p)							\
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+} while (0)
+
 #define kvfree_rcu_arg_1(ptr)					\
 do {								\
 	typeof(ptr) ___p = (ptr);				\
