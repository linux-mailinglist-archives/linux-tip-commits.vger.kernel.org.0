Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43244A0A0C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfH1S4T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 14:56:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48150 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfH1S4T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 14:56:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3377-0002d0-Od; Wed, 28 Aug 2019 20:56:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A4621C0DE2;
        Wed, 28 Aug 2019 20:56:13 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:56:13 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] MAINTAINERS: Update from paulmck@linux.ibm.com to
 paulmck@kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156701857329.18445.9457677423596381777.tip-bot2@tip-bot2>
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

Commit-ID:     049b405029c00f3fd9e4ffa269bdd29b429c4672
Gitweb:        https://git.kernel.org/tip/049b405029c00f3fd9e4ffa269bdd29b429c4672
Author:        Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate:    Mon, 26 Aug 2019 16:02:56 -07:00
Committer:     Paul E. McKenney <paulmck@linux.ibm.com>
CommitterDate: Mon, 26 Aug 2019 16:27:08 -07:00

MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org

Note that the paulmck@linux.ibm.com still works most of the time.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5273170..e200eb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9334,7 +9334,7 @@ M:	Nicholas Piggin <npiggin@gmail.com>
 M:	David Howells <dhowells@redhat.com>
 M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
@@ -10363,7 +10363,7 @@ F:	drivers/platform/x86/mlx-platform.c
 
 MEMBARRIER SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	kernel/sched/membarrier.c
@@ -13476,7 +13476,7 @@ S:	Orphan
 F:	drivers/net/wireless/ray*
 
 RCUTORTURE TEST FRAMEWORK
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -13523,7 +13523,7 @@ F:	arch/x86/include/asm/resctrl_sched.h
 F:	Documentation/x86/resctrl*
 
 READ-COPY UPDATE (RCU)
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -13681,7 +13681,7 @@ F:	include/linux/reset-controller.h
 RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
@@ -14710,7 +14710,7 @@ F:	mm/sl?b*
 
 SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -16207,7 +16207,7 @@ F:	drivers/platform/x86/topstar-laptop.c
 
 TORTURE-TEST MODULES
 M:	Davidlohr Bueso <dave@stgolabs.net>
-M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
+M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
