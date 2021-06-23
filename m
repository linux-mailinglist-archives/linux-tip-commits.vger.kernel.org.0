Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3783A3B15A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWIVb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFWIV3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:29 -0400
Date:   Wed, 23 Jun 2021 08:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnHpRyORp2w7j2xFo8ba3YWQSR/vu9cDVYBZOXkxCYc=;
        b=kh7X0kvFk8ZY1w49P54BntYPV2bmCbfjexYuCdsHp7rWKY6mfws5fZRtMAlenlYLZ5rq9V
        cFN4aO1Vmc4n/imTPrZXS3//AXc/L2TohSPhUojuW6Or4kUZWHeGa4j9bjqmZm8/J2hMZa
        psM/eoOs+t0rn4Q/P8SJRkSwDTQdmIZnL14i6l7GlzXkv++MEU+jV9gaPSGBAU6wNNY6s8
        W0y+vP5xlGjvzky5TJyXsESzTH9CAxRiPam5buxPYU8Yk54NXrBTkUCGstP9Be1dbT2WJc
        PVToJf71tdtP0whqR2ekpdreyy6g7kZnr9ALP8v5lBI+/MnJRYeC5JeiyXPxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnHpRyORp2w7j2xFo8ba3YWQSR/vu9cDVYBZOXkxCYc=;
        b=rKALescxL2M5u2r0f2KmIm3QsbB14XtKMP822K7gFq29wVDCrWoCbDJJwA4Kld9tKYdX1e
        y9DARDWI1EaigsDw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockding/lockdep: Avoid to find wrong lock dep
 path in check_irq_usage()
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618170110.3699115-4-boqun.feng@gmail.com>
References: <20210618170110.3699115-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <162443634961.395.10623514533302474947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7b1f8c6179769af6ffa055e1169610b51d71edd5
Gitweb:        https://git.kernel.org/tip/7b1f8c6179769af6ffa055e1169610b51d71edd5
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 19 Jun 2021 01:01:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:07 +02:00

lockding/lockdep: Avoid to find wrong lock dep path in check_irq_usage()

In the step #3 of check_irq_usage(), we seach backwards to find a lock
whose usage conflicts the usage of @target_entry1 on safe/unsafe.
However, we should only keep the irq-unsafe usage of @target_entry1 into
consideration, because it could be a case where a lock is hardirq-unsafe
but soft-safe, and in check_irq_usage() we find it because its
hardirq-unsafe could result into a hardirq-safe-unsafe deadlock, but
currently since we don't filter out the other usage bits, so we may find
a lock dependency path softirq-unsafe -> softirq-safe, which in fact
doesn't cause a deadlock. And this may cause misleading lockdep splats.

Fix this by only keeping LOCKF_ENABLED_IRQ_ALL bits when we try the
backwards search.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210618170110.3699115-4-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 74d084a..6ff1e84 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2768,8 +2768,18 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 3: we found a bad match! Now retrieve a lock from the backward
 	 * list whose usage mask matches the exclusive usage mask from the
 	 * lock found on the forward list.
+	 *
+	 * Note, we should only keep the LOCKF_ENABLED_IRQ_ALL bits, considering
+	 * the follow case:
+	 *
+	 * When trying to add A -> B to the graph, we find that there is a
+	 * hardirq-safe L, that L -> ... -> A, and another hardirq-unsafe M,
+	 * that B -> ... -> M. However M is **softirq-safe**, if we use exact
+	 * invert bits of M's usage_mask, we will find another lock N that is
+	 * **softirq-unsafe** and N -> ... -> A, however N -> .. -> M will not
+	 * cause a inversion deadlock.
 	 */
-	backward_mask = original_mask(target_entry1->class->usage_mask);
+	backward_mask = original_mask(target_entry1->class->usage_mask & LOCKF_ENABLED_IRQ_ALL);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
 	if (bfs_error(ret)) {
