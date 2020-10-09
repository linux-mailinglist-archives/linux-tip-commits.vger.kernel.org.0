Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815FF28842E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgJIH7S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732509AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ADAC0613DD;
        Fri,  9 Oct 2020 00:58:53 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ascJWP7w3B3xScXoK4K6IE4Cav1GdhpDImy6b/9N6mY=;
        b=Com5l8oDirfY4Jcf+0YHoAdLLbpmJgKHbCHqBJ7ueRYgA1kd+mdD/oNMKyF3tTS5bpilcG
        brWOa5ZgfED1pNLwijTv62+St2Ae4TRsrt8JSpuE0eXHdYG7XP5kcg478buUM+dxZmi00e
        XYR+jb9bn+fUeK0BEv85PI2ptr/6/6LTbjjpnsWqBjBulrBFkwKDQzVvVswjl5yEunhioR
        qTn6vBSGy8110FnkPFAN38hmk2FPnaKlJP6gpDBn21EfMjO6ignMa5DmS4RjIuzqV2ZPDF
        M75/dcQdyd3wXUKw/g1rvIv8PL9LllSyq17nKxRrFg6UHMg+ziN+s75je+m4dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ascJWP7w3B3xScXoK4K6IE4Cav1GdhpDImy6b/9N6mY=;
        b=s5uVUWi2ZvAjyKGHzk1Sv9t4D2gSdFFl34HtZ2NTcFliLjsCvprPmJuJlqeJvZNQFq/hwR
        r5wqMcApTnV1y4CQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Skew delay to be longer for certain access types
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033171.7002.4242667766393113069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     106a307fd0a762e2d47e1cf99e6da43763887a18
Gitweb:        https://git.kernel.org/tip/106a307fd0a762e2d47e1cf99e6da43763887a18
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:03 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:57 -07:00

kcsan: Skew delay to be longer for certain access types

For compound instrumentation and assert accesses, skew the watchpoint
delay to be longer if randomized. This is useful to improve race
detection for such accesses.

For compound accesses we should increase the delay as we've aggregated
both read and write instrumentation. By giving up 1 call into the
runtime, we're less likely to set up a watchpoint and thus less likely
to detect a race. We can balance this by increasing the watchpoint
delay.

For assert accesses, we know these are of increased interest, and we
wish to increase our chances of detecting races for such checks.

Note that, kcsan_udelay_{task,interrupt} define the upper bound delays.
When randomized, delays are uniformly distributed between [0, delay].
Skewing the delay does not break this promise as long as the defined
upper bounds are still adhered to. The current skew results in delays
uniformly distributed between [delay/2, delay].

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4c8b40b..95a364e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -283,11 +283,15 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(void)
+static inline unsigned int get_delay(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
+	/* For certain access types, skew the random delay to be longer. */
+	unsigned int skew_delay_order =
+		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
+
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay) :
+				prandom_u32_max(delay >> skew_delay_order) :
 				0);
 }
 
@@ -470,7 +474,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay());
+	udelay(get_delay(type));
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
