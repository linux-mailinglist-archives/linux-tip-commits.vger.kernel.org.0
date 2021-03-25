Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183DF348E8D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCYLJO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 07:09:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCYLIk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:40 -0400
Date:   Thu, 25 Mar 2021 11:08:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616670518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd2nkwFdsLB6eLMF+RCYw5ivYZH6ZQ2d2Ubsi/FjZvI=;
        b=4ZAfPrzGhg2c8rR/6ir1vkGYyWBb25BydqX+e26LGvEA+cRy7ZbOxRhJyKZ1nccXMn79SN
        4Zv2clJbh9GK6pTWm+DtrL9O0XWtTiMiBNDkXbCa4NmQYD2F7eGNwo0CIt8AatfUdaraUD
        to/p/N+j28PwyA57qwbauFXqe6XqdcDad0qkDK58Y35aDq/QrUyQUHm61e+mWUWl7Zm0QH
        SMhG01pPP14l0yyUfuII4nOlQBtnGZ40hEkaRrJBLN2gyNGA8NXRyGNQHXsJuZBAwbtXgU
        B3FWhgWYvXy6LnE0RXaRROuhZ0058a/6tKS8zCdq3pjmiqHj73lueUzAnLANWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616670518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd2nkwFdsLB6eLMF+RCYw5ivYZH6ZQ2d2Ubsi/FjZvI=;
        b=TKAxbSqHIkkI9g6QkLeKvJ6BfbrxbQCDjXw/hmZK081wNyo3cz3fLpdjxbq9Lx9CDvWF00
        T8ZTc+X8G/DVLfCg==
From:   "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Use -EINVAL in sched_dynamic_mode()
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210325004515.531631-2-linux@rasmusvillemoes.dk>
References: <20210325004515.531631-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Message-ID: <161667051768.398.4185188604723886727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c4681f3f1cfcfde0c95ff72f0bdb43f9ffd7f00e
Gitweb:        https://git.kernel.org/tip/c4681f3f1cfcfde0c95ff72f0bdb43f9ffd7f00e
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Thu, 25 Mar 2021 01:45:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 11:39:13 +01:00

sched/core: Use -EINVAL in sched_dynamic_mode()

-1 is -EPERM which is a somewhat odd error to return from
sched_dynamic_write(). No other callers care about which negative
value is used.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20210325004515.531631-2-linux@rasmusvillemoes.dk
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fe9d3f..95bd6ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5384,7 +5384,7 @@ static int sched_dynamic_mode(const char *str)
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
-	return -1;
+	return -EINVAL;
 }
 
 static void sched_dynamic_update(int mode)
