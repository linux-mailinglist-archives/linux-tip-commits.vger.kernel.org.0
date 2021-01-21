Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D82FECEB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbhAUOcd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 09:32:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbhAUO1i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 09:27:38 -0500
Date:   Thu, 21 Jan 2021 14:26:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611239204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vp+oChejXYQaQMXBw2VrbSL0UCrrbTvoLk9vdSI72Ck=;
        b=ZeN/MyF48BcRtIxiuT7SqmvYfC29AkCPztiz3K3wNNzfzDku5Mar/SuKraLjNB1Rc4Dn7n
        beiWeE+fSkZGGKtUvsRgNSpMP2OeHCUbHD+ormV8Zo44NRpWgTEFQpPVi4/aTKsfopa/0i
        NsihQhbzzALNvSlmX6+zBq8reqw/hn2/85lJYCkHCkTjjO0LbI7T7vREjcEFMDl/sFIrqT
        n0tpu4uwXa/p+SxQPlyeJ+RWsBu/JvoSxv6NLgyapdYo9UrYqPLBOvAXxl7v+CMKofW9B8
        iUj2Qah65xCM5CG5gdM0AIhdSX0mzOdD880PX4FvI+XCAwYyEq5SgiiecSzk7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611239204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vp+oChejXYQaQMXBw2VrbSL0UCrrbTvoLk9vdSI72Ck=;
        b=Cq8CRT9C0p35sX+5Virnlbjd4Hm7Avc/KEcFK7iKWjr+Ns1qWIWJcSmki4IybCyJF/XKpQ
        GaQLsgDprvNErpBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Add kernel_fpu_begin_mask() to selectively
 initialize state
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        ole@ans.pl, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aff1cac8b8fc7ee900cf73e8f2369966621b053f.1611205691.git.luto@kernel.org>
References: <aff1cac8b8fc7ee900cf73e8f2369966621b053f.1611205691.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161123920342.414.15349572651801087451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e45122893a9870813f9bd7b4add4f613e6f29008
Gitweb:        https://git.kernel.org/tip/e45122893a9870813f9bd7b4add4f613e6f=
29008
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Jan 2021 21:09:48 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Jan 2021 12:07:28 +01:00

x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state

Currently, requesting kernel FPU access doesn't distinguish which parts of
the extended ("FPU") state are needed.  This is nice for simplicity, but
there are a few cases in which it's suboptimal:

 - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
   not use legacy 387 state.  These users want MXCSR initialized but don't
   care about the FPU control word.  Skipping FNINIT would save time.
   (Empirically, FNINIT is several times slower than LDMXCSR.)

 - Code that wants MMX doesn't want or need MXCSR initialized.
   _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
   initializing MXCSR will fail because LDMXCSR generates an #UD when the
   aforementioned CR4 bit is not set.

 - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
   dynamic states will need special handling.

Add a more specific API that allows callers to specify exactly what they
want.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Krzysztof Piotr Ol=C4=99dzki <ole@ans.pl>
Link: https://lkml.kernel.org/r/aff1cac8b8fc7ee900cf73e8f2369966621b053f.1611=
205691.git.luto@kernel.org
---
 arch/x86/include/asm/fpu/api.h | 15 +++++++++++++--
 arch/x86/kernel/fpu/core.c     |  9 +++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a5aba4a..67a4f1c 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -16,14 +16,25 @@
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
  * disables preemption so be careful if you intend to use it for long periods
  * of time.
- * If you intend to use the FPU in softirq you need to check first with
+ * If you intend to use the FPU in irq/softirq you need to check first with
  * irq_fpu_usable() if it is possible.
  */
-extern void kernel_fpu_begin(void);
+
+/* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
+#define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
+#define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
+
+extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 extern void fpregs_mark_activate(void);
=20
+/* Code that is unaware of kernel_fpu_begin_mask() can use this */
+static inline void kernel_fpu_begin(void)
+{
+	kernel_fpu_begin_mask(KFPU_387 | KFPU_MXCSR);
+}
+
 /*
  * Use fpregs_lock() while editing CPU's FPU registers or fpu->state.
  * A context switch will (and softirq might) save CPU's FPU registers to
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index eb86a2b..571220a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -121,7 +121,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 }
 EXPORT_SYMBOL(copy_fpregs_to_fpstate);
=20
-void kernel_fpu_begin(void)
+void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();
=20
@@ -141,13 +141,14 @@ void kernel_fpu_begin(void)
 	}
 	__cpu_invalidate_fpregs_state();
=20
-	if (boot_cpu_has(X86_FEATURE_XMM))
+	/* Put sane initial values into the control registers. */
+	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
 		ldmxcsr(MXCSR_DEFAULT);
=20
-	if (boot_cpu_has(X86_FEATURE_FPU))
+	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
 		asm volatile ("fninit");
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
=20
 void kernel_fpu_end(void)
 {
