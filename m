Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25734D4EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2QYd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC2QYL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2371C061756;
        Mon, 29 Mar 2021 09:24:10 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7FPeckfSjITUXp52cHV7Fc1rw89cy3joY0fjU5Su11I=;
        b=0vUZ1cpnR+w+2BBTQ1kFb6m86NM/k9n1LhqD+KuiCYLKQAxIZxFYggFpyk3nNTdRJJtpHt
        7je4gKDGAVog5PHjs9AU91JQuV4MntAcsjlF5XOxpERZENf202dIcWc4QZ4ip+icOZJ/Tg
        Lm/a7Ot+VC2FTu91RCrH6rdot9Q8frhwLkFWuAeiqBxn/Z4jJixP9IT/ndQtDqjql8346f
        24WQ7vvzXsGsUByqweiKKM0gVp3OTPLMnqfA/2UvjNeqw6cdqxF44PeoR1qTeYbFSjqm5F
        C3K0xcJtcGx39pzu7R1obf787VFs2kuZRlKgj9L5sBH8+nVt3rcYy4jgxN7l5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7FPeckfSjITUXp52cHV7Fc1rw89cy3joY0fjU5Su11I=;
        b=j5aYWKOlOpoTucdNqTWuB13xrfADsQVXaSrLP3lXzLWR4AnMKzXL5GzjnnXERpQYO37nzi
        026wyolRrBjl6ZBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Restrict the trylock WARN_ON() to debug
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.436565064@linutronix.de>
References: <20210326153944.436565064@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504783.29796.15372027244154710919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c2c360ed7f28fd6b7eb7e39e70af2d2ae405f466
Gitweb:        https://git.kernel.org/tip/c2c360ed7f28fd6b7eb7e39e70af2d2ae405f466
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:04 +02:00

locking/rtmutex: Restrict the trylock WARN_ON() to debug

The warning as written is expensive and not really required for a
production kernel. Make it depend on rt mutex debugging and use !in_task()
for the condition which generates far better code and gives the same
answer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.436565064@linutronix.de
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 512b400..c68542d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1456,7 +1456,7 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
 	int ret;
 
-	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
 	/*
