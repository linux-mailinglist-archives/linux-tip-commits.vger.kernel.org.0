Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC7288254
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbgJIGgQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732077AbgJIGfq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:46 -0400
Date:   Fri, 09 Oct 2020 06:35:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w2Txudd0p3x5QADUruorODyrkr2nSKA+MOFASu3jT0Q=;
        b=Uc5PqrUWwbwykDdxNUb7ekCdUlXdOAqoPE4sx1g6xaAbhfw5lHzEKJ3csl5YiOlRQPR25e
        f/BCBCZmIHgsgEH0ZsC5/d780OZk8KMCEnNFef3CTDRYN6zooAgbkbHJfMH5FiLFr6hHP+
        zQ+W+8TPDk+0PHtO8g1nGlBm1bHg+8Ts5C28LDlyHzl+gNpCDHtcGrCl5k13mLeMBONYBn
        +CwkKd15EL4oo894utyS+GrBsJB4d66mycwOh7VLWzUQOrs8DmImgKqhZDLKowibdHsAT0
        mtxaCdg3el1+EeOvSnWExJzYvq1L5aHdPAs1A2qPadXKfemgoW5EBwJHaMjC2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w2Txudd0p3x5QADUruorODyrkr2nSKA+MOFASu3jT0Q=;
        b=dMvClm/SyWwVlKVEC/AI0UMUwDCxZKeHWV8SaT7AxAE4Ai1fSW2zcJoKl+7fYiNy7IwHdb
        49FHublC6P/wMjBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Initialize at declaration time in rcu_exp_handler()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534349.7002.11231812841183178094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7487ea07dfa9bd782a13469cab18973ea0ab8c57
Gitweb:        https://git.kernel.org/tip/7487ea07dfa9bd782a13469cab18973ea0ab8c57
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 18 Jun 2020 09:51:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:03 -07:00

rcu: Initialize at declaration time in rcu_exp_handler()

This commit moves the initialization of the CONFIG_PREEMPT=n version of
the rcu_exp_handler() function's rdp and rnp local variables into their
respective declarations to save a couple lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1888c0e..8760b6e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -732,11 +732,9 @@ static void rcu_exp_need_qs(void)
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
 static void rcu_exp_handler(void *unused)
 {
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_node *rnp = rdp->mynode;
 
-	rdp = this_cpu_ptr(&rcu_data);
-	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
