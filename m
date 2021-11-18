Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECF8455E23
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhKROhw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39250 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhKROhs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:48 -0500
Date:   Thu, 18 Nov 2021 14:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QjHGt3ySaTeGh3PrFYQQSBoVtSN9jX6Ks1rDr/XRCo=;
        b=diDPc5pTlWclqiilZ+TU9lnMD2c96x71GQv2pt25GRbL63wn1mGo1WYH8zUlkooX4csBro
        h/H8M4WDLj++7URh341CB7VlOmni6Ywz6o9yqB6T1fY9iPZ1bgHyzi1fUBkov48tg6qpQX
        zAXQrl/uJRzo50pFsaefXMn7UoZ6lri1yutkUUTrbPjkfVJ5K9ggaFFq8VGw3gaPFt/fyr
        UR+IMcOaW7me94+xW8EEoQ25iU4ebNBNRunCaHDxP2W2Cs7DgLCMHmu9QM1Q6yQrW9PJeN
        LSFqvbZToB/11IYB9/ur+u7cASHJGzTA7WJtX8LYRU2nRsP+1gSEbYBpUfjZQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QjHGt3ySaTeGh3PrFYQQSBoVtSN9jX6Ks1rDr/XRCo=;
        b=sdRNDSMJPCvrfKGfIGelVv/gYWWvbpf9MNE8R1WegdBW9uIAFNfj6PA7RLqdLMRG+gMpfO
        zo0BjOvujoPcFCAA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Stop pretending that perf can handle multiple
 guest callbacks
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-5-seanjc@google.com>
References: <20211111020738.2512932-5-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724608671.11128.10950352397891299823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2934e3d09350c1a7ca2433fbeabfcd831e48a575
Gitweb:        https://git.kernel.org/tip/2934e3d09350c1a7ca2433fbeabfcd831e48a575
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:25 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:07 +01:00

perf: Stop pretending that perf can handle multiple guest callbacks

Drop the 'int' return value from the perf (un)register callbacks helpers
and stop pretending perf can support multiple callbacks.  The 'int'
returns are not future proofing anything as none of the callers take
action on an error.  It's also not obvious that there will ever be
co-tenant hypervisors, and if there are, that allowing multiple callbacks
to be registered is desirable or even correct.

Opportunistically rename callbacks=>cbs in the affected declarations to
match their definitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20211111020738.2512932-5-seanjc@google.com
---
 arch/arm64/include/asm/kvm_host.h |  4 ++--
 arch/arm64/kvm/perf.c             |  8 ++++----
 include/linux/perf_event.h        | 12 ++++++------
 kernel/events/core.c              | 15 ++++-----------
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2a5f7f3..f680f30 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -675,8 +675,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
-int kvm_perf_init(void);
-int kvm_perf_teardown(void);
+void kvm_perf_init(void);
+void kvm_perf_teardown(void);
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index c84fe24..a0d660c 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -48,12 +48,12 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.get_guest_ip	= kvm_get_guest_ip,
 };
 
-int kvm_perf_init(void)
+void kvm_perf_init(void)
 {
-	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
 
-int kvm_perf_teardown(void)
+void kvm_perf_teardown(void)
 {
-	return perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 318c489..98c2044 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1252,8 +1252,8 @@ static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
 	 */
 	return rcu_dereference(perf_guest_cbs);
 }
-extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
-extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
+extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
+extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 
 extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
@@ -1497,10 +1497,10 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
-static inline int perf_register_guest_info_callbacks
-(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
-static inline int perf_unregister_guest_info_callbacks
-(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
+static inline void perf_register_guest_info_callbacks
+(struct perf_guest_info_callbacks *cbs)					{ }
+static inline void perf_unregister_guest_info_callbacks
+(struct perf_guest_info_callbacks *cbs)					{ }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c552e1b..17e5b20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6521,31 +6521,24 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
-/*
- * We assume there is only KVM supporting the callbacks.
- * Later on, we might change it to a list if there is
- * another virtualization implementation supporting the callbacks.
- */
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
-int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
+void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(rcu_access_pointer(perf_guest_cbs)))
-		return -EBUSY;
+		return;
 
 	rcu_assign_pointer(perf_guest_cbs, cbs);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
-int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
+void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(rcu_access_pointer(perf_guest_cbs) != cbs))
-		return -EINVAL;
+		return;
 
 	rcu_assign_pointer(perf_guest_cbs, NULL);
 	synchronize_rcu();
-	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 
