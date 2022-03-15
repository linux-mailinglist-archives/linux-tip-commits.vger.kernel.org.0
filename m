Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14054D9927
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Mar 2022 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347325AbiCOKpq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Mar 2022 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiCOKpd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B0E369FC;
        Tue, 15 Mar 2022 03:44:00 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA1pRjsE0F0dK8IOP1daJkJTyZKHnKoWT89RGvNQvu0=;
        b=mVFCrigkvJ/kXjR++te7h9HeBTxerOPCZ6zYSvZKlMAMxQ618wbEnZKLeOJg83EHv43sja
        sd5dNa/kjA596lOUtfDQVHWQkKHy9Bjcy6d4b5D8ebwEAc0OXFIOEQSiIxKOmWxgMT8YSd
        sbkwVDQWIGnV90iv+xpAHD5hTlY85CNrolhfalKGDsbOU0khQNEqR6dX3fD4tAlXukUJbh
        wys2wGItDciRKqigSGX1gsOZCXYq1CruhtMrrNYg+ivfotWhOv0hHlUgCyYEY+xJBRasjw
        u7QravFdMWC0BRI89tUazUDIPibtC5cCLXNAhy4rV2YUMX1VsmoEjgSZEuZPqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA1pRjsE0F0dK8IOP1daJkJTyZKHnKoWT89RGvNQvu0=;
        b=awW4dRJXSSSjqFl36i/kF8uaNMtqBqDk+JTy2L+eoolfHnxBKT0HqrwH9R8blXOfvc26Z0
        9UyyvTssSn36y8Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,kexec: Disable CET on kexec
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.641454603@infradead.org>
References: <20220308154318.641454603@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103762.16921.300221360110727148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     af22700390c2f1d92dadd3eedf2738525a3a2f3a
Gitweb:        https://git.kernel.org/tip/af22700390c2f1d92dadd3eedf2738525a3a2f3a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:39 +01:00

x86/ibt,kexec: Disable CET on kexec

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.641454603@infradead.org
---
 arch/x86/include/asm/cpu.h           | 3 +++
 arch/x86/kernel/cpu/common.c         | 6 ++++++
 arch/x86/kernel/machine_kexec_64.c   | 4 +++-
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index a60025f..86e5e4e 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -73,4 +73,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
 #else
 static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 #endif
+
+extern __noendbr void cet_disable(void);
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index db1f149..709acab 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -535,6 +535,12 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 	}
 }
 
+__noendbr void cet_disable(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_IBT))
+		wrmsrl(MSR_IA32_S_CET, 0);
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index f5da4a1..566bb8e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -27,6 +27,7 @@
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -310,6 +311,7 @@ void machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	hw_breakpoint_disable();
+	cet_disable();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
@@ -325,7 +327,7 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 399f075..5b65f6e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -115,6 +115,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	pushq   %rdx
 
 	/*
+	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
+	 * below.
+	 */
+	movq	%cr4, %rax
+	andq	$~(X86_CR4_CET), %rax
+	movq	%rax, %cr4
+
+	/*
 	 * Set cr0 to a known state:
 	 *  - Paging enabled
 	 *  - Alignment check disabled
