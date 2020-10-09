Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84D2882A4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgJIGij (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbgJIGfW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:22 -0400
Date:   Fri, 09 Oct 2020 06:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ultAcx4AIdBgJ+HhsRtBTZB86jq7uf/s6e4g99lbCs8=;
        b=H743syxaiG4rZB2AO71xDfu0SWSRnMHtuG6ZkTqLCGY6GwCGNH4x0E7VhrtKo+v/CACSaj
        nbZYp2iFaF0gEuH/8TsUr4TiJL+kz0/FmL71stkNiaTjO8Lz2oBI2/3AyFQSdQp51CRZ6z
        j9CgheD6bol91oQcTFZe6Ia55tIU8XekUBlVUbpYByGU0eEoAphWdNEjOQ2wkJpzM17dA2
        sPRgRwzLtuzQzZ2yYvP7kYndooq15qMKfqov58yVa4X80kxzE9JHdMl8qfVcrTaphMPGXG
        XRumVpDCfFF7QXg9hZMiqXH3QBkG+gaB3LYGagCdCChNDV64jCmQM62+aZyq7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ultAcx4AIdBgJ+HhsRtBTZB86jq7uf/s6e4g99lbCs8=;
        b=NMKcVJ26Bpr/8+Hsu1FpQtDXHOzhoQqZm9DdeK8IhPkdrMXViNyckUhfrLT3ybB9miWN6V
        INbp+hd9eMfaNVBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide optional RCU-reader exit delay for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531894.7002.9393828135273571405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d29aaf1ef992b5b4612fe32b9e6f517f7bba904
Gitweb:        https://git.kernel.org/tip/3d29aaf1ef992b5b4612fe32b9e6f517f7bba904
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 07 Aug 2020 13:44:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:27 -07:00

rcu: Provide optional RCU-reader exit delay for strict GPs

The goal of this series is to increase the probability of tools like
KASAN detecting that an RCU-protected pointer was used outside of its
RCU read-side critical section.  Thus far, the approach has been to make
grace periods and callback processing happen faster.  Another approach
is to delay the pointer leaker.  This commit therefore allows a delay
to be applied to exit from RCU read-side critical sections.

This slowdown is specified by a new rcutree.rcu_unlock_delay kernel boot
parameter that specifies this delay in microseconds, defaulting to zero.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/rcu/tree_plugin.h                        | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..cb90624 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4152,6 +4152,15 @@
 			This wake_up() will be accompanied by a
 			WARN_ONCE() splat and an ftrace_dump().
 
+	rcutree.rcu_unlock_delay= [KNL]
+			In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels,
+			this specifies an rcu_read_unlock()-time delay
+			in microseconds.  This defaults to zero.
+			Larger delays increase the probability of
+			catching RCU pointer leaks, that is, buggy use
+			of RCU-protected pointers after the relevant
+			rcu_read_unlock() has completed.
+
 	rcutree.sysrq_rcu= [KNL]
 			Commandeer a sysrq key to dump out Tree RCU's
 			rcu_node tree with an eye towards determining
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfdb902..3f3a4ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -430,6 +430,12 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return !list_empty(&rnp->blkd_tasks);
 }
 
+// Add delay to rcu_read_unlock() for strict grace periods.
+static int rcu_unlock_delay;
+#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
+module_param(rcu_unlock_delay, int, 0444);
+#endif
+
 /*
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
@@ -460,10 +466,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	}
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
-		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
 			rcu_report_qs_rdp(rdp->cpu, rdp);
-		else
+			udelay(rcu_unlock_delay);
+		} else {
 			rcu_qs();
+		}
 	}
 
 	/*
