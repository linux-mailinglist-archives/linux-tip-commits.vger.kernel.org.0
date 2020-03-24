Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07DA190942
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXJQl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:16:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgCXJQl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffq-000807-Tn; Tue, 24 Mar 2020 10:16:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 99A311C0451;
        Tue, 24 Mar 2020 10:16:35 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:35 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Suppress boottime bad-sequence warnings
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139525.28353.16827061802164073908.tip-bot2@tip-bot2>
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

Commit-ID:     4ab00bdd99a906c089b5c20ee7b5cb91e7c61123
Gitweb:        https://git.kernel.org/tip/4ab00bdd99a906c089b5c20ee7b5cb91e7c61123
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Dec 2019 15:53:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

rcutorture: Suppress boottime bad-sequence warnings

In normal production, an excessively long wait on a grace period
(synchronize_rcu(), for example) at boottime is often just as bad
as at any other time.  In fact, given the desire for fast boot, any
sort of long wait at boot is a bad idea.  However, heavy rcutorture
testing on large hyperthreaded systems can generate such long waits
during boot as a matter of course.  This commit therefore causes
the rcupdate.rcu_cpu_stall_suppress_at_boot kernel boot parameter to
suppress reporting of bootime bad-sequence warning due to excessively
long grace-period waits.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 16c84ec..5efd950 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1423,7 +1423,8 @@ rcu_torture_stats_print(void)
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	pr_cont("rtc: %p %s: %lu tfle: %d rta: %d rtaf: %d rtf: %d ",
 		rcu_torture_current,
-		rcu_torture_current ? "ver" : "VER",
+		rcu_torture_current && !rcu_stall_is_suppressed_at_boot()
+			? "ver" : "VER",
 		rcu_torture_current_version,
 		list_empty(&rcu_torture_freelist),
 		atomic_read(&n_rcu_torture_alloc),
