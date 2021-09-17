Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3840F890
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhIQM7s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245152AbhIQM7c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:32 -0400
Date:   Fri, 17 Sep 2021 12:58:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bxIZ5LhoUV4ix+lnXE2xGVlkqc/2qTLNPp5vFvn5tY=;
        b=M8KrSV7XFLHUCwgsl4G6nZ4DSBD39hZBzppholgSw6+Scp/WyW3xKA8O0gCEZ9wuBybJFi
        rKBUlZLTw/6ykzFNj6T4y8Ez+/67m5wEJ8Wos0jooyGBITHAszasJ5RGCfdWrdAO9OPUbE
        jSSQmr21b8BFdbp9rm4uSGJv7qmKh9sF2nc9t7avgNywosuhU/upDvFG3v/LMHpsBTq7HN
        SuvTJz41nsYRRjbs8fIVc2OqrG1q4Zedp/n/4QZqYCh2K0Dd19M82RdWV1NmgjthTKLdQ5
        a530Jv9GZABWJqLbgQyuLaztWYcw46xg5FqLsLXUz8tVLKnZmhuPzpq6MiXDSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bxIZ5LhoUV4ix+lnXE2xGVlkqc/2qTLNPp5vFvn5tY=;
        b=3hAsUGblkeNbOUug1j2I3uH/3Y9qBL2jxhvliZvQnG38QWI0l3hOTQYYf6Ew1YNOEwNPHO
        3PS7la36Uo6twfDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make write_cr2() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.563524913@infradead.org>
References: <20210624095148.563524913@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348858.25758.10805581589903085682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     209cfd0cbb6722d3461e4f928dc150e4c3811948
Gitweb:        https://git.kernel.org/tip/209cfd0cbb6722d3461e4f928dc150e4c3811948
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:12:16 +02:00

x86/xen: Make write_cr2() noinstr

vmlinux.o: warning: objtool: pv_ops[42]: native_write_cr2
vmlinux.o: warning: objtool: pv_ops[42]: xen_write_cr2
vmlinux.o: warning: objtool: exc_nmi()+0x127: call to pv_ops[42]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.563524913@infradead.org
---
 arch/x86/include/asm/paravirt.h | 2 +-
 arch/x86/kernel/paravirt.c      | 7 ++++++-
 arch/x86/xen/mmu_pv.c           | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 8878065..be82b52 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -140,7 +140,7 @@ static __always_inline unsigned long read_cr2(void)
 				ALT_NOT(X86_FEATURE_XENPV));
 }
 
-static inline void write_cr2(unsigned long x)
+static __always_inline void write_cr2(unsigned long x)
 {
 	PVOP_VCALL1(mmu.write_cr2, x);
 }
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e351014..fc2cf2b 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -223,6 +223,11 @@ static noinstr unsigned long pv_native_read_cr2(void)
 {
 	return native_read_cr2();
 }
+
+static noinstr void pv_native_write_cr2(unsigned long val)
+{
+	native_write_cr2(val);
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -304,7 +309,7 @@ struct paravirt_patch_template pv_ops = {
 
 #ifdef CONFIG_PARAVIRT_XXL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
-	.mmu.write_cr2		= native_write_cr2,
+	.mmu.write_cr2		= pv_native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 1df5f01..f3cafe5 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1204,7 +1204,8 @@ static void __init xen_pagetable_init(void)
 	xen_remap_memory();
 	xen_setup_mfn_list_list();
 }
-static void xen_write_cr2(unsigned long cr2)
+
+static noinstr void xen_write_cr2(unsigned long cr2)
 {
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
