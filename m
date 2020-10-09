Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB8288261
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgJIGgj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgJIGfn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:43 -0400
Date:   Fri, 09 Oct 2020 06:35:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e23ZJ22qXArxcta0QGAEs1RNrsrSjjP8CMkmJNsG7wk=;
        b=Bu2NmsySFNFtWffJ4Cg/ZJQusolWXeycOAVJgnavcGyWWIxPLaSt3URxSTPDmIF1V+VMcO
        LBMnSieZDIoE0zoBsZCsqw9dn1ErDMBDD4kbpWy6TtaF6TQJwED1b24TF2wXBXxsF9bhrq
        kY8X9FoR9UzUmnAfsk/rhB7Rs608hwQv4iVbPz5EN0N2r7/EpcMWg18JwiOa7Q71vVLNB6
        LONjKbX4xV5uc1AiKRJw2HqM9aa0W+XcRmREkEYl+TZwievHRACMFqIdrk8u3n6Y4i0XDD
        bBrOnW/lk2l3Ur3S0MkO7OR72znqYb6bARtorzAAw+3MMNSR9ycFFfpsoksjxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e23ZJ22qXArxcta0QGAEs1RNrsrSjjP8CMkmJNsG7wk=;
        b=da53S3W1dLV/Cry0b8a0Mf5g8Z5uHRuIO1lxw7lmAGXi76SbMn2o2Q3S4/3Xw3ZEXz+auZ
        ZNXD68PmGJh9k/Ag==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534078.7002.3183727303718435811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9b1ce0acb5e65e9ea1e6b322562d072f9f7d1f6e
Gitweb:        https://git.kernel.org/tip/9b1ce0acb5e65e9ea1e6b322562d072f9f7d1f6e
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Mon, 22 Jun 2020 23:37:03 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:06 -07:00

rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()

Originally, the call to rcu_preempt_blocked_readers_cgp() from
force_qs_rnp() had to be conditioned on CONFIG_PREEMPT_RCU=y, as in
commit a77da14ce9af ("rcu: Yet another fix for preemption and CPU
hotplug").  However, there is now a CONFIG_PREEMPT_RCU=n definition of
rcu_preempt_blocked_readers_cgp() that unconditionally returns zero, so
invoking it is now safe.  In addition, the CONFIG_PREEMPT_RCU=n definition
of rcu_initiate_boost() simply releases the rcu_node structure's ->lock,
which is what happens when the "if" condition evaluates to false.

This commit therefore drops the IS_ENABLED(CONFIG_PREEMPT_RCU) check,
so that rcu_initiate_boost() is called only in CONFIG_PREEMPT_RCU=y
kernels when there are readers blocking the current grace period.
This does not change the behavior, but reduces code-reader confusion by
eliminating non-CONFIG_PREEMPT_RCU=y calls to rcu_initiate_boost().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4770d77..acc926f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2533,8 +2533,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
-			    rcu_preempt_blocked_readers_cgp(rnp)) {
+			if (rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
 				 * are all zero.  But we might need to
