Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8434A35B518
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhDKNpL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bWcXHtULmma/Hs3hOl6jyA/3/UrzQJWR8qWj3RECxIw=;
        b=SJzxMxk7xF6s17dBmjnaMWV9dOsiWiedbS4/2pVmk0LTGPKGX/yUgrNATT9sdP2XtnOTFI
        olJJ+na4kZJfasyP0x87WpoOYQ8mNd9cHHmhGG6P0a8iy0lQboGU13Qad9iF1lx7LgbJ6Y
        vTSgyyRMMmQ22B2c00vn9L8ms6GNv/fWoQ4NWIRaKOAWjaakU56pxkA7J2dcwhpM2DE3Mb
        S2oSfcJefpgN6VqStjrJ3KYeYrx3Pdhp7DXFbsEbuZJNLguTePvWPIQVkf5Hb5FV7c39Ll
        UXJeUj4nI7vSZ04zREMgMSIokWPGdiCKO6fhBPXeQ5QWxpn2JHk/YQMS5udeyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bWcXHtULmma/Hs3hOl6jyA/3/UrzQJWR8qWj3RECxIw=;
        b=oxMX++ouX0LqM1EMIFL6fBbOb13nTDjnJmNM6uo3f5huchBbzOEU8KMjP9d6MOlLEoAD6a
        PB4YfzkrnYNehIAQ==
From:   "tip-bot2 for Akira Yokosawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist: Replace reference to atomic_ops.rst
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862179.29796.413703618256109229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5bb1369d4bea078dd1298dfc2c6ce781d9e34dde
Gitweb:        https://git.kernel.org/tip/5bb1369d4bea078dd1298dfc2c6ce781d9e34dde
Author:        Akira Yokosawa <akiyks@gmail.com>
AuthorDate:    Sat, 16 Jan 2021 00:11:45 +09:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:17:35 -08:00

rculist: Replace reference to atomic_ops.rst

The hlist_nulls_for_each_entry_rcu() docbook header references the
atomic_ops.rst file, which was removed in commit f0400a77ebdc ("atomic:
Delete obsolete documentation").  This commit therefore substitutes a
section in memory-barriers.txt discussing the use of barrier() in loops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ff3e947..d8afdb8 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -161,7 +161,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
  * as this loop can be restarted [2]
- * [1] Documentation/core-api/atomic_ops.rst around line 114
+ * [1] Documentation/memory-barriers.txt around line 1533
  * [2] Documentation/RCU/rculist_nulls.rst around line 146
  */
 #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)			\
