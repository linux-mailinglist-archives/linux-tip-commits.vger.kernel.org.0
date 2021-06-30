Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306E93B8396
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhF3NuK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhF3Nt7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:59 -0400
Date:   Wed, 30 Jun 2021 13:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nVX/0WPKk2ivgyKtGoSwAEj04COmGj5kweEDgnoScpM=;
        b=fqCbxlje+RFvGIeZk88ui3SZxX04NSHl20gbKb45+mzGXhPZaheFiMeKqVjoLI7QZqMCah
        pcyD0fv/LI0OTJlLhTlu2pP/Pw/JD8kyNuuKJo6ZW90Y/BbDSNwUaQ3Z3Q3h7GGPcFnzPR
        2+akoA+5PloctlytbVLikUVU/V+zc3ihtUtvJginscq1A+SVoBMo7wMlscMYeimnFCGR+Q
        hN/Sc0cWVd1gA485z4g6ZGy9talWAxDKIjRv8QL5OMK8APcavVcmkARYk3g8p5qKd9P3mD
        R4nPOqbuDDEA696UBMbLaFbjkAMBStzNGcmawyQ0f5JZQEf1KQ8+Uq0dBkJnKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nVX/0WPKk2ivgyKtGoSwAEj04COmGj5kweEDgnoScpM=;
        b=pxhc/CDb6/uKgh7O2HWg7ARiOnWSqTyilKi8ED/kDHS9drkjnuqk4/+i0j4J89yT9Xq8vW
        JcF6riktB8NZhIDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Delete bypass_timer upon nocb_gp wakeup
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084888.395.11826643816926939100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3b2348e2fdf403b25a317b394db605257f321966
Gitweb:        https://git.kernel.org/tip/3b2348e2fdf403b25a317b394db605257f321966
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:08 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Delete bypass_timer upon nocb_gp wakeup

A NOCB-gp wake p can safely delete the ->nocb_bypass_timer because
nocb_gp_wait() will recheck again the bypass state and rearm the bypass
timer if necessary.  This commit therefore deletes this timer.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a667551..4253a0e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1701,6 +1701,8 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		del_timer(&rdp_gp->nocb_timer);
 	}
 
+	del_timer(&rdp_gp->nocb_bypass_timer);
+
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
