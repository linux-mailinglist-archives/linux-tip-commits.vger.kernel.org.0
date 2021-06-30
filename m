Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB83B83A9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhF3Nu3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhF3NuE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BBFC06124A;
        Wed, 30 Jun 2021 06:47:35 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=imD2axTsxkdokPv9333c8qwYnbxLFNhGj18SC09LANs=;
        b=ZB5F4OtUyXuUfZwDjKZtwtNe8WZDrlvd2pc2NUObWZoLozJEykda0iRCA/hPmTyeIgZ5jd
        c+0HkG3ReBKwCg2MCu881PVWcwfhq6CysmziZix33vGHXOP+yaDGj4YZc9mob+d7qhDxXp
        8DC8ohuN+lzRPUJg4Zib0UJoS0ihcNQhPErylIJnwyRrC9O/Dy7ya6YX0OuMyJWbtRreZD
        HLFGOkbP5p3P8YUZ1X+573wXFmkcS7BiPLOjRRMliHt6EvxSjrb5wpUTRhy6q8xX/tqOjf
        RK3CjuG4Jb6vt1eRScquRMDgvOz1rxgH9ZZw0vGJ26h7VtMsC2h0v48iVkMP6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=imD2axTsxkdokPv9333c8qwYnbxLFNhGj18SC09LANs=;
        b=pDIog/uROIN7jhTGsxP93E0/2hcukOZ1dIwlSxqiUCt1LiClWyerTe+80cms0f+b9X3XB5
        Yx+ePJSL/NohRZDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make show_rcu_gp_kthreads() dump rcu_node
 structures blocking GP
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085331.395.6710579387383459364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b15805013b441b13fcf6e402c03421c03edb79c6
Gitweb:        https://git.kernel.org/tip/b15805013b441b13fcf6e402c03421c03edb79c6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 07 Apr 2021 15:14:01 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP

Currently, show_rcu_gp_kthreads() only dumps rcu_node structures that
have outdated ideas of the current grace-period number.  This commit
also dumps those that are in any way blocking the current grace period.
This helps diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c1f8386..e6bd518 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -746,8 +746,9 @@ void show_rcu_gp_kthreads(void)
 		data_race(rcu_state.gp_max),
 		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
-				 READ_ONCE(rnp->gp_seq_needed)))
+		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
+		    !data_race(rnp->qsmask) && !data_race(rnp->boost_tasks) &&
+		    !data_race(rnp->exp_tasks) && !data_race(rnp->gp_tasks))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
 			rnp->grplo, rnp->grphi,
