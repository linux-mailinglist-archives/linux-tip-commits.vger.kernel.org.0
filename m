Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242034676E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhCWSUG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 14:20:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhCWSTh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 14:19:37 -0400
Date:   Tue, 23 Mar 2021 18:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616523575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZvd/FmbxnQRcsh5Lz/slR/Uda4I6DGr81sjHgEAcMI=;
        b=TvGvFFWyEnq1947AKf1jdnlEVyZpjAki+maufMs4fBQ+Y9tfQ7NG1/XsCAqSmmeF+gUP3Y
        TCTrlQUUObZjyOn01dv4t7X/QT4CLclvrGFDL1HTuOD5YscZ1OFhfLV/Lnl0comcXQZv45
        GCvenQTmnq0uV6lqzpfrO/7XvDQQ98hS0wiVFtBLkVtEsAHqkGNIHWTXG1v4XjSr5Qh3Po
        mfi7/Vv0N42ZKjfUw2WReA41UVUA9rcXJSHrijteC/W0yqkqFSWo9wjmaXQqPo/j/4L0WN
        2tN8N7BA51KYSPVUSQRNDOaABGSs7Vj79H5wmdv6dajMLLNTew0Kp7u2YpBiHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616523575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZvd/FmbxnQRcsh5Lz/slR/Uda4I6DGr81sjHgEAcMI=;
        b=hRPGtDm8JuVGXZcLdUhhrYYUwuLeHTQo4u6XnR/j2h7vmn66c6160ieYqoFV8eh9tYaBWC
        kSanV12OhRG5hmDQ==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Consolidate early memory reservations
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201217201214.3414100-2-guro@fb.com>
References: <20201217201214.3414100-2-guro@fb.com>
MIME-Version: 1.0
Message-ID: <161652357527.398.12584359578124264139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
Gitweb:        https://git.kernel.org/tip/a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 02 Mar 2021 12:04:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 23 Mar 2021 17:13:17 +01:00

x86/setup: Consolidate early memory reservations

The early reservations of memory areas used by the firmware, bootloader,
kernel text and data are spread over setup_arch(). Moreover, some of them
happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
trim_low_memory_range() are called after reserve_real_mode() that allocates
memory.

There was no corruption of these memory regions because memblock always
allocates memory either from the end of memory (in top-down mode) or above
the kernel image (in bottom-up mode). However, the bottom up mode is going
to be updated to span the entire memory [1] to avoid limitations caused by
KASLR.

Consolidate early memory reservations in a dedicated function to improve
robustness against future changes. Having the early reservations in one
place also makes it clearer what memory must be reserved before memblock
allocations are allowed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Borislav Petkov <bp@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Link: [1] https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
Link: https://lkml.kernel.org/r/20210302100406.22059-2-rppt@kernel.org
---
 arch/x86/kernel/setup.c | 92 +++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176..3e3c603 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -645,18 +645,6 @@ static void __init trim_snb_memory(void)
 	}
 }
 
-/*
- * Here we put platform-specific memory range workarounds, i.e.
- * memory known to be corrupt or otherwise in need to be reserved on
- * specific platforms.
- *
- * If this gets used more widely it could use a real dispatch mechanism.
- */
-static void __init trim_platform_memory_ranges(void)
-{
-	trim_snb_memory();
-}
-
 static void __init trim_bios_range(void)
 {
 	/*
@@ -729,7 +717,38 @@ static void __init trim_low_memory_range(void)
 {
 	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 }
-	
+
+static void __init early_reserve_memory(void)
+{
+	/*
+	 * Reserve the memory occupied by the kernel between _text and
+	 * __end_of_kernel_reserve symbols. Any kernel sections after the
+	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
+	 * separate memblock_reserve() or they will be discarded.
+	 */
+	memblock_reserve(__pa_symbol(_text),
+			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
+
+	/*
+	 * Make sure page 0 is always reserved because on systems with
+	 * L1TF its contents can be leaked to user processes.
+	 */
+	memblock_reserve(0, PAGE_SIZE);
+
+	early_reserve_initrd();
+
+	if (efi_enabled(EFI_BOOT))
+		efi_memblock_x86_reserve_range();
+
+	memblock_x86_reserve_range_setup_data();
+
+	reserve_ibft_region();
+	reserve_bios_regions();
+
+	trim_snb_memory();
+	trim_low_memory_range();
+}
+
 /*
  * Dump out kernel offset information on panic.
  */
@@ -764,29 +783,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 
 void __init setup_arch(char **cmdline_p)
 {
-	/*
-	 * Reserve the memory occupied by the kernel between _text and
-	 * __end_of_kernel_reserve symbols. Any kernel sections after the
-	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
-	 * separate memblock_reserve() or they will be discarded.
-	 */
-	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
-
-	/*
-	 * Make sure page 0 is always reserved because on systems with
-	 * L1TF its contents can be leaked to user processes.
-	 */
-	memblock_reserve(0, PAGE_SIZE);
-
-	early_reserve_initrd();
-
-	/*
-	 * At this point everything still needed from the boot loader
-	 * or BIOS or kernel text should be early reserved or marked not
-	 * RAM in e820. All other memory is free game.
-	 */
-
 #ifdef CONFIG_X86_32
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
 
@@ -910,8 +906,18 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
-	if (efi_enabled(EFI_BOOT))
-		efi_memblock_x86_reserve_range();
+	/*
+	 * Do some memory reservations *before* memory is added to
+	 * memblock, so memblock allocations won't overwrite it.
+	 * Do it after early param, so we could get (unlikely) panic from
+	 * serial.
+	 *
+	 * After this point everything still needed from the boot loader or
+	 * firmware or kernel text should be early reserved or marked not
+	 * RAM in e820. All other memory is free game.
+	 */
+	early_reserve_memory();
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
@@ -938,9 +944,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
-	/* after early param, so could get panic from serial */
-	memblock_x86_reserve_range_setup_data();
-
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		disable_apic = 1;
@@ -1032,8 +1035,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	find_smp_config();
 
-	reserve_ibft_region();
-
 	early_alloc_pgt_buf();
 
 	/*
@@ -1054,8 +1055,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	sev_setup_arch();
 
-	reserve_bios_regions();
-
 	efi_fake_memmap();
 	efi_find_mirror();
 	efi_esrt_init();
@@ -1081,9 +1080,6 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_real_mode();
 
-	trim_platform_memory_ranges();
-	trim_low_memory_range();
-
 	init_mem_mapping();
 
 	idt_setup_early_pf();
