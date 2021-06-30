Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B53B8386
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhF3Nt6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:49:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhF3Nty (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:54 -0400
Date:   Wed, 30 Jun 2021 13:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QPyltbgbo3ToP6WYW7nuZSR1FFjhPACA6g4JtLpsHM0=;
        b=n//F9nfb80uCrf0or1fPzZKg+bZTUSmSu52fWsNCryNTQPbVN4QbPhzZOvXvCLvmK8Gd6w
        xfyRN4GJH3Nv+9MPoi7fjBFtkPEywaSSmrhFIb1tkV+GndTq0fM2TRimU1wWzh6fLPUpUz
        a6ipjcWaCNOkHrOE1o3o/cA1aAQh4RZVgVZpzHx1Zu/0QvA3L06whRWzSZTXpum2Ik/dNJ
        Kf0pFb1M3EiyVB3yKx61XLMoCR9CaCOzn94EfeNkWi++gBP9EIRe8kKJvdl2RluFRlHRij
        f+oBg7rpnybVHMFdELHslXtoNotA8qQed/03w7DIP6I14mNHxjlqtiqtwWjBkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QPyltbgbo3ToP6WYW7nuZSR1FFjhPACA6g4JtLpsHM0=;
        b=t2SehsuwC4csFpD+EhT3S3C20xRSlmWzQn5s6SjMro/u1Ct0UYk7Ue0FegyYqZ/OEiIGJq
        +crcagicMtABKjBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084324.395.16870757216022933477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     474d0997361c07d163693d0de41e76a2f2899d0a
Gitweb:        https://git.kernel.org/tip/474d0997361c07d163693d0de41e76a2f2899d0a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 20 Apr 2021 10:58:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:55:17 -07:00

tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline

In some architectures, the no-op variant of show_rcu_tasks_gp_kthreads()
get "no previous prototype" compiler warnings.  These are false positives
given that kernel/rcu/tasks.h is included only once.  But why put up
with the compiler noise?

This commit therefore adds "static inline" to this definition to force
the compiler to accept this situation, while also moving it to its proper
place in kernel/rcu/rcu.h.

Reported-by: kernel test robot <lkp@intel.com>
[ paulmck: Update per Stephen Rothwell feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h   | 4 ++++
 kernel/rcu/tasks.h | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d..c0b3ab6 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -441,7 +441,11 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+#ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void show_rcu_tasks_gp_kthreads(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d6aa352..fc21853 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1401,5 +1401,4 @@ void __init rcu_init_tasks_generic(void)
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
