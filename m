Return-Path: <linux-tip-commits+bounces-3578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FDA3F8D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E7D427C36
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD021506E;
	Fri, 21 Feb 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NXwZTEcD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7rkwJCb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E213212F92;
	Fri, 21 Feb 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151760; cv=none; b=eDL83iQmVAv8P2t7Dtlc8mFIO01xFfxzS8200Ql7Dx7NNu8V+B8k8K7JG07XG2dF7xHK0LLJpn0sgQtdi9JwTPQ/o/7yO/9pN/o2v17fE7MLvEMFkps2NWbSawlOLkF3Fd/GxX7ekQ2jFB/pperouFHdyBcueW27yTjCV5s0zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151760; c=relaxed/simple;
	bh=FN3wVqvn0IQIfAHqCy6oCl28/dgMayTPYSnGR3Pm1zU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O7adedG1jA088SMpS4TC8deyXO2PYQ77IMH6QrZfwSjIhheHfnTbvs8dRwk4al8VFBUhSE/H8eOY1gP+5twCTvPUPS7y/UvTJX4TrhgSXw723PNwblsOyieKxMsCjAvHbh5OHk38x2iKO5Q2/WrdUqb0FO5CvXqFPcTJZzZVizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NXwZTEcD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7rkwJCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:29:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740151755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jexkDkSD6taFW6G0zMw6c6AWCbmEYs2xm3WdGEeghC8=;
	b=NXwZTEcDwxhzRPRJtSC4GUYprWBblgMb7ACxY4sAcr0s9ZsktjcGRZHqpHfot6D+Pja+WR
	d5hRBS5fYgWo1jETsLghrpxzDIJoZ4scID9mE2OUT0st9B6igquinHKqe8sNj0B5jJscOg
	Cd5nJoxPRMkjq+dLL/MB5AgB+62CEBTmkHuRBSZl/4p0nci7jukJ6B7+6fTTbKOEd0ggLF
	z6SJXpoi2228QNQ28dl49g25C4t+NbduwwgXLc5GUY6NnAwvyp5DRNF4ykMiIhXoUga4On
	be8Xtej+vw3LIf8xI2pbl2p4sH5fqjcbuRIPwADYgtnkCKkrKv4CN1LQHOT9ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740151755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jexkDkSD6taFW6G0zMw6c6AWCbmEYs2xm3WdGEeghC8=;
	b=F7rkwJCbqirXbd/qCs82tct5N+ZmWyZdnFjUzYt19GHC3p15GQn+fVU/tp+u/JFnQhf4Rj
	U6kuPvSO1GCDDeDQ==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/e820: Drop obsolete E820_TYPE_RESERVED_KERN and
 related code
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214090651.3331663-5-rppt@kernel.org>
References: <20250214090651.3331663-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015175242.10177.981417045108157021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     efe659ac014647eb048d62475e55cce42d8951d7
Gitweb:        https://git.kernel.org/tip/efe659ac014647eb048d62475e55cce42d8951d7
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Fri, 14 Feb 2025 11:06:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:05:00 +01:00

x86/e820: Drop obsolete E820_TYPE_RESERVED_KERN and related code

E820_TYPE_RESERVED_KERN is a relict from the ancient history that was used
to early reserve setup_data, see:

  28bb22379513 ("x86: move reserve_setup_data to setup.c")

Nowadays setup_data is anyway reserved in memblock and there is no point in
carrying E820_TYPE_RESERVED_KERN that behaves exactly like E820_TYPE_RAM
but only complicates the code.

A bonus for removing E820_TYPE_RESERVED_KERN is a small but measurable
speedup of 20 microseconds in init_mem_mappings() on a VM with 32GB or RAM.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20250214090651.3331663-5-rppt@kernel.org
---
 arch/x86/include/asm/e820/api.h   |  1 +-
 arch/x86/include/asm/e820/types.h |  9 +----
 arch/x86/kernel/e820.c            | 65 +-----------------------------
 arch/x86/kernel/setup.c           |  1 +-
 arch/x86/kernel/tboot.c           |  3 +-
 arch/x86/mm/init_64.c             |  8 +----
 6 files changed, 4 insertions(+), 83 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f..c83645d 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -29,7 +29,6 @@ extern unsigned long e820__end_of_low_ram_pfn(void);
 extern u64  e820__memblock_alloc_reserved(u64 size, u64 align);
 extern void e820__memblock_setup(void);
 
-extern void e820__reserve_setup_data(void);
 extern void e820__finish_early_params(void);
 extern void e820__reserve_resources(void);
 extern void e820__reserve_resources_late(void);
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d..80c4a72 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -35,15 +35,6 @@ enum e820_type {
 	 * marking it with the IORES_DESC_SOFT_RESERVED designation.
 	 */
 	E820_TYPE_SOFT_RESERVED	= 0xefffffff,
-
-	/*
-	 * Reserved RAM used by the kernel itself if
-	 * CONFIG_INTEL_TXT=y is enabled, memory of this type
-	 * will be included in the S3 integrity calculation
-	 * and so should not include any memory that the BIOS
-	 * might alter over the S3 transition:
-	 */
-	E820_TYPE_RESERVED_KERN	= 128,
 };
 
 /*
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 8d8bd03..9fb67ab 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -187,8 +187,7 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 static void __init e820_print_type(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		/* Fall through: */
-	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
+	case E820_TYPE_RAM:		pr_cont("usable");			break;
 	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
 	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
 	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
@@ -764,7 +763,7 @@ void __init e820__register_nosave_regions(unsigned long limit_pfn)
 
 		pfn = PFN_DOWN(entry->addr + entry->size);
 
-		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
+		if (entry->type != E820_TYPE_RAM)
 			register_nosave_region(PFN_UP(entry->addr), pfn);
 
 		if (pfn >= limit_pfn)
@@ -991,60 +990,6 @@ static int __init parse_memmap_opt(char *str)
 early_param("memmap", parse_memmap_opt);
 
 /*
- * Reserve all entries from the bootloader's extensible data nodes list,
- * because if present we are going to use it later on to fetch e820
- * entries from it:
- */
-void __init e820__reserve_setup_data(void)
-{
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 pa_data, pa_next;
-	u32 len;
-
-	pa_data = boot_params.hdr.setup_data;
-	if (!pa_data)
-		return;
-
-	while (pa_data) {
-		data = early_memremap(pa_data, sizeof(*data));
-		if (!data) {
-			pr_warn("e820: failed to memremap setup_data entry\n");
-			return;
-		}
-
-		len = sizeof(*data);
-		pa_next = data->next;
-
-		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
-		if (data->type == SETUP_INDIRECT) {
-			len += data->len;
-			early_memunmap(data, sizeof(*data));
-			data = early_memremap(pa_data, len);
-			if (!data) {
-				pr_warn("e820: failed to memremap indirect setup_data\n");
-				return;
-			}
-
-			indirect = (struct setup_indirect *)data->data;
-
-			if (indirect->type != SETUP_INDIRECT)
-				e820__range_update(indirect->addr, indirect->len,
-						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-		}
-
-		pa_data = pa_next;
-		early_memunmap(data, len);
-	}
-
-	e820__update_table(e820_table);
-
-	pr_info("extended physical RAM map:\n");
-	e820__print_table("reserve setup_data");
-}
-
-/*
  * Called after parse_early_param(), after early parameters (such as mem=)
  * have been processed, in which case we already have an E820 table filled in
  * via the parameter callback function(s), but it's not sorted and printed yet:
@@ -1063,7 +1008,6 @@ void __init e820__finish_early_params(void)
 static const char *__init e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return "System RAM";
 	case E820_TYPE_ACPI:		return "ACPI Tables";
 	case E820_TYPE_NVS:		return "ACPI Non-volatile Storage";
@@ -1079,7 +1023,6 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
 static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
 {
 	switch (entry->type) {
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return IORESOURCE_SYSTEM_RAM;
 	case E820_TYPE_ACPI:		/* Fall-through: */
 	case E820_TYPE_NVS:		/* Fall-through: */
@@ -1101,7 +1044,6 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
 	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_SOFT_RESERVED:	return IORES_DESC_SOFT_RESERVED;
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
@@ -1124,7 +1066,6 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
 		return false;
-	case E820_TYPE_RESERVED_KERN:
 	case E820_TYPE_RAM:
 	case E820_TYPE_ACPI:
 	case E820_TYPE_NVS:
@@ -1353,7 +1294,7 @@ void __init e820__memblock_setup(void)
 		if (entry->type == E820_TYPE_SOFT_RESERVED)
 			memblock_reserve(entry->addr, entry->size);
 
-		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
+		if (entry->type != E820_TYPE_RAM)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6fb9a85..46d92d0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -895,7 +895,6 @@ void __init setup_arch(char **cmdline_p)
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
 
-	e820__reserve_setup_data();
 	e820__finish_early_params();
 
 	if (efi_enabled(EFI_BOOT))
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c1bcb6..46b8f1f 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -200,8 +200,7 @@ static int tboot_setup_sleep(void)
 	tboot->num_mac_regions = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
-		if ((e820_table->entries[i].type != E820_TYPE_RAM)
-		 && (e820_table->entries[i].type != E820_TYPE_RESERVED_KERN))
+		if (e820_table->entries[i].type != E820_TYPE_RAM)
 			continue;
 
 		add_mac_region(e820_table->entries[i].addr, e820_table->entries[i].size);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6..519aa53 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -469,8 +469,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
-			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pte_init(pte, __pte(0), init);
 			continue;
@@ -526,8 +524,6 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
-			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
@@ -615,8 +611,6 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
-			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_pud_init(pud, __pud(0), init);
 			continue;
@@ -704,8 +698,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN) &&
-			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_ACPI))
 				set_p4d_init(p4d, __p4d(0), init);
 			continue;

