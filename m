Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F934D4E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhC2QYb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37624 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhC2QYJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:09 -0400
Date:   Mon, 29 Mar 2021 16:24:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gV6uQ3EP+gw4rb1JSm1Y++Svm7LKINBQTvbW2b0gmA=;
        b=Hw68Xr4trGWBae9lokbF3sf7QACHi2MiBiN57w5luHqumdm0LN1hbmtK4IvDXFUrOCZyPc
        3MShSr2ZF7LR7NgpBAAco61ihB1kHIinHxXnKvqodij2N54srQYWEkmxbiFIsOUVCzHGWN
        /vwJrlU5xqFc7ffQm2h5PqlWGdcHk+rzdJygAO67CC/fYrs5rair3emoC9CKufVHVuog+8
        5EipZ8taKHSDT/rARSPA7ZzRI0SUiwvRGPCTBEXyvVMdOHTpI+DFoxc/+3n57LnMCYJj4D
        wIYdCMfbOl+2dnd75DJ8dIotPE6yk+f811sg7ZL8bz9tiPhCB+a8od6hOrZd0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gV6uQ3EP+gw4rb1JSm1Y++Svm7LKINBQTvbW2b0gmA=;
        b=6Vszh3cbjDhl9gJoVO9RJ7HuLV/PcaPM9NRVwZ8xOu9NfFgR6WC7Mg3ZDcyFWdwczz941W
        gCzEIv+yGk75efBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Fix misleading comment in
 rt_mutex_postunlock()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.341734608@linutronix.de>
References: <20210326153944.341734608@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504815.29796.10410853523682764877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     82cd5b1039e26b1b1254886464991e34de439ac5
Gitweb:        https://git.kernel.org/tip/82cd5b1039e26b1b1254886464991e34de439ac5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:04 +02:00

locking/rtmutex: Fix misleading comment in rt_mutex_postunlock()

Preemption is disabled in mark_wakeup_next_waiter(,) not in
rt_mutex_slowunlock().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.341734608@linutronix.de
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7d0c168..512b400 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1305,7 +1305,7 @@ void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
 	wake_up_q(wake_q);
 
-	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
 }
 
