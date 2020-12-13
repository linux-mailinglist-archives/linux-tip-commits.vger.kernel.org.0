Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE62D8F97
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgLMTCK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbgLMTBz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:55 -0500
Date:   Sun, 13 Dec 2020 19:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aK19tajOXU2XxgOEJFIMptYecJ8Q/IP/RnVubEMijIk=;
        b=HdDO4XwmgWsHLKgomqYZk2MsPG0pR52vPlmD++X6SrE47QEy2RbqjyVSVDtr8BP6NyBIOt
        bTAhaubi58zP33dR3OWexsGGcelH1GuA6qJJPb5wFAIxApI41hm78dpubtXjC5XvkTh5Fy
        It/fUYEDcCizkw0Kaebzv1fA9Vxeh4pAmq3GiMFcMidlD2LjZOAo/ogfHWVLHkxowhhje9
        UL6UeF+Hp+3oyxSjeKTcVvAr36LYJiNUynJCSVi+wmddpvZbKKWX1yKv6CX+WEhsvlNRDI
        yvwWxoyg+jtV3fEkg6zxl3UQO58qz74co53Vv0703ygZCTcnK8Gmd+9O73RjkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aK19tajOXU2XxgOEJFIMptYecJ8Q/IP/RnVubEMijIk=;
        b=oyF/cfk2NrPxSzIp29+GtQW8BwlsTxrmMU8lIUI3IKkSJ9KaIW3bo1iHw8hKnKQS3wZSpA
        IMT1t4sa3DUlq0Cg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: Update RCU's hotplug requirements with a bit
 about design
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607173.3364.2022355149628880918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a043260740d5d6ec5be59c3fb595c719890a0b0b
Gitweb:        https://git.kernel.org/tip/a043260740d5d6ec5be59c3fb595c719890a0b0b
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Tue, 29 Sep 2020 15:29:28 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:02:43 -08:00

docs: Update RCU's hotplug requirements with a bit about design

The rcu_barrier() section of the "Hotplug CPU" section discusses
deadlocks, however the description of deadlocks other than those involving
rcu_barrier() is rather incomplete.

This commit therefore continues the section by describing how RCU's
design handles CPU hotplug in a deadlock-free way.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 49 +++++++--
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a1..8807985 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``.
-
-However, all-callback-wait operations such as ``rcu_barrier()`` are also
-not supported, due to the fact that there are phases of CPU-hotplug
-operations where the outgoing CPU's callbacks will not be invoked until
-after the CPU-hotplug operation ends, which could also result in
-deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
-during its execution, which results in another type of deadlock when
-invoked from a CPU-hotplug notifier.
+grace-period operations such as (``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``).  However, these synchronous operations
+do block and therefore cannot be invoked from notifiers that execute via
+``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
+and ``CPUHP_AP_ONLINE`` states.
+
+In addition, all-callback-wait operations such as ``rcu_barrier()`` may
+not be invoked from any CPU-hotplug notifier.  This restriction is due
+to the fact that there are phases of CPU-hotplug operations where the
+outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
+operation ends, which could also result in deadlock. Furthermore,
+``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
+which results in another type of deadlock when invoked from a CPU-hotplug
+notifier.
+
+Finally, RCU must avoid deadlocks due to interaction between hotplug,
+timers and grace period processing. It does so by maintaining its own set
+of books that duplicate the centrally maintained ``cpu_online_mask``,
+and also by reporting quiescent states explicitly when a CPU goes
+offline.  This explicit reporting of quiescent states avoids any need
+for the force-quiescent-state loop (FQS) to report quiescent states for
+offline CPUs.  However, as a debugging measure, the FQS loop does splat
+if offline CPUs block an RCU grace period for too long.
+
+An offline CPU's quiescent state will be reported either:
+1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
+2.  When grace period initialization (``rcu_gp_init()``) detects a
+    race either with CPU offlining or with a task unblocking on a leaf
+    ``rcu_node`` structure whose CPUs are all offline.
+
+The CPU-online path (``rcu_cpu_starting()``) should never need to report
+a quiescent state for an offline CPU.  However, as a debugging measure,
+it does emit a warning if a quiescent state was not already reported
+for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions
+between RCU's hotplug notifier hooks, the grace period initialization
+code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
