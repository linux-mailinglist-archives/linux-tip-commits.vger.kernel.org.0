Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447683B83A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhF3Nu2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhF3NuD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:03 -0400
Date:   Wed, 30 Jun 2021 13:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BmrCEHzPuZ2P33HLKLlbSmPtl64zirpK9AIyrAiF7uM=;
        b=fEQb9kJRu2pOpAUdl72AcZdeuMHWQupU/UoqglRPXSgCrfaizAGsqiHCadbEVXtnV05TGR
        qLOllQY9jxISU8rMDYB74SqBV4HWk0US45vUTk66ILWT+DRZEWx4iTfXRrYbosDnNKwnO3
        Bh04UJCnIxOuD/uOhiFtt+9YwInN6P2oW0+9a8ZpPtzyxHcrzRroSJHEumcuGwQmQ5gmLk
        H8DVo/KCQW4H4d8RHZyf3kHgbeDa/SUn+kIZFCf2kjUocU8ebuJS3dBCGX8QAiLCX80NTc
        NyHZM3D1vOjJU/O8N2lORMozqSU6xFhkym4ooFxMNTpEI9/NF8aJKSpaSYXBhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BmrCEHzPuZ2P33HLKLlbSmPtl64zirpK9AIyrAiF7uM=;
        b=vC21HuOxQGqU7eEcluH8qrcKa54vta739knrAPw+A0AdX+Q9KjHw8ZsEoaArbLEvQe8qyS
        06aCrvirSf13z2Dg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085275.395.50984527438365289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4d80b8e196fad9852050f3c8624eea09a6bbeada
Gitweb:        https://git.kernel.org/tip/4d80b8e196fad9852050f3c8624eea09a6bbeada
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 07 Apr 2021 15:21:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs

Kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y can experience
significant lock contention due to RCU's resulting focus on ending grace
periods as soon as possible.  This is OK, but only if there are not very
many CPUs.  This commit therefore puts this Kconfig option off-limits
to systems with more than four CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1942c1f..4fd6499 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -116,7 +116,7 @@ config RCU_EQS_DEBUG
 
 config RCU_STRICT_GRACE_PERIOD
 	bool "Provide debug RCU implementation with short grace periods"
-	depends on DEBUG_KERNEL && RCU_EXPERT
+	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4
 	default n
 	select PREEMPT_COUNT if PREEMPT=n
 	help
