Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F513B840E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhF3NwK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhF3Nut (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:49 -0400
Date:   Wed, 30 Jun 2021 13:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DJCC/VRCAUwmf1mTlnAMJYeUlhnaz9sRUFwdaxtc4yA=;
        b=rkRWAtW3CHYbrcwtcrpAEoCNF5B2gCTZV6RCiPs5leV99SV5DK/VORWRU2rH6bfF41vwy1
        +Tiy1MaoY5Cy2kh4IHR+5q/X7PdCmRjDB7zNrHrYLKSTVnWg2Lj9IqvNOKtth0ZjyJZZ/C
        KVV89lgY08dnkLBZ6wKWb2Gv/RjmBYx1qg3gFEbHo92rn2VfQEjndWVaEQ446C2V6SKrxE
        wljOPQPdNiqifeiIASKyVw5NAoNqYUofi4NunB/4PhK2L48YkfjU2I0IGYwGdxCjk2jms8
        AdfsIn5s7/M5JPFc6FlJgMaJA/3WBJn0uVZm+GPU+7R1eeFGCsm0KLVvKzvMNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DJCC/VRCAUwmf1mTlnAMJYeUlhnaz9sRUFwdaxtc4yA=;
        b=807gPWA99vVfTPiiNTcHvclOnxgCcX/glRZMNQgSWVmAYz3k6n9AsmoR1ZY/z89YuVOrvl
        mMHbmn8lhP6R1RDw==
From:   "tip-bot2 for Rolf Eike Beer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix typo in comment: kthead -> kthread
Cc:     Rolf Eike Beer <eb@emlix.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088067.395.13294559967881399882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4c9c3809ae2ecfcece9acb3f51427e617d21fafb
Gitweb:        https://git.kernel.org/tip/4c9c3809ae2ecfcece9acb3f51427e617d21fafb
Author:        Rolf Eike Beer <eb@emlix.com>
AuthorDate:    Wed, 17 Mar 2021 10:24:51 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:45:58 -07:00

rcu: Fix typo in comment: kthead -> kthread

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 mm/oom_kill.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b..2cbe8f8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1940,7 +1940,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthead if needed, either due to it
+ * Awaken the no-CBs grace-period kthread if needed, either due to it
  * legitimately being asleep or due to overload conditions.
  *
  * If warranted, also wake up the kthread servicing this CPUs queues.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5..54527de 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -922,7 +922,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			continue;
 		}
 		/*
-		 * No kthead_use_mm() user needs to read from the userspace so
+		 * No kthread_use_mm() user needs to read from the userspace so
 		 * we are ok to reap it.
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
