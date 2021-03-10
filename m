Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7233333B55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Mar 2021 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhCJL0k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Mar 2021 06:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhCJL0V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Mar 2021 06:26:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA8C061760;
        Wed, 10 Mar 2021 03:26:21 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:26:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615375577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLWp08SxYz4Zo0pPsXFq06aKXbywttB2tZphRG46gro=;
        b=0UYMLVOJR9nvlIUcGthOUE0AqyPc0Gv8YQfvetaCwSXO3mfixGuZTMtonNN4cFp6HxQEeQ
        avXGuCxbtSppTmgzq+FU7FZNmqwHitnsMVyIkOSj9X5tX7+V96A3rz2Ay3v5ia4bo8iGxm
        ivaztewAE7APIs80jL/ccBVb6rKciOu32QR2XvpKu8T1RhqT9Wqb5LCZSrY0TpERG57y1k
        P64z67gMI+nwEQu7VN5bBSoKbuUUm3j2JZQK1eyjk/BQLmx5yXlZwB2dFDqmF7trV9uhoZ
        VHbc8AHxK1resP5UACnJSESz4A96wAvrJn2dcli/Z8SEMlNGIJjwZpIqed6q2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615375577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLWp08SxYz4Zo0pPsXFq06aKXbywttB2tZphRG46gro=;
        b=5Ty3+tChSaIbDtl2sQaQTapj1gmGUvxUc8fyotl1CHULaLTR6HeRTwfcjq9AwAjW6e9ZXi
        mz8nDyrqQwbh2gCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] u64_stats,lockdep: Fix u64_stats_init() vs lockdep
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Erhard F." <erhard_f@mailbox.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YEXicy6+9MksdLZh@hirez.programming.kicks-ass.net>
References: <YEXicy6+9MksdLZh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161537557688.398.9814412263245097413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d5b0e0677bfd5efd17c5bbb00156931f0d41cb85
Gitweb:        https://git.kernel.org/tip/d5b0e0677bfd5efd17c5bbb00156931f0d41cb85
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 08 Mar 2021 09:38:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Mar 2021 09:51:45 +01:00

u64_stats,lockdep: Fix u64_stats_init() vs lockdep

Jakub reported that:

    static struct net_device *rtl8139_init_board(struct pci_dev *pdev)
    {
	    ...
	    u64_stats_init(&tp->rx_stats.syncp);
	    u64_stats_init(&tp->tx_stats.syncp);
	    ...
    }

results in lockdep getting confused between the RX and TX stats lock.
This is because u64_stats_init() is an inline calling seqcount_init(),
which is a macro using a static variable to generate a lockdep class.

By wrapping that in an inline, we negate the effect of the macro and
fold the static key variable, hence the confusion.

Fix by also making u64_stats_init() a macro for the case where it
matters, leaving the other case an inline for argument validation
etc.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Debugged-by: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Erhard F." <erhard_f@mailbox.org>
Link: https://lkml.kernel.org/r/YEXicy6+9MksdLZh@hirez.programming.kicks-ass.net
---
 include/linux/u64_stats_sync.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index c6abb79..e81856c 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -115,12 +115,13 @@ static inline void u64_stats_inc(u64_stats_t *p)
 }
 #endif
 
+#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
+#define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
+#else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-	seqcount_init(&syncp->seq);
-#endif
 }
+#endif
 
 static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
