Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EF3B8410
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhF3NwL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhF3Nuu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:50 -0400
Date:   Wed, 30 Jun 2021 13:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4ApfSJZ/b6C1ev2ily99lhwL5g/RNDcH89Cs5O7sC1I=;
        b=pRnjmlUFiyt8bl/q5o9fwGuABVnID8RTCqA7CMpKMx5FYz3ZVAEvCS2Uwz8s0IeVlXp9Gl
        mXrpD/jP2toRQPeG5M0fmrxdpYCvpnvSAUC9wXpLFjU8MqF+AUHfM3AYX01vB+tj7YbzqG
        /TtKQXgVx2HH6Ly492Y6MSv+aMh+F/2DCT6CVPjIwNYrl0WoOBgDJ0A+AaCzNtkfDmznjy
        WoPTk83gJEr9YOl8lluVar+RFCQeeYN4VptXDcP2UAuq61IucTx/wUO+0XjxPUT/AR6MNc
        ZiM7E/wU64aX3lyMpghMqr7KWMGOKz+myq4PJa/yQzQw7xEbRHE1eQxFsWt6vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4ApfSJZ/b6C1ev2ily99lhwL5g/RNDcH89Cs5O7sC1I=;
        b=qOrok+oBHDkP5zTkCJ3Vr0SruyIocTJ2slco9wg90HWCKP/qvkEhgSswDWUqSTryMjDDo/
        TIWaFH0eyQ1Mf3AA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/rcu: Add drgn script to dump number of RCU callbacks
Cc:     Richard Weinberger <richard@nod.at>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088118.395.9310491266899099190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e5bd61e82b7a60c92bc09a618a0d8a612689037b
Gitweb:        https://git.kernel.org/tip/e5bd61e82b7a60c92bc09a618a0d8a612689037b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 22 Apr 2021 11:55:43 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:39:19 -07:00

tools/rcu: Add drgn script to dump number of RCU callbacks

This commit adds an rcu-cbs.py drgn script that computes the number of
RCU callbacks waiting to be invoked.  This information can be helpful
when managing systems that are short of memory and that have software
components that make heavy use of RCU, for example, by opening and
closing files in tight loops.  (But please note that there are almost
always better ways to get your job done than by opening and closing
files in tight loops.)

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/rcu/rcu-cbs.py | 46 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+)
 create mode 100644 tools/rcu/rcu-cbs.py

diff --git a/tools/rcu/rcu-cbs.py b/tools/rcu/rcu-cbs.py
new file mode 100644
index 0000000..f8b461b
--- /dev/null
+++ b/tools/rcu/rcu-cbs.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Dump out the number of RCU callbacks outstanding.
+#
+# On older kernels having multiple flavors of RCU, this dumps out the
+# number of callbacks for the most heavily used flavor.
+#
+# Usage: sudo drgn rcu-cbs.py
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+import sys
+import drgn
+from drgn import NULL, Object
+from drgn.helpers.linux import *
+
+def get_rdp0(prog):
+	try:
+		rdp0 = prog.variable('rcu_preempt_data', 'kernel/rcu/tree.c');
+	except LookupError:
+		rdp0 = NULL;
+
+	if rdp0 == NULL:
+		try:
+			rdp0 = prog.variable('rcu_sched_data',
+					     'kernel/rcu/tree.c');
+		except LookupError:
+			rdp0 = NULL;
+
+	if rdp0 == NULL:
+		rdp0 = prog.variable('rcu_data', 'kernel/rcu/tree.c');
+	return rdp0.address_of_();
+
+rdp0 = get_rdp0(prog);
+
+# Sum up RCU callbacks.
+sum = 0;
+for cpu in for_each_possible_cpu(prog):
+	rdp = per_cpu_ptr(rdp0, cpu);
+	len = rdp.cblist.len.value_();
+	# print("CPU " + str(cpu) + " RCU callbacks: " + str(len));
+	sum += len;
+print("Number of RCU callbacks in flight: " + str(sum));
