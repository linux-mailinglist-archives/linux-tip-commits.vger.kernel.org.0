Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFE285C3C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgJGKCv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgJGKCv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A6C061755;
        Wed,  7 Oct 2020 03:02:50 -0700 (PDT)
Date:   Wed, 07 Oct 2020 10:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWWREGokKQ1me5leK/31/ALOJ+Vxwb3kDIVXjPzMi7M=;
        b=z13PPWWg2T8v7+Tg164UF8ionbWma9y75GAymi3EhqpyV7FtqeK+gkcIuFCWpFkqe7NewC
        CGLul0j1r8vu01UP6F/hwmSljGLheewWVxKPvdz2mHgvZ3at5S1SnK+G+bVi6q37jWEaYO
        ILXVeAsOHSLl5nmPCH51uCz2IICmfQ0368TfFQzVlcLTCo5SslgPCxwUQq3/9BeW68UOwm
        OFdl+F13zrhEhV2fE2YYIrsYg+VsrXbKWPHYAQC6vefqprDxJFh9oyKRHj5PfLhjefLOeD
        3iEyvoHs13wdj7NmwSuOXXLqHvC3ImaFN2knlT+TV4mUgDqoEEVeN7nVZ+qUEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWWREGokKQ1me5leK/31/ALOJ+Vxwb3kDIVXjPzMi7M=;
        b=zFwuKp0IVMV6tXlRdZ6UYED/w87m21TI0xUMimZ9w78DiJWe1nyUKfTuHJyDe+fa42VcSG
        WZQX7kmXnzIjPRAQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-5-tony.luck@intel.com>
References: <20201006210910.21062-5-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206496856.7002.10970744380821526233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a2f73400e4dfd13f673c6e1b4b98d180fd1e47b3
Gitweb:        https://git.kernel.org/tip/a2f73400e4dfd13f673c6e1b4b98d180fd1e47b3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:08 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 11:26:56 +02:00

x86/mce: Avoid tail copy when machine check terminated a copy from user

In the page fault case it is ok to see if a few more unaligned bytes
can be copied from the source address. Worst case is that the page fault
will be triggered again.

Machine checks are more serious. Just give up at the point where the
main copy loop triggered the #MC and return from the copy code as if
the copy succeeded. The machine check handler will use task_work_add() to
make sure that the task is sent a SIGBUS.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-5-tony.luck@intel.com
---
 arch/x86/lib/copy_user_64.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 5b68e94..77b9b2a 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
+#include <asm/trapnr.h>
 
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
@@ -221,6 +222,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Try to copy last bytes and clear the rest if needed.
  * Since protection fault in copy_from/to_user is not a normal situation,
  * it is not necessary to optimize tail handling.
+ * Don't try to copy the tail if machine check happened
  *
  * Input:
  * rdi destination
@@ -232,11 +234,24 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
+	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
+	je 3f
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
+	/*
+	 * Return zero to pretend that this copy succeeded. This
+	 * is counter-intuitive, but needed to prevent the code
+	 * in lib/iov_iter.c from retrying and running back into
+	 * the poison cache line again. The machine check handler
+	 * will ensure that a SIGBUS is sent to the task.
+	 */
+3:	xorl %eax,%eax
+	ASM_CLAC
+	ret
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
