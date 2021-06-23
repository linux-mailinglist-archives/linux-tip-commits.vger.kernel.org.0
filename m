Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D33B159D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFWIVa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFWIV2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1259C061760;
        Wed, 23 Jun 2021 01:19:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpCzKvdaHwOORklxX4W5YgmNbX+jg/b7ZtCxW1/4cdc=;
        b=uQL2gI1gp8p9MM8bGaK4b0ffKG/8TXmowttMcVnNkCqDcN6Ik45GmrmPmUmIqJQjPH+EiY
        4kwLyRFTOYBhnlHi7OJWAewP318kk1wm8MBQoZ52npy6z6QPiOhmlpUM+XrwvFgkO3FRSq
        FUmR1yPrkzNzHE9AAlb29RvWva7YY95Rs9vYmfEIrj5YN8kKTXKnPVurDzw5Q2qnjJ5QME
        eMVj6Wl9ZqGHgmu00RgMKZlOnZX6WceZqDkfLoqRf0vnOz5/f4+qJW31dDPPlBTKBPkmC+
        DP9DS8rWZPinQZDa/CL5kwb2XQv+GZ8vtdgignpnPrpxEViVQ5e9D8sFGEIH+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpCzKvdaHwOORklxX4W5YgmNbX+jg/b7ZtCxW1/4cdc=;
        b=9ANl90uZGN4jM+ib0iooNqRUjg9ZktGxptx3jgMeQlscfuFDOVq7V5s6baEPjsBT+nRv6R
        evUAJImnTjbZpWAA==
From:   "tip-bot2 for Xiongwei Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Correct the description error
 for check_redundant()
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618130230.123249-1-sxwjean@me.com>
References: <20210618130230.123249-1-sxwjean@me.com>
MIME-Version: 1.0
Message-ID: <162443634605.395.8419234298182174439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0e8a89d49d45197770f2e57fb15f1bc9ded96eb0
Gitweb:        https://git.kernel.org/tip/0e8a89d49d45197770f2e57fb15f1bc9ded96eb0
Author:        Xiongwei Song <sxwjean@gmail.com>
AuthorDate:    Fri, 18 Jun 2021 21:02:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:09 +02:00

locking/lockdep: Correct the description error for check_redundant()

If there is no matched result, check_redundant() will return BFS_RNOMATCH.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lkml.kernel.org/r/20210618130230.123249-1-sxwjean@me.com
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0584b20..095c87f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2829,7 +2829,7 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
  * <target> or not. If it can, <src> -> <target> dependency is already
  * in the graph.
  *
- * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * Return BFS_RMATCH if it does, or BFS_RNOMATCH if it does not, return BFS_E* if
  * any error appears in the bfs search.
  */
 static noinline enum bfs_result
