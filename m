Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4E9FF79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfH1KS1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 06:18:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46406 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfH1KQc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v08-0000DY-De; Wed, 28 Aug 2019 12:16:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21CF71C0DE2;
        Wed, 28 Aug 2019 12:16:23 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Use clock ID in posix_cpu_timer_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.155487201@linutronix.de>
References: <20190821192920.155487201@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738305.5714.1341294776737821335.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     99093c5b81f58815fbfc1fe301c87206c6f5f730
Gitweb:        https://git.kernel.org/tip/99093c5b81f58815fbfc1fe301c87206c6f5f730
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:29 +02:00

posix-cpu-timers: Use clock ID in posix_cpu_timer_get()

Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
as argument to the sample functions. That allows to simplify them once all
callers are fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.155487201@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 12561f8..8e4ce8a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -699,6 +699,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
 {
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct task_struct *p = timer->it.cpu.task;
 	u64 now;
 
@@ -717,7 +718,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	 * Sample the clock to take the difference with the expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &now);
+		cpu_clock_sample(clkid, p, &now);
 	} else {
 		struct sighand_struct *sighand;
 		unsigned long flags;
@@ -737,7 +738,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 			timer->it.cpu.expires = 0;
 			return;
 		} else {
-			cpu_clock_sample_group(timer->it_clock, p, &now, false);
+			cpu_clock_sample_group(clkid, p, &now, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
