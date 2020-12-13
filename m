Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA22D8FAD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgLMTED (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:04:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgLMTBo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:44 -0500
Date:   Sun, 13 Dec 2020 19:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qhKYu1Ldu+f1TgbS5XS0Rify3c1y+IUY9L5eSuHtCyY=;
        b=RoGnWRNNuimNAmKoA47cZIQJyXu1gkYeS6VKXGpAsGmKDmzUd0RXq5ZP68Uo9Z/QXIPAfZ
        EgTtDk048mtSw2TO6CGSbi0T1a6esVr8KNhYHsQpj9J5Zcd3HZQb38w+UxLgUvjrkK5R2/
        7//jpYuuWZ+FI5HVVY2G6pN+FW5W1Ym0N0C9LuywLMUIGALeuqiQO1ySQfeRPqbc4fz6Bb
        1wwMgNDnffnGfdwn6lyUx6vSrfAbsIncPOkCigb/DQtLOWb6RqSjwN4l+/dbQrWSV/jCp4
        zR2qfl/5wD66rXugXeCOVkjUXwlAcAhDcD1MHdJQYeONahoYZzyjaH5GVv/J+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qhKYu1Ldu+f1TgbS5XS0Rify3c1y+IUY9L5eSuHtCyY=;
        b=Nmd3jSZ0j2fW16UaoLuvfhp+i1nX4PQppCqUrcZwMz0v7cElpWr334eeuceYSdZtCCHYQ7
        gKTx3n9WHW9gEjDg==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606186.3364.10216145648628597394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a3941517fcd6625adc540aef5ec3f717c8fa71e8
Gitweb:        https://git.kernel.org/tip/a3941517fcd6625adc540aef5ec3f717c8fa71e8
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Thu, 24 Sep 2020 12:04:10 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config

This commit clarifies that the "p" and the "s" in the in the RCU_NOCB_CPU
config-option description refer to the "x" in the "rcuox/N" kthread name.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
[ paulmck: While in the area, update description and advice. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..cdc57b4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -221,19 +221,23 @@ config RCU_NOCB_CPU
 	  Use this option to reduce OS jitter for aggressive HPC or
 	  real-time workloads.	It can also be used to offload RCU
 	  callback invocation to energy-efficient CPUs in battery-powered
-	  asymmetric multiprocessors.
+	  asymmetric multiprocessors.  The price of this reduced jitter
+	  is that the overhead of call_rcu() increases and that some
+	  workloads will incur significant increases in context-switch
+	  rates.
 
 	  This option offloads callback invocation from the set of CPUs
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
-
-	  Say Y here if you want to help to debug reduced OS jitter.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
+
+	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
 config TASKS_TRACE_RCU_READ_MB
