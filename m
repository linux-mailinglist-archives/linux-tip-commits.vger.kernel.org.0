Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778E228828C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgJIGh6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbgJIGfb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33163C0613D4;
        Thu,  8 Oct 2020 23:35:31 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NH7+qz70uuA7M/8J/NzK8S8LxVhvl7LNyP0PTc/zHRc=;
        b=wC4Qo28tXXtLs+Y4Wsn8Foii5xIg8ffUYyA/UXzPBX1iKHZrM7WQpCuT1/01f3XtlsMB0U
        9v1OgQnyNsmYJaF7FglgSqmJUfQ2i/aWdSpefyZOCWlNTFwlYNgufLVGUQIUohfAd0s8V+
        0jtaA1/3kmy1pP3fWNjJ4+B8TKclZFvawW4jN6WyPFmpKK83MiDukPe4ak7xgq4HV3npjt
        iag73poABfpdUBY7umhLCtmIXxuNnG0PzPZOy3vSrL3IiwJNcsUGbEyk0OuPdA1ksShras
        61mNn5xNdFZXk++4QvfBgGfI9zLy2imMIcMBVdxksPE6MaHfcbPa1wNjmrdaIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NH7+qz70uuA7M/8J/NzK8S8LxVhvl7LNyP0PTc/zHRc=;
        b=G2tYAQJA57+NeN/cU1pMi3n8pG0D4+U7QrUoYUw+K7IRopePsQQR4STg/9t7qxDTsEjBDx
        nqV9wTgnQLqP4+Aw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Consolidate scftorture_invoke_one() check
 and kfree()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532907.7002.3852636641253580280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     676e5469643e716df7f39ef77ba8f09c85b0c4f8
Gitweb:        https://git.kernel.org/tip/676e5469643e716df7f39ef77ba8f09c85b0c4f8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Jul 2020 14:13:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:35 -07:00

scftorture: Consolidate scftorture_invoke_one() check and kfree()

This commit moves checking of the ->scfc_out field and the freeing of
the scf_check structure down below the end of switch statement, thus
saving a few lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 0d7299d..f220cd3 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -289,7 +289,7 @@ static void scf_handler_1(void *scfc_in)
 static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_random_state *trsp)
 {
 	uintptr_t cpu;
-	int ret;
+	int ret = 0;
 	struct scf_check *scfcp = NULL;
 	struct scf_selector *scfsp = scf_sel_rand(trsp);
 
@@ -322,11 +322,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			else
 				scfp->n_single_ofl++;
 			kfree(scfcp);
-		} else if (scfcp && scfsp->scfs_wait) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs); // Leak rather than trash!
-			else
-				kfree(scfcp);
+			scfcp = NULL;
 		}
 		break;
 	case SCF_PRIM_MANY:
@@ -341,12 +337,6 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_in = true;
 		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
-		if (scfcp) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
-			else
-				kfree(scfcp);
-		}
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
@@ -360,14 +350,14 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_in = true;
 		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
-		if (scfcp) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
-			else
-				kfree(scfcp);
-		}
 		break;
 	}
+	if (scfcp && scfsp->scfs_wait) {
+		if (WARN_ON_ONCE(!scfcp->scfc_out))
+			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
+		else
+			kfree(scfcp);
+	}
 	if (use_cpus_read_lock)
 		cpus_read_unlock();
 	else
