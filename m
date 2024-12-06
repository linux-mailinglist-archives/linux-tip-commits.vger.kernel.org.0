Return-Path: <linux-tip-commits+bounces-2999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871479E6BC3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4285428848D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70BB200B9E;
	Fri,  6 Dec 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="en2Fvn/x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekzJP/9b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866251FF7AC;
	Fri,  6 Dec 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480209; cv=none; b=Yao4PO3YV1iHB+kotNeKJpmeXwuDudCKqOA/liax7wppx31Lclhd1cH86uNAzw5meClnzTJIHFnjYNwhyZlBpxgcDYODUKeTgWXRCa6jPkdwuX13IrfklmwwCRdTk9cXsCVJQSKtk7yD4ulY0Oc+wM6XKZkMdNOt03mG/Kk2Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480209; c=relaxed/simple;
	bh=uo6jgoyTB9RBqNSHvd6Qsk0dDh2pcRgV2pmlSGICkA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFEjI7VEw8slwRupRLddFckyuLENLfghfU26qyfS2CdWj7/Ll1E9kr2jk58eeSpH2/TZTachtJOG0hXw4bbJXD7OjCmg3BBSs8p4EKSbfFg6iL7o05HJY8qKIdQoMtX4BqV/ARaIPX1sEKH2pQWz7d6U6HWUg8GD8ijeEN525IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=en2Fvn/x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekzJP/9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uNY76JKDMptvZ3ZZH2ykHka+gt7LlO+hkSRCYbVkS8=;
	b=en2Fvn/xjteyLAbJrxWC3BVvdZGt9eIOWHOPwun4T4/e+NMst9phvIRQW3z7z8PiIcK9wU
	erNu1FIFmOGIS4lLqIKzJgX9507ZRlQUQH6eC/AcK3fj4xBjU6hf9Sy55JMofOkYU/HKLl
	BpN2q0OCVKkeLUMDiA4+7NFRW7wyxOGnEzP/oR0CASkUm2uvLk9qgwnOpoQ9uoYQxIwZz7
	3b6asR7zVdYm+CKc1Jzv3OyfSigoxMA/WCnXlkqXdlr8krHVyKjeZozezF/q8K1eIruLXL
	PlZjGX4BFDqG8hHz98zuynItoqwAgYCf8ZnpcERoK/Hm4MidqGcNg2ODD++ROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uNY76JKDMptvZ3ZZH2ykHka+gt7LlO+hkSRCYbVkS8=;
	b=ekzJP/9b+xgsh51LorOI9FMInSxOnEAz1IUzPV+6r1IiNZ0q9N9nxVvOpTPEZPkfkTRpbJ
	rHvW6LW4rZsje7AA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Drop page_list argument from relocate_kernel()
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-11-dwmw2@infradead.org>
References: <20241205153343.3275139-11-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020509.412.16473323990956408472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b3adabae8a96fee62184f4236bf60313b35244e9
Gitweb:        https://git.kernel.org/tip/b3adabae8a96fee62184f4236bf60313b35244e9
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:42:00 +01:00

x86/kexec: Drop page_list argument from relocate_kernel()

The kernel's virtual mapping of the relocate_kernel page currently needs
to be RWX because it is written to before the %cr3 switch.

Now that the relocate_kernel page has its own .data section and local
variables, it can also have *global* variables. So eliminate the separate
page_list argument, and write the same information directly to variables
in the relocate_kernel page instead. This way, the relocate_kernel code
itself doesn't need to copy it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-11-dwmw2@infradead.org
---
 arch/x86/include/asm/kexec.h         | 12 +++------
 arch/x86/kernel/machine_kexec_64.c   | 18 +++++---------
 arch/x86/kernel/relocate_kernel_64.S | 36 +++++++++------------------
 3 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ccb8ff3..48e4f44 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -8,12 +8,6 @@
 # define PA_PGD			2
 # define PA_SWAP_PAGE		3
 # define PAGES_NR		4
-#else
-# define PA_CONTROL_PAGE	0
-# define VA_CONTROL_PAGE	1
-# define PA_TABLE_PAGE		2
-# define PA_SWAP_PAGE		3
-# define PAGES_NR		4
 #endif
 
 # define KEXEC_CONTROL_PAGE_SIZE	4096
@@ -60,6 +54,10 @@ struct kimage;
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
+
+extern unsigned long kexec_va_control_page;
+extern unsigned long kexec_pa_table_page;
+extern unsigned long kexec_pa_swap_page;
 #endif
 
 /*
@@ -122,7 +120,7 @@ relocate_kernel(unsigned long indirection_page,
 #else
 unsigned long
 relocate_kernel(unsigned long indirection_page,
-		unsigned long page_list,
+		unsigned long pa_control_page,
 		unsigned long start_address,
 		unsigned int preserve_context,
 		unsigned int host_mem_enc_active);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 63dca5c..c9fd60f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -315,6 +315,11 @@ int machine_kexec_prepare(struct kimage *image)
 	result = init_pgtable(image, __pa(control_page));
 	if (result)
 		return result;
+	kexec_va_control_page = (unsigned long)control_page;
+	kexec_pa_table_page = (unsigned long)__pa(image->arch.pgd);
+
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
@@ -339,12 +344,11 @@ void machine_kexec_cleanup(struct kimage *image)
 void machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
-					     unsigned long page_list,
+					     unsigned long pa_control_page,
 					     unsigned long start_address,
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
-	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
 	void *control_page;
@@ -382,14 +386,6 @@ void machine_kexec(struct kimage *image)
 
 	control_page = page_address(image->control_code_page);
 
-	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
-	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
-
-	if (image->type == KEXEC_TYPE_DEFAULT)
-		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
-						<< PAGE_SHIFT);
-
 	/*
 	 * Allow for the possibility that relocate_kernel might not be at
 	 * the very start of the page.
@@ -417,7 +413,7 @@ void machine_kexec(struct kimage *image)
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
-					   (unsigned long)page_list,
+					   virt_to_phys(control_page),
 					   image->start,
 					   image->preserve_context,
 					   host_mem_enc_active);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index f13866a..d52c3bb 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -34,9 +34,9 @@ SYM_DATA_LOCAL(saved_cr0, .quad 0)
 SYM_DATA_LOCAL(saved_cr3, .quad 0)
 SYM_DATA_LOCAL(saved_cr4, .quad 0)
 	/* other data */
-SYM_DATA_LOCAL(va_control_page, .quad 0)
-SYM_DATA_LOCAL(pa_table_page, .quad 0)
-SYM_DATA_LOCAL(pa_swap_page, .quad 0)
+SYM_DATA(kexec_va_control_page, .quad 0)
+SYM_DATA(kexec_pa_table_page, .quad 0)
+SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
 	.section .text.relocate_kernel,"ax";
@@ -46,7 +46,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
-	 * %rsi page_list
+	 * %rsi pa_control_page
 	 * %rdx start address
 	 * %rcx preserve_context
 	 * %r8  host_mem_enc_active
@@ -79,31 +79,19 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save SME active flag */
 	movq	%r8, %r12
 
-	/*
-	 * get physical and virtual address of control page now
-	 * this is impossible after page table switch
-	 */
-	movq	PTR(PA_CONTROL_PAGE)(%rsi), %r8
-	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
-
-	/* get physical address of page table now too */
-	movq	PTR(PA_TABLE_PAGE)(%rsi), %r9
-
-	/* get physical address of swap page now */
-	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
-
-	/* save some information for jumping back */
-	movq	%r9, pa_table_page(%rip)
-	movq	%r10, pa_swap_page(%rip)
+	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)
-	movq	%r11, va_control_page(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
 	/* Switch to the identity mapped page tables */
+	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
 
+	/* Physical address of control page */
+	movq    %rsi, %r8
+
 	/* setup a new stack at the end of the physical control page */
 	lea	PAGE_SIZE(%r8), %rsp
 
@@ -227,13 +215,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
 	leaq	relocate_kernel(%rip), %r8
-	movq	pa_swap_page(%rip), %r10
+	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
-	movq	pa_table_page(%rip), %rax
+	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	va_control_page(%rip), %rax
+	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE

