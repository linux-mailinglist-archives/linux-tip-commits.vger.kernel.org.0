Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136ED434C51
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJTNqo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhJTNqn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:43 -0400
Date:   Wed, 20 Oct 2021 13:44:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLbXaRs8h0i/l0o+1ebKiIEU543k0BSyB6N2AXM090E=;
        b=1AbgfrTu+aHaOuK7pHfCWzPqIio6ARjhJHT8LERb++bpGEfzwTU/ujLxgo7ZcATroe9TPf
        Utjoc2GHjxXJe5nKCI7z41WDWW+lmkRRR3FDachMbDm3Oe0ojKJCjYctrIiQWb935CHlJ0
        i2D6YMsUJRODoUlz+LrF+zyDgYcpJk6gGSElyMZztX7D3VShK7QZGgKLrMv40YjOvhGkOg
        Ag6QP/CpFU8iovwrSRdwSZMH7yOUCEbK4tnWWRe/qDNN8OfbfLp36JOdV9viTNNolrO8mA
        qP9++u886a0EOd6/xY59TzSU05EtanlOq7ueDF92PRDjySx/b/gXzJXsEQ6NSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLbXaRs8h0i/l0o+1ebKiIEU543k0BSyB6N2AXM090E=;
        b=cgEIpJOSx8VWHJWx0Q/G4WWAXmPdBc7/3JtaXWmo8rHXzqK8Vg6NQjp++8hVcwmAHec/eo
        9zPOUr62PIpbTjDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Provide a proper function for ex_handler_fprestore()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011540.053515012@linutronix.de>
References: <20211015011540.053515012@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473746711.25758.12860950936116805705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     079ec41b22b952cdf3126527d735e373c9125f6d
Gitweb:        https://git.kernel.org/tip/079ec41b22b952cdf3126527d735e373c9125f6d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:29 +02:00

x86/fpu: Provide a proper function for ex_handler_fprestore()

To make upcoming changes for support of dynamically enabled features
simpler, provide a proper function for the exception handler which removes
exposure of FPU internals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011540.053515012@linutronix.de
---
 arch/x86/include/asm/fpu/api.h | 4 +---
 arch/x86/kernel/fpu/core.c     | 5 +++++
 arch/x86/kernel/fpu/internal.h | 2 ++
 arch/x86/mm/extable.c          | 5 ++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c691f07..9263d70 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -113,6 +113,7 @@ static inline void update_pasid(void) { }
 /* Trap handling */
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern void fpu_sync_fpstate(struct fpu *fpu);
+extern void fpu_reset_from_exception_fixup(void);
 
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
@@ -129,9 +130,6 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 /* State tracking */
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-/* fpstate */
-extern union fpregs_state init_fpstate;
-
 /* fpstate-related functions which are exported to KVM */
 extern void fpu_init_fpstate_user(struct fpu *fpu);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9bb0c1c..79f2e8d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -155,6 +155,11 @@ void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 	}
 }
 
+void fpu_reset_from_exception_fixup(void)
+{
+	restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
+}
+
 #if IS_ENABLED(CONFIG_KVM)
 void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 {
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index bd7f813..479f2db 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,6 +2,8 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
+extern union fpregs_state init_fpstate;
+
 /* CPU feature check wrappers */
 static __always_inline __pure bool use_xsave(void)
 {
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 79c2e30..5cd2a88 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -4,8 +4,7 @@
 #include <linux/sched/debug.h>
 #include <xen/xen.h>
 
-#include <asm/fpu/signal.h>
-#include <asm/fpu/xstate.h>
+#include <asm/fpu/api.h>
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
@@ -48,7 +47,7 @@ static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
+	fpu_reset_from_exception_fixup();
 	return true;
 }
 
