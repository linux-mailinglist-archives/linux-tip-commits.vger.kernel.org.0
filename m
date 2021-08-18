Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B783EFE70
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhHRH70 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHRH7V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D59C061764;
        Wed, 18 Aug 2021 00:58:46 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eIhIpwE6U/SNQl9kMW+lq4Bq4RrHOAPxo1DY0Pzt3y0=;
        b=zZrHRRQ5lUBHsPlfHPgC91yBVj9bCdP9Z+5awQkP9JBz7bldPvi7+K5a//etjJbTDAT0+M
        bFw0qcEqMqmkrAhBDqA0cHt9Su0LZxGfDAiSEytbz7KjOfCDHrpqxP7YJhRFyv9YBU+rFV
        T8N6hSUftsRWyP1eNX2rZVflcuYtBDaWDZFfBcWhXIePZgDOMW1fGEhZBNV9x458n0EzjV
        U05W0DqmDXbEXkxk7mT9/Lv9o/nQLDGtlPmFX/5i4FpT1Wxp3uQD+oyQtz5n+zGmha1L8y
        Lxqbh2sP8k9sKDK1dCNol60zBN2aI3+b2QS6naU8SOj8BYX8+TBxRkamt0Q9LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eIhIpwE6U/SNQl9kMW+lq4Bq4RrHOAPxo1DY0Pzt3y0=;
        b=iyKKqVtZHAcjObRzem4kDt3cpEzCHsOZa1ySEBoSaV3U5n3kCI2MzOlO8frzeR+AKHt64h
        ypmbk1SqN0VQnBCg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352470.25758.1087604458737673053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     08cac6049412061e571fadadc3e23464dc46d0f2
Gitweb:        https://git.kernel.org/tip/08cac6049412061e571fadadc3e23464dc46d0f2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:50 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:43 -07:00

kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()

There are a number get_ctx() calls that are close to each other, which
results in poor codegen (repeated preempt_count loads).

Specifically in kcsan_found_watchpoint() (even though it's a slow-path)
it is beneficial to keep the race-window small until the watchpoint has
actually been consumed to avoid missed opportunities to report a race.

Let's clean it up a bit before we add more code in
kcsan_found_watchpoint().

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d92977e..9061009 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -301,9 +301,9 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static __always_inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(struct kcsan_ctx *ctx)
 {
-	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
+	return READ_ONCE(kcsan_enabled) && !ctx->disable_count;
 }
 
 /* Introduce delay depending on context and configuration. */
@@ -353,10 +353,17 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long flags;
 	bool consumed;
 
-	if (!kcsan_is_enabled())
+	/*
+	 * We know a watchpoint exists. Let's try to keep the race-window
+	 * between here and finally consuming the watchpoint below as small as
+	 * possible -- avoid unneccessarily complex code until consumed.
+	 */
+
+	if (!kcsan_is_enabled(ctx))
 		return;
 
 	/*
@@ -364,14 +371,12 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	 * reporting a race where e.g. the writer set up the watchpoint, but the
 	 * reader has access_mask!=0, we have to ignore the found watchpoint.
 	 */
-	if (get_ctx()->access_mask != 0)
+	if (ctx->access_mask)
 		return;
 
 	/*
-	 * Consume the watchpoint as soon as possible, to minimize the chances
-	 * of !consumed. Consuming the watchpoint must always be guarded by
-	 * kcsan_is_enabled() check, as otherwise we might erroneously
-	 * triggering reports when disabled.
+	 * Consuming the watchpoint must be guarded by kcsan_is_enabled() to
+	 * avoid erroneously triggering reports if the context is disabled.
 	 */
 	consumed = try_consume_watchpoint(watchpoint, encoded_watchpoint);
 
@@ -409,6 +414,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long irq_flags = 0;
 
 	/*
@@ -417,7 +423,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 */
 	reset_kcsan_skip();
 
-	if (!kcsan_is_enabled())
+	if (!kcsan_is_enabled(ctx))
 		goto out;
 
 	/*
@@ -489,7 +495,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Re-read value, and check if it is as expected; if not, we infer a
 	 * racy access.
 	 */
-	access_mask = get_ctx()->access_mask;
+	access_mask = ctx->access_mask;
 	new = 0;
 	switch (size) {
 	case 1:
