Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212E9E84CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2019 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfJ2JxF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Oct 2019 05:53:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732998AbfJ2Jwr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAq-0004R6-NG; Tue, 29 Oct 2019 10:52:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5943D1C0073;
        Tue, 29 Oct 2019 10:52:21 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:21 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] context_tracking: Rename
 context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-7-frederic@kernel.org>
References: <20191016025700.31277-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274107.29376.11215352275412049465.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     84e0dacd0c347e9ee2531052013babd84683245f
Gitweb:        https://git.kernel.org/tip/84e0dacd0c347e9ee2531052013babd84683245f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:12 +01:00

context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()

Standardize the naming on top of the context_tracking_enabled_*() base.
Also make it clear we are checking the context tracking state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-7-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h       | 2 +-
 include/linux/context_tracking_state.h | 4 ++--
 include/linux/vtime.h                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index f1601ba..c9065ad 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -118,7 +118,7 @@ static inline void guest_enter_irqoff(void)
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_cpu_is_enabled())
+	if (!context_tracking_enabled_this_cpu())
 		rcu_virt_note_context_switch(smp_processor_id());
 }
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 91250bd..08f125f 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -31,7 +31,7 @@ static inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
-static inline bool context_tracking_cpu_is_enabled(void)
+static inline bool context_tracking_enabled_this_cpu(void)
 {
 	return __this_cpu_read(context_tracking.active);
 }
@@ -43,7 +43,7 @@ static inline bool context_tracking_in_user(void)
 #else
 static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_cpu_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
 #endif
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 0fc7f11..54e9151 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -34,7 +34,7 @@ static inline bool vtime_accounting_enabled(void)
 static inline bool vtime_accounting_cpu_enabled(void)
 {
 	if (vtime_accounting_enabled()) {
-		if (context_tracking_cpu_is_enabled())
+		if (context_tracking_enabled_this_cpu())
 			return true;
 	}
 
