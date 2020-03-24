Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B246190960
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCXJTt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:19:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgCXJQm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffs-0007xx-Ev; Tue, 24 Mar 2020 10:16:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 341981C048C;
        Tue, 24 Mar 2020 10:16:33 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Fix stray access to rcu_fwd_cb_nodelay
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139290.28353.6911043287008731885.tip-bot2@tip-bot2>
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

Commit-ID:     102c14d2f87976e8390d2cb892ccd14e3532e020
Gitweb:        https://git.kernel.org/tip/102c14d2f87976e8390d2cb892ccd14e3532e020
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 21 Dec 2019 11:23:50 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Fix stray access to rcu_fwd_cb_nodelay

The rcu_fwd_cb_nodelay variable suppresses excessively long read-side
delays while carrying out an rcutorture forward-progress test.  As such,
it is accessed both by readers and updaters, and most of the accesses
therefore use *_ONCE().  Except for one in rcu_read_delay(), which this
commit fixes.

This data race was reported by KCSAN.  Not appropriate for backporting
due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index edd9746..124160a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -339,7 +339,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	 * period, and we want a long delay occasionally to trigger
 	 * force_quiescent_state. */
 
-	if (!rcu_fwd_cb_nodelay &&
+	if (!READ_ONCE(rcu_fwd_cb_nodelay) &&
 	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
