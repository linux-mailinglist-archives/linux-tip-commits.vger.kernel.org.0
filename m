Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4C2D900C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395401AbgLMTXv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E450C0617B0;
        Sun, 13 Dec 2020 11:01:05 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4Sd+Cs3y8s5uRq3tGRRZI1vwDuUt+rBnr6/LSMwM2Lo=;
        b=m4iI1DW+EbTa3dxJs4pESquDHBYVjZ+lYM1LwQ1LRK/X3QnA+kuc90Bcf4xc0DJg2uWXNp
        354j0OWGw5fOAcpmghCH4YcEBnONyXpNkYbNi89j4VRPzYHez4TcrEJxudR15OmNlc54zV
        +AhOKH4FgOXxf7HMZZ+RLr8/yW1YVkkihKqplO2/Jv/IedAb7XKJV+OBe95D8Y9S2/mf3y
        hqAkU8veEeM2tCuc+Lsrg2/Qm6Hxy7mRAZOmocKyogPcwjiK175lD+xNRCS3qz2gnEzaKQ
        0NSxp31i2kXIvcVn8D7/Da145QDQlfqkr32Zq9naeM3uVJS6Z7sJlCfMZCY4cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4Sd+Cs3y8s5uRq3tGRRZI1vwDuUt+rBnr6/LSMwM2Lo=;
        b=EfC7JpEuUOx1dlr4+NqwLBR4gZ87hEgwc3HksWAtBOVLyk5ZZ+k4lTnGlHmEC5NPv3sHyq
        ziC2NUqrb5w1laCw==
From:   "tip-bot2 for chao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Panic after fixed number of stalls
Cc:     chao <chao@eero.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606298.3364.3699797820156010845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dfe564045c653d9e6969ccca57a8a04771d333f7
Gitweb:        https://git.kernel.org/tip/dfe564045c653d9e6969ccca57a8a04771d333f7
Author:        chao <chao@eero.com>
AuthorDate:    Sun, 30 Aug 2020 23:41:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

rcu: Panic after fixed number of stalls

Some stalls are transient, so that system fully recovers.  This commit
therefore allows users to configure the number of stalls that must happen
in order to trigger kernel panic.

Signed-off-by: chao <chao@eero.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kernel.h  |  1 +
 kernel/rcu/tree_stall.h |  6 ++++++
 kernel/sysctl.c         | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e91..4b5fd3d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -536,6 +536,7 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ca21d28..70d48c5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -13,6 +13,7 @@
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
@@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	static int cpu_stall;
+
+	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+		return;
+
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085..c9fbdd8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2650,6 +2650,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#if defined(CONFIG_TREE_RCU)
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 	{
 		.procname	= "stack_erasing",
