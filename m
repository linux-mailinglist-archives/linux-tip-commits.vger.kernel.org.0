Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8335B4F3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhDKNo1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbhDKNoH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:07 -0400
Date:   Sun, 11 Apr 2021 13:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7k4w8PBBycUrS84B3942DEhzWctx/BqZ4wnHwDa0rzE=;
        b=ua2CQaJZegZsBcdoIX73sF6VVFJJmL0qIFrDOtZyCafzgoektu/YywMPxcTS8NB7eFsg4v
        lXYoXINo40oFHfOZnLbliyZre+IpyhKNNSGNVtDuqiQh0nb2XGpIeGVANSUZ/JCAvI+vQ8
        AL6q0SUI3DvbOU5amqfRLSdQzJ5mkA5fGOtXdAmYt+VK8kx3zCAEtauLq/aSvGziTmgThU
        JhLT6uHmGOBAf2z4xRnAZ6lHO/BeJIw1uoI48ZXs6xFCQYhH9EbAaJIvdDXk8aMp/ms48L
        LtfLdGMPAB9hNgaphwLIBA7R3jLaUgPTik4xV3ttvDnWIIPX8/MBvsKAqbMdbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7k4w8PBBycUrS84B3942DEhzWctx/BqZ4wnHwDa0rzE=;
        b=qMQ12OuY6D2ipH1/swDgxnqVFwSrMXJNsVO+HOjwcu0rGCLmUxJQbI7PfBecC58HI1laar
        TafwnYbV8wcHCVDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make rcu_read_unlock_special() expedite strict
 grace periods
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861487.29796.10741759635447629780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7308e0240410d3644c9d7cc6263079a58e3effeb
Gitweb:        https://git.kernel.org/tip/7308e0240410d3644c9d7cc6263079a58e3effeb
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 13:57:16 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:21:41 -08:00

rcu: Make rcu_read_unlock_special() expedite strict grace periods

In kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y, every grace
period is an expedited grace period.  However, rcu_read_unlock_special()
does not treat them that way, instead allowing the deferred quiescent
state to be reported whenever.  This commit therefore adds a check of
this Kconfig option that causes rcu_read_unlock_special() to treat all
grace periods as expedited for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e17cb23..a21c41c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -615,6 +615,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
+			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
