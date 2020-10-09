Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF212882B5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgJIGjI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731872AbgJIGfS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D8C0613D4;
        Thu,  8 Oct 2020 23:35:18 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SmGxhmME8Hy2hOn5OmEjZZPKgc2gqsbEjd5a+b+t5x4=;
        b=3ybOrSlkivpGu5OB7pMPVXGn0oQebufKt7iEix1wit/RmLlzCdqvHQMDg5+HPBtGNrYt9d
        UHZDiqQ6hvEIbzw2hrK2NtjOyaq0LW94IXuWc6uNYvd2EVhafHLVDYpyiSb/VXyiAdWAkk
        ouMDc5434Co/YCDi78KZIVD7TOR47rguz45qwNf2Pgy4FATH9K6cWXk5TvGYS6MpnMG+WP
        0EF8y0+puN3YcPMUskMm+aInesRzpHS54tUVQOuosdeRTrOVrHeS2pececgOZ5/NTivfqn
        8NH/Q7vcYy0eKCXlF+uxtgCS0EiWAVZZZDkZmB4W6jwYkuvGhEhTT9siD5DPjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SmGxhmME8Hy2hOn5OmEjZZPKgc2gqsbEjd5a+b+t5x4=;
        b=nrin+CIoX9qwcx2mhAcwWrf3CkpbBszMlTBguAfJbDHkZXygQteJ3EvpsxkOee8H7IJDxG
        fhmp1/nMWazj+KCQ==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Output number of elapsed grace periods
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531641.7002.13156353405914355341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     959954df0ca7da2111c3fb67a666681798d15b9d
Gitweb:        https://git.kernel.org/tip/959954df0ca7da2111c3fb67a666681798d15b9d
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 18 Jun 2020 16:29:55 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:31 -07:00

rcutorture: Output number of elapsed grace periods

This commit adds code to print the grace-period number at the start
of the test along with both the grace-period number and the number of
elapsed grace periods at the end of the test.  Note that variants of
RCU)without the notion of a grace-period number (for example, Tiny RCU)
just print zeroes.

[ paulmck: Adjust commit log. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index db37861..c8206ff 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -172,6 +172,7 @@ static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
+static unsigned long start_gp_seq;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -2469,8 +2470,9 @@ rcu_torture_cleanup(void)
 
 	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
-	pr_alert("%s:  End-test grace-period state: g%lu f%#x\n",
-		 cur_ops->name, gp_seq, flags);
+	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
+		 cur_ops->name, (long)gp_seq, flags,
+		 rcutorture_seq_diff(gp_seq, start_gp_seq));
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	if (rcu_torture_can_boost())
@@ -2594,6 +2596,8 @@ rcu_torture_init(void)
 	long i;
 	int cpu;
 	int firsterr = 0;
+	int flags = 0;
+	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
 		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
@@ -2636,6 +2640,11 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
+	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
+	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	start_gp_seq = gp_seq;
+	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
+		 cur_ops->name, (long)gp_seq, flags);
 
 	/* Set up the freelist. */
 
