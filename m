Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75E2D59BB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLJLvo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgLJLuf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00429C0613D6;
        Thu, 10 Dec 2020 03:49:51 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+fQAUeaF44k2setJj/XxrdUzAdqCJpGaOKVMnN/+U4=;
        b=grbTYgqAwqSSFwIT1qsLog3+6qO5pbwG6MeLnRvDXUFITUzlc0dGebtNBe5Rwx2cIVQdCe
        MAhxc2kwYx5C5gNsQndqMBmyNr87b4M+Su7dyLuk9HbQ35UaLaL6P0/vce7KWqWkbO9jZX
        bLGjz1omrO3QE35Hev6UU34Apn6uTr36QeI4BW/G/AxO+WfXjbIwXwTwhmP9o4cxwluHGM
        MKduVYfdVELsVQrboEMvitRU15X+aJJNoNinzqaruQGom2Fuhgtnc/hbwg8IlGmH1As+Dm
        E9w1ZC8go9D03q2vo6g+Xvno92+Yf/H5XlGPDLY72qjB4Xocum4jrh3uWEP57w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+fQAUeaF44k2setJj/XxrdUzAdqCJpGaOKVMnN/+U4=;
        b=gVPCnhS0K1B/iDgvmUZpae+LgNQouRPq3nop9v0KRKgxKiVQ5wetHCbxzGwg3+XFuexlp+
        iJWp6ieMQw5rJeAg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: stub: get rid of efi_get_max_fdt_addr()
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029134901.9773-1-ardb@kernel.org>
References: <20201029134901.9773-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <160760098928.3364.13832080297268895659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     54649911f31b6e7c2a79a1426ca98259139e4c35
Gitweb:        https://git.kernel.org/tip/54649911f31b6e7c2a79a1426ca98259139e4c35
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 29 Oct 2020 14:49:01 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 09 Dec 2020 08:37:27 +01:00

efi: stub: get rid of efi_get_max_fdt_addr()

Now that ARM started following the example of arm64 and RISC-V, and
no longer imposes any restrictions on the placement of the FDT in
memory at boot, we no longer need per-arch implementations of
efi_get_max_fdt_addr() to factor out the differences. So get rid of
it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20201029134901.9773-1-ardb@kernel.org
---
 arch/arm/include/asm/efi.h              | 6 ------
 arch/arm64/include/asm/efi.h            | 6 ------
 arch/riscv/include/asm/efi.h            | 6 ------
 drivers/firmware/efi/libstub/efi-stub.c | 1 -
 drivers/firmware/efi/libstub/efistub.h  | 1 -
 drivers/firmware/efi/libstub/fdt.c      | 3 +--
 6 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 1536805..abae071 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -73,12 +73,6 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
  */
 #define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
 
-/* on ARM, the FDT should be located in a lowmem region */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
-}
-
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 00bd1e1..3578aba 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -64,12 +64,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 #define EFI_KIMG_ALIGN	\
 	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
 
-/* on arm64, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
  * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 7542282..6d98cd9 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -27,12 +27,6 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
 
-/* on RISC-V, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /* Load initrd at enough distance from DRAM start */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 914a343..ec2f398 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -273,7 +273,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	install_memreserve_table();
 
 	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						efi_get_max_fdt_addr(image_addr),
 						initrd_addr, initrd_size,
 						cmdline_ptr, fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b8ec29d..b50a6c6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -750,7 +750,6 @@ efi_status_t efi_exit_boot_services(void *handle,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 368cd60..365c3a4 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -238,7 +238,6 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -275,7 +274,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_info("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
+	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
