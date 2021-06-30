Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26A93B839C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhF3NuR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhF3NuA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64398C061766;
        Wed, 30 Jun 2021 06:47:31 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Si5bK9QV9107uYBkgUEQnbEMv02+6F4/oa5JL3AyiNg=;
        b=UzfYYOLxHHo4guG72lv+KChbq/K3LNYxKBTMkV0Z6GYs2nVo0gJbW9WWmsfzx8A9jXR7TM
        2ikJOMPryh16h1tptx6G9tZvoaQebRJSDfjfiB1TUqRDYjK8akSyC1ADmGjR2DmFzBZTJl
        qa1R5g/A7SZZMY8U8+pYOL1NGfQjX1Gc7jtaokaXMh+DP88rvBm6pLXr0TrV+JU274InjC
        aR0OoIij1sTAnbteI0wW5sl7h0EVfiwjTCSf8dHK/RkIZM+PzLkT5ji03H0/UQJm/00IP9
        MMtmkcsGQcD/VuA/OBRqtA4s0/JXz9ojRP3irgPcNQrVeF8OL5ryqQ0/vhxNmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Si5bK9QV9107uYBkgUEQnbEMv02+6F4/oa5JL3AyiNg=;
        b=nwve69rZOgVTP+aeBb3nrYJ305jFVHy5K8vAOi7rm3s5bfMs1YlcbSJzfbCO1+13NrV5Z0
        o5sIQL5KIHxldMAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084941.395.12604560475089258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b6e2c4ed35c33d7e55197aa26d99645a690ca467
Gitweb:        https://git.kernel.org/tip/b6e2c4ed35c33d7e55197aa26d99645a690ca467
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:07 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup

When waking up in nocb_gp_wait(), there is no need to keep the nocb_timer
around because this function will traverse the whole rdp list. Any
update performed before the timer was armed will now be visible after
the ->nocb_gp_lock acquire.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 015adec..a667551 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2211,6 +2211,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
 		if (bypass)
 			del_timer(&my_rdp->nocb_bypass_timer);
+		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+			del_timer(&my_rdp->nocb_timer);
+		}
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
