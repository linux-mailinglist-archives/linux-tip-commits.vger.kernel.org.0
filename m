Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73D3B839F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhF3NuS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhF3NuB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE4C0617A6;
        Wed, 30 Jun 2021 06:47:31 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OiJwSCQn2D2oUF/cdCVH0EZ9r/Wg5Bhk4npRiGT6x0g=;
        b=miDweKWlzSzc5p/XA9JswNr8UYGqXrHyJ5OQ9AmghQ9UwQzki9fVN4j0FpTMgBtRaZKUom
        qUkoAI28Tdh0lhWdmU00UDbP8EsQ68i9Gyo0W/HM8z6KptdAtfWSn0ZsO/39mh9q/pC8jw
        mVHPkEk+Z0XfDtGBPoXroAOdX+gowCqtTpaiDDvY1z7K/HvnvGzWetchLQJ8IQWX0X4+qy
        l1I6FwsRtbf2CMvkr/tkg1lvVkXPETGSimAh3LI9eyi05vvY3GB+zhDmLh97xNR2TzQcQS
        ++lhu71YvqKkh0/yH66OskAfQ1m6jvYTsiRim5NKwHA8SI6S4dDBkwtf8jmqUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OiJwSCQn2D2oUF/cdCVH0EZ9r/Wg5Bhk4npRiGT6x0g=;
        b=No46Y9hl1JOhSLN1mnPoQisRVypvbroynGNr/kSzoVFoSOrgjRsFP4fDR1TXof+UjL1AW7
        upCduu+U75xNfSDg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Allow de-offloading rdp leader
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084998.395.3405266147539948669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     552cac80e65f38a0cc9022456c09efed7e88f9d6
Gitweb:        https://git.kernel.org/tip/552cac80e65f38a0cc9022456c09efed7e88f9d6
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:06 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Allow de-offloading rdp leader

The only thing that prevented an rdp leader from being de-offloaded was
the nocb_bypass_timer that used to lock the nocb_lock of the rdp leader.

If an rdp gets de-offloaded, it will subtlely ignore rcu_nocb_lock()
calls and do its job in the timer unsafely.  Worse yet:  If it gets
re-offloaded in the middle of the timer, rcu_nocb_unlock() would try to
unlock, leaving it imbalanced.

Now that the nocb_bypass_timer doesn't use the nocb_lock anymore,
de-offloading the rdp leader is now safe.  This commit therefore allows
the rdp leader to be de-offloaded.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 82e9ffb..015adec 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2489,10 +2489,6 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	if (rdp == rdp->nocb_gp_rdp) {
-		pr_info("Can't deoffload an rdp GP leader (yet)\n");
-		return -EINVAL;
-	}
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (rcu_rdp_is_offloaded(rdp)) {
