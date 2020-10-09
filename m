Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BD288F71
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbgJIRB6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389958AbgJIRBa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83CEC0613D2;
        Fri,  9 Oct 2020 10:01:29 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DsUXCFgB0t8Uz1s66Xv3x9K3h5PRL9+85GNO1gQyCNw=;
        b=uqPQ0lq9j159dwjEitmbe3g3lMgvIvEjwtLwA/ttHqk4wHgdPKaSOScbJabe2VyKa3tpr3
        HlCaU0ZiMW6i/OC0V+QqzLnZcHPJVQIl2bx4/LPQjGazo5jpIqaKCLcT/ClcTT+yb/FJfc
        8KRxyE1g+Y51M+jwNnVcorDpN7TzFTa1G/5aKzaCVK/blAxWHHHFAHbUncgphngKczMrWS
        ZVFqwKVFXFAKVYiH3riOwoof75KGutyBSd8LLxop9gInIeP0yE7gVinf1+OSaaiN94kuFr
        tpaPL7j+JlRED9hIe+h4Yqu1uUaYsMNuukUW9eK+3caTmF/so6z6fcXyDDm+CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DsUXCFgB0t8Uz1s66Xv3x9K3h5PRL9+85GNO1gQyCNw=;
        b=tsyJjwYX+hZAptY3Vdx0hr6DroEAXAq4MekM8lAnKONvUELxb6KIaD+GYLAWr0IzN1F/dk
        Ef3w0E+2kWmi6qCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288705.7002.3287677624087065789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1aba898d50dd0dc18d418bf66b2eea0028b2fbd6
Gitweb:        https://git.kernel.org/tip/1aba898d50dd0dc18d418bf66b2eea0028b2fbd6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:25:00 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:19 -07:00

mm/pagemap: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
[ paulmck: Fix !SMP build error per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/pagemap.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dc..b3d9d92 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -168,9 +168,7 @@ void release_pages(struct page **pages, int nr);
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+	VM_BUG_ON(preemptible());
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
 	 * this for us.
