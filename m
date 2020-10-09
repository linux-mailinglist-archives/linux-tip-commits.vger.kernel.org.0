Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EFC288298
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgJIGiO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbgJIGf0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50FC0613DB;
        Thu,  8 Oct 2020 23:35:25 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a9A2Qj4e5LNnQd1bHY/ymov1oqwXcDB9VLQrsElYBy4=;
        b=3cWJHKakabzM5yGNHWGgbwCUBg6Asi/hJm/m8/pf+In5OgA4n19DfjOCOM+YtMwzOnQ0dO
        jQL+epEOJGK/AH+cKCoquWK7ScFsFYmt1Pha83xI0bGwmBtK7d22aNhZDT5AoHJ2LuyxL5
        hYjuVjrR/ONwXYcVg1n6wGwcurHVyyVFaeVPjqDIXdacLcxaZeYHsFxeNDkDSffk2irgXZ
        7RcBkSYmBNxE9POUKYz8aHaffLwcoVLcP+5ZeS1Eru+xfTxr8quQce9qDvX9As0zLnZ1qu
        A/dIFzhRalQhPeIUU2iU1u1QTHtzXW4K7YRJGclca6p4sm8diuSy0LhCcMgzHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a9A2Qj4e5LNnQd1bHY/ymov1oqwXcDB9VLQrsElYBy4=;
        b=pQaZusIFvtgG7J2IsojWES8y0yeeNz9Y3j12oHtdi14dnhaG7UwWFvqHG8c449jLIkXZP3
        qH7MWdmgT2qa8HCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Reduce leaf fanout for strict RCU grace periods
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532326.7002.17818852493729855728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dc1269186bed3afc5a2018527516be84fe55d3e0
Gitweb:        https://git.kernel.org/tip/dc1269186bed3afc5a2018527516be84fe55d3e0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Aug 2020 16:52:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:23 -07:00

rcu: Reduce leaf fanout for strict RCU grace periods

Because strict RCU grace periods will complete more quickly, they will
experience greater lock contention on each leaf rcu_node structure's
->lock.  This commit therefore reduces the leaf fanout in order to reduce
this lock contention.

Note that this also has the effect of reducing the number of CPUs
supported to 16 in the case of CONFIG_RCU_FANOUT_LEAF=2 or 81 in the
case of CONFIG_RCU_FANOUT_LEAF=3.  However, greater numbers of CPUs are
probably a bad idea when using CONFIG_RCU_STRICT_GRACE_PERIOD=y.  Those
wishing to live dangerously are free to edit their kernel/rcu/Kconfig
files accordingly.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0ebe15a..b71e21f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -135,10 +135,12 @@ config RCU_FANOUT
 
 config RCU_FANOUT_LEAF
 	int "Tree-based hierarchical RCU leaf-level fanout value"
-	range 2 64 if 64BIT
-	range 2 32 if !64BIT
+	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 2 3 if RCU_STRICT_GRACE_PERIOD
 	depends on TREE_RCU && RCU_EXPERT
-	default 16
+	default 16 if !RCU_STRICT_GRACE_PERIOD
+	default 2 if RCU_STRICT_GRACE_PERIOD
 	help
 	  This option controls the leaf-level fanout of hierarchical
 	  implementations of RCU, and allows trading off cache misses
