Return-Path: <linux-tip-commits+bounces-5662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82168ABAA1C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC959E0FD4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE013D51E;
	Sat, 17 May 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmHcMwkS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Izv8vrzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9DB665;
	Sat, 17 May 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486840; cv=none; b=Dy9fTeBag51QC72rwFVYLy+rSZKcpXavKgEANQM8ZEV+HHRkhydMlDNcKxro8ANmQG5568t7iJ/5GYK16qbgd+kpsr1Xj6UWvcERHGQFORYfFiAjGvNsmsArXGBUylor1mDGqMgaS0ZnbHzpY1u9bhy+XDh4oJ8l1XGurmyya/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486840; c=relaxed/simple;
	bh=uQiRZdi6cf2J8qwGiQGb06TAB/2XktpcMmS8ReKwtwg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jV8yqSt+yHZG1KycWMJC8Tfzk+ExTy8QxUnySLCi+l5d/rx4/KV8i69S6EyoBwTZJMtZMT5hmvBqDuozFS/vRMAo4U5tquml0Cyexq/+6idPGfaREXGXsbJ4P/WySfdAFfBnlBl//7DGog0nrLKQAquv4+i2qVDEvqzWyQAJLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmHcMwkS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Izv8vrzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 13:00:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zdv98f6FPlwcsJjTQL2fJjwZKTmtVuPaKfXVItWDHvk=;
	b=pmHcMwkShhCufCvRhZnPReq5A43pha9eaJCW23Trc3R/loAH5eERwZyJIbd3dUff8r37ZN
	SmveWSlGouOqVFex+0mtL4w9ThBejNXzk6lATvx6OY/A6OhSaX+cu+gN26VM7RbY64Lv0I
	fIz0I0sAoH3xjUVMef70ewdOC8EkrY6lyjZ00MEpHVRX13RjIwWHeRFgudEOrRqFMxGLsy
	AWwzjj28FRvSNGLweoO9WtMTE4qJXFvggtcB9rJqi8hDRUw86QCaHzOHSV7o14LljXZV9w
	Z08vSXJ8t1e2uFSegrjJG2aK4Gfh1Y7V/06M/lYw64QP9wXsKRlXaWTEd665fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zdv98f6FPlwcsJjTQL2fJjwZKTmtVuPaKfXVItWDHvk=;
	b=Izv8vrzHaJ5Nq9rLLhlSW93hNVL1Uy8/ilvzQ1uOgJ1EP49NODi9xQ1gQQlAUQT4M/7H7B
	xw+m7XlHUaEjteAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250516123306.3812286-5-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-5-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174748683623.406.17252580515305855537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     09230b7554824c9db1712324efcf3595c67fd326
Gitweb:        https://git.kernel.org/tip/09230b7554824c9db1712324efcf3595c67fd326
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 15:33:06 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:38:29 +02:00

x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

PARAVIRT_XXL is exclusively utilized by XEN_PV, which is only compatible
with 64-bit machines.

Clearly designate PARAVIRT_XXL as 64-bit only and remove ifdefs to
support CONFIG_PGTABLE_LEVELS < 5.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250516123306.3812286-5-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig                      | 1 +
 arch/x86/include/asm/paravirt.h       | 4 ----
 arch/x86/include/asm/paravirt_types.h | 2 --
 arch/x86/kernel/paravirt.c            | 2 --
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bae3e97..121f9f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -799,6 +799,7 @@ config PARAVIRT
 
 config PARAVIRT_XXL
 	bool
+	depends on X86_64
 
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 03f680d..b5e59a7 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -463,8 +463,6 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 5
-
 static inline p4d_t __p4d(p4dval_t val)
 {
 	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
@@ -496,8 +494,6 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 		set_pgd(pgdp, native_make_pgd(0));			\
 } while (0)
 
-#endif  /* CONFIG_PGTABLE_LEVELS == 5 */
-
 static inline void p4d_clear(p4d_t *p4dp)
 {
 	set_p4d(p4dp, native_make_p4d(0));
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b08b9d3..37a8627 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -189,12 +189,10 @@ struct pv_mmu_ops {
 
 	void (*set_p4d)(p4d_t *p4dp, p4d_t p4dval);
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 	struct paravirt_callee_save p4d_val;
 	struct paravirt_callee_save make_p4d;
 
 	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
-#endif	/* CONFIG_PGTABLE_LEVELS >= 5 */
 
 	struct pv_lazy_ops lazy_mode;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 015bf29..ab3e172 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -211,12 +211,10 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.set_p4d		= native_set_p4d,
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 	.mmu.p4d_val		= PTE_IDENT,
 	.mmu.make_p4d		= PTE_IDENT,
 
 	.mmu.set_pgd		= native_set_pgd,
-#endif /* CONFIG_PGTABLE_LEVELS >= 5 */
 
 	.mmu.pte_val		= PTE_IDENT,
 	.mmu.pgd_val		= PTE_IDENT,

