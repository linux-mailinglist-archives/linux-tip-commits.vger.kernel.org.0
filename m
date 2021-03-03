Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDB32C77C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355614AbhCDAcH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbhCCIQr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:47 -0500
Date:   Wed, 03 Mar 2021 08:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614759360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=icLblF3vQtfDNoKvII/E4l0qTGNuLYMVTTidVqwnwn8=;
        b=2Vtf7ScAFVUWzWzPf92b7WkwoZw1/h56wg7Yfcty2Q+x3Dpz+mhx96Fw5T4Q3Z4SXgRpaj
        0nlQHRO+C0gRqX6IkC69oIvBqLWKryCwOCmCiMRQ7vhbYpXkDOTpf2ToyRJI02C6npwcqm
        X1808mS8EMLH83b7oR02T08ukJfe8GIpCTRY7g/ps4yboEtBKmrk0WSYxyPRJ/0081nuki
        qHg8bWQPEskGcF+da0Qn7jP4Auhw5GM3nSjgyuLhdxP2HTRwMKvv0dAs1MEA7LeoQkVvAt
        W4F/BURuy5oO38xx0xuodAZQa+bACwtxJy/n7vy0qdshuBmtVQ5uLYyaO3C0iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614759360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=icLblF3vQtfDNoKvII/E4l0qTGNuLYMVTTidVqwnwn8=;
        b=l0FK4CDplcS5wCzL+k/LBWeqX1iphsqmTPYUxBJu/+ZvWPqJBRQH6l1hb1kJYxRknqa+ht
        Si9IJngaj6odKGBA==
From:   "tip-bot2 for Shuah Khan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add lockdep_assert_not_held()
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161475935945.20312.2870945278690244669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ac1cce36595238680c32c3f197e5aa18db6fa7a3
Gitweb:        https://git.kernel.org/tip/ac1cce36595238680c32c3f197e5aa18db6fa7a3
Author:        Shuah Khan <skhan@linuxfoundation.org>
AuthorDate:    Fri, 26 Feb 2021 17:06:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 02 Mar 2021 15:06:34 +01:00

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
