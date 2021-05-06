Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35296375378
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhEFMPH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhEFMPE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676DDC061763;
        Thu,  6 May 2021 05:14:05 -0700 (PDT)
Date:   Thu, 06 May 2021 12:14:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFi+2XMBvWjVnyEFrRHCcDUvtd4Zbd57lf6pnbiqTbo=;
        b=KEd81c8D8EaBD92yYqerdZHz7vMeP/vh6gysFcQhgPUDIb5sYTEjml1KfGfEPPQRnoVMXi
        QJo6fIWqryEzzd6g/kLCs5/HO8U+GvDZdMx5mBTahRgvUFnRkPHsop/YunuaSPW8ZStP2c
        llfTdRQRU132jm0kJMq+7IVqWpdWyMlDsbg/vRrUbr2dpYvQaH8/ueirUErXG9cyGReyMx
        UxoWoGdau4iDx4+pQCkoVNc6rV+z7zNWBTnK+5kpuPMPajVJEZHtqtBaXVVXe1OlxPhVDE
        VggdJqo1uYiE8svS49DL+NGPn6byKzBVg/Cy08tYbkMUGzyf4pOG2/mNBLzbsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFi+2XMBvWjVnyEFrRHCcDUvtd4Zbd57lf6pnbiqTbo=;
        b=YUhhCCRd/gT9jPJmYVYDJcVmAa94oNfOE2QfiC3pXufEA1VHHpQ9Jdp+1qiJTnd/TRnEZI
        XeijJ/33i6N2olCQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] context_tracking: KVM: Move guest enter/exit
 wrappers to KVM's domain
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-8-seanjc@google.com>
References: <20210505002735.1684165-8-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324284.29796.14346305745024562129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1ca0016c149be35fe19a6b75fce95c25807b7159
Gitweb:        https://git.kernel.org/tip/1ca0016c149be35fe19a6b75fce95c25807b7159
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 04 May 2021 17:27:34 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:12 +02:00

context_tracking: KVM: Move guest enter/exit wrappers to KVM's domain

Move the guest enter/exit wrappers to kvm_host.h so that KVM can manage
its context tracking vs. vtime accounting without bleeding too many KVM
details into the context tracking code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210505002735.1684165-8-seanjc@google.com

---
 include/linux/context_tracking.h | 45 +-------------------------------
 include/linux/kvm_host.h         | 45 +++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index aa58c2a..4d7fced 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -118,49 +118,4 @@ extern void context_tracking_init(void);
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_FORCE */
 
-/* must be called with irqs disabled */
-static __always_inline void guest_enter_irqoff(void)
-{
-	/*
-	 * This is running in ioctl context so its safe to assume that it's the
-	 * stime pending cputime to flush.
-	 */
-	instrumentation_begin();
-	vtime_account_guest_enter();
-	instrumentation_end();
-
-	/*
-	 * KVM does not hold any references to rcu protected data when it
-	 * switches CPU into a guest mode. In fact switching to a guest mode
-	 * is very similar to exiting to userspace from rcu point of view. In
-	 * addition CPU may stay in a guest mode for quite a long time (up to
-	 * one time slice). Lets treat guest mode as quiescent state, just like
-	 * we do with user-mode execution.
-	 */
-	if (!context_tracking_guest_enter()) {
-		instrumentation_begin();
-		rcu_virt_note_context_switch(smp_processor_id());
-		instrumentation_end();
-	}
-}
-
-static __always_inline void guest_exit_irqoff(void)
-{
-	context_tracking_guest_exit();
-
-	instrumentation_begin();
-	/* Flush the guest cputime we spent on the guest */
-	vtime_account_guest_exit();
-	instrumentation_end();
-}
-
-static inline void guest_exit(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_exit_irqoff();
-	local_irq_restore(flags);
-}
-
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8895b95..2f34487 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -338,6 +338,51 @@ struct kvm_vcpu {
 	struct kvm_dirty_ring dirty_ring;
 };
 
+/* must be called with irqs disabled */
+static __always_inline void guest_enter_irqoff(void)
+{
+	/*
+	 * This is running in ioctl context so its safe to assume that it's the
+	 * stime pending cputime to flush.
+	 */
+	instrumentation_begin();
+	vtime_account_guest_enter();
+	instrumentation_end();
+
+	/*
+	 * KVM does not hold any references to rcu protected data when it
+	 * switches CPU into a guest mode. In fact switching to a guest mode
+	 * is very similar to exiting to userspace from rcu point of view. In
+	 * addition CPU may stay in a guest mode for quite a long time (up to
+	 * one time slice). Lets treat guest mode as quiescent state, just like
+	 * we do with user-mode execution.
+	 */
+	if (!context_tracking_guest_enter()) {
+		instrumentation_begin();
+		rcu_virt_note_context_switch(smp_processor_id());
+		instrumentation_end();
+	}
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit();
+
+	instrumentation_begin();
+	/* Flush the guest cputime we spent on the guest */
+	vtime_account_guest_exit();
+	instrumentation_end();
+}
+
+static inline void guest_exit(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	guest_exit_irqoff();
+	local_irq_restore(flags);
+}
+
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 {
 	/*
