Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591361CE654
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgEKVBO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732093AbgEKVAG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 17:00:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39DC061A0C;
        Mon, 11 May 2020 14:00:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWu-00063e-Kw; Mon, 11 May 2020 23:00:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C51291C07EB;
        Mon, 11 May 2020 22:59:45 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:45 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Add data_race() to ->srcu_lock_count and
 ->srcu_unlock_count arrays
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078565.390.9530533982000142424.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b68c6146512d92f6d570d26e1873497ade2cc4cb
Gitweb:        https://git.kernel.org/tip/b68c6146512d92f6d570d26e1873497ade2cc4cb
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 16:36:59 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock_count arrays

The srcu_data structure's ->srcu_lock_count and ->srcu_unlock_count arrays
are read and written locklessly, so this commit adds the data_race()
to the diagnostic-print loads from these arrays in order mark them as
known and approved data-racy accesses.

This data race was reported by KCSAN. Not appropriate for backporting due
to failure being unlikely and due to this being used only by rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ba2b751..6d3ef70 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1281,8 +1281,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		struct srcu_data *sdp;
 
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		u0 = sdp->srcu_unlock_count[!idx];
-		u1 = sdp->srcu_unlock_count[idx];
+		u0 = data_race(sdp->srcu_unlock_count[!idx]);
+		u1 = data_race(sdp->srcu_unlock_count[idx]);
 
 		/*
 		 * Make sure that a lock is always counted if the corresponding
@@ -1290,8 +1290,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		 */
 		smp_rmb();
 
-		l0 = sdp->srcu_lock_count[!idx];
-		l1 = sdp->srcu_lock_count[idx];
+		l0 = data_race(sdp->srcu_lock_count[!idx]);
+		l1 = data_race(sdp->srcu_lock_count[idx]);
 
 		c0 = l0 - u0;
 		c1 = l1 - u1;
