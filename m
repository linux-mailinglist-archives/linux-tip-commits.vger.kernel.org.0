Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9E288294
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgJIGf2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJIGfP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25564C0613D5;
        Thu,  8 Oct 2020 23:35:15 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kEI3jt05TyTejgS45crLuDdk8MooQ6XTwAZBUjl/xWg=;
        b=C1x9sG+zetDn9pYslq1hZeahaurNxTqkzpOtAEvBJO3FDZcjSP3VMpggLeb7Bm36h/PRm9
        k2Qe50IVo2iyiZ06QIs9GvL5+2xJbBj/gCLiff8IZG6Jiv0cKW86pybIy+yIs7NIS64gQi
        eSBY2vpDMPbvkzvvplOUMx9Iii8p+pK/hjioC3bNWB4PIm7ugUEMy90jpztl+lu1G9LspT
        52pB4B0O99omNadO7b3b5a5cGuMVqATLAgKD587KqrVTvtmJy27XDC/CpETMkzUzo/rNaq
        /t716DEmisqw1GSiJAS78h5hgaxc4FZsDfvduAWvUmeZYaqgG4rc3pwuLkWqOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kEI3jt05TyTejgS45crLuDdk8MooQ6XTwAZBUjl/xWg=;
        b=LncLS7Wh50RzsMht0xEEMxRF95Z/RnqX+coYEG47t8cNDh0Awb/sK/Bbz+30AbvhFseZwv
        /q7l2OWFCp6VxFAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Properly set rcu_fwds for OOM handling
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531297.7002.4130611121050528796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c8fa63714763b7795a3f5fb7ed6d000763e6dccc
Gitweb:        https://git.kernel.org/tip/c8fa63714763b7795a3f5fb7ed6d000763e6dccc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 19 Jul 2020 14:40:31 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:34 -07:00

rcutorture: Properly set rcu_fwds for OOM handling

The conversion of rcu_fwds to dynamic allocation failed to actually
allocate the required structure.  This commit therefore allocates it,
frees it, and updates rcu_fwds accordingly.  While in the area, it
abstracts the cleanup actions into rcu_torture_fwd_prog_cleanup().

Fixes: 5155be9994e5 ("rcutorture: Dynamically allocate rcu_fwds structure")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c8206ff..7942be4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2148,9 +2148,20 @@ static int __init rcu_torture_fwd_prog_init(void)
 		return -ENOMEM;
 	spin_lock_init(&rfp->rcu_fwd_lock);
 	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+	rcu_fwds = rfp;
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
+static void rcu_torture_fwd_prog_cleanup(void)
+{
+	struct rcu_fwd *rfp;
+
+	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rfp = rcu_fwds;
+	rcu_fwds = NULL;
+	kfree(rfp);
+}
+
 /* Callback function for RCU barrier testing. */
 static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 {
@@ -2448,7 +2459,7 @@ rcu_torture_cleanup(void)
 	show_rcu_gp_kthreads();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
-	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rcu_torture_fwd_prog_cleanup();
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
