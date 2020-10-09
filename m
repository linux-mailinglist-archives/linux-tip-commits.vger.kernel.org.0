Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4A28828F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgJIGh6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbgJIGfb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD1C0613D5;
        Thu,  8 Oct 2020 23:35:31 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=876oewZVm8/wrFnG6gCaxU7GuYYeDkrAigVuZbkvwD0=;
        b=R0Jn1QpWEjSvE23kcxmnFkzKyamFPklJfQvgV6WsIxiWAjDz3TC20XOC2tPQwEqAMlCVVz
        WLuS9IcenJ5tM5JO87w8MOi2RQLIlh77zVkXSQN1dZJBs64O2fka+9J5+ZwJI6l/6M3L2D
        GQVfme/AfHi8l4zr8czfBh2YcRxS4+01NkBmWeGrh03tgw3UTKs/3F6Aj1GmFMXoyYfszm
        LDzlDeMJlWeJKZgrSKEIfYSrmVxkjeNwMM7MRz4DsGhBZSNyzuj1ctD2enn4ukDXRTPrmo
        ebEiR2eOZ0ibsXI0h0XSml1yj/FCaVk+7zCQgic21GmhSIY+OcG+zQoWeFj7FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=876oewZVm8/wrFnG6gCaxU7GuYYeDkrAigVuZbkvwD0=;
        b=Q8foGM+fYZrGrYWV2TODwWBvt2CSR6Xxojl5mUHgr//p7Pl5SpWeaD3WLtWw1r3OJ9OXis
        GcCtc8kO/VSfzYAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add smp_call_function() memory-ordering checks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532954.7002.8445416359793328131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     34e8c4837adb579962e528a4f7dd1f75cb120be4
Gitweb:        https://git.kernel.org/tip/34e8c4837adb579962e528a4f7dd1f75cb120be4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Jul 2020 13:49:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:34 -07:00

scftorture: Add smp_call_function() memory-ordering checks

This commit adds checks for memory misordering across calls to and
returns from smp_call_function() in the case where the caller waits.
Misordering results in a splat.

Note that in contrast to smp_call_function_single(), this code does not
test memory ordering into the handler in the no-wait case because none
of the handlers would be able to free the scf_check structure without
introducing heavy synchronization to work out which was last.

[ paulmck: s/GFP_KERNEL/GFP_ATOMIC/ per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 3519ad1..0d7299d 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -297,11 +297,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		cpus_read_lock();
 	else
 		preempt_disable();
-	switch (scfsp->scfs_prim) {
-	case SCF_PRIM_SINGLE:
+	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
 		if (WARN_ON_ONCE(!scfcp))
 			atomic_inc(&n_alloc_errs);
+	}
+	switch (scfsp->scfs_prim) {
+	case SCF_PRIM_SINGLE:
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
 			scfp->n_single_wait++;
@@ -328,11 +330,6 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 		break;
 	case SCF_PRIM_MANY:
-		if (scfsp->scfs_wait) {
-			scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-			if (WARN_ON_ONCE(!scfcp))
-				atomic_inc(&n_alloc_errs);
-		}
 		if (scfsp->scfs_wait)
 			scfp->n_many_wait++;
 		else
@@ -356,7 +353,19 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_all_wait++;
 		else
 			scfp->n_all++;
-		smp_call_function(scf_handler, NULL, scfsp->scfs_wait);
+		if (scfcp) {
+			scfcp->scfc_cpu = -1;
+			scfcp->scfc_wait = true;
+			scfcp->scfc_out = false;
+			scfcp->scfc_in = true;
+		}
+		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
+		if (scfcp) {
+			if (WARN_ON_ONCE(!scfcp->scfc_out))
+				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
+			else
+				kfree(scfcp);
+		}
 		break;
 	}
 	if (use_cpus_read_lock)
