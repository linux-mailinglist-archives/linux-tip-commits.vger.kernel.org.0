Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7F53B8390
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhF3NuG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhF3Nt5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC32CC0617AF;
        Wed, 30 Jun 2021 06:47:28 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+59KbFtar40vLhGSKyEne5Fu30nhDlbYIAhrPWDd15s=;
        b=SiiIS3ih6QUfgLpQBJmSakNRNnVWOH1xJ55X29xl4wRw3zm/rv6wMxhfRRS+MbybBDzfVF
        IXMVaPkQXH91aLCnvhLmPoXBGth35jZJ6mkdCqlX7n04FODOkmv8VvloaPMjfPxOuPYGgb
        /JF2ey7QcerMk6mmJJQTF0lrEHdseoLPUWleVLnPlPwwGldRvFbuZ3Om5eyQy9Nomr062N
        UlKg2ZtRv//pKAr4UsqSgFkE5N4lJ7JcDj345t+IMuQSDDEmn6GIGh7rKZv+NrelbC6rIK
        BfI6u3xtCw/94sdLkDl303iqgUqMRDO1H8DfIsb55oO8sgBLZWpB2ZZGdK+rrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+59KbFtar40vLhGSKyEne5Fu30nhDlbYIAhrPWDd15s=;
        b=SpD3hcofzb0FQvyaE+IeIA4E3CLWOAJeSL+EYk1YB+Im8HmFCyR9tEgblQ3ICxo7F9J4ZZ
        ij8TgsFwpE5yWaAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Early test SRCU polling start
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084634.395.17365008224912917541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0a580fa65cfa08a40af1a0a2cf73d100863e4981
Gitweb:        https://git.kernel.org/tip/0a580fa65cfa08a40af1a0a2cf73d100863e4981
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 14 Apr 2021 15:24:13 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:12:33 -07:00

srcu: Early test SRCU polling start

Place an early call to start_poll_synchronize_srcu() before the invocation
of call_srcu() on the same srcu_struct structure.

After the later call to srcu_barrier(), the completion of the
first grace period should be visible to a subsequent invocation of
poll_state_synchronize_srcu(), and if not, warn.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b95ae86..0aa118a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -524,6 +524,7 @@ static void test_callback(struct rcu_head *r)
 }
 
 DEFINE_STATIC_SRCU(early_srcu);
+static unsigned long early_srcu_cookie;
 
 struct early_boot_kfree_rcu {
 	struct rcu_head rh;
@@ -536,8 +537,10 @@ static void early_boot_test_call_rcu(void)
 	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
-	if (IS_ENABLED(CONFIG_SRCU))
+	if (IS_ENABLED(CONFIG_SRCU)) {
+		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
 		call_srcu(&early_srcu, &shead, test_callback);
+	}
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 	if (!WARN_ON_ONCE(!rhp))
 		kfree_rcu(rhp, rh);
@@ -563,6 +566,7 @@ static int rcu_verify_early_boot_tests(void)
 		if (IS_ENABLED(CONFIG_SRCU)) {
 			early_boot_test_counter++;
 			srcu_barrier(&early_srcu);
+			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
 		}
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
