Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5320E147
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jun 2020 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgF2Uxs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Jun 2020 16:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731323AbgF2TNT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9DC008750;
        Mon, 29 Jun 2020 01:34:11 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:34:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593419647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ+eb7tN8ZwXkyJhRRs4yvTcir5EqoRvUR29QFQnXZE=;
        b=te7+GFwy4Z+fQSc2EYp03TlmKzhMHvR9qWwAVYEokyZHq4HhIH/wChy58yWt8eRZ4vjOG7
        zg70YDCHu2+QLTJfuvnymVsvbtRvGyr1L0wDZdQfOjTzs3qOM9xoosPTgOa91TO0+HA0mU
        KfsttHI9KLu8mPIJu2rNLmVrqFiQSQjHGqw7BRO2ay1Qe9gf+glH9vOefo/V2Em7dTYcqR
        3GF2Fx8lSRlJI2I5Wp3bgOFaNHrderXHs8CvaonMP6yOwbYi/qN1ZNdnFHg/YRIiZBjejD
        hRLd5HVQpnYiS8Q4U/30PKkicxhrz15ijfxX++QK5EV/rj6DJhRKAHRn9OUofw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593419647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ+eb7tN8ZwXkyJhRRs4yvTcir5EqoRvUR29QFQnXZE=;
        b=XSU5vVHmE8mDWvf5VpbQMgmSrClHk9Xh0kQlLRdf9RW8gIevIzGruAXKeOaTbhxKBW/f8V
        uPK84MOMOStRRCDA==
From:   "tip-bot2 for Petteri Aimonen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200624114646.28953-2-bp@alien8.de>
References: <20200624114646.28953-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <159341964686.4006.12217287543191255172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7ad816762f9bf89e940e618ea40c43138b479e10
Gitweb:        https://git.kernel.org/tip/7ad816762f9bf89e940e618ea40c43138b479e10
Author:        Petteri Aimonen <jpa@git.mail.kapsi.fi>
AuthorDate:    Tue, 16 Jun 2020 11:12:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 29 Jun 2020 10:02:00 +02:00

x86/fpu: Reset MXCSR to default in kernel_fpu_begin()

Previously, kernel floating point code would run with the MXCSR control
register value last set by userland code by the thread that was active
on the CPU core just before kernel call. This could affect calculation
results if rounding mode was changed, or a crash if a FPU/SIMD exception
was unmasked.

Restore MXCSR to the kernel's default value.

 [ bp: Carve out from a bigger patch by Petteri, add feature check, add
   FNINIT call too (amluto). ]

Signed-off-by: Petteri Aimonen <jpa@git.mail.kapsi.fi>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207979
Link: https://lkml.kernel.org/r/20200624114646.28953-2-bp@alien8.de
---
 arch/x86/include/asm/fpu/internal.h | 5 +++++
 arch/x86/kernel/fpu/core.c          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f4..845e748 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -623,6 +623,11 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
  * MXCSR and XCR definitions:
  */
 
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
 extern unsigned int mxcsr_feature_mask;
 
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c8189..15247b9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,6 +101,12 @@ void kernel_fpu_begin(void)
 		copy_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
+
+	if (boot_cpu_has(X86_FEATURE_XMM))
+		ldmxcsr(MXCSR_DEFAULT);
+
+	if (boot_cpu_has(X86_FEATURE_FPU))
+		asm volatile ("fninit");
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
