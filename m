Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1840C28822F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgJIGfa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgJIGfa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:30 -0400
Date:   Fri, 09 Oct 2020 06:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/iOf96KfdqVZLnqmAf9Vb8aV2ZwFiiRdb4JgKeBLdTc=;
        b=o6mTAyGU1LyFKmrChlxERKLYEG65lHM77C5whlTs603IqKec/cQmlf9GO224b3/LItp+Nz
        cIHsx8qELMvWhTBB/o6HsooA0MmZLXjgZQwGzNWwwM8ldAQsF0kaz/LnZbMqhKNBCS19XV
        N4+GoRaQeHkq/scGzeGNh7ALqOs/uouE9neOuXFiEMwL+m3qAYRoraMGM0dpb0SLkTVU5G
        fe6u/U/MMtAUJUYI3rD1fZxt2ewiCrSaBay8lLrhXugoxaH2CLAKqcMZxTG0Ns2erwiLeH
        O+euznbN3TFB+ULo/LFVcZ2/7eJ3xc2M6XqrxxEyUpN512PQZWHH9/kQpALetw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/iOf96KfdqVZLnqmAf9Vb8aV2ZwFiiRdb4JgKeBLdTc=;
        b=o8kqzbO4jc+CdjUI/lWZdsJFtFGLvm8hLzMZFtYcYsdthzycgKgNyc6EQMlqRZGP3cwdaf
        FXovoOqhJZIMM9Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Prevent compiler from reducing race probabilities
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532756.7002.520879055987147583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ee7035d29576dcb59b1191e5f609517cacab1e56
Gitweb:        https://git.kernel.org/tip/ee7035d29576dcb59b1191e5f609517cacab1e56
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Jul 2020 16:38:16 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:36 -07:00

scftorture: Prevent compiler from reducing race probabilities

Detecting smp_call_function() memory misordering requires close timing,
so it is necessary to have the checks immediately before and after
the call to the smp_call_function*() function under test.  This commit
therefore inserts barrier() calls to prevent the compiler from optimizing
memory-misordering detection down into the zone of extreme improbability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 880c2ce..8349681 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -322,6 +322,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_single++;
 		if (scfcp) {
 			scfcp->scfc_cpu = cpu;
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
 		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
@@ -339,8 +340,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		if (scfcp)
+		if (scfcp) {
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
+		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	case SCF_PRIM_ALL:
@@ -348,8 +351,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_all_wait++;
 		else
 			scfp->n_all++;
-		if (scfcp)
+		if (scfcp) {
+			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
+		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	}
@@ -358,6 +363,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
 		else
 			kfree(scfcp);
+		barrier(); // Prevent race-reduction compiler optimizations.
 	}
 	if (use_cpus_read_lock)
 		cpus_read_unlock();
