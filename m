Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB035B4FC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhDKNog (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhDKNoL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:11 -0400
Date:   Sun, 11 Apr 2021 13:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2I8Jzajm6CxpM1DtpVQ0xJu04Azyzi3aak9s7+5qHE4=;
        b=sNbfMefCx/TpyQpHp9eJ3w7FyQhvQDa/hoAE7W3jHjWKh9/ontfQiqfaKOkMaKk1Y69uXl
        c2LIBO9DNgbOnsEn6KMEUBvu/SgM4SMevXfQAF1XP9jc1fTvjUlOTO2/AwhdnG/0t+lzPV
        Nv4qqXhl/r8Wj8w+cHFGjIFNxVaTPXY62WsWAUJadRuwu3IUhNTiXfWP9YQMFXlnUTnvDC
        uuqhn70nbecxZexHTa9MNu95Wlety3xje+WhyzJWUNu5UPuWTM2hHtw0wjgyFh3QkyGrS8
        vK26SdFj4RL3tcNkU/CK9LwsLlRb0p1/oDHlbAaFv9LYSiCqKGiEK/UmQYjQ6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2I8Jzajm6CxpM1DtpVQ0xJu04Azyzi3aak9s7+5qHE4=;
        b=iDLQQiODGjox+5YLhjgdDKi2MZ65Lq2JMx5A33E93pc40wxU+YWA8x2QG3DYYKn+YfMbis
        kk1GVye/z6Z//PDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Forbid NOCB toggling on offline CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861738.29796.13597165418686082678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     64305db2856b969a5d48e8f3a5b0d06b5594591c
Gitweb:        https://git.kernel.org/tip/64305db2856b969a5d48e8f3a5b0d06b5594591c
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 18:12:09 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:21 -08:00

rcu/nocb: Forbid NOCB toggling on offline CPUs

It makes no sense to de-offload an offline CPU because that CPU will never
invoke any remaining callbacks.  It also makes little sense to offload an
offline CPU because any pending RCU callbacks were migrated when that CPU
went offline.  Yes, it is in theory possible to use a number of tricks
to permit offloading and deoffloading offline CPUs in certain cases, but
in practice it is far better to have the simple and deterministic rule
"Toggling the offload state of an offline CPU is forbidden".

For but one example, consider that an offloaded offline CPU might have
millions of callbacks queued.  Best to just say "no".

This commit therefore forbids toggling of the offloaded state of
offline CPUs.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  3 +--
 kernel/rcu/tree_plugin.h | 57 ++++++++++++++-------------------------
 2 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03503e2..ee77858 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4086,8 +4086,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 	/*
 	 * Lock in case the CB/GP kthreads are still around handling
-	 * old callbacks (longer term we should flush all callbacks
-	 * before completing CPU offline)
+	 * old callbacks.
 	 */
 	rcu_nocb_lock(rdp);
 	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 013142d..9fd8588 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2399,23 +2399,18 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	return 0;
 }
 
-static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+static long rcu_nocb_rdp_deoffload(void *arg)
 {
+	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
 
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+
 	pr_info("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * If there are still pending work offloaded, the offline
-	 * CPU won't help much handling them.
-	 */
-	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		return -EBUSY;
-	}
 
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
@@ -2446,14 +2441,6 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	return ret;
 }
 
-static long rcu_nocb_rdp_deoffload(void *arg)
-{
-	struct rcu_data *rdp = arg;
-
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	return __rcu_nocb_rdp_deoffload(rdp);
-}
-
 int rcu_nocb_cpu_deoffload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -2466,12 +2453,14 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
-		else
-			ret = __rcu_nocb_rdp_deoffload(rdp);
-		if (!ret)
-			cpumask_clear_cpu(cpu, rcu_nocb_mask);
+			if (!ret)
+				cpumask_clear_cpu(cpu, rcu_nocb_mask);
+		} else {
+			pr_info("NOCB: Can't CB-deoffload an offline CPU\n");
+			ret = -EINVAL;
+		}
 	}
 	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
@@ -2480,12 +2469,14 @@ int rcu_nocb_cpu_deoffload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
-static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+static long rcu_nocb_rdp_offload(void *arg)
 {
+	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
 
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
 	 * For now we only support re-offload, ie: the rdp must have been
 	 * offloaded on boot first.
@@ -2525,14 +2516,6 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	return ret;
 }
 
-static long rcu_nocb_rdp_offload(void *arg)
-{
-	struct rcu_data *rdp = arg;
-
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	return __rcu_nocb_rdp_offload(rdp);
-}
-
 int rcu_nocb_cpu_offload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -2541,12 +2524,14 @@ int rcu_nocb_cpu_offload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
-		else
-			ret = __rcu_nocb_rdp_offload(rdp);
-		if (!ret)
-			cpumask_set_cpu(cpu, rcu_nocb_mask);
+			if (!ret)
+				cpumask_set_cpu(cpu, rcu_nocb_mask);
+		} else {
+			pr_info("NOCB: Can't CB-offload an offline CPU\n");
+			ret = -EINVAL;
+		}
 	}
 	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
