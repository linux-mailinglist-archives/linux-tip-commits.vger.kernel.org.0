Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150403B83F2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhF3Nv0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhF3Nue (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:34 -0400
Date:   Wed, 30 Jun 2021 13:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ISi4I1I/bNJAmMaOWEVfWbAvI/ixIwNvsTWUxMvIm08=;
        b=U8piDqlLL3FscUgyO3nsz595O/dO3jAtcocO3qr8cuTOdfRMn5NsJ7rQNn6gC95MsIwCbF
        h3fYKC7Ax02pAzXOuy1AfhwDq6LpUGMZ39VAsgcPdyEZ93a2+J2nKHZ5fPfJKyq2GxB++I
        03T9U22YI77UOjDKM/WUFY2iOeYhk+nVrkQnsSPhRZf3w0Gmt4n619ulMpHPGe3ur7MUp1
        0ZWy/A0Bk+Km7ef6YAgA+1s+XISOLqCqteCoHym+cL91wl51c4/xbrM82xfGXi2e3agceq
        MlTDMztE5Szizee5WfOvEhWb+dtogVXTBMrc2oKnaA6SPES66uYvsgc2Zi+7wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ISi4I1I/bNJAmMaOWEVfWbAvI/ixIwNvsTWUxMvIm08=;
        b=VY6K1CO2YI6dSUHtZe0ZCQpibi4GJuVUqLANRt1+H8YxLFbWLpGeJ+bkpjfOMeqETYVv5a
        5zC1fOGGzdPlmYAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] timer: Revert "timer: Add timer_curr_running()"
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087478.395.13592774436335383913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     258ca95e2cd9a0fcc4508a1bf1742b1a3e9a7bbb
Gitweb:        https://git.kernel.org/tip/258ca95e2cd9a0fcc4508a1bf1742b1a3e9a7bbb
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:04 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:02:44 -07:00

timer: Revert "timer: Add timer_curr_running()"

This reverts commit dcd42591ebb8a25895b551a5297ea9c24414ba54.
The only user was RCU/nocb.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h |  2 --
 kernel/time/timer.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4118a97..fda13c9 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -192,8 +192,6 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
-extern bool timer_curr_running(struct timer_list *timer);
-
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf..84332f0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1237,20 +1237,6 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-bool timer_curr_running(struct timer_list *timer)
-{
-	int i;
-
-	for (i = 0; i < NR_BASES; i++) {
-		struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
-
-		if (base->running_timer == timer)
-			return true;
-	}
-
-	return false;
-}
-
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
