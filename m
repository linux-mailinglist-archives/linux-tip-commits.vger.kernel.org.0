Return-Path: <linux-tip-commits+bounces-6461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913BEB439CC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E895A0409
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B62FE055;
	Thu,  4 Sep 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1C4utQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OpqC1G0Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22E2FDC55;
	Thu,  4 Sep 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984854; cv=none; b=HuAKzwuka2N+OSuPxVcNYypWK1ttioSEfa7e8136i8+XJsqn8hQZrSyOAXpzVekPqUw7um9mkyZIAYpZ/1F3VssQzOSoH2EjoJmg/WWVEr66uem+gcYyur49Dpio/0lccCcFCc3r1w4zhPaDtGxghgmXFbVWFVVUc7uGGd4UCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984854; c=relaxed/simple;
	bh=XgaWd/nD5yMGJtdIHu9t+wbiNuhY+y4mNae93kdP+Ow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eB6TniiufK6GcTJvKfbYwey6al7/25AP6wQ5w7wFhBF7HFVn2Gc8ZZ47kqoGjqFj7RsLVudVuotfp6fBwHXav95uBFwDf95xR/W4G/FJZlMOOnN1FLn4ao7b6r9w1SITOcu88eZ2Eg/jFEMnFXC0DR15uD9amWQXrYpUcmIqOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1C4utQS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OpqC1G0Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9gQekIc2xh3ze+MlycvMGCXSpW5B19NMjvNQObH9uU=;
	b=N1C4utQSkXnOC5o27NzuWkLvnp23TcHBQVl+V9gH12B4Veej8lqNiDFZxJ9hgBi1slAyuo
	2yv4QON9fEiz7ZF6ElimAvzNiaY6VZIvd0+v2ikVi5cfT3HZglPu+YaeRPtqNEmktYe1FN
	RBlaamKL9tGSTinI4i5KJCCPGCTuaX2vu0sFzHC+lMna6VYc0xG5/WMV/JrlrqEpctfs9G
	QXuNREmyI6Xw0knySkO69qmvYpV6cWXjsKsRrojLdL1ZoAHRgcEaeo7SC4N/lt7Xq4AlAx
	2SkqXgRTWk3mHzB0TFM33kBxRXHQA+pEssqoX3Nn3UVMjdb/kKfso+wHYEWpYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9gQekIc2xh3ze+MlycvMGCXSpW5B19NMjvNQObH9uU=;
	b=OpqC1G0YL78rD3OxkVnK9am/BRBYjjGNPlN9FUJYED4exMx58VpoN3GE57yXy89kyJvvsN
	gpB+q2v+LqlmXbDw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Create a confined code area for startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-43-ardb+git@google.com>
References: <20250828102202.1849035-43-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698484922.1920.8666651766644369989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7b38dec3c5af54665a4b29483aa02bd1c1e71cf1
Gitweb:        https://git.kernel.org/tip/7b38dec3c5af54665a4b29483aa02bd1c1e=
71cf1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:22 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 18:00:01 +02:00

x86/boot: Create a confined code area for startup code

In order to be able to have tight control over which code may execute
from the early 1:1 mapping of memory, but still link vmlinux as a single
executable, prefix all symbol references in startup code with __pi_, and
invoke it from outside using the __pi_ prefix.

Use objtool to check that no absolute symbol references are present in
the startup code, as these cannot be used from code running from the 1:1
mapping.

Note that this also requires disabling the latent-entropy GCC plugin, as
the global symbol references that it injects would require explicit
exports, and given that the startup code rarely executes more than once,
it is not a useful source of entropy anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-43-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile     | 14 ++++++++++++++
 arch/x86/boot/startup/sev-shared.c |  1 -
 arch/x86/boot/startup/sme.c        |  1 -
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/include/asm/setup.h       |  1 +
 arch/x86/include/asm/sev.h         |  1 +
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/kernel/head_64.S          |  8 ++++----
 arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
 tools/objtool/check.c              |  3 ++-
 10 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 32737f4..e8fdf02 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -4,6 +4,7 @@ KBUILD_AFLAGS		+=3D -D__DISABLE_EXPORTS
 KBUILD_CFLAGS		+=3D -D__DISABLE_EXPORTS -mcmodel=3Dsmall -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
 			   $(DISABLE_STACKLEAK_PLUGIN) \
+			   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
 			   -fno-jump-tables \
 			   -include $(srctree)/include/linux/hidden.h
@@ -36,3 +37,16 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STAN=
DARD :=3D y
 #
 $(pi-objs): objtool-enabled	=3D 1
 $(pi-objs): objtool-args	=3D $(if $(delay-objtool),,$(objtool-args-y)) --noa=
bs
+
+#
+# Confine the startup code by prefixing all symbols with __pi_ (for position
+# independent). This ensures that startup code can only call other startup
+# code, or code that has explicitly been made accessible to it via a symbol
+# alias.
+#
+$(obj)/%.pi.o: OBJCOPYFLAGS :=3D --prefix-symbols=3D__pi_
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+targets	+=3D $(obj-y)
+obj-y	:=3D $(patsubst %.o,%.pi.o,$(obj-y))
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 2a28463..e09c668 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -12,7 +12,6 @@
 #include <asm/setup_data.h>
=20
 #ifndef __BOOT_COMPRESSED
-#define error(v)			pr_err(v)
 #define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index bf9153b..52b98e7 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -568,7 +568,6 @@ void __head sme_enable(struct boot_params *bp)
=20
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /* Local version for startup code, which never operates on user page tables =
*/
-__weak
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b9133c8..cf9a511 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -272,7 +272,7 @@ static int svsm_perform_call_protocol(struct svsm_call *c=
all)
=20
 	do {
 		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
+			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret =3D=3D -EAGAIN);
=20
 	if (sev_cfg.ghcbs_initialized)
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 692af46..914eb32 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -53,6 +53,7 @@ extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_para=
ms *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void startup_64_load_idt(void *vc_handler);
+extern void __pi_startup_64_load_idt(void *vc_handler);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
=20
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0030c71..f222bef 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -551,6 +551,7 @@ struct cpuid_leaf {
 };
=20
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
 	      void *ctx, struct cpuid_leaf *leaf);
=20
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1bc40d0..fd28b53 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -319,5 +319,5 @@ void early_setup_idt(void)
 		handler =3D vc_boot_ghcb;
 	}
=20
-	startup_64_load_idt(handler);
+	__pi_startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3..d219963 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -71,7 +71,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	xorl	%edx, %edx
 	wrmsr
=20
-	call	startup_64_setup_gdt_idt
+	call	__pi_startup_64_setup_gdt_idt
=20
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -91,7 +91,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * subsequent code. Pass the boot_params pointer as the first argument.
 	 */
 	movq	%r15, %rdi
-	call	sme_enable
+	call	__pi_sme_enable
 #endif
=20
 	/* Sanitize CPU configuration */
@@ -111,7 +111,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	movq	%r15, %rsi
-	call	__startup_64
+	call	__pi___startup_64
=20
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	leaq	early_top_pgt(%rip), %rcx
@@ -562,7 +562,7 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
-	call    do_vc_no_ghcb
+	call    __pi_do_vc_no_ghcb
=20
 	/* Unwind pt_regs */
 	POP_REGS
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index f8a33b2..edbf9c9 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -16,7 +16,7 @@
=20
 	.text
 	.code64
-SYM_FUNC_START(sme_encrypt_execute)
+SYM_FUNC_START(__pi_sme_encrypt_execute)
=20
 	/*
 	 * Entry parameters:
@@ -69,9 +69,9 @@ SYM_FUNC_START(sme_encrypt_execute)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(sme_encrypt_execute)
+SYM_FUNC_END(__pi_sme_encrypt_execute)
=20
-SYM_FUNC_START(__enc_copy)
+SYM_FUNC_START_LOCAL(__enc_copy)
 	ANNOTATE_NOENDBR
 /*
  * Routine used to encrypt memory in place.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fb47327..d0d2066 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3564,7 +3564,8 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 		if (func && insn_func(insn) && func !=3D insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___pfx_", 11))
 				return 0;
=20
 			if (file->ignore_unreachables)

