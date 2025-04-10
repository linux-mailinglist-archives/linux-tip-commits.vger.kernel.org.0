Return-Path: <linux-tip-commits+bounces-4828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEAA84187
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9588C2E88
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192A28152F;
	Thu, 10 Apr 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYao1Y1n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wqlF154P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C154281527;
	Thu, 10 Apr 2025 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283586; cv=none; b=e0VV5RaAtbaCsMAQHEEk0XKSAEjxbZddDeaNgvjtFuYDxKV7p2+mUs4yiJyQTujmrpDNYwmEB8jSFa6wxziecxcvuPKNglWMR5/xmhCWMbO0tDG10Z1yMihuHMN2QLt0tQsLd+7gOmhdHC+yXH55Vto2BojKLyu03DGC14EBZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283586; c=relaxed/simple;
	bh=13bTmMFNoHs5RfNUO7w1QxKqsS7EhkABv8NVzUinE+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hSo+zxN3ZXtp8hrbidL2KmmDGxrV9xOaTrfrapSbBDN0tGBOVXm20NYrFtbjdyaAPC779o1ApLlBpjJmZOw7px2gPtqYJoogNfaWTXzPpQ3sCWiQqkQb3J0sjD6IxtdemVoy1IwIXlhgMGzcCEu9oGFNVfRs9zygWmZzqKhyI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYao1Y1n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wqlF154P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 11:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744283583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VWMW7+Hgq7Oet86pzLTVfdIhwdQzTh37nnYenf44KA=;
	b=eYao1Y1nxQiUPz8w7Z4EgDzLHC4yg08pfoXaCoHuN/vJby1WcfBmcs0vPyIFdSJ0XW5Wtd
	G4qxDlMbL26Yk4c2Zlw2RJRjwS7reRpPiOFClpsInXRf+XIbIpFHLhL9Ziyp/sYoos+8yZ
	AwZp0MfqWAenw/tWqu6RIsHErnCz+3Zl5scFCdwdzbBJXLESk3wWofpYphBsxBUQ8FfTQL
	GJW/3UPeeZ23il8prNl3HjBwpyo+0OBs9J9IhCy120PQULFylOujau5zLnbTygVmMYmIBX
	6iUvqVqthG3OwMHL0qkEepn+ONYoU3jfEtEbljSXW3TFZJ76x3Vevha0SJEZNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744283583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VWMW7+Hgq7Oet86pzLTVfdIhwdQzTh37nnYenf44KA=;
	b=wqlF154PcFhOuOAN53nysACWXUMtOOmMsrWypl8TLZ7qSGUOHzROCguIo7VdClMWgw4Ua+
	Z0YDbTB+cH3LTYAg==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/kexec: Add 8250 MMIO serial port output
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326142404.256980-3-dwmw2@infradead.org>
References: <20250326142404.256980-3-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174428358226.31282.6409810067635972823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7516e7216bdfb9e2fab0a0ca3bd23cb2e61e46ed
Gitweb:        https://git.kernel.org/tip/7516e7216bdfb9e2fab0a0ca3bd23cb2e61e46ed
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 26 Mar 2025 14:16:02 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 12:17:14 +02:00

x86/kexec: Add 8250 MMIO serial port output

This supports the same 32-bit MMIO-mapped 8250 as the early_printk code.

It's not clear why the early_printk code supports this form and only this
form; the actual runtime 8250_pci doesn't seem to support it. But having
hacked up QEMU to expose such a device, early_printk does work with it,
and now so does the kexec debug code.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250326142404.256980-3-dwmw2@infradead.org
---
 arch/x86/include/asm/kexec.h         |  1 +
 arch/x86/kernel/early_printk.c       |  3 +++
 arch/x86/kernel/machine_kexec_64.c   | 17 +++++++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9601094..f2ad779 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -65,6 +65,7 @@ extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
+extern unsigned long kexec_debug_8250_mmio32;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index acb7d05..9e8707d 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -333,6 +333,9 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_X86_64)
+		kexec_debug_8250_mmio32 = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+#endif
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc73f97..ecb0da5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -76,6 +76,19 @@ map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
 #endif
 
+static int map_mmio_serial(struct x86_mapping_info *info, pgd_t *level4p)
+{
+	unsigned long mstart, mend;
+
+	if (!kexec_debug_8250_mmio32)
+		return 0;
+
+	mstart = kexec_debug_8250_mmio32 & PAGE_MASK;
+	mend = (kexec_debug_8250_mmio32 + PAGE_SIZE + 23) & PAGE_MASK;
+	pr_info("Map PCI serial at %lx - %lx\n", mstart, mend);
+	return kernel_ident_mapping_init(info, level4p, mstart, mend);
+}
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -285,6 +298,10 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 	if (result)
 		return result;
 
+	result = map_mmio_serial(&info, image->arch.pgd);
+	if (result)
+		return result;
+
 	/*
 	 * This must be last because the intermediate page table pages it
 	 * allocates will not be control pages and may overlap the image.
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 21011cd..8808cfc 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
@@ -413,6 +414,22 @@ pr_char_null:
 	ret
 SYM_CODE_END(pr_char_8250)
 
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+.Lxmtrdy_loop_mmio:
+	movb	(LSR*4)(%rdx), %ah
+	testb	$XMTRDY, %ah
+	jnz	.Lready_mmio
+	rep nop
+	jmp .Lxmtrdy_loop_mmio
+
+.Lready_mmio:
+	movb	%al, (%rdx)
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char_8250_mmio32)
+
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
@@ -423,6 +440,11 @@ SYM_CODE_END(pr_char_8250)
 	testw	%dx, %dx
 	jnz	1f
 
+	leaq	pr_char_8250_mmio32(%rip), %rsi
+	movq	kexec_debug_8250_mmio32(%rip), %rdx
+	testq	%rdx, %rdx
+	jnz	1f
+
 	leaq	pr_char_null(%rip), %rsi
 1:
 .endm

