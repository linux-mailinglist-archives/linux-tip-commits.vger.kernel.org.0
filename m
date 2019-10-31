Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA87EAF58
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJaLzM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:55:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJaLzL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92i-0002xS-2F; Thu, 31 Oct 2019 12:55:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 593701C04E4;
        Thu, 31 Oct 2019 12:55:00 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:59 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Documentation: Rename rcu_node_context_switch() to
 rcu_note_context_switch()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289998.29376.9578728814186666748.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b1ec18eae0b63a19a05a846c084aa84cbd9c87c6
Gitweb:        https://git.kernel.org/tip/b1ec18eae0b63a19a05a846c084aa84cbd9c87c6
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 27 Aug 2019 09:00:44 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 29 Oct 2019 02:48:29 -07:00

Documentation: Rename rcu_node_context_switch() to rcu_note_context_switch()

While Paul was explaining some RCU magic I noticed a typo in
rcu_note_context_switch().  As a result, this commit replaces
rcu_node_context_switch() with rcu_note_context_switch().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg               | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 248b122..1a8b129 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -423,7 +423,7 @@ wait on.
 +-----------------------------------------------------------------------+
 
 If the CPU does a context switch, a quiescent state will be noted by
-``rcu_node_context_switch()`` on the left. On the other hand, if the CPU
+``rcu_note_context_switch()`` on the left. On the other hand, if the CPU
 takes a scheduler-clock interrupt while executing in usermode, a
 quiescent state will be noted by ``rcu_sched_clock_irq()`` on the right.
 Either way, the passage through a quiescent state will be noted in a
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 2bcd742..069f6f8 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3880,7 +3880,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_node_context_switch()</text>
+         xml:space="preserve">rcu_note_context_switch()</text>
     </g>
     <g
        transform="translate(1881.1886,54048.57)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index 779c9ac..7d6c5f7 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -753,7 +753,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_node_context_switch()</text>
+         xml:space="preserve">rcu_note_context_switch()</text>
     </g>
     <g
        transform="translate(3131.2648,-585.6713)"
