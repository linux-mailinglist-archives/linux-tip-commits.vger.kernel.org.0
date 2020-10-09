Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F933288236
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgJIGfk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbgJIGfh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:37 -0400
Date:   Fri, 09 Oct 2020 06:35:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xjgZXEeDs3BTu2Qvjo0CIFoTOUQKyrt13PEwiAHozTg=;
        b=3rsHCrPu0cRSM/f7nm7zRJrhGJC6iJpTG+OEqMwqI1jOLWtrGILx0nTwgRNUsKlV6MsiLt
        GV1YI3f5luMU2Tp3AysuIc8/+nzdgW2Sv68J7lroWRCKpCNp9ncovGeA0R1kX165dncCM+
        V8ReG3u9UJnDoOjoBmp4wNX7Bu/HKMtX1CQBT1LY77O/1xR67PC8AyARzCPLkkhG0QJrEb
        lGZmFnz8/bMxSx43jtni4dZ19XKHsquEFaV12jfuWj/XyyiP3Yf7A6ofeyZ14W/Y/fvfxq
        /h9gPIefBskhTK7YLhlUL2r+Kmr50rYGRTr49/iMK/rIL4YHR34Bk7vZnhUONw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xjgZXEeDs3BTu2Qvjo0CIFoTOUQKyrt13PEwiAHozTg=;
        b=hs1T9l8xHFB1xsjBGsFRa1o04FdY4U2t00xbnJWuwlK9bqUXZpdaj1MFu/ZQ04HfmTAMYN
        EjhB3pPIPMQ2iNCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused __rcu_is_watching() function
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533416.7002.17781828054052046297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7f2a53c231fe5d9522c3b695ab454203904031ac
Gitweb:        https://git.kernel.org/tip/7f2a53c231fe5d9522c3b695ab454203904031ac
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 17 Aug 2020 10:37:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:37:56 -07:00

rcu: Remove unused __rcu_is_watching() function

The x86/entry work removed all uses of __rcu_is_watching(), therefore
this commit removes it entirely.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 1 -
 include/linux/rcutree.h | 1 -
 kernel/entry/common.c   | 2 +-
 kernel/rcu/tree.c       | 5 -----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5cc9637..7c1ecdb 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -103,7 +103,6 @@ static inline void rcu_scheduler_starting(void) { }
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline bool __rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d2f4064..59eb5cd 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,7 +64,6 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-bool __rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d..ad794a1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -278,7 +278,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * terminate a grace period, if and only if the timer interrupt is
 	 * not nested into another interrupt.
 	 *
-	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * Checking for rcu_is_watching() here would prevent the nesting
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interupt and eventually claim
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 396abe0..2323622 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1077,11 +1077,6 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	}
 }
 
-noinstr bool __rcu_is_watching(void)
-{
-	return !rcu_dynticks_curr_cpu_in_eqs();
-}
-
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
