Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1228825C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbgJIGgc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732072AbgJIGfp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:45 -0400
Date:   Fri, 09 Oct 2020 06:35:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ITg+dG7tl+GjY5lV5WKsORS1RXlwXv8V2CL4q3hnLck=;
        b=fK0UB8xfqvxO8B6TYYfJ6+Tz20akSsknCFlGgjCXr6taiIRvFBYRIW3UD2wWIiQZUpGDeN
        HP9t3wkU3okRh/t4YzLBTYJAWDbkd3ydV+KaFGJ0BNY4OUTVcss0A0IbKSq7kI1J05XcV1
        JOmsQdtcbCNxfvy6ykOKmvJN/S0rM0aiwhGDsg7M/4uLy/6oUMjS1ibE1ButJ4OnjEcZev
        x6ewub3qvs687MoeDuu2pU53t9nlOPHtr8peuzzEmYKEUS4T7dTBIhUEGhPX0+QcUvuOgl
        4z8A749QN4kRfJ07k5wXweWATvK4OPRLqISkjhrdZjbbKudd3UY50EAZY5jTJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ITg+dG7tl+GjY5lV5WKsORS1RXlwXv8V2CL4q3hnLck=;
        b=Yn+jGSTG03xQ2C+tlNu19CkW+xk5/lsge/Izrt3A9ABy1vWowSmYtke6HCtle++o1qTQXV
        38Zt8IdNo/WaCtAg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/trace: Use gp_seq_req in acceleration's
 rcu_grace_period tracepoint
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534236.7002.14439556240682068228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a7886e899fd8334a03d37e66ad10295d175725ea
Gitweb:        https://git.kernel.org/tip/a7886e899fd8334a03d37e66ad10295d175725ea
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 18 Jun 2020 21:36:40 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:04 -07:00

rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period tracepoint

During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
the value used for acceleration - it is the value of gp_seq at which it
is safe the execute all callbacks in the callback list.

The rdp's gp_seq is not very useful for this scenario. Make
rcu_grace_period report the gp_seq_req instead as it allows one to
reason about how the acceleration works.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eb36779..8969120 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1483,9 +1483,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+
 	return ret;
 }
 
