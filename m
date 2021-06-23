Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB93B15A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFWIVc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhFWIV3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77ADC061756;
        Wed, 23 Jun 2021 01:19:12 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG9JxpNo7PTghVEuXbJZgmJVEaFT/OZ5XpDl3stXIFs=;
        b=weye3k81NavctGPggG6stf+yEEmGgyNbpjGhVZCWTVJSbahfIruukQuuR6UblCvOHEQ2u3
        CSIVN3d7lFph39WNWkUzlkTus9FK+BxFae467si0ZSYbtYqWSzLld2LfJ2nbLelSMRqcE4
        /mXU/VtzA+C8zQbVJjGRpimM5PTQLpLgIXQDCY5CN3NR2JGMQfQWJlkio/fPnsfqBFnyl5
        mIC0p15wP1FMxNAzshJ0WV2KNWUUllaPk7e19WClsoLy0mSP+sKH47sZ/irN+ZTUW88+D/
        hzFxCyGsBTBJ2fROVtwxtXYUKHjo7EmAgajqpSVUIcAPhCZfftLPg0yRN/6CkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG9JxpNo7PTghVEuXbJZgmJVEaFT/OZ5XpDl3stXIFs=;
        b=/96CD00PiHKwcGcPRkiKtf5YQfsHmn/8V6kx3E+RfSL/TkV9JhzLG4Tl/oK1ebX9BQUckI
        xCIhSUYUXtpm3PDw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Remove the unnecessary trace saving
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618170110.3699115-3-boqun.feng@gmail.com>
References: <20210618170110.3699115-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <162443635021.395.7928917720698557665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d4c157c7b1a67a0844a904baaca9a840c196c103
Gitweb:        https://git.kernel.org/tip/d4c157c7b1a67a0844a904baaca9a840c196c103
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 19 Jun 2021 01:01:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:07 +02:00

locking/lockdep: Remove the unnecessary trace saving

In print_bad_irq_dependency(), save_trace() is called to set the ->trace
for @prev_root as the current call trace, however @prev_root corresponds
to the the held lock, which may not be acquired in current call trace,
therefore it's wrong to use save_trace() to set ->trace of @prev_root.
Moreover, with our adjustment of printing backwards dependency path, the
->trace of @prev_root is unncessary, so remove it.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210618170110.3699115-3-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3b32cd9..74d084a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2550,9 +2550,6 @@ print_bad_irq_dependency(struct task_struct *curr,
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
-	prev_root->trace = save_trace();
-	if (!prev_root->trace)
-		return;
 	print_shortest_lock_dependencies_backwards(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
