Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7728828A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgJIGhv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbgJIGfd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:33 -0400
Date:   Fri, 09 Oct 2020 06:35:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IqZBUmMJdU0+pd6ijht4njDqLqHu9vvxoTGK3PUEjjM=;
        b=gVKNQOHntzvJXrlxHwBk2+U+0PxBtAW8PmBruD9EbndB0eEocVec1FiLfsgAuimiakHMnj
        dCXRDFPsvaAEkLGjU4M3bhb7n1I6D4UW7L76CAEf/Beq7arZho7Aq64etKJ8jWruSaoMGr
        1FxeWFzCYvM6/uyMDp9T/M3p/cgLBUSfKofmAM6CLkRx5ne+1M+sD0dU1cCCJKf9uTF7va
        n8OlNlyJUQZiMf1luex2ltkY6FUD174u57rMRuu+xE/wzxkqIVcfdNk0usNSsHptOxQy28
        nfBVjcgQCtzbccheBH/Prp8q+wqgLd1grKq7+i/oxFVZKnP3oYWQ1DX4XyodAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IqZBUmMJdU0+pd6ijht4njDqLqHu9vvxoTGK3PUEjjM=;
        b=3Bq0kHVGg/EkPysYW6LPHb5w4mP/E1zF+LG8k9islWSH5OMRIfYGfqV22VN3M2BbrGeLdf
        s8VeUq2Jpye1g4Ag==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add smp_call_function_single()
 memory-ordering checks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533052.7002.8386450735778016248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b93e21a51e1c8ed3816da888d34f88193ad1b917
Gitweb:        https://git.kernel.org/tip/b93e21a51e1c8ed3816da888d34f88193ad1b917
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Jun 2020 20:49:50 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:33 -07:00

scftorture: Add smp_call_function_single() memory-ordering checks

This commit adds checks for memory misordering across calls to
smp_call_function_single() and also across returns in the case where
the caller waits.  Misordering results in a splat.

[ paulmck: s/GFP_KERNEL/GFP_ATOMIC/ per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 56 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 09a6242..9b42271 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -117,9 +117,20 @@ static struct scf_selector scf_sel_array[SCF_NPRIMS];
 static int scf_sel_array_len;
 static unsigned long scf_sel_totweight;
 
+// Communicate between caller and handler.
+struct scf_check {
+	bool scfc_in;
+	bool scfc_out;
+	int scfc_cpu; // -1 for not _single().
+	bool scfc_wait;
+};
+
 // Use to wait for all threads to start.
 static atomic_t n_started;
 static atomic_t n_errs;
+static atomic_t n_mb_in_errs;
+static atomic_t n_mb_out_errs;
+static atomic_t n_alloc_errs;
 static bool scfdone;
 
 DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
@@ -222,24 +233,27 @@ static struct scf_selector *scf_sel_rand(struct torture_random_state *trsp)
 // Update statistics and occasionally burn up mass quantities of CPU time,
 // if told to do so via scftorture.longwait.  Otherwise, occasionally burn
 // a little bit.
-static void scf_handler(void *unused)
+static void scf_handler(void *scfc_in)
 {
 	int i;
 	int j;
 	unsigned long r = torture_random(this_cpu_ptr(&scf_torture_rand));
+	struct scf_check *scfcp = scfc_in;
 
+	if (likely(scfcp) && WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
+		atomic_inc(&n_mb_in_errs);
 	this_cpu_inc(scf_invoked_count);
 	if (longwait <= 0) {
 		if (!(r & 0xffc0))
 			udelay(r & 0x3f);
-		return;
+		goto out;
 	}
 	if (r & 0xfff)
-		return;
+		goto out;
 	r = (r >> 12);
 	if (longwait <= 0) {
 		udelay((r & 0xff) + 1);
-		return;
+		goto out;
 	}
 	r = r % longwait + 1;
 	for (i = 0; i < r; i++) {
@@ -248,14 +262,24 @@ static void scf_handler(void *unused)
 			cpu_relax();
 		}
 	}
+out:
+	if (unlikely(!scfcp))
+		return;
+	if (scfcp->scfc_wait)
+		WRITE_ONCE(scfcp->scfc_out, true);
+	else
+		kfree(scfcp);
 }
 
 // As above, but check for correct CPU.
-static void scf_handler_1(void *me)
+static void scf_handler_1(void *scfc_in)
 {
-	if (WARN_ON_ONCE(smp_processor_id() != (uintptr_t)me))
+	struct scf_check *scfcp = scfc_in;
+
+	if (likely(scfcp) && WARN_ONCE(smp_processor_id() != scfcp->scfc_cpu, "%s: Wanted CPU %d got CPU %d\n", __func__, scfcp->scfc_cpu, smp_processor_id())) {
 		atomic_inc(&n_errs);
-	scf_handler(NULL);
+	}
+	scf_handler(scfcp);
 }
 
 // Randomly do an smp_call_function*() invocation.
@@ -263,6 +287,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 {
 	uintptr_t cpu;
 	int ret;
+	struct scf_check *scfcp = NULL;
 	struct scf_selector *scfsp = scf_sel_rand(trsp);
 
 	if (use_cpus_read_lock)
@@ -271,17 +296,32 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	switch (scfsp->scfs_prim) {
 	case SCF_PRIM_SINGLE:
+		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
+		if (WARN_ON_ONCE(!scfcp))
+			atomic_inc(&n_alloc_errs);
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
 			scfp->n_single_wait++;
 		else
 			scfp->n_single++;
-		ret = smp_call_function_single(cpu, scf_handler_1, (void *)cpu, scfsp->scfs_wait);
+		if (scfcp) {
+			scfcp->scfc_cpu = cpu;
+			scfcp->scfc_wait = scfsp->scfs_wait;
+			scfcp->scfc_out = false;
+			scfcp->scfc_in = true;
+		}
+		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
 		if (ret) {
 			if (scfsp->scfs_wait)
 				scfp->n_single_wait_ofl++;
 			else
 				scfp->n_single_ofl++;
+			kfree(scfcp);
+		} else if (scfcp && scfsp->scfs_wait) {
+			if (WARN_ON_ONCE(!scfcp->scfc_out))
+				atomic_inc(&n_mb_out_errs); // Leak rather than trash!
+			else
+				kfree(scfcp);
 		}
 		break;
 	case SCF_PRIM_MANY:
