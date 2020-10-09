Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFE28829D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgJIGiX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbgJIGf0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57003C0613D9;
        Thu,  8 Oct 2020 23:35:24 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VEgf26RzggCubPXzupqdHIFViKuOabmXpAbO3PT+QY4=;
        b=ZLRLFvIwqkTxEW5JXELEgGjy3Pm58UJUimgFTh8YVt0FRR1bi0Rj/03U0giGi4B0/Hmxqc
        a6+61wyyrtUum7AhUFHr2BthnM2WhgQr6jOnxJAbzGC55xB/Ss56+vxhp6YAnG3+Vz9t4S
        hy1kHbS86hDGrRCpxrNewlWuPkbscCWKn9JO6cizzFwaim8c52CttzPJ3Tpv+ZiClScDku
        6dwePgD4+hR9arrauE7I4OM5oN2wkTqnfxITPCvn2mcvs1t2feFGE3GcpsjvNZxNdV8Tl2
        oUQHP3Z84tFV+Elx9f/KQtH1BcyJAlyX14p+U0op74un5ulGr4sqcrpeBPsVKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VEgf26RzggCubPXzupqdHIFViKuOabmXpAbO3PT+QY4=;
        b=nC04CpCjCZtSz/MZFyYiOVYZAWrLzerIGNF1h7nCMDauBoTu2kkwD4tVn7mqCWu+NgTkp7
        kyN9k+yaNuHen9CQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532224.7002.16877228121557722513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     29fc5f93320cb447f83baedfe103ed784cadb073
Gitweb:        https://git.kernel.org/tip/29fc5f93320cb447f83baedfe103ed784cadb073
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 06:39:30 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:24 -07:00

rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs

The value of DEFAULT_RCU_BLIMIT is normally set to 10, the idea being to
avoid needless response-time degradation due to RCU callback invocation.
However, when CONFIG_RCU_STRICT_GRACE_PERIOD=y it is better to avoid
throttling callback execution in order to better detect pointer
leaks from RCU read-side critical sections.  This commit therefore
sets the value of DEFAULT_RCU_BLIMIT to 1000 in kernels built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8551159..4436857 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -468,17 +468,18 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
-#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
-#define DEFAULT_MAX_RCU_BLIMIT 10000 /* ... even during callback flood. */
+#define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
+				// Maximum callbacks per rcu_do_batch ...
+#define DEFAULT_MAX_RCU_BLIMIT 10000 // ... even during callback flood.
 static long blimit = DEFAULT_RCU_BLIMIT;
-#define DEFAULT_RCU_QHIMARK 10000 /* If this many pending, ignore blimit. */
+#define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
 static long qhimark = DEFAULT_RCU_QHIMARK;
-#define DEFAULT_RCU_QLOMARK 100   /* Once only this many pending, use blimit. */
+#define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
 static long qlowmark = DEFAULT_RCU_QLOMARK;
 #define DEFAULT_RCU_QOVLD_MULT 2
 #define DEFAULT_RCU_QOVLD (DEFAULT_RCU_QOVLD_MULT * DEFAULT_RCU_QHIMARK)
-static long qovld = DEFAULT_RCU_QOVLD; /* If this many pending, hammer QS. */
-static long qovld_calc = -1;	  /* No pre-initialization lock acquisitions! */
+static long qovld = DEFAULT_RCU_QOVLD; // If this many pending, hammer QS.
+static long qovld_calc = -1;	  // No pre-initialization lock acquisitions!
 
 module_param(blimit, long, 0444);
 module_param(qhimark, long, 0444);
