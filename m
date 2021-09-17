Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8E40F897
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbhIQNAD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbhIQM7o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D31C0613E1;
        Fri, 17 Sep 2021 05:58:11 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YU7DhP0+gi95S4MQpl8y0dduxeX/SMa7+L3Ahh86INE=;
        b=omisVUSZ+T1wBN3RAwyqXHpA1cgegbrYS+pEKiYp0VY14N8WrJIgDImWkQOXLmVSZxjul3
        P/8gS4gdjXrqAlUjIk6WwDntvr56mGpGsZQuudT9nV5NazZzfRcDWc65E5iOOG6iGc1l/s
        oHaFK2N+6Aq21S+qxywe6zuiO1wEw2ej7B9kTs4h5CjczOGb10qT4gKpRofyH97ochmJcO
        Eyqo4Zzq/Y880p7EkfcHs466EVlFk8CfvI/1MqqeGcYwvFmTA5qJbZDelzECKic1g03DgE
        MTQqPSlSpNnGPgOvAbWxPFb4NU6rJ+AHfjWP6cuAWpFKZzH4mEAPak4gf+lIGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YU7DhP0+gi95S4MQpl8y0dduxeX/SMa7+L3Ahh86INE=;
        b=yuGXEZzJvAgyvFZKnMLD/WyUMZ1DxoLNQx4EotC3OJSS4lSGQQiNDMNZzXj55VOqIb8coa
        gIKhzb9N8PzmOnDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make read_cr2() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.500331616@infradead.org>
References: <20210624095148.500331616@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348940.25758.3277626795705340243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0a53c9acf4da51a75392b0b543ce5eaae78a567f
Gitweb:        https://git.kernel.org/tip/0a53c9acf4da51a75392b0b543ce5eaae78a567f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:11:50 +02:00

x86/xen: Make read_cr2() noinstr

vmlinux.o: warning: objtool: pv_ops[41]: native_read_cr2
vmlinux.o: warning: objtool: pv_ops[41]: xen_read_cr2
vmlinux.o: warning: objtool: pv_ops[41]: xen_read_cr2_direct
vmlinux.o: warning: objtool: exc_double_fault()+0x15: call to pv_ops[41]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.500331616@infradead.org
---
 arch/x86/include/asm/paravirt.h | 2 +-
 arch/x86/kernel/paravirt.c      | 7 ++++++-
 arch/x86/xen/xen-asm.S          | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index a13a9a3..8878065 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -133,7 +133,7 @@ static inline void write_cr0(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr0, x);
 }
 
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
 				"mov %%cr2, %%rax;",
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc0..e351014 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -218,6 +218,11 @@ void paravirt_end_context_switch(struct task_struct *next)
 	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
 		arch_enter_lazy_mmu_mode();
 }
+
+static noinstr unsigned long pv_native_read_cr2(void)
+{
+	return native_read_cr2();
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -298,7 +303,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 1e62644..aef4a1e 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -102,6 +102,7 @@ SYM_FUNC_START(check_events)
 	ret
 SYM_FUNC_END(check_events)
 
+.pushsection .noinstr.text, "ax"
 SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
@@ -116,6 +117,7 @@ SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_END
 	ret
 SYM_FUNC_END(xen_read_cr2_direct);
+.popsection
 
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
