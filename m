Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B7375375
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhEFMPF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhEFMPE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DDDC061574;
        Thu,  6 May 2021 05:14:05 -0700 (PDT)
Date:   Thu, 06 May 2021 12:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypkaF+ac1DREN7nON1GHvK8c5ibYK2ojCVgvTDAV6QA=;
        b=18sJVlFrCQO3kqhURUM91kK4pQt15sEu5jVfltrQCt/ZXt0pZBlwc7d+KVoseSGyKOxbZR
        skFzRf5evw9nUs9sSYQopuaw4Wv3L3p06r6LUReJQCJdtErj11akqUqv3BRhFiE1aNtbtQ
        M4LGOT2QZGeirwU8Th4NDsptRCiNS5UBizvWJ7oYhTQcckMOOQyLoWIZQcTFqHKrufYi1q
        SgXKi62KMYJ9jejeEs3LGm/LAgXwMmT6yR0FjcShAlbtzqyNTaGpW57XJVrcOdwKY7J2tx
        jO/uQNBAJEubd61WR8wulDYwzdM3WDWrfMBrkEm2DO4nmh3bCS7a8gzB4vRKOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypkaF+ac1DREN7nON1GHvK8c5ibYK2ojCVgvTDAV6QA=;
        b=vNyjOIfjYJZ+WXuD8DCXaPa07T/2bggAbkWf6tkrBDhlp3ccvKVhpKSrDxtQqRik+VD9xB
        FXWxc5TgblhohwBw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] context_tracking: Consolidate guest enter/exit wrappers
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-7-seanjc@google.com>
References: <20210505002735.1684165-7-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324327.29796.6542362933513475728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     14296e0c447885d6c7b326e059fb528eb00526ed
Gitweb:        https://git.kernel.org/tip/14296e0c447885d6c7b326e059fb528eb00526ed
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 04 May 2021 17:27:33 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:11 +02:00

context_tracking: Consolidate guest enter/exit wrappers

Consolidate the guest enter/exit wrappers, providing and tweaking stubs
as needed.  This will allow moving the wrappers under KVM without having
to bleed #ifdefs into the soon-to-be KVM code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210505002735.1684165-7-seanjc@google.com

---
 include/linux/context_tracking.h | 65 +++++++++++--------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 56c648b..aa58c2a 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -71,6 +71,19 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 	}
 }
 
+static __always_inline bool context_tracking_guest_enter(void)
+{
+	if (context_tracking_enabled())
+		__context_tracking_enter(CONTEXT_GUEST);
+
+	return context_tracking_enabled_this_cpu();
+}
+
+static __always_inline void context_tracking_guest_exit(void)
+{
+	if (context_tracking_enabled())
+		__context_tracking_exit(CONTEXT_GUEST);
+}
 
 /**
  * ct_state() - return the current context tracking state if known
@@ -92,6 +105,9 @@ static inline void user_exit_irqoff(void) { }
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
+static inline bool context_tracking_guest_enter(void) { return false; }
+static inline void context_tracking_guest_exit(void) { }
+
 #endif /* !CONFIG_CONTEXT_TRACKING */
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
@@ -102,74 +118,41 @@ extern void context_tracking_init(void);
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_FORCE */
 
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 /* must be called with irqs disabled */
 static __always_inline void guest_enter_irqoff(void)
 {
+	/*
+	 * This is running in ioctl context so its safe to assume that it's the
+	 * stime pending cputime to flush.
+	 */
 	instrumentation_begin();
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_guest_enter(current);
-	else
-		current->flags |= PF_VCPU;
+	vtime_account_guest_enter();
 	instrumentation_end();
 
-	if (context_tracking_enabled())
-		__context_tracking_enter(CONTEXT_GUEST);
-
-	/* KVM does not hold any references to rcu protected data when it
+	/*
+	 * KVM does not hold any references to rcu protected data when it
 	 * switches CPU into a guest mode. In fact switching to a guest mode
 	 * is very similar to exiting to userspace from rcu point of view. In
 	 * addition CPU may stay in a guest mode for quite a long time (up to
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_enabled_this_cpu()) {
+	if (!context_tracking_guest_enter()) {
 		instrumentation_begin();
 		rcu_virt_note_context_switch(smp_processor_id());
 		instrumentation_end();
 	}
 }
 
-static __always_inline void context_tracking_guest_exit(void)
-{
-	if (context_tracking_enabled())
-		__context_tracking_exit(CONTEXT_GUEST);
-}
-
 static __always_inline void guest_exit_irqoff(void)
 {
 	context_tracking_guest_exit();
 
 	instrumentation_begin();
-	vtime_account_guest_exit();
-	instrumentation_end();
-}
-
-#else
-static __always_inline void guest_enter_irqoff(void)
-{
-	/*
-	 * This is running in ioctl context so its safe
-	 * to assume that it's the stime pending cputime
-	 * to flush.
-	 */
-	instrumentation_begin();
-	vtime_account_guest_enter();
-	rcu_virt_note_context_switch(smp_processor_id());
-	instrumentation_end();
-}
-
-static __always_inline void context_tracking_guest_exit(void) { }
-
-static __always_inline void guest_exit_irqoff(void)
-{
-	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
 	vtime_account_guest_exit();
 	instrumentation_end();
 }
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
 static inline void guest_exit(void)
 {
