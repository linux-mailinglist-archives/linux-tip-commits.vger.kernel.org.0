Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62E724D5B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jun 2023 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbjFFTnL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 6 Jun 2023 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbjFFTmp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828010FB;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw+F+a9Unv7j52vMk+RKdT6o55w27B3ppxDYZe9u1nc=;
        b=fV5u/EMTKKuJmBRPHlTwlN1Li/HI/gy9QHe2M2uqZ12IXUrN9zHWZsDet64aQW41/XDEw8
        +ywKoDnIBi/jFNuG8LEOPWLcok3LvhyLajYno1VxkMvpYhg3tqTdRUBnmsBRDdJ5/y2dzi
        ZhiHAs3hzZjIA3feYaESGoKQf9BtbQv9bqI5xVJO5VJTDiUfGLLoUcmK/w81n83FcWWuFC
        C0ynum2Vl/sQd76uXikMQaazTUGp0nINuXE1k5hCokJ16zbD9yQEczN2UUKusHYGEIKzW8
        OuuQ7x3QfkPBgbnC8hisPvUjFOe28wkN4cWyWEQdwL6TMfTrqG2abX/f6IpItA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw+F+a9Unv7j52vMk+RKdT6o55w27B3ppxDYZe9u1nc=;
        b=HSGx9quToqOFUfUZI5/j2wpfp5jMuFeM8ZsnYujCdLKAcw1DOzIQb33WCopBMGt3KT9Hq7
        CLtUoxs0odBUB1DQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] efi/libstub: Implement support for unaccepted memory
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-4-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608056028.404.9833548856454967336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     745e3ed85f71a6382a239b03d9278a8025f2beae
Gitweb:        https://git.kernel.org/tip/745e3ed85f71a6382a239b03d9278a8025f2beae
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:31 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 16:58:23 +02:00

efi/libstub: Implement support for unaccepted memory

UEFI Specification version 2.9 introduces the concept of memory
acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, requiring memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific for the Virtual
Machine platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. It's better to postpone memory
acceptance until memory is needed. It lowers boot time and reduces
memory overhead.

The kernel needs to know what memory has been accepted. Firmware
communicates this information via memory map: a new memory type --
EFI_UNACCEPTED_MEMORY -- indicates such memory.

Range-based tracking works fine for firmware, but it gets bulky for
the kernel: e820 (or whatever the arch uses) has to be modified on every
page acceptance. It leads to table fragmentation and there's a limited
number of entries in the e820 table.

Another option is to mark such memory as usable in e820 and track if the
range has been accepted in a bitmap. One bit in the bitmap represents a
naturally aligned power-2-sized region of address space -- unit.

For x86, unit size is 2MiB: 4k of the bitmap is enough to track 64GiB or
physical address space.

In the worst-case scenario -- a huge hole in the middle of the
address space -- It needs 256MiB to handle 4PiB of the address
space.

Any unaccepted memory that is not aligned to unit_size gets accepted
upfront.

The bitmap is allocated and constructed in the EFI stub and passed down
to the kernel via EFI configuration table. allocate_e820() allocates the
bitmap if unaccepted memory is present, according to the size of
unaccepted region.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20230606142637.5171-4-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/compressed/Makefile                |   1 +-
 arch/x86/boot/compressed/mem.c                   |   9 +-
 arch/x86/include/asm/efi.h                       |   2 +-
 drivers/firmware/efi/Kconfig                     |  14 +-
 drivers/firmware/efi/efi.c                       |   1 +-
 drivers/firmware/efi/libstub/Makefile            |   2 +-
 drivers/firmware/efi/libstub/bitmap.c            |  41 +++-
 drivers/firmware/efi/libstub/efistub.h           |   6 +-
 drivers/firmware/efi/libstub/find.c              |  43 +++-
 drivers/firmware/efi/libstub/unaccepted_memory.c | 222 ++++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c          |  13 +-
 include/linux/efi.h                              |  12 +-
 12 files changed, 365 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 drivers/firmware/efi/libstub/bitmap.c
 create mode 100644 drivers/firmware/efi/libstub/find.c
 create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe6..cc49781 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
new file mode 100644
index 0000000..67594fc
--- /dev/null
+++ b/arch/x86/boot/compressed/mem.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "error.h"
+
+void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	error("Cannot accept memory");
+}
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 419280d..8b4be7c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -31,6 +31,8 @@ extern unsigned long efi_mixed_mode_stack_pa;
 
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
+#define EFI_UNACCEPTED_UNIT_SIZE PMD_SIZE
+
 /*
  * The EFI services are called through variadic functions in many cases. These
  * functions are implemented in assembler and support only a fixed number of
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 043ca31..231f1c7 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -269,6 +269,20 @@ config EFI_COCO_SECRET
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
 
+config UNACCEPTED_MEMORY
+	bool
+	depends on EFI_STUB
+	help
+	   Some Virtual Machine platforms, such as Intel TDX, require
+	   some memory to be "accepted" by the guest before it can be used.
+	   This mechanism helps prevent malicious hosts from making changes
+	   to guest memory.
+
+	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
+
+	   This option adds support for unaccepted memory and makes such memory
+	   usable by the kernel.
+
 config EFI_EMBEDDED_FIRMWARE
 	bool
 	select CRYPTO_LIB_SHA256
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index abeff7d..7dce06e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -843,6 +843,7 @@ static __initdata char memory_type_name[][13] = {
 	"MMIO Port",
 	"PAL Code",
 	"Persistent",
+	"Unaccepted",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3abb2b3..16d64a3 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -96,6 +96,8 @@ CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
+lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
+
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
diff --git a/drivers/firmware/efi/libstub/bitmap.c b/drivers/firmware/efi/libstub/bitmap.c
new file mode 100644
index 0000000..5c9bba0
--- /dev/null
+++ b/drivers/firmware/efi/libstub/bitmap.c
@@ -0,0 +1,41 @@
+#include <linux/bitmap.h>
+
+void __bitmap_set(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		*p |= mask_to_set;
+	}
+}
+
+void __bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 54a2822..6aa38a1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1136,4 +1136,10 @@ void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
 
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map);
+void process_unaccepted_memory(u64 start, u64 end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+void arch_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/find.c b/drivers/firmware/efi/libstub/find.c
new file mode 100644
index 0000000..4e7740d
--- /dev/null
+++ b/drivers/firmware/efi/libstub/find.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bitmap.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+
+/*
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ */
+#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
+		if ((idx + 1) * BITS_PER_LONG >= sz)				\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
+out:										\
+	sz;									\
+})
+
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+}
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
new file mode 100644
index 0000000..ca61f47
--- /dev/null
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+struct efi_unaccepted_memory *unaccepted_table;
+
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map)
+{
+	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
+	efi_status_t status;
+	int i;
+
+	/* Check if the table is already installed */
+	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
+	if (unaccepted_table) {
+		if (unaccepted_table->version != 1) {
+			efi_err("Unknown version of unaccepted memory table\n");
+			return EFI_UNSUPPORTED;
+		}
+		return EFI_SUCCESS;
+	}
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+		unsigned long m = (unsigned long)map->map;
+
+		d = efi_early_memdesc_ptr(m, map->desc_size, i);
+		if (d->type != EFI_UNACCEPTED_MEMORY)
+			continue;
+
+		unaccepted_start = min(unaccepted_start, d->phys_addr);
+		unaccepted_end = max(unaccepted_end,
+				     d->phys_addr + d->num_pages * PAGE_SIZE);
+	}
+
+	if (unaccepted_start == ULLONG_MAX)
+		return EFI_SUCCESS;
+
+	unaccepted_start = round_down(unaccepted_start,
+				      EFI_UNACCEPTED_UNIT_SIZE);
+	unaccepted_end = round_up(unaccepted_end, EFI_UNACCEPTED_UNIT_SIZE);
+
+	/*
+	 * If unaccepted memory is present, allocate a bitmap to track what
+	 * memory has to be accepted before access.
+	 *
+	 * One bit in the bitmap represents 2MiB in the address space:
+	 * A 4k bitmap can track 64GiB of physical address space.
+	 *
+	 * In the worst case scenario -- a huge hole in the middle of the
+	 * address space -- It needs 256MiB to handle 4PiB of the address
+	 * space.
+	 *
+	 * The bitmap will be populated in setup_e820() according to the memory
+	 * map after efi_exit_boot_services().
+	 */
+	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
+				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*unaccepted_table) + bitmap_size,
+			     (void **)&unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate unaccepted memory config table\n");
+		return status;
+	}
+
+	unaccepted_table->version = 1;
+	unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
+	unaccepted_table->phys_base = unaccepted_start;
+	unaccepted_table->size = bitmap_size;
+	memset(unaccepted_table->bitmap, 0, bitmap_size);
+
+	status = efi_bs_call(install_configuration_table,
+			     &unaccepted_table_guid, unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, unaccepted_table);
+		efi_err("Failed to install unaccepted memory config table!\n");
+	}
+
+	return status;
+}
+
+/*
+ * The accepted memory bitmap only works at unit_size granularity.  Take
+ * unaligned start/end addresses and either:
+ *  1. Accepts the memory immediately and in its entirety
+ *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
+ *
+ * The function will never reach the bitmap_set() with zero bits to set.
+ */
+void process_unaccepted_memory(u64 start, u64 end)
+{
+	u64 unit_size = unaccepted_table->unit_size;
+	u64 unit_mask = unaccepted_table->unit_size - 1;
+	u64 bitmap_size = unaccepted_table->size;
+
+	/*
+	 * Ensure that at least one bit will be set in the bitmap by
+	 * immediately accepting all regions under 2*unit_size.  This is
+	 * imprecise and may immediately accept some areas that could
+	 * have been represented in the bitmap.  But, results in simpler
+	 * code below
+	 *
+	 * Consider case like this (assuming unit_size == 2MB):
+	 *
+	 * | 4k | 2044k |    2048k   |
+	 * ^ 0x0        ^ 2MB        ^ 4MB
+	 *
+	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
+	 * represented in the bitmap. The 2MB->4MB region can be represented in
+	 * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
+	 * immediately accepted in its entirety.
+	 */
+	if (end - start < 2 * unit_size) {
+		arch_accept_memory(start, end);
+		return;
+	}
+
+	/*
+	 * No matter how the start and end are aligned, at least one unaccepted
+	 * unit_size area will remain to be marked in the bitmap.
+	 */
+
+	/* Immediately accept a <unit_size piece at the start: */
+	if (start & unit_mask) {
+		arch_accept_memory(start, round_up(start, unit_size));
+		start = round_up(start, unit_size);
+	}
+
+	/* Immediately accept a <unit_size piece at the end: */
+	if (end & unit_mask) {
+		arch_accept_memory(round_down(end, unit_size), end);
+		end = round_down(end, unit_size);
+	}
+
+	/*
+	 * Accept part of the range that before phys_base and cannot be recorded
+	 * into the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base) {
+		arch_accept_memory(start,
+				   min(unaccepted_table->phys_base, end));
+		start = unaccepted_table->phys_base;
+	}
+
+	/* Nothing to record */
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Accept memory that doesn't fit into bitmap */
+	if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = bitmap_size * unit_size * BITS_PER_BYTE +
+			     unaccepted_table->phys_base;
+		phys_end = end + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		end = bitmap_size * unit_size * BITS_PER_BYTE;
+	}
+
+	/*
+	 * 'start' and 'end' are now both unit_size-aligned.
+	 * Record the range as being unaccepted:
+	 */
+	bitmap_set(unaccepted_table->bitmap,
+		   start / unit_size, (end - start) / unit_size);
+}
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long range_start, range_end;
+	unsigned long bitmap_size;
+	u64 unit_size;
+
+	if (!unaccepted_table)
+		return;
+
+	unit_size = unaccepted_table->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base)
+		start = unaccepted_table->phys_base;
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+	bitmap_size = DIV_ROUND_UP(end, unit_size);
+
+	for_each_set_bitrange_from(range_start, range_end,
+				   unaccepted_table->bitmap, bitmap_size) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = range_start * unit_size + unaccepted_table->phys_base;
+		phys_end = range_end * unit_size + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted_table->bitmap,
+			     range_start, range_end - range_start);
+	}
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cd77a7a..3cc7faa 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -613,6 +613,16 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			e820_type = E820_TYPE_PMEM;
 			break;
 
+		case EFI_UNACCEPTED_MEMORY:
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
+				efi_warn_once(
+"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+				continue;
+			}
+			e820_type = E820_TYPE_RAM;
+			process_unaccepted_memory(d->phys_addr,
+						  d->phys_addr + PAGE_SIZE * d->num_pages);
+			break;
 		default:
 			continue;
 		}
@@ -697,6 +707,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
+		status = allocate_unaccepted_bitmap(nr_desc, map);
+
 	efi_bs_call(free_pool, map);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 571d1a6..8ffe451 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -108,7 +108,8 @@ typedef	struct {
 #define EFI_MEMORY_MAPPED_IO_PORT_SPACE	12
 #define EFI_PAL_CODE			13
 #define EFI_PERSISTENT_MEMORY		14
-#define EFI_MAX_MEMORY_TYPE		15
+#define EFI_UNACCEPTED_MEMORY		15
+#define EFI_MAX_MEMORY_TYPE		16
 
 /* Attribute values: */
 #define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
@@ -417,6 +418,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -534,6 +536,14 @@ struct efi_boot_memmap {
 	efi_memory_desc_t	map[];
 };
 
+struct efi_unaccepted_memory {
+	u32 version;
+	u32 unit_size;
+	u64 phys_base;
+	u64 size;
+	unsigned long bitmap[];
+};
+
 /*
  * Architecture independent structure for describing a memory map for the
  * benefit of efi_memmap_init_early(), and for passing context between
