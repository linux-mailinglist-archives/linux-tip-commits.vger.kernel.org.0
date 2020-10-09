Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B11288237
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgJIGfl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbgJIGfh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:37 -0400
Date:   Fri, 09 Oct 2020 06:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LPkTdcPUCdKrCLgh51HE//SNhTebXCVLktJ5NJZ3Dgs=;
        b=gJ2FCCr6+apqvCeL/nNkyN0ijdIfxcVAZqYfnLcPWnrsXRMNpVozgO3qAC0VUzsaJGJqbu
        C5cEwIKhZMXhvZZ1VbHe93r6B6iDyAuUnmjAQ2VmL+y80OtC/o/ufwNHU32eq0VNPsTl6E
        ZWA5OZMW1S8KBIPjgA7AfAHcs4ztn8RSzIEAWIRDgStfts8+6v4Ds4vGVMpFcSqn9ZF7QE
        sUDSN8Hg818OpTKncYSqleCRVTw7JWE0xKtW1Y257OXKYPI8pIrDRQZWC2FBwVj7713ucf
        FtTymca1n7iTMuQYnauJVLzQ7VxLQLtr/td0O4K/jKuZ+fnQEj4MVx+kDYwofQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LPkTdcPUCdKrCLgh51HE//SNhTebXCVLktJ5NJZ3Dgs=;
        b=vTApOnilTDgbMBBEz7ikuUEOlajRkBEJDqM91w7Jtn2eemqpyxKWxpKtMtStQeQKlokAJ0
        pBYC8M+EN4xJKRAA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Clarify comments about FQS loop reporting
 quiescent states
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533513.7002.3197971404035541858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f37599e6f06da47e49c3408afe66c5b6e83a90bd
Gitweb:        https://git.kernel.org/tip/f37599e6f06da47e49c3408afe66c5b6e83a90bd
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Fri, 07 Aug 2020 13:07:19 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:37:55 -07:00

rcu: Clarify comments about FQS loop reporting quiescent states

Since at least v4.19, the FQS loop no longer reports quiescent states
for offline CPUs except in emergency situations.

This commit therefore fixes the comment in rcu_gp_init() to match the
current code.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 52108dd..2c7afe4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1706,10 +1706,13 @@ static bool rcu_gp_init(void)
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
-	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
-	 * will handle subsequent offline CPUs.
+	 * Apply per-leaf buffered online and offline operations to
+	 * the rcu_node tree. Note that this new grace period need not
+	 * wait for subsequent online CPUs, and that RCU hooks in the CPU
+	 * offlining path, when combined with checks in this function,
+	 * will handle CPUs that are currently going offline or that will
+	 * go offline later.  Please also refer to "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
