Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B60288289
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgJIGhv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731970AbgJIGfc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:32 -0400
Date:   Fri, 09 Oct 2020 06:35:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zdDfHF+nbfWKrxxTyGW/+bnegHmzKtqAi7hUkaAhi2E=;
        b=uKxIa0Q3jQnI61vBKnlldCwbJn0kkwLNLvWETLK4Sead5KEb16/2tPMZM9YeYbgZDH/12F
        zwAlxJC2xdQXwfGGRrYqj2eC+axnuV/feRpc6NWqSdD8xkJMdIRV9yoFIPgvVFmHbfSlvZ
        xmzzB7FuL7JAlWfo413hGhUfbWswsHqCjMgBZKkigeuIjruVOkYQWoO1SImwj7RVLIyWco
        AdLgBG/A9O+cNcs+R93tMyqieBMh39vIyS9oK9qVbEbNEPu9DuVpjTrRHRjIK1dkrSDfM3
        uQ9lRGyXWj72OcU3uU2ts3U8PzprDNK+TgJEaeNiYnu8FEE3b9w75Cy1b6xI6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zdDfHF+nbfWKrxxTyGW/+bnegHmzKtqAi7hUkaAhi2E=;
        b=u1uk2940rudhW0q795MJDUbA7uNM1UxZ+xrn8P4pHIPqlOWiDabm6m+SQjXg1flXZukvzF
        NvxgxB9AzKfe0mBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add smp_call_function_many()
 memory-ordering checks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533003.7002.8090034918982279919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     980205ee8489d53c4380f7762debac87312b0fb3
Gitweb:        https://git.kernel.org/tip/980205ee8489d53c4380f7762debac87312b0fb3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Jul 2020 12:30:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:34 -07:00

scftorture: Add smp_call_function_many() memory-ordering checks

This commit adds checks for memory misordering across calls to and
returns from smp_call_function_many() in the case where the caller waits.
Misordering results in a splat.

Note that in contrast to smp_call_function_single(), this code does not
test memory ordering into the handler in the no-wait case because none
of the handlers would be able to free the scf_check structure without
introducing heavy synchronization to work out which was last.

[ paulmck: s/GFP_KERNEL/GFP_ATOMIC/ per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 9b42271..3519ad1 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -240,8 +240,11 @@ static void scf_handler(void *scfc_in)
 	unsigned long r = torture_random(this_cpu_ptr(&scf_torture_rand));
 	struct scf_check *scfcp = scfc_in;
 
-	if (likely(scfcp) && WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
-		atomic_inc(&n_mb_in_errs);
+	if (likely(scfcp)) {
+		WRITE_ONCE(scfcp->scfc_out, false); // For multiple receivers.
+		if (WARN_ON_ONCE(unlikely(!READ_ONCE(scfcp->scfc_in))))
+			atomic_inc(&n_mb_in_errs);
+	}
 	this_cpu_inc(scf_invoked_count);
 	if (longwait <= 0) {
 		if (!(r & 0xffc0))
@@ -325,11 +328,28 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 		break;
 	case SCF_PRIM_MANY:
+		if (scfsp->scfs_wait) {
+			scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
+			if (WARN_ON_ONCE(!scfcp))
+				atomic_inc(&n_alloc_errs);
+		}
 		if (scfsp->scfs_wait)
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		smp_call_function_many(cpu_online_mask, scf_handler, NULL, scfsp->scfs_wait);
+		if (scfcp) {
+			scfcp->scfc_cpu = -1;
+			scfcp->scfc_wait = true;
+			scfcp->scfc_out = false;
+			scfcp->scfc_in = true;
+		}
+		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
+		if (scfcp) {
+			if (WARN_ON_ONCE(!scfcp->scfc_out))
+				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
+			else
+				kfree(scfcp);
+		}
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
