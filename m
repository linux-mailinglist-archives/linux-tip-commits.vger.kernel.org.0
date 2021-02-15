Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177531BB8E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBOO4o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBOO43 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:29 -0500
Date:   Mon, 15 Feb 2021 14:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pVdkKBzdaa2ExWANR0rD8xk4CTnelwlcSqg+X8XsJRE=;
        b=j9kROgeRUlPU4XwhIorrD/UxjG6PqHspT3b5Ivd6RphBpqmjtIlKqReQlIa0jCG87HfDit
        HDAdELyDk0iZZbSZyiEgUbmUdxI+IBwDrJ16gbW4+FcXLTvMfWxzFn/FHBH7JzT0xrFBrR
        WGfD7Spu8agr6T1NW1KZoERk83QHuysFvqKWHdRREP+mXAjVg5KHgxlSLKbwNBIuKmiUNT
        mdiRD22wcmcsyiEMybZ/PLyMgwb2Mc9WnBYNfxxtfyR8p/WDsyfKdmFyeT9QNknF1nqBqm
        NOuM8A8ReCDouxrvyf92J08ylYiIwU/EkZkWAFki3i9hw/wog7z1bheUu3/n1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pVdkKBzdaa2ExWANR0rD8xk4CTnelwlcSqg+X8XsJRE=;
        b=ptmD75g0ijuoC3lJDvZbg6tJcnjcv70dvJCUQL1RdG2JkMAqBqcWt4Rw2Hc+ET2rd+RbpH
        rxNzhUIJMsFCoSAw==
From:   "tip-bot2 for Scott Wood" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Unconditionally use rcuc threads on PREEMPT_RT
Cc:     Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094602.20312.12836987543630267200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8b9a0ecc7ef5e1ed3afbc926de17399a37128c82
Gitweb:        https://git.kernel.org/tip/8b9a0ecc7ef5e1ed3afbc926de17399a37128c82
Author:        Scott Wood <swood@redhat.com>
AuthorDate:    Tue, 15 Dec 2020 15:16:46 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:43:51 -08:00

rcu: Unconditionally use rcuc threads on PREEMPT_RT

PREEMPT_RT systems have long used the rcutree.use_softirq kernel
boot parameter to avoid use of RCU_SOFTIRQ handlers, which can disrupt
real-time applications by invoking callbacks during return from interrupts
that arrived while executing time-critical code.  This kernel boot
parameter instead runs RCU core processing in an 'rcuc' kthread, thus
allowing the scheduler to do its job of avoiding disrupting time-critical
code.

This commit therefore disables the rcutree.use_softirq kernel boot
parameter on PREEMPT_RT systems, thus forcing such systems to do RCU
core processing in 'rcuc' kthreads.  This approach has long been in
use by users of the -rt patchset, and there have been no complaints.
There is therefore no way for the system administrator to override this
choice, at least without modifying and rebuilding the kernel.

Signed-off-by: Scott Wood <swood@redhat.com>
[bigeasy: Reword commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Update kernel-parameters.txt accordingly. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/rcu/tree.c                               | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..521255f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4092,6 +4092,10 @@
 			value, meaning that RCU_SOFTIRQ is used by default.
 			Specify rcutree.use_softirq=0 to use rcuc kthreads.
 
+			But note that CONFIG_PREEMPT_RT=y kernels disable
+			this kernel boot parameter, forcibly setting it
+			to zero.
+
 	rcutree.rcu_fanout_exact= [KNL]
 			Disable autobalancing of the rcu_node combining
 			tree.  This is used by rcutorture, and might
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..d609035 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -100,8 +100,10 @@ static struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = true;
+static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(use_softirq, bool, 0444);
+#endif
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
