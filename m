Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62E3B83A6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhF3Nu1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhF3NuD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AAC0617AE;
        Wed, 30 Jun 2021 06:47:34 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R8kTnQwoEbSv1KgfxiIKdS5m5ASUPkG+NxYKS/vaKy4=;
        b=JqBTNwMtV8QrMl20vZHIE5SJvpe/7xN8hLAq3YV7l0cCnN0aM4q/cwI0vgeJJ5UtTjA8iK
        h2/fgNoweoTdzCaZE7OFxzEbq27YkEwMoSbMLEKri5deAmDEx1++ctAtMfY+EJ72idctQH
        rn1b1oienMsuZSksuPjb6dRo8QxgnoVl4fDRuYkbMrSG4zS34N8yJQud8wbEOEWXDAJbxL
        yREQiELFP/wYDS+shG3ZPJpFzrIVXff4ChG5Cm8XtPRXEOcyCfvGXTmmHiuGetH3/vDV+8
        az9y/V+7cVwSgVzxKns87cAYXgCxM0US7O5Qah6IGpODCJO6jsQO4S04OenzOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R8kTnQwoEbSv1KgfxiIKdS5m5ASUPkG+NxYKS/vaKy4=;
        b=xGp4FkeM3el9AAlF1S6z21n0rz3wbZzfzePaOgd4wYcga2Puj//oQI25vyWKtPe4q+h+j5
        wGc1aARKKpRqFUDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make rcu_gp_cleanup() be noinline for tracing
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085229.395.12015743587088607685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2f20de99a63b0de9bcceedafc3281e65fbf7d4fd
Gitweb:        https://git.kernel.org/tip/2f20de99a63b0de9bcceedafc3281e65fbf7d4fd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 11 Apr 2021 10:49:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Make rcu_gp_cleanup() be noinline for tracing

Although there are trace events for RCU grace periods, these are only
enabled in CONFIG_RCU_TRACE=y kernels.  This commit therefore marks
rcu_gp_cleanup() noinline in order to provide a function that can be
traced that is invoked near the end of each grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 00a3ebc..6eb64e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2026,7 +2026,7 @@ static void rcu_gp_fqs_loop(void)
 /*
  * Clean up after the old grace period.
  */
-static void rcu_gp_cleanup(void)
+static noinline void rcu_gp_cleanup(void)
 {
 	int cpu;
 	bool needgp = false;
