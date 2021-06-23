Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6D3B22FC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhFWWLX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFWWLR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C88C061574;
        Wed, 23 Jun 2021 15:08:58 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0J39fbuJLexkACLO7XU8YpH6ugjZfIbjI/IdtEqQFE=;
        b=fCkrrGC7B1RP2dXSNlvLHPxxFlv+vhM4yxZR6JWfn5oxVtJQKprFcN27i/4ofqWP0DAFv2
        GsXfNcY68n+soiZPkqQ/BnuKPtdvQrIjglIsB1U/uCxqNp/1o3eKV3vznMu1VuMzAupbBw
        zbOkOXAk7ROyk6TKCpOe+6Lt3wj3hAk0lBqr85W4t/zEcbhOf3tLvecnnhaIGrybaRsNR1
        EieM/zsYuhccbxFIz4ozCYXGS4h8Q2EBQ21Fl3a+18V8cwyCyG/0qyMWyI9qKU2Dz3jM6e
        /BUbddOooYh0OG2S2m0z3c1tIgXZ1jC6JjaqIF3X98Jib3TR5Yhl4nhD3p4NGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0J39fbuJLexkACLO7XU8YpH6ugjZfIbjI/IdtEqQFE=;
        b=Xdf6Qeg50nnNyKWdR89aYwgdFf1YdIB4OaJUEJt+KPhlDs3hI4LWgKTu5uHM839udM4/q6
        n64tpGXBYyIU+dAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkru: Remove xstate fiddling from write_pkru()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.897372712@linutronix.de>
References: <20210623121456.897372712@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613653.395.16973019914888523169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     72a6c08c44e4460e39315ca828f60b8d5afd6b19
Gitweb:        https://git.kernel.org/tip/72a6c08c44e4460e39315ca828f60b8d5afd6b19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:55:51 +02:00

x86/pkru: Remove xstate fiddling from write_pkru()

The PKRU value of a task is stored in task->thread.pkru when the task is
scheduled out. PKRU is restored on schedule in from there. So keeping the
XSAVE buffer up to date is a pointless exercise.

Remove the xstate fiddling and cleanup all related functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.897372712@linutronix.de
---
 arch/x86/include/asm/pkru.h          | 17 ++++-------------
 arch/x86/include/asm/special_insns.h | 14 +-------------
 arch/x86/kvm/x86.c                   |  4 ++--
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 7e45509..ccc539f 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -41,23 +41,14 @@ static inline u32 read_pkru(void)
 
 static inline void write_pkru(u32 pkru)
 {
-	struct pkru_state *pk;
-
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
 	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
+	 * WRPKRU is relatively expensive compared to RDPKRU.
+	 * Avoid WRPKRU when it would not change the value.
 	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
+	if (pkru != rdpkru())
+		wrpkru(pkru);
 }
 
 static inline void pkru_write_default(void)
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2acd6cb..f3fbb84 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -104,25 +104,13 @@ static inline void wrpkru(u32 pkru)
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
 
-static inline void __write_pkru(u32 pkru)
-{
-	/*
-	 * WRPKRU is relatively expensive compared to RDPKRU.
-	 * Avoid WRPKRU when it would not change the value.
-	 */
-	if (pkru == rdpkru())
-		return;
-
-	wrpkru(pkru);
-}
-
 #else
 static inline u32 rdpkru(void)
 {
 	return 0;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 }
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07f7888..8ee7add 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -943,7 +943,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 	    (kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru)
-		__write_pkru(vcpu->arch.pkru);
+		write_pkru(vcpu->arch.pkru);
 }
 EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
 
@@ -957,7 +957,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU))) {
 		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
-			__write_pkru(vcpu->arch.host_pkru);
+			write_pkru(vcpu->arch.host_pkru);
 	}
 
 	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {
