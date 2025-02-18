Return-Path: <linux-tip-commits+bounces-3506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE7A39BCE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA377173EA2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480A243388;
	Tue, 18 Feb 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5ZUoJEJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="INxgG0tY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373802417E1;
	Tue, 18 Feb 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880708; cv=none; b=eN5OR6m4V97hpYtNOTVaNmee6lidGkM3/+yuI6fWSvm4oyW4F17tWLDocQh+eSvytTkCUvfThfs9O+EvsMmYbYcPsbNjGuqgVpVUStDLDGa4Lf+lvXjMjWoqXBKHcnQ1MOP8dvRgQ2jeJtoBiS86GfY7CJFN0MRzuWVZJRHn8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880708; c=relaxed/simple;
	bh=QzezLcIhCfiQZ0zMvn7fOH0ca/UhyPJyps6rl6kk6iw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iEVx+LKSCAL8GP1LsmIooTpJgRHuxXCi9LGe21L2C6d0URefJ5DIs3DN3UzW5amMU/T5gzNuqhHvzqelwCNIAdEspvMHj9Q2He+dAfc0q8/CZI8i8XzFYwaBOgoZn5SNH3d23GiQkxSy2TNU1ZD2XjnApfPL69pNzTKiut5sYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5ZUoJEJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=INxgG0tY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXqrD57Pkfc1zBKL55yPAMRj9AqBskD8/WEdfR738Vw=;
	b=Q5ZUoJEJkMMHNYSbAQsnjZhL98bUAWmv2cx8FF9DK3WxagVEdchrYK2RcZvXHI+2DexIR5
	GxyU3iqqN4ikLjhfK0I5bZnNaZAbKcebdyVuKAp9qQtNIskyE7576i/6KmXpVQyyowPLd8
	5djPwLG0RpthyrES82Pc6vlAGRSUoLh8PwafqiBxuGYlqLApI2XZem/CCzuPjtUjicBUIy
	5Fr4uZ5zMzoVWIKeiAkthB+VDAvhdJovu99TAPVOZG9QclibM0Xzx31m7lCXgwl7EeTBnE
	hAofHyu6ZguRpO/qZ19//wrQ2RdYBq7/7ZAPiS2sIpMfPu0ZP7XXvh1JHru4Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXqrD57Pkfc1zBKL55yPAMRj9AqBskD8/WEdfR738Vw=;
	b=INxgG0tYPnTnPtnoKnKnZmvU+wLUzrsKi8TyUwraDk29wE0DOzyvo9hnP4idxy/lgumcdz
	Xz3FRLML7eDu3HCw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu/64: Remove INIT_PER_CPU macros
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-12-brgerst@gmail.com>
References: <20250123190747.745588-12-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070378.10177.35473941057874375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     38a4968b3190f873a8a60e953287278eddf037f1
Gitweb:        https://git.kernel.org/tip/38a4968b3190f873a8a60e953287278eddf037f1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:43 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:50 +01:00

x86/percpu/64: Remove INIT_PER_CPU macros

Now that the load and link addresses of percpu variables are the same,
these macros are no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-12-brgerst@gmail.com
---
 arch/x86/include/asm/desc.h   |  1 -
 arch/x86/include/asm/percpu.h | 22 ----------------------
 arch/x86/kernel/head64.c      |  2 +-
 arch/x86/kernel/irq_64.c      |  1 -
 arch/x86/kernel/vmlinux.lds.S |  7 -------
 arch/x86/tools/relocs.c       |  1 -
 6 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 62dc9f5..ec95fe4 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,7 +46,6 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
-DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd8..1a76eb8 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,12 +20,6 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#ifdef CONFIG_X86_64_SMP
-# define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-#else
-# define INIT_PER_CPU_VAR(var)  var
-#endif
-
 #else /* !__ASSEMBLY__: */
 
 #include <linux/build_bug.h>
@@ -98,22 +92,6 @@
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
 /*
- * Initialized pointers to per-CPU variables needed for the boot
- * processor need to use these macros to get the proper address
- * offset from __per_cpu_load on SMP.
- *
- * There also must be an entry in vmlinux_64.lds.S
- */
-#define DECLARE_INIT_PER_CPU(var) \
-       extern typeof(var) init_per_cpu_var(var)
-
-#ifdef CONFIG_X86_64_SMP
-# define init_per_cpu_var(var)  init_per_cpu__##var
-#else
-# define init_per_cpu_var(var)  var
-#endif
-
-/*
  * For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though).
  */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 22c9ba3..05f8b8a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -567,7 +567,7 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
-	struct desc_struct *gdt = (void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
+	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index ade0043..56bdeec 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -27,7 +27,6 @@
 #include <asm/apic.h>
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_VMAP_STACK
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 93c2fa8..1769a71 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -471,13 +471,6 @@ SECTIONS
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
 
 #ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ae69626..5778bc4 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -90,7 +90,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"_end)$"

