Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5E2AA125
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgKFX1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgKFX11 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D0C0613D2;
        Fri,  6 Nov 2020 15:27:27 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irQJbEToJc499UoCRHTFIoyAe3py43uyL2+VIzJy7aw=;
        b=06YTOM0v3Ky7drw/e6Q05wEAFYO1vB7sOQjcbOjDcFJA7Co+DGvffIA2VWoJ/+E3PELJM9
        wdG+42PKMKrYCqxIYCuomw3SqLCuuG0dgOs403kUg/rjkAtTj7tsH4+nqJb1bSiodIpZpo
        g7ZOxDuRnHV5JepeIJ2+u8zP9VOz1AK2QWKUQM53EH+jGv1QnYmbZa0gX1ex697kSwHqLG
        mX2ua2MuyKIhL1bhQq2e7QtYbitArhk8iZUUInUODUja264WDJPDxj6uGvJmFNRepxSzrT
        7w+EoA1MvsnwbGis3d6ShzP2pUYrqEDGVxOytl0imVog502eCJgTYVFIvzbomQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irQJbEToJc499UoCRHTFIoyAe3py43uyL2+VIzJy7aw=;
        b=ny5oDYd5ZT1dLv995RkHncd6AkqRo3MExk3V4luXz9ZqPeun3jloqZ9UX5EcLFMZx3gTwg
        g7S7mc+Pr00aWdAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] highmem: Make DEBUG_HIGHMEM functional
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.268258322@linutronix.de>
References: <20201103095857.268258322@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524446.397.16379792318716189243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     389755c250814185938f5b04334a4f0184c30647
Gitweb:        https://git.kernel.org/tip/389755c250814185938f5b04334a4f0184c30647
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:55 +01:00

highmem: Make DEBUG_HIGHMEM functional

For some obscure reason when CONFIG_DEBUG_HIGHMEM is enabled the stack
depth is increased from 20 to 41. But the only thing DEBUG_HIGHMEM does is
to enable a few BUG_ON()'s in the mapping code.

That's a leftover from the historical mapping code which had fixed entries
for various purposes. DEBUG_HIGHMEM inserted guard mappings between the map
types. But that got all ditched when kmap_atomic() switched to a stack
based map management. Though the WITH_KM_FENCE magic survived without being
functional. All the thing does today is to increase the stack depth.

Add a working implementation to the generic kmap_local* implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095857.268258322@linutronix.de

---
 mm/highmem.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index bb4ce13..67d2d59 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -376,9 +376,19 @@ EXPORT_SYMBOL(kunmap_high);
 
 static DEFINE_PER_CPU(int, __kmap_local_idx);
 
+/*
+ * With DEBUG_HIGHMEM the stack depth is doubled and every second
+ * slot is unused which acts as a guard page
+ */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_INCR	2
+#else
+# define KM_INCR	1
+#endif
+
 static inline int kmap_local_idx_push(void)
 {
-	int idx = __this_cpu_inc_return(__kmap_local_idx) - 1;
+	int idx = __this_cpu_add_return(__kmap_local_idx, KM_INCR) - 1;
 
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
 	BUG_ON(idx >= KM_MAX_IDX);
@@ -392,7 +402,7 @@ static inline int kmap_local_idx(void)
 
 static inline void kmap_local_idx_pop(void)
 {
-	int idx = __this_cpu_dec_return(__kmap_local_idx);
+	int idx = __this_cpu_sub_return(__kmap_local_idx, KM_INCR);
 
 	BUG_ON(idx < 0);
 }
