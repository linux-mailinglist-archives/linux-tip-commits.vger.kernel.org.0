Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8B365652
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTKlT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhDTKlS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:41:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144CC06174A;
        Tue, 20 Apr 2021 03:40:47 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb4eM4nPac9m1qOjx+gQdVVniX4nvTAZh4HF4hyBU3c=;
        b=xDi0mmWjVSi2NJRkTXzawxBI4UH8MP8OOYaBgA1yVmddov8ttuPFsTdbuCjig9phOToIJ9
        MOJwcv//d5umR93xNQwMgw4UNxKVqRJS3Zt/c+jnxwabqwhwUmWZTq9gzItNbQYkTUW5eX
        ArrpGeGiRFpCj/J5RNjW3J9+Gm/Wk6Gre6FLkyXBf85RV4jc6OG01jezqaPJIWEKs6/RUN
        zSrpBY3TZuu6X5aTnDcJMg2KBFI5+IQSkGTyt/eUQdv/E+WGGRPJaMO/NaQhe4568vw/iH
        pt/FrI+m/fla71utxerDDfs3d16ZUXQrBM0fZSyi/4PSFIepEdORznrIAyR7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb4eM4nPac9m1qOjx+gQdVVniX4nvTAZh4HF4hyBU3c=;
        b=WCDZaTNnu0pJHAOMe+wV0fstBO4/9fDOGXzBNoO8Tuxd43cdbYowgGquWNJbLWtLTavzGh
        HH8+JFPYc/sS34Cw==
From:   "tip-bot2 for Zhouyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] preempt/dynamic: Fix typo in macro conditional statement
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210410073523.5493-1-zhouzhouyi@gmail.com>
References: <20210410073523.5493-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Message-ID: <161891524495.29796.16697487389176619561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0c89d87d1d43d9fa268d1dc489518564d58bf497
Gitweb:        https://git.kernel.org/tip/0c89d87d1d43d9fa268d1dc489518564d58bf497
Author:        Zhouyi Zhou <zhouzhouyi@gmail.com>
AuthorDate:    Sat, 10 Apr 2021 15:35:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:02:57 +02:00

preempt/dynamic: Fix typo in macro conditional statement

Commit 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched()
static call") tried to provide irqentry_exit_cond_resched() static call
in irqentry_exit, but has a typo in macro conditional statement.

Fixes: 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched() static call")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210410073523.5493-1-zhouzhouyi@gmail.com
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8442e5c..2003d69 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -422,7 +422,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMT_DYNAMIC
+#ifdef CONFIG_PREEMPT_DYNAMIC
 			static_call(irqentry_exit_cond_resched)();
 #else
 			irqentry_exit_cond_resched();
