Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE79135B520
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhDKNpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhDKNod (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:33 -0400
Date:   Sun, 11 Apr 2021 13:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BVR+E1ujL8ah5KVCZfRjKKS6ZhUnHmUplGiXEKJHZJs=;
        b=zM0nwpGTv2Kqyi1+HY+4QLdcD9yiyfDAcl/nBIAvPC0vRJftEQuM+f35ERgUaRV9WX1Swr
        MMP0LvmM/PGnl9lYavwhrFAvtRF45np6sssG2CGGgnGhRXCjq3t/15ayIUBpNVw02BXyHn
        0bJvWpYk2NNtYlBjRE4Sdh+0FGF7lBTnHEb0n7gJ/uuaRzIu2Fb/Nes/8PyBWJrbfLZHc3
        5ah67yJ59ac3r6B4hr4c5flcpe0zyHTjbNzOAe9FApUNOFQ/6tadghspB6kV1ZaNeAA0Ww
        K00UCQfQmVAcfDoM/jv7so9B5wTFbmQ/JPqiLyB4foKK1+Uoqwzjh8/gyxbWUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BVR+E1ujL8ah5KVCZfRjKKS6ZhUnHmUplGiXEKJHZJs=;
        b=RqQlE6GLRM9PCjIO7CN7N6lxhzO+odRd+y5AnG5z6cufXDFa6g1B8HfeftgHnSgWEuBSA/
        rCYX2IZ+Jm/N2DAg==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: deprecate "all" option to rcu_nocbs=
Cc:     Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862402.29796.123664795038375752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3e70df91f961b9df7ab3c0ae1934bdf15454c536
Gitweb:        https://git.kernel.org/tip/3e70df91f961b9df7ab3c0ae1934bdf15454c536
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:27 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

rcu: deprecate "all" option to rcu_nocbs=

With the core bitmap support now accepting "N" as a placeholder for
the end of the bitmap, "all" can be represented as "0-N" and has the
advantage of not being specific to RCU (or any other subsystem).

So deprecate the use of "all" by removing documentation references
to it.  The support itself needs to remain for now, since we don't
know how many people out there are using it currently, but since it
is in an __init area anyway, it isn't worth losing sleep over.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +---
 kernel/rcu/tree_plugin.h                        | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..83e2ef1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4068,9 +4068,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..0b95562 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1464,14 +1464,12 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
 		cpumask_setall(rcu_nocb_mask);
 	else
 		if (cpulist_parse(str, rcu_nocb_mask)) {
