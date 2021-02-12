Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF3319EBD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBLMkk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhBLMjG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:06 -0500
Date:   Fri, 12 Feb 2021 12:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nxcFYNNymYh9idMXgQ4P9EBHnP3Wdi2QRAUhSK5ilY=;
        b=gABcBQ5QyA8QU3YQX8M8nJ45nMXiwwzDfOy4RFmEX58Hkxm6pXAyghF//PW1egYMM/ePTF
        FW4nHiVa8VtQ0m2FcPfSW0Vz6YzINXKcmCQauSFgaVWNqJTNCVPVSDq2rSINqA8k6IQeHi
        LzKP5DBja0eQn3VJhVO0nyyBFoUm3fKEt2jN+o6SgLKrSIvjmQIAxWZOoKhkJcWX/hbA83
        3JxJf/t50IoUuoxsV3x6HiSsKWwRIU3jEyOlKyCQDt5PA6dqXnZVfhIRKWpNjFVlQtRUfS
        CkpDfomSPagXpcIeu0p/+87AdgOZ5SHMCtnYpZpFmZBsLmUSnaHUQN0vfKXFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nxcFYNNymYh9idMXgQ4P9EBHnP3Wdi2QRAUhSK5ilY=;
        b=uM6dZnwE0VZLJY5aeL+OXp0jdmFaB1aRiuWIaCRR9mkTOb5AOgYTZwqiZacjSRAP55q2gb
        kKt7kBLh9ApuXgBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] timer: Add timer_curr_running()
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343712.23325.16879161573630488715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dcd42591ebb8a25895b551a5297ea9c24414ba54
Gitweb:        https://git.kernel.org/tip/dcd42591ebb8a25895b551a5297ea9c24414ba54
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:33 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

timer: Add timer_curr_running()

This commit adds a timer_curr_running() function that verifies that the
current code is running in the context of the specified timer's handler.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9..4118a97 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -192,6 +192,8 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
+extern bool timer_curr_running(struct timer_list *timer);
+
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8dbc008..f9b2096 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1237,6 +1237,19 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
+bool timer_curr_running(struct timer_list *timer)
+{
+	int i;
+
+	for (i = 0; i < NR_BASES; i++) {
+		struct timer_base *base = this_cpu_ptr(&timer_bases[i]);
+		if (base->running_timer == timer)
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
