Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745AE434C6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhJTNrG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJTNqx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:53 -0400
Date:   Wed, 20 Oct 2021 13:44:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDbPnI8kBoDSSqPBYyW0gRtsMDXRGIoHSwEZ6XOwPH0=;
        b=utDrMkxlC8E+JfhVmACur42H19/HeExvoBMUwSB4Zr+ZDVn11hOKcZkRyGp9/jx1jufBP7
        mvt3/kr0jHWuuVbQ9cmSzmF7If1//Ve8oljbHs7y47PhymhMzJ0cGx3/Jdfd6Mdwy+Wo4v
        wpS6nBLni0Z1BWVBoPwCWgWWMQxec6opK4C7xsZZn/JhSKWImzFJCl914bho8mrDwweDrR
        L9X5ON718cYDnlg2Aohat4PYKbZmTZTT04H7IMvDxyW55atmuwYWMcGmhDV1Yo8GiDnyRr
        CVbCWod1oZ0plmCtCQk2fPF7q/jhc8t9F+ObuPKw0TvXRigdRLG3tSA0RcljlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDbPnI8kBoDSSqPBYyW0gRtsMDXRGIoHSwEZ6XOwPH0=;
        b=7Y1edulM0CBL5jS4sZXj68sBiBP7Z0A42wlOfiM8HwMghSjwON+UuY97pecYfOjs/oRa3p
        soMv/nrtHFlGIFAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mark fpu__init_prepare_fx_sw_frame() as __init
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.296435736@linutronix.de>
References: <20211015011539.296435736@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747688.25758.8190307736931364512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9603445549dacd7688532a4076c377e43a3ecfce
Gitweb:        https://git.kernel.org/tip/9603445549dacd7688532a4076c377e43a3ecfce
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:27 +02:00

x86/fpu: Mark fpu__init_prepare_fx_sw_frame() as __init

No need to keep it around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.296435736@linutronix.de
---
 arch/x86/include/asm/fpu/signal.h | 2 --
 arch/x86/kernel/fpu/internal.h    | 8 ++++++++
 arch/x86/kernel/fpu/signal.c      | 4 +++-
 arch/x86/kernel/fpu/xstate.c      | 1 +
 4 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/fpu/internal.h

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 8b6631d..04868a7 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -31,6 +31,4 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
-extern void fpu__init_prepare_fx_sw_frame(void);
-
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
new file mode 100644
index 0000000..036f84c
--- /dev/null
+++ b/arch/x86/kernel/fpu/internal.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_INTERNAL_H
+#define __X86_KERNEL_FPU_INTERNAL_H
+
+/* Init functions */
+extern void fpu__init_prepare_fx_sw_frame(void);
+
+#endif
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index e257805..2a4d1d0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -16,6 +16,8 @@
 #include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
 
+#include "internal.h"
+
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
 static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
 
@@ -514,7 +516,7 @@ unsigned long fpu__get_fpstate_size(void)
  * This will be saved when ever the FP and extended state context is
  * saved on the user stack during the signal handler delivery to the user.
  */
-void fpu__init_prepare_fx_sw_frame(void)
+void __init fpu__init_prepare_fx_sw_frame(void)
 {
 	int size = fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b2537a8..1f5a66a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -19,6 +19,7 @@
 
 #include <asm/tlbflush.h>
 
+#include "internal.h"
 #include "xstate.h"
 
 #define for_each_extended_xfeature(bit, mask)				\
