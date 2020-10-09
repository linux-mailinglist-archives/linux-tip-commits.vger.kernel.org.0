Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17BC288293
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgJIGiG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgJIGfa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C63C0613D2;
        Thu,  8 Oct 2020 23:35:30 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1w57BxKhs6wQz/oInVwEYo75Yd6Sf1QqtysQc4UAQ3k=;
        b=mIpBDQ+w3ToT5X3C6UV8sQ7o8ccCYYL58V275wQQkSi2VuylPmKPRGLMVrNh0hxTum9N0v
        l6ellsI4ZJCnQBoCG/aDSaIL1A7HaEXZW1bAnWQWamGyckw5gmJNRz9JBjRMozNO5kQgnb
        NJ/AO9Lt2ym+FVQXH2lrI/jJ640iYTmkoI1zppwfa5YAw2dOT+Od/WZ1YIu5eQauAVMOXz
        90B6m3LnaO7GgxnCndCxOQJEtkHVnPLa5ZaE/LGEigWrIq5Xl42NgtTSv13uL0m7YuvU8i
        Lkvt+Gt5Y9G4Whp+XNUa4S7TwxSK+K8ninZ4l7smmB+921XWyaV7l9uRqK8Z+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1w57BxKhs6wQz/oInVwEYo75Yd6Sf1QqtysQc4UAQ3k=;
        b=fOpXgPQscVazM0P8/RQekr36EEuN+lZlfVy6xi/jt13SH4Rmr/T/mk/M9aEmkxe3eU09tH
        kYzXE+6dDmg1ffCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Consolidate scftorture_invoke_one()
 scf_check initialization
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532858.7002.1670791791306456488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4df55bddc1a360e94c86e227fe417ac9422cb615
Gitweb:        https://git.kernel.org/tip/4df55bddc1a360e94c86e227fe417ac9422cb615
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Jul 2020 13:58:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:35 -07:00

scftorture: Consolidate scftorture_invoke_one() scf_check initialization

This commit hoists much of the initialization of the scf_check
structure out of the switch statement, thus saving a few lines of code.
The initialization of the ->scfc_in field remains in each leg of the
switch statement in order to more heavily stress memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index f220cd3..8ab72e5 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -299,8 +299,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-		if (WARN_ON_ONCE(!scfcp))
+		if (WARN_ON_ONCE(!scfcp)) {
 			atomic_inc(&n_alloc_errs);
+		} else {
+			scfcp->scfc_cpu = -1;
+			scfcp->scfc_wait = scfsp->scfs_wait;
+			scfcp->scfc_out = false;
+		}
 	}
 	switch (scfsp->scfs_prim) {
 	case SCF_PRIM_SINGLE:
@@ -311,8 +316,6 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_single++;
 		if (scfcp) {
 			scfcp->scfc_cpu = cpu;
-			scfcp->scfc_wait = scfsp->scfs_wait;
-			scfcp->scfc_out = false;
 			scfcp->scfc_in = true;
 		}
 		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
@@ -330,12 +333,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		if (scfcp) {
-			scfcp->scfc_cpu = -1;
-			scfcp->scfc_wait = true;
-			scfcp->scfc_out = false;
+		if (scfcp)
 			scfcp->scfc_in = true;
-		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	case SCF_PRIM_ALL:
@@ -343,12 +342,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_all_wait++;
 		else
 			scfp->n_all++;
-		if (scfcp) {
-			scfcp->scfc_cpu = -1;
-			scfcp->scfc_wait = true;
-			scfcp->scfc_out = false;
+		if (scfcp)
 			scfcp->scfc_in = true;
-		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	}
