Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CD1CE642
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgEKVAJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732107AbgEKVAI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 17:00:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1FC061A0E;
        Mon, 11 May 2020 14:00:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWw-00064W-FK; Mon, 11 May 2020 23:00:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C60F1C07B4;
        Mon, 11 May 2020 22:59:47 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark rcu_state.ncpus to detect concurrent writes
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078695.390.3190940566900241563.tip-bot2@tip-bot2>
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

Commit-ID:     2f08469563550d15cb08a60898d3549720600eee
Gitweb:        https://git.kernel.org/tip/2f08469563550d15cb08a60898d3549720600eee
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 10 Feb 2020 05:29:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:15 -07:00

rcu: Mark rcu_state.ncpus to detect concurrent writes

The rcu_state structure's ncpus field is only to be modified by the
CPU-hotplug CPU-online code path, which is single-threaded.  This
commit therefore enlists KCSAN's help in enforcing this restriction.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 156ac8d..c88240a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3612,6 +3612,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
 	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
