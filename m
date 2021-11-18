Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809D1455E19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhKROhp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhKROhm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:42 -0500
Date:   Thu, 18 Nov 2021 14:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Zm0uORDvEK0aATpQAo0AM5PHmZRibrRmFjGz2l+CxU=;
        b=DvusMaZrs5uY252cAjpwIVXfAFxVQFmLuOUlC1xPkyAHPXjJZYz+DV2cVP/xjAsaEql5ma
        1zVd6PnyiLr1ccOq4HzztcJhfPRsLMvgalFoIiTToGSK8aq/rgcUXe7smd8IX8QvLfVf4c
        BCWev8ZWwJI0FqvvwQbx6AzE04N6trNsN/NFq55jStrfa9XpJeRkxgqWHSM8+i3l9e6Maa
        adxigZpdS9bF+RRhEkPsDkDHQSMEfUdQE+NfQao1vNyAdYNq2ysLnDLXLyQuBmgpyclzaQ
        dCofofgmTOghS6M1PRw2LOzw7Up37OvMAhrnOcXBF81/6ygDolTwpFqBE3ZY0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Zm0uORDvEK0aATpQAo0AM5PHmZRibrRmFjGz2l+CxU=;
        b=Leo7xTBM9HRWn7OpAaWQ7O87txmssRo+nsaBoW7QV56ciH+q9zRH4CGkAsACAraZPopo/U
        JTHNG5xCE0cY61Dg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: x86: More precisely identify NMI from guest
 when handling PMI
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-12-seanjc@google.com>
References: <20211111020738.2512932-12-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724608104.11128.12039087886235952211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     db215756ae5970aec8ad50257d2eb1678b552b91
Gitweb:        https://git.kernel.org/tip/db215756ae5970aec8ad50257d2eb1678b552b91
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:32 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:09 +01:00

KVM: x86: More precisely identify NMI from guest when handling PMI

Differentiate between IRQ and NMI for KVM's PMC overflow callback, which
was originally invoked in response to an NMI that arrived while the guest
was running, but was inadvertantly changed to fire on IRQs as well when
support for perf without PMU/NMI was added to KVM.  In practice, this
should be a nop as the PMC overflow callback shouldn't be reached, but
it's a cheap and easy fix that also better documents the situation.

Note, this also doesn't completely prevent false positives if perf
somehow ends up calling into KVM, e.g. an NMI can arrive in host after
KVM sets its flag.

Fixes: dd60d217062f ("KVM: x86: Fix perf timer mode IP reporting")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20211111020738.2512932-12-seanjc@google.com
---
 arch/x86/kvm/svm/svm.c |  2 +-
 arch/x86/kvm/vmx/vmx.c |  4 +++-
 arch/x86/kvm/x86.c     |  2 +-
 arch/x86/kvm/x86.h     | 13 ++++++++++---
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5630c24..b2f0c6c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3931,7 +3931,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
-		kvm_before_interrupt(vcpu);
+		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 
 	kvm_load_host_xsave_state(vcpu);
 	stgi();
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7d90c8d..a0c2497 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6317,7 +6317,9 @@ void vmx_do_interrupt_nmi_irqoff(unsigned long entry);
 static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
 					unsigned long entry)
 {
-	kvm_before_interrupt(vcpu);
+	bool is_nmi = entry == (unsigned long)asm_exc_nmi_noist;
+
+	kvm_before_interrupt(vcpu, is_nmi ? KVM_HANDLING_NMI : KVM_HANDLING_IRQ);
 	vmx_do_interrupt_nmi_irqoff(entry);
 	kvm_after_interrupt(vcpu);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bb71e10..ab032ef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9896,7 +9896,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * interrupts on processors that implement an interrupt shadow, the
 	 * stat.exits increment will do nicely.
 	 */
-	kvm_before_interrupt(vcpu);
+	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
 	local_irq_enable();
 	++vcpu->stat.exits;
 	local_irq_disable();
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d070043..f8d2c58 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -385,9 +385,16 @@ static inline bool kvm_cstate_in_guest(struct kvm *kvm)
 	return kvm->arch.cstate_in_guest;
 }
 
-static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu)
+enum kvm_intr_type {
+	/* Values are arbitrary, but must be non-zero. */
+	KVM_HANDLING_IRQ = 1,
+	KVM_HANDLING_NMI,
+};
+
+static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu,
+					enum kvm_intr_type intr)
 {
-	WRITE_ONCE(vcpu->arch.handling_intr_from_guest, 1);
+	WRITE_ONCE(vcpu->arch.handling_intr_from_guest, (u8)intr);
 }
 
 static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
@@ -397,7 +404,7 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_handling_nmi_from_guest(struct kvm_vcpu *vcpu)
 {
-	return !!vcpu->arch.handling_intr_from_guest;
+	return vcpu->arch.handling_intr_from_guest == KVM_HANDLING_NMI;
 }
 
 static inline bool kvm_pat_valid(u64 data)
