Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8542E2D8FF3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgLMTCb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgLMTCI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:08 -0500
Date:   Sun, 13 Dec 2020 19:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zmbmRk4ZszZ1QrQtkgSEJadskh5ZiIzN4efURuXYneA=;
        b=KEJ0+TdcOMCHV0gFasJJkTYIGoUxmUiYizesXjeVTdnQHVcmAB9WyCH5QgGZe3SKC31D1F
        T4NOBl4Gp4uwX8dy1LDH8UXRLFP+AiapT5dfXptI5Yb2MPbBrRd9XEusXtd1wq0M5iY5vD
        1NYX31oLk9SwU4ODOGn+1G36C9FpAZfFCxO0cHpTpZF3lKRIrdMFvrroju3Y9YHA+fD0/n
        koX01BHQdxgVpF+Vi78m7B5jn3amgjVihqfxaqFJTLZ0GaF+ri6eDDxMZDVVKHyx3Px1sw
        tigPyjl05CCnCtSb+6mRkZFOO7+qRsGKGPvdsEYsm4mIMmwYMn4BYeYesMXgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zmbmRk4ZszZ1QrQtkgSEJadskh5ZiIzN4efURuXYneA=;
        b=wBRR4HhjgmZiu3Qy0YHLT4K4O/mIeqOmlQRmrjU+Sna4nG5vf/3pMO+ScKIb1G/vZBe+52
        FZu+IF1HgRDAWnCg==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sched: Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607476.3364.15470212499968970763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9f14cb030d987ae5e201e88cd345c6d772bcce51
Gitweb:        https://git.kernel.org/tip/9f14cb030d987ae5e201e88cd345c6d772bcce51
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:09:59 -08:00

sched: Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP

Currently, variables used only within lockdep expressions are flagged as
unused, requiring that these variables' declarations be decorated with
either #ifdef or __maybe_unused.  This results in ugly code.  This commit
therefore causes the lockdep_tasklist_lock_is_held() function to be
visible even when lockdep is not enabled, thus removing the need for
these decorations.  This approach further relies on dead-code elimination
to remove any references to functions or variables that are not available
in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched/task.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 85fb2f3..c0f71f2 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -47,9 +47,7 @@ extern spinlock_t mmlist_lock;
 extern union thread_union init_thread_union;
 extern struct task_struct init_task;
 
-#ifdef CONFIG_PROVE_RCU
 extern int lockdep_tasklist_lock_is_held(void);
-#endif /* #ifdef CONFIG_PROVE_RCU */
 
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
