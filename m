Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C2426F83F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIRIbQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIRIbB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:01 -0400
Date:   Fri, 18 Sep 2020 08:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rU1pPZbVFmEfvu/DP9kueUx3w5wVWwFseh3if88jeoU=;
        b=dcnvY3WD6rLJfDwQMggeL0m7J6G1e16WdUQ39902p+x5lIOskvOWtTDcRc75oP3focwbtQ
        wFj3jGNqJvIKcj8rnkPycS3nrQ4B+E0bQyJumPu3q71BWr2oiGzSv7jF2BK9SVmfVacenE
        yKqBh2Zr/m0+RheUY1ceUwTElX0cJudFaM8/emnL9fcvI/R5yBFNTicQ1QySt+7D9Xx3fU
        aJ1Pp/lBaumzfCA/VCNWovhr2DYvgNaCVcGPsIWG2Lai8uVzh7x97XAvNrfVqIFjZPjmu3
        F/JZrS/ehObkcNzivhxOjYWMe0b+l3PCWyXNjZbb++aUIuXyZhrdQwGE5Gv5Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rU1pPZbVFmEfvu/DP9kueUx3w5wVWwFseh3if88jeoU=;
        b=VF6ag/++Ys2E0phvl6zmD4nFJ3+fef5lqlAyMubAS7HT0zY8cUKgVjUkzEvz071WIu5N2s
        2MYBy0wfLH/LRfDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: arm32: Use low allocation for the
 uncompressed kernel
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160041785640.15536.10531706302598671727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     762cd288fc4a24a372f36408e69b1885967f94bb
Gitweb:        https://git.kernel.org/tip/762cd288fc4a24a372f36408e69b1885967f94bb
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 09 Sep 2020 17:11:50 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:55:02 +03:00

efi/libstub: arm32: Use low allocation for the uncompressed kernel

Before commit

  d0f9ca9be11f25ef ("ARM: decompressor: run decompressor in place if loaded via UEFI")

we were rather limited in the choice of base address for the uncompressed
kernel, as we were relying on the logic in the decompressor that blindly
rounds down the decompressor execution address to the next multiple of 128
MiB, and decompresses the kernel there. For this reason, we have a lot of
complicated memory region handling code, to ensure that this memory window
is available, even though it could be occupied by reserved regions or
other allocations that may or may not collide with the uncompressed image.

Today, we simply pass the target address for the decompressed image to the
decompressor directly, and so we can choose a suitable window just by
finding a 16 MiB aligned region, while taking TEXT_OFFSET and the region
for the swapper page tables into account.

So let's get rid of the complicated logic, and instead, use the existing
bottom up allocation routine to allocate a suitable window as low as
possible, and carve out a memory region that has the right properties.

Note that this removes any dependencies on the 'dram_base' argument to
handle_kernel_image(), and so this is removed as well. Given that this
was the only remaining use of dram_base, the code that produces it is
removed entirely as well.

Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Tested-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm32-stub.c | 178 ++++-----------------
 drivers/firmware/efi/libstub/arm64-stub.c |   1 +-
 drivers/firmware/efi/libstub/efi-stub.c   |  44 +-----
 drivers/firmware/efi/libstub/efistub.h    |   4 +-
 4 files changed, 38 insertions(+), 189 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index bcf770c..4b5b240 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -113,162 +113,58 @@ void free_screen_info(struct screen_info *si)
 	efi_bs_call(free_pool, si);
 }
 
-static efi_status_t reserve_kernel_base(unsigned long dram_base,
-					unsigned long *reserve_addr,
-					unsigned long *reserve_size)
-{
-	efi_physical_addr_t alloc_addr;
-	efi_memory_desc_t *memory_map;
-	unsigned long nr_pages, map_size, desc_size, buff_size;
-	efi_status_t status;
-	unsigned long l;
-
-	struct efi_boot_memmap map = {
-		.map		= &memory_map,
-		.map_size	= &map_size,
-		.desc_size	= &desc_size,
-		.desc_ver	= NULL,
-		.key_ptr	= NULL,
-		.buff_size	= &buff_size,
-	};
-
-	/*
-	 * Reserve memory for the uncompressed kernel image. This is
-	 * all that prevents any future allocations from conflicting
-	 * with the kernel. Since we can't tell from the compressed
-	 * image how much DRAM the kernel actually uses (due to BSS
-	 * size uncertainty) we allocate the maximum possible size.
-	 * Do this very early, as prints can cause memory allocations
-	 * that may conflict with this.
-	 */
-	alloc_addr = dram_base + MAX_UNCOMP_KERNEL_SIZE;
-	nr_pages = MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE;
-	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
-			     EFI_BOOT_SERVICES_DATA, nr_pages, &alloc_addr);
-	if (status == EFI_SUCCESS) {
-		if (alloc_addr == dram_base) {
-			*reserve_addr = alloc_addr;
-			*reserve_size = MAX_UNCOMP_KERNEL_SIZE;
-			return EFI_SUCCESS;
-		}
-		/*
-		 * If we end up here, the allocation succeeded but starts below
-		 * dram_base. This can only occur if the real base of DRAM is
-		 * not a multiple of 128 MB, in which case dram_base will have
-		 * been rounded up. Since this implies that a part of the region
-		 * was already occupied, we need to fall through to the code
-		 * below to ensure that the existing allocations don't conflict.
-		 * For this reason, we use EFI_BOOT_SERVICES_DATA above and not
-		 * EFI_LOADER_DATA, which we wouldn't able to distinguish from
-		 * allocations that we want to disallow.
-		 */
-	}
-
-	/*
-	 * If the allocation above failed, we may still be able to proceed:
-	 * if the only allocations in the region are of types that will be
-	 * released to the OS after ExitBootServices(), the decompressor can
-	 * safely overwrite them.
-	 */
-	status = efi_get_memory_map(&map);
-	if (status != EFI_SUCCESS) {
-		efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
-		return status;
-	}
-
-	for (l = 0; l < map_size; l += desc_size) {
-		efi_memory_desc_t *desc;
-		u64 start, end;
-
-		desc = (void *)memory_map + l;
-		start = desc->phys_addr;
-		end = start + desc->num_pages * EFI_PAGE_SIZE;
-
-		/* Skip if entry does not intersect with region */
-		if (start >= dram_base + MAX_UNCOMP_KERNEL_SIZE ||
-		    end <= dram_base)
-			continue;
-
-		switch (desc->type) {
-		case EFI_BOOT_SERVICES_CODE:
-		case EFI_BOOT_SERVICES_DATA:
-			/* Ignore types that are released to the OS anyway */
-			continue;
-
-		case EFI_CONVENTIONAL_MEMORY:
-			/* Skip soft reserved conventional memory */
-			if (efi_soft_reserve_enabled() &&
-			    (desc->attribute & EFI_MEMORY_SP))
-				continue;
-
-			/*
-			 * Reserve the intersection between this entry and the
-			 * region.
-			 */
-			start = max(start, (u64)dram_base);
-			end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
-
-			status = efi_bs_call(allocate_pages,
-					     EFI_ALLOCATE_ADDRESS,
-					     EFI_LOADER_DATA,
-					     (end - start) / EFI_PAGE_SIZE,
-					     &start);
-			if (status != EFI_SUCCESS) {
-				efi_err("reserve_kernel_base(): alloc failed.\n");
-				goto out;
-			}
-			break;
-
-		case EFI_LOADER_CODE:
-		case EFI_LOADER_DATA:
-			/*
-			 * These regions may be released and reallocated for
-			 * another purpose (including EFI_RUNTIME_SERVICE_DATA)
-			 * at any time during the execution of the OS loader,
-			 * so we cannot consider them as safe.
-			 */
-		default:
-			/*
-			 * Treat any other allocation in the region as unsafe */
-			status = EFI_OUT_OF_RESOURCES;
-			goto out;
-		}
-	}
-
-	status = EFI_SUCCESS;
-out:
-	efi_bs_call(free_pool, memory_map);
-	return status;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 unsigned long dram_base,
 				 efi_loaded_image_t *image)
 {
-	unsigned long kernel_base;
+	const int slack = TEXT_OFFSET - 5 * PAGE_SIZE;
+	int alloc_size = MAX_UNCOMP_KERNEL_SIZE + EFI_PHYS_ALIGN;
+	unsigned long alloc_base, kernel_base;
 	efi_status_t status;
 
-	/* use a 16 MiB aligned base for the decompressed kernel */
-	kernel_base = round_up(dram_base, EFI_PHYS_ALIGN) + TEXT_OFFSET;
-
 	/*
-	 * Note that some platforms (notably, the Raspberry Pi 2) put
-	 * spin-tables and other pieces of firmware at the base of RAM,
-	 * abusing the fact that the window of TEXT_OFFSET bytes at the
-	 * base of the kernel image is only partially used at the moment.
-	 * (Up to 5 pages are used for the swapper page tables)
+	 * Allocate space for the decompressed kernel as low as possible.
+	 * The region should be 16 MiB aligned, but the first 'slack' bytes
+	 * are not used by Linux, so we allow those to be occupied by the
+	 * firmware.
 	 */
-	status = reserve_kernel_base(kernel_base - 5 * PAGE_SIZE, reserve_addr,
-				     reserve_size);
+	status = efi_low_alloc_above(alloc_size, EFI_PAGE_SIZE, &alloc_base, 0x0);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
 	}
 
-	*image_addr = kernel_base;
+	if ((alloc_base % EFI_PHYS_ALIGN) > slack) {
+		/*
+		 * More than 'slack' bytes are already occupied at the base of
+		 * the allocation, so we need to advance to the next 16 MiB block.
+		 */
+		kernel_base = round_up(alloc_base, EFI_PHYS_ALIGN);
+		efi_info("Free memory starts at 0x%lx, setting kernel_base to 0x%lx\n",
+			 alloc_base, kernel_base);
+	} else {
+		kernel_base = round_down(alloc_base, EFI_PHYS_ALIGN);
+	}
+
+	*reserve_addr = kernel_base + slack;
+	*reserve_size = MAX_UNCOMP_KERNEL_SIZE;
+
+	/* now free the parts that we will not use */
+	if (*reserve_addr > alloc_base) {
+		efi_bs_call(free_pages, alloc_base,
+			    (*reserve_addr - alloc_base) / EFI_PAGE_SIZE);
+		alloc_size -= *reserve_addr - alloc_base;
+	}
+	efi_bs_call(free_pages, *reserve_addr + MAX_UNCOMP_KERNEL_SIZE,
+		    (alloc_size - MAX_UNCOMP_KERNEL_SIZE) / EFI_PAGE_SIZE);
+
+	*image_addr = kernel_base + TEXT_OFFSET;
 	*image_size = 0;
+
+	efi_debug("image addr == 0x%lx, reserve_addr == 0x%lx\n",
+		  *image_addr, *reserve_addr);
+
 	return EFI_SUCCESS;
 }
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index e5bfac7..56e79f3 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -50,7 +50,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 unsigned long dram_base,
 				 efi_loaded_image_t *image)
 {
 	efi_status_t status;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 65a0070..311a168 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -87,40 +87,6 @@ static void install_memreserve_table(void)
 		efi_err("Failed to install memreserve config table!\n");
 }
 
-static unsigned long get_dram_base(void)
-{
-	efi_status_t status;
-	unsigned long map_size, buff_size;
-	unsigned long membase  = EFI_ERROR;
-	struct efi_memory_map map;
-	efi_memory_desc_t *md;
-	struct efi_boot_memmap boot_map;
-
-	boot_map.map		= (efi_memory_desc_t **)&map.map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &map.desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
-
-	status = efi_get_memory_map(&boot_map);
-	if (status != EFI_SUCCESS)
-		return membase;
-
-	map.map_end = map.map + map_size;
-
-	for_each_efi_memory_desc_in_map(&map, md) {
-		if (md->attribute & EFI_MEMORY_WB) {
-			if (membase > md->phys_addr)
-				membase = md->phys_addr;
-		}
-	}
-
-	efi_bs_call(free_pool, map.map);
-
-	return membase;
-}
-
 /*
  * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
  * that is described in the PE/COFF header.  Most of the code is the same
@@ -134,7 +100,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	unsigned long image_addr;
 	unsigned long image_size = 0;
-	unsigned long dram_base;
 	/* addr/point and size pairs for memory management*/
 	unsigned long initrd_addr = 0;
 	unsigned long initrd_size = 0;
@@ -174,13 +139,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	dram_base = get_dram_base();
-	if (dram_base == EFI_ERROR) {
-		efi_err("Failed to find DRAM base\n");
-		status = EFI_LOAD_ERROR;
-		goto fail;
-	}
-
 	/*
 	 * Get the command line from EFI, using the LOADED_IMAGE
 	 * protocol. We are going to copy the command line into the
@@ -218,7 +176,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = handle_kernel_image(&image_addr, &image_size,
 				     &reserve_addr,
 				     &reserve_size,
-				     dram_base, image);
+				     image);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
 		goto fail_free_screeninfo;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 158f86f..27cdcb1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -10,9 +10,6 @@
 #include <linux/types.h>
 #include <asm/efi.h>
 
-/* error code which can't be mistaken for valid address */
-#define EFI_ERROR	(~0UL)
-
 /*
  * __init annotations should not be used in the EFI stub, since the code is
  * either included in the decompressor (x86, ARM) where they have no effect,
@@ -789,7 +786,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 unsigned long dram_base,
 				 efi_loaded_image_t *image);
 
 asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
