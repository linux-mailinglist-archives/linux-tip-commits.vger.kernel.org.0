Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7E0288271
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgJIGhK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbgJIGfi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D12C0613D8;
        Thu,  8 Oct 2020 23:35:37 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sHh1RFuK7JSSsCBfQMh+rbtO1awZY6pntNvZJuoLYAE=;
        b=PGP11oeaPYKdrTSCIqRcEm69vCcgP5I/pt1zjSXVQEwsh6l3k/T4lh9BMshRTYCSxi1HQQ
        kDR3VgLD/Y+5o6NqSgVkSpMqfa+ScvXgbptzfnTFjYpPZsQ4k3TEvKEUeuSsJHIpqJUJhx
        Xph5C+Ou/r0YZzkNOfOYh7N2KjDUiTx/56XWAANfE5pOrwle7NKMqjYdbdh2GyNVYPFYWb
        PvRtsasCW8C9YYdEpM1XjVSJFjD1cXJwBH71IajoPS8X6bf0yueDko7g/a5UqXvYLKeWe2
        Iphdu1XdJ3KZbiFEgDc6NfQgriQapcB3DrSQO1aa6a5PEw9nkCK0acZTLfu26g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sHh1RFuK7JSSsCBfQMh+rbtO1awZY6pntNvZJuoLYAE=;
        b=CH4D9/JzksgKIKm5keRk8wfVaHGksn5x1t2N0B4ayuhL7S9lrq3pRswkUBh14WsH0fxqB9
        M63T6xEoSCfophDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Add a warning for non-GP kthread running GP code
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533566.7002.13927077796544290635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4569c5ee95d5695bfd794ae968c2d59b3e69129a
Gitweb:        https://git.kernel.org/tip/4569c5ee95d5695bfd794ae968c2d59b3e69129a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Aug 2020 10:35:16 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:37:54 -07:00

rcu/nocb: Add a warning for non-GP kthread running GP code

This commit increases RCU's ability to defend itself by emitting a warning
if one of the nocb CB kthreads invokes the GP kthread's wait function.
This warning augments a similar check that is carried out at the end
of rcutorture testing and when RCU CPU stall warnings are emitted.
The problem with those checks is that the miscreants have long since
departed and disposed of any and all evidence.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4d63ee3..cb1e8c8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1926,6 +1926,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * nearest grace period (if any) to wait for next.  The CB kthreads
 	 * and the global grace-period kthread are awakened if needed.
 	 */
+	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
