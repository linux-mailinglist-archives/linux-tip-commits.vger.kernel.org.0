Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17483B159C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFWIV3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhFWIV2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1FC061756;
        Wed, 23 Jun 2021 01:19:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9+mXy6PlzhYxwKHjP6l72LS8Lbp638w1IPEBMM20S0=;
        b=bkcAEbD+CYtPPrNOPjK/xyLV4Uz522PfRus7WlYbSdnpGaAMlsV7pa3PWr+wLDV1ukaM56
        pYwUggi3fWX9/q+lratjPJOsUDmkFUTHc3zu6C6y6PsU727tnyxoOvVWYHmnKRYhHRv8HR
        pAaQUKSBhsDDDttGT+pAiA/gjB1OVO3ylplY53iNddLVye/a9oa4hRjaTxQ+YP20A4U3SJ
        2sO8hNVqadpQbUW5PwXDYBuVJJEXzuTSh8gMpPWXtbbxq0NUM9vca/6KKydQkxVhYaZOq6
        5ExVYHKDgLddlMjFrIgXBOiBteGXEcx3/6OR303yaLxtnpqQvbdluFmp/lbAVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9+mXy6PlzhYxwKHjP6l72LS8Lbp638w1IPEBMM20S0=;
        b=w4nUKjm0idVsDEhnqltxudseoTt7+KJnp/VXajOmzk/LuIkgZ4Aqa8XSAhRfMd3SrbmOo3
        +gBZkYJOXflMIIDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Fix selftests vs
 PROVE_RAW_LOCK_NESTING
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210617190313.322096283@infradead.org>
References: <20210617190313.322096283@infradead.org>
MIME-Version: 1.0
Message-ID: <162443634810.395.1660357312688822086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c0c2c0dad6a06e0c05e9a52d65f932bd54364c97
Gitweb:        https://git.kernel.org/tip/c0c2c0dad6a06e0c05e9a52d65f932bd54364c97
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Jun 2021 20:57:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:08 +02:00

lockdep/selftests: Fix selftests vs PROVE_RAW_LOCK_NESTING

When PROVE_RAW_LOCK_NESTING=y many of the selftests FAILED because
HARDIRQ context is out-of-bounds for spinlocks. Instead make the
default hardware context the threaded hardirq context, which preserves
the old locking rules.

The wait-type specific locking selftests will have a non-threaded
HARDIRQ variant.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20210617190313.322096283@infradead.org
---
 lib/locking-selftest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 5c50b09..af12e84 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -195,6 +195,7 @@ static void init_shared_classes(void)
 #define HARDIRQ_ENTER()				\
 	local_irq_disable();			\
 	__irq_enter();				\
+	lockdep_hardirq_threaded();		\
 	WARN_ON(!in_irq());
 
 #define HARDIRQ_EXIT()				\
