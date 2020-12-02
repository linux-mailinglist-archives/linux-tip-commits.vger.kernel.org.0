Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11732CB91F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgLBJjd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388252AbgLBJjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0DC0617A6;
        Wed,  2 Dec 2020 01:38:29 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqXFfAZNyRw9Fb25xNpxRDEXP61srZBre0/XZS1Zk2g=;
        b=D+rI16Wx4fgnqONrrcf3hbgw/zN78RaeY3UPpSXfYk9ketdkuqeqHiHF5jUyozYmeRSKu7
        l4qQ6nBPl1knEXC6xcecjNP2TZSZN7+9TUbxlHU1Fl/pTQguhLyKgYIuikJoqWu8WdmNYH
        K+8IQXFqAH8kjHVJ8qHkXUZPKEZ+YHy/GeQqktPp465an65AX0DUn8G/GDva0tf+lXcxlg
        lP1EYNcgXvqxBdWQqYt/jVwN6IwQ/+Zi1rONtLROXD6CLdbgbFr34O6GcX1/UAs3l7AGBF
        18L/MY+DFwZ0eIABxSSnCYGpKX6sMjEC3922/Zz9CJdRJ4I4BRAaX+wlrQfe4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqXFfAZNyRw9Fb25xNpxRDEXP61srZBre0/XZS1Zk2g=;
        b=tuALIVnuuTYZBjDDqyNlDKuhRDPgDBIFg1AHScbuPiSlSjRQNwJTWgHJExIm3onc4liqGO
        jOobBvKrSDbKo/BA==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Rename exit_to_user_mode()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201142755.31931-3-svens@linux.ibm.com>
References: <20201201142755.31931-3-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160690190705.3364.1388958360043512749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     f052615ca0112378c3571fc9662bbbcd18cf6b8d
Gitweb:        https://git.kernel.org/tip/f052615ca0112378c3571fc9662bbbcd18cf6b8d
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:18 +01:00

entry: Rename exit_to_user_mode()

In order to make this function publicly available rename it so it can still
be inlined. An additional exit_to_user_mode() function will be added with
a later commit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201201142755.31931-3-svens@linux.ibm.com

---
 kernel/entry/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8e294a7..dff07b4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -122,7 +122,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 }
 
 /**
- * exit_to_user_mode - Fixup state when exiting to user mode
+ * __exit_to_user_mode - Fixup state when exiting to user mode
  *
  * Syscall/interupt exit enables interrupts, but the kernel state is
  * interrupts disabled when this is invoked. Also tell RCU about it.
@@ -133,7 +133,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
  *    mitigations, etc.
  * 4) Tell lockdep that interrupts are enabled
  */
-static __always_inline void exit_to_user_mode(void)
+static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
@@ -299,7 +299,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
@@ -312,7 +312,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
