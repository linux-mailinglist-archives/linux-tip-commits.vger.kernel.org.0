Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5E3B83BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhF3Nus (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbhF3NuS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:18 -0400
Date:   Wed, 30 Jun 2021 13:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pT3jcPoXSkgaK9gj1sGZmCVZ61S+iLjp3MF/noAVhN0=;
        b=tdTLDGQqZXbHnQIzUjhn3FZNp5gpk5xO4bcn64GDk0Gat7UTKERpJS6wHS1eAwH4UNcn/G
        td8XbNS/UezOV+CSYzIgDKWAe7Z8s11RhTG+AO0RP3YsTrZDuH0P0rJaiNoz2RRBte9Ez3
        lkqWwmDjfwAxEXhgxxEAgfxkZowRcalAWQSzX077wrK8aCayQ7N6HBXLTP6JUPuAfoTYha
        9pfefwmLAT/C7PGoZ6wzz8+pIRHlD2LBGHC5bwBpsQwP92CnQLFxOxsFUa2jpgLVwpZlwI
        Y8q+RBMb5UJziLa9FGyDzbpK+VjGS8sRGis6+XUKCXTOb2sCCidx6IQRIwoIwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pT3jcPoXSkgaK9gj1sGZmCVZ61S+iLjp3MF/noAVhN0=;
        b=4gjLqbeVlVfcasMhjU1eqpvJiAk7kWEZeLR7UEyFWKMWCOJoSKW4OV4NSbWYHnwAoALYTs
        vHKydsagXhKCL+DQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Abstract read-lock-held checks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086717.395.14743974037116101510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a5c095e0e9b6fedcffd0907c84f77751128e2a34
Gitweb:        https://git.kernel.org/tip/a5c095e0e9b6fedcffd0907c84f77751128e2a34
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 13 Mar 2021 20:05:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

rcutorture: Abstract read-lock-held checks

This commit adds a (*readlock_held)() function pointer to the
rcu_torture_ops structure in order to make the rcu_torture_one_read()
function's rcu_dereference_check() lockdep expression more appropriate
for a given run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 29d2f4c..bf488f9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -331,6 +331,7 @@ struct rcu_torture_ops {
 	void (*read_delay)(struct torture_random_state *rrsp,
 			   struct rt_read_seg *rtrsp);
 	void (*readunlock)(int idx);
+	int (*readlock_held)(void);
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -359,6 +360,11 @@ static struct rcu_torture_ops *cur_ops;
  * Definitions for rcu torture testing.
  */
 
+static int torture_readlock_not_held(void)
+{
+	return rcu_read_lock_bh_held() || rcu_read_lock_sched_held();
+}
+
 static int rcu_torture_read_lock(void) __acquires(RCU)
 {
 	rcu_read_lock();
@@ -488,6 +494,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= rcu_torture_read_unlock,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_torture_deferred_free,
@@ -540,6 +547,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_busted_torture_deferred_free,
 	.sync		= synchronize_rcu_busted,
@@ -589,6 +597,11 @@ static void srcu_torture_read_unlock(int idx) __releases(srcu_ctlp)
 	srcu_read_unlock(srcu_ctlp, idx);
 }
 
+static int torture_srcu_read_lock_held(void)
+{
+	return srcu_read_lock_held(srcu_ctlp);
+}
+
 static unsigned long srcu_torture_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
@@ -646,6 +659,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -681,6 +695,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -700,6 +715,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -787,6 +803,7 @@ static struct rcu_torture_ops trivial_ops = {
 	.readlock	= rcu_torture_read_lock_trivial,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock_trivial,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial,
 	.exp_sync	= synchronize_rcu_trivial,
@@ -850,6 +867,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.readlock	= tasks_tracing_torture_read_lock,
 	.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
 	.readunlock	= tasks_tracing_torture_read_unlock,
+	.readlock_held	= rcu_read_lock_trace_held,
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
@@ -871,11 +889,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 	return cur_ops->gp_diff(new, old);
 }
 
-static bool __maybe_unused torturing_tasks(void)
-{
-	return cur_ops == &tasks_ops || cur_ops == &tasks_rude_ops;
-}
-
 /*
  * RCU torture priority-boost testing.  Runs one real-time thread per
  * CPU for moderate bursts, repeatedly registering RCU callbacks and
@@ -1553,11 +1566,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
-				  rcu_read_lock_bh_held() ||
-				  rcu_read_lock_sched_held() ||
-				  srcu_read_lock_held(srcu_ctlp) ||
-				  rcu_read_lock_trace_held() ||
-				  torturing_tasks());
+				  !cur_ops->readlock_held || cur_ops->readlock_held());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
 		rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
