Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D61190954
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCXJTP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:19:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgCXJQs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffy-00080n-4L; Tue, 24 Mar 2020 10:16:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E17E71C0494;
        Tue, 24 Mar 2020 10:16:36 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:36 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Refrain from callback flooding during boot
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139661.28353.1259820595698014027.tip-bot2@tip-bot2>
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

Commit-ID:     435508095ab5b6870e8140948983920ce4684e9b
Gitweb:        https://git.kernel.org/tip/435508095ab5b6870e8140948983920ce4684e9b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 04 Dec 2019 15:58:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

rcutorture: Refrain from callback flooding during boot

Additional rcutorture aggression can result in, believe it or not,
boot times in excess of three minutes on large hyperthreaded systems.
This is long enough for rcutorture to decide to do some callback flooding,
which seems a bit excessive given that userspace cannot have started
until long after boot, and it is userspace that does the real-world
callback flooding.  Worse yet, because Tiny RCU lacks forward-progress
functionality, the looping-in-the-kernel tests can also be problematic
during early boot.

This commit therefore causes rcutorture to hold off on callback
flooding until about the time that init is spawned, and the same
for looping-in-the-kernel tests for Tiny RCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9ba4978..08fa4ef 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1994,8 +1994,11 @@ static int rcu_torture_fwd_prog(void *args)
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
 		register_oom_notifier(&rcutorture_oom_nb);
-		rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
-		rcu_torture_fwd_prog_cr(rfp);
+		if (!IS_ENABLED(CONFIG_TINY_RCU) ||
+		    rcu_inkernel_boot_has_ended())
+			rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
+		if (rcu_inkernel_boot_has_ended())
+			rcu_torture_fwd_prog_cr(rfp);
 		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
