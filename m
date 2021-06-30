Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F233B8405
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhF3NwE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhF3Nuq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:46 -0400
Date:   Wed, 30 Jun 2021 13:47:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zoMZKOa/Moxgqqn+/6sn0Nzz+6avR44cy5shnSo4F4A=;
        b=l7hzfjWgSCMO5eT1Gfw9f8K0l2Lw3oGDfuvBIeGOOoxiZm99IHhEJCEYjZZQc8KoZMVihO
        vr43HtzPN1cxJI+dKTVdWGmXKkJNJVOsAWCtR1rHEYkatuxa4Vm+5SBDbrhXPgluqwVwi6
        wvFnAUhO+6jHM87R3i1cJuL1QuZ4swwRzhtQyhCGFZualZJADctleIPeww98J/k9067zA9
        q+iIRLQ4kFS0w8kUVvmby0Kb33ipuoUSBmQXa591HL1xnbtfuHfuvaK64SiLbRoRI4gspX
        g8l+8iUPGUQd69QCek17DQmiU/Vir6Cp4MolHqq+KqXKkLcNhf1w39wcf4KHkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zoMZKOa/Moxgqqn+/6sn0Nzz+6avR44cy5shnSo4F4A=;
        b=g6E2sGMxu+Nr+ElPzh9Ond6MbvQ6yGqN7UJP4bGJajxHLOR50KBYWYQrg2Q8LGLxI3uaQ8
        Ng7n47A3I2J/LLAw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Use kfree_rcu_monitor() instead of
 open-coded variant
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087804.395.14999204819611952242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7fe1da33f6bad33b79135b1df6c3476f87856928
Gitweb:        https://git.kernel.org/tip/7fe1da33f6bad33b79135b1df6c3476f87856928
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Thu, 15 Apr 2021 19:20:00 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant

Replace an open-coded version of the kfree_rcu_monitor() function body
with a call to that function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1ae5f88..d643fd8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3697,7 +3697,6 @@ static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu, freed = 0;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		int count;
@@ -3705,12 +3704,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 		count = krcp->count;
 		count += drain_page_cache(krcp);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (krcp->monitor_todo)
-			kfree_rcu_drain_unlock(krcp, flags);
-		else
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
 
 		sc->nr_to_scan -= count;
 		freed += count;
