Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC840C8B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhIOPur (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbhIOPup (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:45 -0400
Date:   Wed, 15 Sep 2021 15:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhHtcCHO+2Y/FDEObJkFWJHOd6DliC/iVyIqLVaRLpk=;
        b=aVPq7nvwWXL/NZu3eGNKCTp0skdCMNwgQxOTSRopPNkYY3AiwroMgTeQv48+/jr/MK9bes
        SI9g9EFzl0VZK3mmfqlkQRwf3jGhuoe5dePxEDniRbAHv867N1uhd5rnKAYohS6Dw2u7Uc
        sFmnMS6JouEw2uktbXTJpb6Scl0kvjajgBhr5ChodszvAjQElJvyhPPBNVfGH/O+uTK7ri
        nxZ+tCMhDKAallo4/6BCTyKmDCXql/xb4NH1OdIaImNHCfIthiz5uyBkUb9ijhajJJ4YYo
        Ntq4DKJ8zZZQjh05UzuPVhpHe3O0+4ofSmrykWCcvi16Nkgpe2Aupeu+6MsoTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhHtcCHO+2Y/FDEObJkFWJHOd6DliC/iVyIqLVaRLpk=;
        b=dxlH4OsQwAenVuLzk938kA3q5aJFH7/B7HSaQDAXjG/Tbykmnxz1P+Cki7WtgJsC08Y71E
        o0rDy2P0Mv9ALyDg==
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
Message-ID: <163172096438.25758.8681674473725174430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ee6781aba03fc3040e3dfaa57fe8c2cea751ee35
Gitweb:        https://git.kernel.org/tip/ee6781aba03fc3040e3dfaa57fe8c2cea751ee35
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:48 +02:00

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
index 04cafc0..ff4ade8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -238,6 +238,11 @@ struct pv_info pv_info = {
 /* 64-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
 
+static noinstr unsigned long pv_native_read_cr2(void)
+{
+	return native_read_cr2();
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
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
