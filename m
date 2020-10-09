Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33522882A3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgJIGii (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbgJIGfX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:23 -0400
Date:   Fri, 09 Oct 2020 06:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hPnO8QXfvQfdOjv/lpS2xmbp/8I1sbq5gsBHRfuJ/sk=;
        b=mMDFXlcg5EQRQTV9irhdr3nvOULrFrU8Fwk/LoENziV78sBHwDvHibQ1xPr8nnAZAYuNV6
        nLwWMMMO/HckowfqqWq34kGToqSb6F0cK0zjxPHw2Mgs3kdX71/wOv4F0C82renTgcld+e
        YopvNMyPWOTEcdLnAJ4AZ7M3Hon291LW4qdAZOYOLFaYs4ttS0ZpZ8lCkonTAaEKSdH3rf
        xCBvCdOxUJBiDoHGM3gseiZvbnwb/YUrp/byP84beeYGo5MLmDtZ+jx1cF934DAEzNYOoG
        kV79bRWc5gXC8Y9qj8T5jfEAjNSarLTIhZ8Vtf90RkQh/VJxR6LaAgmZqB1l6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hPnO8QXfvQfdOjv/lpS2xmbp/8I1sbq5gsBHRfuJ/sk=;
        b=Vk4XKyONAwXyTq1TOgRuJ3sakcWHkaSHdBuywqom3BSYZa6AWDL6BUivoLDxbmNz20rUkm
        m+x2hKImqgPM+wAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Attempt QS when CPU discovers GP for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532057.7002.10594936632616598969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1a2f5d57a33f7b9189b6b3e997eb858301482d79
Gitweb:        https://git.kernel.org/tip/1a2f5d57a33f7b9189b6b3e997eb858301482d79
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 16:35:08 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:26 -07:00

rcu: Attempt QS when CPU discovers GP for strict GPs

A given CPU normally notes a new grace period during one RCU_SOFTIRQ,
but avoids reporting the corresponding quiescent state until some later
RCU_SOFTIRQ.  This leisurly approach improves efficiency by increasing
the number of update requests served by each grace period, but is not
what is needed for kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y.

This commit therefore adds a new rcu_strict_gp_check_qs() function
which, in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, simply enters and
immediately exist an RCU read-side critical section.  If the CPU is
in a quiescent state, the rcu_read_unlock() will attempt to report an
immediate quiescent state.  This rcu_strict_gp_check_qs() function is
invoked from note_gp_changes(), so that a CPU just noticing a new grace
period might immediately report a quiescent state for that grace period.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4436857..36a860c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1575,6 +1575,19 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 }
 
 /*
+ * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, attempt to generate a
+ * quiescent state.  This is intended to be invoked when the CPU notices
+ * a new grace period.
+ */
+static void rcu_strict_gp_check_qs(void)
+{
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
+		rcu_read_lock();
+		rcu_read_unlock();
+	}
+}
+
+/*
  * Update CPU-local rcu_data state to record the beginnings and ends of
  * grace periods.  The caller must hold the ->lock of the leaf rcu_node
  * structure corresponding to the current CPU, and must have irqs disabled.
@@ -1644,6 +1657,7 @@ static void note_gp_changes(struct rcu_data *rdp)
 	}
 	needwake = __note_gp_changes(rnp, rdp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	rcu_strict_gp_check_qs();
 	if (needwake)
 		rcu_gp_kthread_wake();
 }
