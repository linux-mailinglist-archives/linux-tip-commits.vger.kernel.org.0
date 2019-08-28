Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF19FF65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfH1KRp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 06:17:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfH1KQj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0G-0000LP-IJ; Wed, 28 Aug 2019 12:16:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 99A2A1C0DE3;
        Wed, 28 Aug 2019 12:16:32 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Respect INFINITY for hard RTTIME limit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.078293002@linutronix.de>
References: <20190821192922.078293002@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739240.5777.15500414280182979993.tip-bot2@tip-bot2>
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

Commit-ID:     fe0517f893d36636de20d0a809fc0c788ca0cade
Gitweb:        https://git.kernel.org/tip/fe0517f893d36636de20d0a809fc0c788ca0cade
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:39 +02:00

posix-cpu-timers: Respect INFINITY for hard RTTIME limit

The RTIME limit expiry code does not check the hard RTTIME limit for
INFINITY, i.e. being disabled.  Add it.

While this could be considered an ABI breakage if something would depend on
this behaviour. Though it's highly unlikely to have an effect because
RLIM_INFINITY is at minimum INT_MAX and the RTTIME limit is in seconds, so
the timer would fire after ~68 years.

Adding this obvious correct limit check also allows further consolidation
of that code and is a prerequisite for cleaning up the 0 based checks and
the rlimit setter code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.078293002@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e62139a..a738d76 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -921,7 +921,7 @@ static void check_process_timers(struct task_struct *tsk,
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
 		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
 
-		if (psecs >= hard) {
+		if (hard != RLIM_INFINITY && psecs >= hard) {
 			/*
 			 * At the hard limit, we just die.
 			 * No need to calculate anything else now.
