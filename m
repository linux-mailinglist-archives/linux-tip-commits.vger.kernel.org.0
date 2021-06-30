Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06143B83F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhF3NvZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhF3Nue (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:34 -0400
Date:   Wed, 30 Jun 2021 13:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WJ2rbnrZWdwUsjLKBgZHktold59pyaDd2hrLcmZrpD4=;
        b=J6HnDHIN9On1lIRIeKGKTg6McYP0p9YjnDerzPxLwxW9nJmQMGjT5epr0KiLz0Bytusmnr
        nxBG/tcvHuWon+XJYi3yFM+WiTO+5HgbeU293J76J4BFtmjczuIDUhleGzCg7ytg3agxFf
        7cqkiUeOSEuWAER0ZuBjdqhC4VPpXjys73UTkKsbvuVcLv+7om4S8gWs0s0SlkN0azg60A
        QYfmt0lqZysESI8QPpdQqyJ2Bz0qs7nwUyksJ9iii2i9Y3iGwqim+Xd7aGGp63g4KNoAsy
        f69yRB3aI1970njyXSRp3LGXDE2NEb2pJjaQd/+vITRx65wAV4JzWIozUz1+sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WJ2rbnrZWdwUsjLKBgZHktold59pyaDd2hrLcmZrpD4=;
        b=aFV+RwC584VAJTNUaGcmNYgcIUHqa0nQZU6wot9d4DqxDaiUTlUQ0CZWZG4XGWyWKYIZ9x
        MOQjwbv5Ej1jeoAA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Remove superfluous sdp->srcu_lock_count zero filling
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
Message-ID: <162506087428.395.11085466467426386302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     94df76a1971d9c61eb2c67ae10cc294b68cbd03b
Gitweb:        https://git.kernel.org/tip/94df76a1971d9c61eb2c67ae10cc294b68cbd03b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 01:47:03 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:03:34 -07:00

srcu: Remove superfluous sdp->srcu_lock_count zero filling

Because alloc_percpu() zeroes out the allocated memory, there is no need
to zero-fill newly allocated per-CPU memory.  This commit therefore removes
the loop zeroing the ->srcu_lock_count and ->srcu_unlock_count arrays
from init_srcu_struct_nodes().  This is the only use of that function's
is_static parameter, which this commit also removes.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b..3414aff 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -80,7 +80,7 @@ do {									\
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
+static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -148,14 +148,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
-		if (is_static)
-			continue;
-
-		/* Dynamically allocated, better be no srcu_read_locks()! */
-		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
-			sdp->srcu_lock_count[i] = 0;
-			sdp->srcu_unlock_count[i] = 0;
-		}
 	}
 }
 
@@ -179,7 +171,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp, is_static);
+	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
