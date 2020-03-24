Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E519090E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCXJRy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:17:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44118 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgCXJRM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgN-0008JX-7K; Tue, 24 Mar 2020 10:17:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D07D11C07F8;
        Tue, 24 Mar 2020 10:16:55 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:55 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide debug symbols and line numbers in KCSAN runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141550.28353.6966279749199443086.tip-bot2@tip-bot2>
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

Commit-ID:     8a7e8f51714004112a0bbbf751f3dd0fcbbbc983
Gitweb:        https://git.kernel.org/tip/8a7e8f51714004112a0bbbf751f3dd0fcbbbc983
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 02 Jan 2020 16:48:05 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:21 -08:00

rcu: Provide debug symbols and line numbers in KCSAN runs

This commit adds "-g -fno-omit-frame-pointer" to ease interpretation
of KCSAN output, but only for CONFIG_KCSAN=y kerrnels.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 82d5fba..f91f2c2 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -3,6 +3,10 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT := n
 
+ifeq ($(CONFIG_KCSAN),y)
+KBUILD_CFLAGS += -g -fno-omit-frame-pointer
+endif
+
 obj-y += update.o sync.o
 obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
