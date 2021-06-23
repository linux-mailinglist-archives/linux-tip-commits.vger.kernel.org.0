Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86B3B231E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFWWMR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFWWLg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:36 -0400
Date:   Wed, 23 Jun 2021 22:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxIoZi7I9cfSbvKYclT53nawEy6YOavdfR8aegFbS2g=;
        b=kuKH6rKz0hS2Q4eiEE0FoI3+fbsmqrys7OGrUJsXQlCQsifL9j8QBDDCb1GwcR+2q+2n1y
        XYEl5kHcmpccAeqclshT7vrzJJwKeT9OuSdSXARbnq/+P9Fl7AycPI3T9GW59pFM9LqKo/
        DENMJcISwzYTfqmrVW4SD/MRlVsUdvc4I8VtR3DHSjBGHM7BiXmF/PB4RVyvVBUer+lZeE
        c2ElPkQ5WclFsBTz3uIfxK7hvcOymWHjzrulf+z9AlkB5MANQZkwnxovvpjwfUMP+oTywn
        wmi0hJbM+c00+9UX10ZxqewDrrDb+eUFAepmTfWD2hWnrz+IEHwiQ+Qza2dZvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxIoZi7I9cfSbvKYclT53nawEy6YOavdfR8aegFbS2g=;
        b=OWMZjevENcXMg7s7kBcAeshvQR8yaq5sllT+EIGBzfmP2UgCL6TjI/GLzc4tL8tCDAqz+M
        vuGIDDgE2xkowkCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename copy_kernel_to_fpregs() to
 restore_fpregs_from_fpstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.716058365@linutronix.de>
References: <20210623121454.716058365@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615694.395.4454795896315678725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1c61fada304c125c3f8a2b8eb1896406e4098a05
Gitweb:        https://git.kernel.org/tip/1c61fada304c125c3f8a2b8eb1896406e4098a05
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:01 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:36:42 +02:00

x86/fpu: Rename copy_kernel_to_fpregs() to restore_fpregs_from_fpstate()

This is not a copy functionality. It restores the register state from the
supplied kernel buffer.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.716058365@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 8 ++++----
 arch/x86/kvm/x86.c                  | 4 ++--
 arch/x86/mm/extable.c               | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 3e0eeda..3558cd0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -376,7 +376,7 @@ static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
+static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
 		os_xrstor(&fpstate->xsave, mask);
@@ -388,7 +388,7 @@ static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask
 	}
 }
 
-static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
+static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
 	/*
 	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
@@ -403,7 +403,7 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
 			: : [addr] "m" (fpstate));
 	}
 
-	__copy_kernel_to_fpregs(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
@@ -474,7 +474,7 @@ static inline void __fpregs_load_activate(void)
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		copy_kernel_to_fpregs(&fpu->state);
+		restore_fpregs_from_fpstate(&fpu->state);
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71bacb7..6f651b9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9653,7 +9653,7 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 	 */
 	if (vcpu->arch.guest_fpu)
 		/* PKRU is separately restored in kvm_x86_ops.run. */
-		__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
+		__restore_fpregs_from_fpstate(&vcpu->arch.guest_fpu->state,
 					~XFEATURE_MASK_PKRU);
 
 	fpregs_mark_activate();
@@ -9674,7 +9674,7 @@ static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu)
 		kvm_save_current_fpu(vcpu->arch.guest_fpu);
 
-	copy_kernel_to_fpregs(&vcpu->arch.user_fpu->state);
+	restore_fpregs_from_fpstate(&vcpu->arch.user_fpu->state);
 
 	fpregs_mark_activate();
 	fpregs_unlock();
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 121921b..2c5cccd 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -65,7 +65,7 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	__copy_kernel_to_fpregs(&init_fpstate, -1);
+	__restore_fpregs_from_fpstate(&init_fpstate, -1);
 	return true;
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
