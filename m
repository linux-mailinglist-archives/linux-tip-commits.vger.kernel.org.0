Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4432FA4E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCFLzT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCFLyh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C7C06175F;
        Sat,  6 Mar 2021 03:54:36 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o2ICOZ8uRP5ii5RQMqIZgNoYqIRrm6M4uwb7LNgNO3s=;
        b=sZ/OC53e7d86B6ao1nN2cP7609XHknInvkd6qbn2aQ2hT/KW75EBXZ2VLcSMqx192tnAJ8
        dhQq1JrD+64hP4ITr3/MQeaIFnqRQX2BM+kB+J8ePl8XmxaZh3/3qoguKXQOrdQP9LUioH
        +OLbbqyP2ChJcEYlnaMb47XLURA1biTy6KpidgzqZliG5Jkk+iYO/YM0BmpeV/YSlob/WR
        cv5kh2j054xDakunOnac46CNXlnXJUYLIuj0V9h1vIZySF3MYrUIOwQa1yAlv/yf1okdt3
        3ZIus92Bxt4PGwuvGest0cS3ZteTFGxjwAt9S/PG66IizV8Wp2jHbk8GPZKvqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o2ICOZ8uRP5ii5RQMqIZgNoYqIRrm6M4uwb7LNgNO3s=;
        b=YOmpd2H7oZGXoCKZL7YDk/iRPWW64vlIsODdCqCmfgVSfcsUpKO7+9lUDVCYNRhMZmi5EW
        BQSipraP7KsE3eAA==
From:   "tip-bot2 for Shuah Khan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add lockdep_assert_not_held()
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161503167472.398.16348854716222341542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3e31f94752e454bdd0ca4a1d046ee21f80c166c5
Gitweb:        https://git.kernel.org/tip/3e31f94752e454bdd0ca4a1d046ee21f80c166c5
Author:        Shuah Khan <skhan@linuxfoundation.org>
AuthorDate:    Fri, 26 Feb 2021 17:06:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:51:05 +01:00

lockdep: Add lockdep_assert_not_held()

Some kernel functions must be called without holding a specific lock.
Add lockdep_assert_not_held() to be used in these functions to detect
incorrect calls while holding a lock.

lockdep_assert_not_held() provides the opposite functionality of
lockdep_assert_held() which is used to assert calls that require
holding a specific lock.

Incorporates suggestions from Peter Zijlstra to avoid misfires when
lockdep_off() is employed.

The need for lockdep_assert_not_held() came up in a discussion on
ath10k patch. ath10k_drain_tx() and i915_vma_pin_ww() are examples
of functions that can use lockdep_assert_not_held().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
---
 include/linux/lockdep.h  | 11 ++++++++---
 kernel/locking/lockdep.c |  6 +++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7b7ebf2..dbd9ea8 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -301,8 +301,12 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
-#define lockdep_assert_held(l)	do {				\
-		WARN_ON(debug_locks && !lockdep_is_held(l));	\
+#define lockdep_assert_held(l)	do {					\
+		WARN_ON(debug_locks && lockdep_is_held(l) == 0);	\
+	} while (0)
+
+#define lockdep_assert_not_held(l)	do {				\
+		WARN_ON(debug_locks && lockdep_is_held(l) == 1);	\
 	} while (0)
 
 #define lockdep_assert_held_write(l)	do {			\
@@ -393,7 +397,8 @@ extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c6d0c1d..969736b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5539,8 +5539,12 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
+	/*
+	 * Avoid false negative lockdep_assert_held() and
+	 * lockdep_assert_not_held().
+	 */
 	if (unlikely(!lockdep_enabled()))
-		return 1; /* avoid false negative lockdep_assert_held() */
+		return -1;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
