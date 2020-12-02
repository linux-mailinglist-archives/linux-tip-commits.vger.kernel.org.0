Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7CA2CBF3B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgLBOMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgLBOMo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8EC0613D4;
        Wed,  2 Dec 2020 06:12:03 -0800 (PST)
Date:   Wed, 02 Dec 2020 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOk8c/T+ua7VKqJwatAWz8PEJ5wH5Uiv4aj4CnDREAI=;
        b=xMWegTBzHAruwLCvaRcLlvwpRpIpNtfek2NQVYhbWgOXSV0WTj3hxYf2mjoCB0+WOKq3qg
        H2ehkiBZlQ7t+JAMd+vubIc9Hr2EugJxm6CYfyBgAg8Z1uDl8xGPonWtZzm9SUjGVtIWFl
        kPBhCGVoZalrIaKZJcNopVVwq8l/9Y+oYkdjXWBzy7+3a3f4ioTEWbjAox97kuIJFQ78eB
        HSsYU042I3EPJHOor0EiBEtPnunF4gOj3FB7sdcDc9e4+DVoEi+9oQ98CDkEjiMsq4Am1l
        T44tiAS240CUI6MYu/cFK/2RcOjtc2Owydz/rihiISBirdAwO+UmkerGxTXzng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOk8c/T+ua7VKqJwatAWz8PEJ5wH5Uiv4aj4CnDREAI=;
        b=wEKzwK1yel7KyVpZgMQWBOCa/NvXKZ0aNMIR0rD4tE47KkELEKco7XykFRMNDmKS08imtP
        wBNLfdZiVLGzc2DQ==
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
Message-ID: <160691832213.3364.4766112716143844753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     bb793562f0da7317adf6c456316bca651ff46f5d
Gitweb:        https://git.kernel.org/tip/bb793562f0da7317adf6c456316bca651ff46f5d
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:57 +01:00

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
