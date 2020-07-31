Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A382342B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgGaJZ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:25:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbgGaJXg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:36 -0400
Date:   Fri, 31 Jul 2020 09:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EBZ5tyGF3fuDAZp/6Dg8af5g/KWzYrKCZk6if9P5PjM=;
        b=x/JeTO/LdF6t4eWTwQ5f4ba3slXitiR32wGnSvDz7Y/OT91EGuuBicZgNRnf2X36ydvY8z
        d4KlJvSw2ErjmpwmKjv1e/HlR5anOFugmjHPGw+GgdYI/9h2Q/rSqT/w6js68Yn6QEHp9L
        +smAtEaAu1oy37YRQ8r395MFOXYjSZlwXFaOMj0Pmo5GO/V0GnLAuNnbkbKh4Be3rY0Zp7
        c3VIuoorLkMWquBFLLML45kNbw3Ntw0nlpokM1ro6ZKhVyg7rCNxuMOfw71yB/y7jvWs7D
        nT2MoycZ68Yw2UVFHvu7QBM2D/uUEdn42zJZBK2yL7RL5K2zmui3ELULJr1wPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EBZ5tyGF3fuDAZp/6Dg8af5g/KWzYrKCZk6if9P5PjM=;
        b=aXmxquL3sDoMQywsblbohsgqNUunA0UMeEAbXx3SPcTzsutuiJQGJMiHQD4jGUoeUL+feC
        zvi9rDuSTFhG8/AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Expedited grace-period sleeps to idle priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741465.4006.9802306169433633247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     68c2f27e01f61760e6ae76fff9682e1ffe9bacb6
Gitweb:        https://git.kernel.org/tip/68c2f27e01f61760e6ae76fff9682e1ffe9bacb6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 May 2020 16:38:29 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: Expedited grace-period sleeps to idle priority

This commit converts the schedule_timeout_uninterruptible() call used
by RCU's expedited grace-period processing to schedule_timeout_idle().
This conversion avoids polluting the load-average with RCU-related
sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 72952ed..1888c0e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -403,7 +403,7 @@ retry_ipi:
 			/* Online, so delay for a bit and try again. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("selectofl"));
-			schedule_timeout_uninterruptible(1);
+			schedule_timeout_idle(1);
 			goto retry_ipi;
 		}
 		/* CPU really is offline, so we must report its QS. */
