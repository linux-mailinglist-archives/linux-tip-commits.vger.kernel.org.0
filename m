Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11799A547
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfHWCMT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:12:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389305AbfHWCMS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3n-0000wR-I0; Fri, 23 Aug 2019 04:12:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 40F451C07E4;
        Fri, 23 Aug 2019 04:12:15 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:15 -0000
From:   tip-bot2 for Julien Grall <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Don't take expiry_lock when timer is
 currently migrated
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Julien Grall <julien.grall@arm.com>
In-Reply-To: <20190821092409.13225-4-julien.grall@arm.com>
References: <20190821092409.13225-4-julien.grall@arm.com>
MIME-Version: 1.0
Message-ID: <156652633520.11649.15892124550118329976.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     68b2c8c1e421096f4b46ac2ac502d25ca067a2a6
Gitweb:        https://git.kernel.org/tip/68b2c8c1e421096f4b46ac2ac502d25ca067a2a6
Author:        Julien Grall <julien.grall@arm.com>
AuthorDate:    Wed, 21 Aug 2019 10:24:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Aug 2019 16:10:01 +02:00

hrtimer: Don't take expiry_lock when timer is currently migrated

migration_base is used as a placeholder when an hrtimer is migrated to a
different CPU. In the case that hrtimer_cancel_wait_running() hits a timer
which is currently migrated it would pointlessly acquire the expiry lock of
the migration base, which is even not initialized.

Surely it could be initialized, but there is absolutely no point in
acquiring this lock because the timer is guaranteed not to run it's
callback for which the caller waits to finish on that base. So it would
just do the inc/lock/dec/unlock dance for nothing.

As the base switch is short and non-preemptible, there is no issue when the
wait function returns immediately.

The timer base and base->cpu_base cannot be NULL in the code path which is
invoking that, so just replace those checks with a check whether base is
migration base.

[ tglx: Updated from RT patch. Massaged changelog. Added comment. ]

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190821092409.13225-4-julien.grall@arm.com


---
 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f48864e..ebbd0fb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1217,7 +1217,11 @@ void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 	/* Lockless read. Prevent the compiler from reloading it below */
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (!timer->is_soft || !base || !base->cpu_base) {
+	/*
+	 * Just relax if the timer expires in hard interrupt context or if
+	 * it is currently on the migration base.
+	 */
+	if (!timer->is_soft || base == &migration_base)
 		cpu_relax();
 		return;
 	}
