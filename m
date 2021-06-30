Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB603B8441
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhF3Nx5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhF3NwE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:04 -0400
Date:   Wed, 30 Jun 2021 13:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m/ocNYUej39qTM6TOPATFSXbQ0ESjovM0aqNr/7WLhc=;
        b=P1sNQ78djiDtJNI6Kn1UIt7BS8JjDbG6wHgxPtXSMYZsMX8njuhHaYYIpoeFWovtereJsw
        Uoxrl8kOm9CCeDRVSfdPTWyyoJwC+gMUfYBWac6RcZ2jBo9rHdz5nospZzxGiCpXFt1utR
        E6zenb8AfQLaOlUvPhJlczACfpYZmWjDC5SqLeW2c597VwJxsyqziY/IPI/TvdjKkw9tnX
        A5npgFcI+NOs8794zdNbMwsC1pgQGD3R/wEkw9smG0gBPmVeuPPHLJcjJD5C3R9Ykbyil6
        VXPs5+QpC6JUT8SRj5znEAdnL/L6Q+joE6k8zdoVfjVYsBUvaWC2FXshUfQRLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m/ocNYUej39qTM6TOPATFSXbQ0ESjovM0aqNr/7WLhc=;
        b=ctjemU1Tmrhqy6Bf1X5WTGyOizwWWfoa7+s3yp4sGZkB8zMsRUpK2GixoYbglUGW+YNVyJ
        /KaSUZ+NAYqUOjCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Simplify value change detection
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506090080.395.14623654638879773782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     6f2d98192c3f204592434177ba240564346eed9f
Gitweb:        https://git.kernel.org/tip/6f2d98192c3f204592434177ba240564346eed9f
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 14 Apr 2021 13:28:17 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:14 -07:00

kcsan: Simplify value change detection

In kcsan_setup_watchpoint() we store snapshots of a watched value into a
union of u8/u16/u32/u64 sized fields, modify this in place using a
consistent field, then later check for any changes via the u64 field.

We can achieve the safe effect more simply by always treating the field
as a u64, as smaller values will be zero-extended. As the values are
zero-extended, we don't need to truncate the access_mask when we apply
it, and can always apply the full 64-bit access_mask to the 64-bit
value.

Finally, we can store the two snapshots and calculated difference
separately, which makes the code a little easier to read, and will
permit reporting the old/new values in subsequent patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 45c821d..d360183 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -407,12 +407,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
-	union {
-		u8 _1;
-		u16 _2;
-		u32 _4;
-		u64 _8;
-	} expect_value;
+	u64 old, new, diff;
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
@@ -468,19 +463,19 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
-	expect_value._8 = 0;
+	old = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
+		old = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 = READ_ONCE(*(const u16 *)ptr);
+		old = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 = READ_ONCE(*(const u32 *)ptr);
+		old = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 = READ_ONCE(*(const u64 *)ptr);
+		old = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
@@ -506,33 +501,30 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * racy access.
 	 */
 	access_mask = get_ctx()->access_mask;
+	new = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
-		if (access_mask)
-			expect_value._1 &= (u8)access_mask;
+		new = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
-		if (access_mask)
-			expect_value._2 &= (u16)access_mask;
+		new = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
-		if (access_mask)
-			expect_value._4 &= (u32)access_mask;
+		new = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
-		if (access_mask)
-			expect_value._8 &= (u64)access_mask;
+		new = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
 	}
 
+	diff = old ^ new;
+	if (access_mask)
+		diff &= access_mask;
+
 	/* Were we able to observe a value-change? */
-	if (expect_value._8 != 0)
+	if (diff != 0)
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
