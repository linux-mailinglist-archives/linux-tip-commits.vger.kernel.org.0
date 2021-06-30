Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C13B83AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhF3Nuc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhF3NuH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:07 -0400
Date:   Wed, 30 Jun 2021 13:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M75XibQsFyPlF5JkI7ERcYXwDzRGjnxSrvXQslc3ZsQ=;
        b=tOaZAwv/m0dleVOw/CeuxPFMymHsheJaBw4A3y/W1DPA6pq/vozrUT+wK2A5M8d0guCqxV
        rrXZ4xUbm6dSx/1D3X0XO8OCv0LRBrMGGQiG0k8x7+G8W0vEUWe559AG1ZpSNf+wyqpIvS
        Ok16yTjSRVdy6e9ynDqtepbIvGLIPN745/5cmv+Rle3PrUAVqdi2uLd6CROMm4hezD0idl
        OAkKHQmvoAShm7mfmXHdX0kcX/4ioQ4kYYwi5chzuhSMV00tNjqqPncSyPAu12sO47ujsx
        h9yRNAc9+ZI1l3B2ISd0TxvGLcBzFg6GVlx/hTd6Cs5EprRJ+sVaj54giGPjCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M75XibQsFyPlF5JkI7ERcYXwDzRGjnxSrvXQslc3ZsQ=;
        b=PGPQWJs3UcEmf6ki7kmdOlkKRzOswdmG0qXP1/hkACu6wgDtcsJnWxrqoc9r3KaoaHhRq2
        AE9ve0+ouasgAADg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Invoke rcu_spawn_core_kthreads() from
 rcu_spawn_gp_kthread()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085703.395.9873664304463955552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e4b1d2bc198e34b48fc7cc3a3c5a2fcb269e271
Gitweb:        https://git.kernel.org/tip/8e4b1d2bc198e34b48fc7cc3a3c5a2fcb269e271
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 31 Mar 2021 10:59:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()

Currently, rcu_spawn_core_kthreads() is invoked via an early_initcall(),
which works, except that rcu_spawn_gp_kthread() is also invoked via an
early_initcall() and rcu_spawn_core_kthreads() relies on adjustments to
kthread_prio that are carried out by rcu_spawn_gp_kthread().  There is
no guaranttee of ordering among early_initcall() handlers, and thus no
guarantee that kthread_prio will be properly checked and range-limited
at the time that rcu_spawn_core_kthreads() needs it.

In most cases, this bug is harmless.  After all, the only reason that
rcu_spawn_gp_kthread() adjusts the value of kthread_prio is if the user
specified a nonsensical value for this boot parameter, which experience
indicates is rare.

Nevertheless, a bug is a bug.  This commit therefore causes the
rcu_spawn_core_kthreads() function to be invoked directly from
rcu_spawn_gp_kthread() after any needed adjustments to kthread_prio have
been carried out.

Fixes: 48d07c04b4cc ("rcu: Enable elimination of Tree-RCU softirq processing")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06f3de9..2532e58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2889,7 +2889,6 @@ static int __init rcu_spawn_core_kthreads(void)
 		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
 	return 0;
 }
-early_initcall(rcu_spawn_core_kthreads);
 
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
@@ -4450,6 +4449,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
 	rcu_spawn_boost_kthreads();
+	rcu_spawn_core_kthreads();
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
