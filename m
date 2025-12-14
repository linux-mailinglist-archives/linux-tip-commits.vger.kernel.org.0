Return-Path: <linux-tip-commits+bounces-7679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD546CBB856
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820CC305130E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6F2D9782;
	Sun, 14 Dec 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkNYQpj3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dOCMfF1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA872C3770;
	Sun, 14 Dec 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701459; cv=none; b=EpxJ88MCwlaz0O8YIYZ1hM/DFe9GepsuuQT4Jc14fC33dau+3A5IUMuLwoYOFff9EmS6N31ScrnCO+tawZePnvYz0mGPmIaFT/5/aXlSOzs9Xn/EM08RM03XSQm5QWofuI9ebZiB+nVNpwgvHrTuyUOoXLXyfNr7wjUbkeF1Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701459; c=relaxed/simple;
	bh=OEfkXToOK0DyBDu0mJW9rQ8IhOzHI0/qqrazpw4uPE4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FBAOIsrKzEfGXjpPcRCKrHbE2JiQjct1DFkx7d/yoCPe0C/XYPf3XLTaSavNCxjjXQzLVWt0PkF03FwMOE3Sx+eFED5L50/loz3pfsx7e7eT+zF4QU/tbq5N65ChxJj7QYh1lUBfgnJiG8lT8pl8HS+xDwAYhR/WYAbPWzXWcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkNYQpj3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dOCMfF1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByNVNp/jkQjFfQRoLin1C0m1NCMrwKUPSWMZn7xRhdc=;
	b=VkNYQpj39ZP9IANAoG/Fis9T+AhEfbgyzsEAZUpdwsr9LIVbjlX4COML+yJEzpiz77WJc9
	UNH8/SbSACsETma4GSFM07cS4rMmXzMubNYRAaG9DpEV8uKWmHjB2HKYKOHK4EWLbV+r1i
	0f6ZGrzaeYTtqMLoR+jEbwlkEELaLk9AWv/H0FAy0XlM+FI7EG9xLXAKMRLAa0KygGleEK
	CFHCCJx+vBmEoXiqeHK+ThBlk07lyNdldblZ8/Iyu4HLZ8ofzP6JRQPg0Q6ctoHICJRiqz
	/yRDbdvrYwF2EwFMs6yqTp9+bCHDBDY487fBtuIpQ9yBuX0ncP3CN1F8Enww/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByNVNp/jkQjFfQRoLin1C0m1NCMrwKUPSWMZn7xRhdc=;
	b=9dOCMfF1eHP4vw+clISmhJGa1Ycvmz54uVbHWXojWhI1MDj9AJ0zTvT9OCSinB0QyA2ATq
	2D6NsOZEEqXFAoAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Standardize e820 table index variable
 names under 'idx'
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-18-mingo@kernel.org>
References: <20250515120549.2820541-18-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145180.498.16352745883692546188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dc043d6463bf5bb732fe4e29ca5db21ba114871e
Gitweb:        https://git.kernel.org/tip/dc043d6463bf5bb732fe4e29ca5db21ba11=
4871e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:40 +01:00

x86/boot/e820: Standardize e820 table index variable names under 'idx'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-18-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 114 ++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index d8fd7c1..a7dabf8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -76,10 +76,10 @@ EXPORT_SYMBOL(pci_mem_start);
 static bool _e820__mapped_any(struct e820_table *table,
 			      u64 start, u64 end, enum e820_type type)
 {
-	int i;
+	int idx;
=20
-	for (i =3D 0; i < table->nr_entries; i++) {
-		struct e820_entry *entry =3D &table->entries[i];
+	for (idx =3D 0; idx < table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &table->entries[idx];
=20
 		if (type && entry->type !=3D type)
 			continue;
@@ -111,10 +111,10 @@ EXPORT_SYMBOL_GPL(e820__mapped_any);
 static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
 					     enum e820_type type)
 {
-	int i;
+	int idx;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
=20
 		if (type && entry->type !=3D type)
 			continue;
@@ -202,10 +202,10 @@ static void __init e820_print_type(enum e820_type type)
 static void __init e820__print_table(const char *who)
 {
 	u64 range_end_prev =3D 0;
-	int i;
+	int idx;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D e820_table->entries + i;
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D e820_table->entries + idx;
 		u64 range_start, range_end;
=20
 		range_start =3D entry->addr;
@@ -345,7 +345,7 @@ int __init e820__update_table(struct e820_table *table)
 	enum e820_type current_type, last_type;
 	u64 last_addr;
 	u32 new_nr_entries, overlap_entries;
-	u32 i, chg_idx, chg_nr;
+	u32 idx, chg_idx, chg_nr;
=20
 	/* If there's only one memory region, don't bother: */
 	if (table->nr_entries < 2)
@@ -354,26 +354,26 @@ int __init e820__update_table(struct e820_table *table)
 	BUG_ON(table->nr_entries > max_nr_entries);
=20
 	/* Bail out if we find any unreasonable addresses in the map: */
-	for (i =3D 0; i < table->nr_entries; i++) {
-		if (entries[i].addr + entries[i].size < entries[i].addr)
+	for (idx =3D 0; idx < table->nr_entries; idx++) {
+		if (entries[idx].addr + entries[idx].size < entries[idx].addr)
 			return -1;
 	}
=20
 	/* Create pointers for initial change-point information (for sorting): */
-	for (i =3D 0; i < 2 * table->nr_entries; i++)
-		change_point[i] =3D &change_point_list[i];
+	for (idx =3D 0; idx < 2 * table->nr_entries; idx++)
+		change_point[idx] =3D &change_point_list[idx];
=20
 	/*
 	 * Record all known change-points (starting and ending addresses),
 	 * omitting empty memory regions:
 	 */
 	chg_idx =3D 0;
-	for (i =3D 0; i < table->nr_entries; i++)	{
-		if (entries[i].size !=3D 0) {
-			change_point[chg_idx]->addr	=3D entries[i].addr;
-			change_point[chg_idx++]->entry	=3D &entries[i];
-			change_point[chg_idx]->addr	=3D entries[i].addr + entries[i].size;
-			change_point[chg_idx++]->entry	=3D &entries[i];
+	for (idx =3D 0; idx < table->nr_entries; idx++)	{
+		if (entries[idx].size !=3D 0) {
+			change_point[chg_idx]->addr	=3D entries[idx].addr;
+			change_point[chg_idx++]->entry	=3D &entries[idx];
+			change_point[chg_idx]->addr	=3D entries[idx].addr + entries[idx].size;
+			change_point[chg_idx++]->entry	=3D &entries[idx];
 		}
 	}
 	chg_nr =3D chg_idx;
@@ -395,9 +395,9 @@ int __init e820__update_table(struct e820_table *table)
 			overlap_list[overlap_entries++] =3D change_point[chg_idx]->entry;
 		} else {
 			/* Remove entry from list (order independent, so swap with last): */
-			for (i =3D 0; i < overlap_entries; i++) {
-				if (overlap_list[i] =3D=3D change_point[chg_idx]->entry)
-					overlap_list[i] =3D overlap_list[overlap_entries-1];
+			for (idx =3D 0; idx < overlap_entries; idx++) {
+				if (overlap_list[idx] =3D=3D change_point[chg_idx]->entry)
+					overlap_list[idx] =3D overlap_list[overlap_entries-1];
 			}
 			overlap_entries--;
 		}
@@ -407,9 +407,9 @@ int __init e820__update_table(struct e820_table *table)
 		 * 1=3Dusable, 2,3,4,4+=3Dunusable)
 		 */
 		current_type =3D 0;
-		for (i =3D 0; i < overlap_entries; i++) {
-			if (overlap_list[i]->type > current_type)
-				current_type =3D overlap_list[i]->type;
+		for (idx =3D 0; idx < overlap_entries; idx++) {
+			if (overlap_list[idx]->type > current_type)
+				current_type =3D overlap_list[idx]->type;
 		}
=20
 		/* Continue building up new map based on this information: */
@@ -482,7 +482,7 @@ static u64 __init
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e82=
0_type old_type, enum e820_type new_type)
 {
 	u64 end;
-	unsigned int i;
+	unsigned int idx;
 	u64 real_updated_size =3D 0;
=20
 	BUG_ON(old_type =3D=3D new_type);
@@ -497,8 +497,8 @@ __e820__range_update(struct e820_table *table, u64 start,=
 u64 size, enum e820_ty
 	e820_print_type(new_type);
 	pr_cont("\n");
=20
-	for (i =3D 0; i < table->nr_entries; i++) {
-		struct e820_entry *entry =3D &table->entries[i];
+	for (idx =3D 0; idx < table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &table->entries[idx];
 		u64 final_start, final_end;
 		u64 entry_end;
=20
@@ -560,7 +560,7 @@ u64 __init e820__range_update_table(struct e820_table *t,=
 u64 start, u64 size,
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, =
bool check_type)
 {
-	int i;
+	int idx;
 	u64 end;
 	u64 real_removed_size =3D 0;
=20
@@ -573,8 +573,8 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
 		e820_print_type(old_type);
 	pr_cont("\n");
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
 		u64 final_start, final_end;
 		u64 entry_end;
=20
@@ -641,12 +641,12 @@ static void __init e820__update_table_kexec(void)
 static int __init e820_search_gap(unsigned long *gapstart, unsigned long *ga=
psize)
 {
 	u64 last =3D MAX_GAP_END;
-	int i =3D e820_table->nr_entries;
+	int idx =3D e820_table->nr_entries;
 	int found =3D 0;
=20
-	while (--i >=3D 0) {
-		u64 start =3D e820_table->entries[i].addr;
-		u64 end =3D start + e820_table->entries[i].size;
+	while (--idx >=3D 0) {
+		u64 start =3D e820_table->entries[idx].addr;
+		u64 end =3D start + e820_table->entries[idx].size;
=20
 		/*
 		 * Since "last" is at most 4GB, we know we'll
@@ -772,11 +772,11 @@ void __init e820__memory_setup_extended(u64 phys_addr, =
u32 data_len)
  */
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
-	int i;
+	int idx;
 	u64 last_addr =3D 0;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
=20
 		if (entry->type !=3D E820_TYPE_RAM)
 			continue;
@@ -797,10 +797,10 @@ void __init e820__register_nosave_regions(unsigned long=
 limit_pfn)
  */
 static int __init e820__register_nvs_regions(void)
 {
-	int i;
+	int idx;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
=20
 		if (entry->type =3D=3D E820_TYPE_NVS)
 			acpi_nvs_register(entry->addr, entry->size);
@@ -848,12 +848,12 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 =
align)
  */
 static unsigned long __init e820__end_ram_pfn(unsigned long limit_pfn)
 {
-	int i;
+	int idx;
 	unsigned long last_pfn =3D 0;
 	unsigned long max_arch_pfn =3D MAX_ARCH_PFN;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
 		unsigned long start_pfn;
 		unsigned long end_pfn;
=20
@@ -1103,7 +1103,7 @@ static bool __init e820_device_region(enum e820_type ty=
pe, struct resource *res)
  */
 void __init e820__reserve_resources(void)
 {
-	int i;
+	int idx;
 	struct resource *res;
 	u64 end;
=20
@@ -1111,8 +1111,8 @@ void __init e820__reserve_resources(void)
 			     SMP_CACHE_BYTES);
 	e820_res =3D res;
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D e820_table->entries + i;
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D e820_table->entries + idx;
=20
 		end =3D entry->addr + entry->size - 1;
 		if (end !=3D (resource_size_t)end) {
@@ -1138,8 +1138,8 @@ void __init e820__reserve_resources(void)
 	}
=20
 	/* Expose the kexec e820 table to sysfs: */
-	for (i =3D 0; i < e820_table_kexec->nr_entries; i++) {
-		struct e820_entry *entry =3D e820_table_kexec->entries + i;
+	for (idx =3D 0; idx < e820_table_kexec->nr_entries; idx++) {
+		struct e820_entry *entry =3D e820_table_kexec->entries + idx;
=20
 		firmware_map_add_early(entry->addr, entry->addr + entry->size, e820_type_t=
o_string(entry));
 	}
@@ -1168,7 +1168,7 @@ static unsigned long __init ram_alignment(resource_size=
_t pos)
=20
 void __init e820__reserve_resources_late(void)
 {
-	int i;
+	int idx;
 	struct resource *res;
=20
 	/*
@@ -1176,7 +1176,7 @@ void __init e820__reserve_resources_late(void)
 	 * these can be claimed by device drivers later on:
 	 */
 	res =3D e820_res;
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
 		if (!res->parent && res->end)
 			insert_resource_expand_to_fit(&iomem_resource, res);
 		res++;
@@ -1194,8 +1194,8 @@ void __init e820__reserve_resources_late(void)
 	 * doesn't properly list 'stolen RAM' as a system region
 	 * in the E820 map.
 	 */
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
 		u64 start, end;
=20
 		if (entry->type !=3D E820_TYPE_RAM)
@@ -1272,7 +1272,7 @@ void __init e820__memory_setup(void)
=20
 void __init e820__memblock_setup(void)
 {
-	int i;
+	int idx;
 	u64 end;
=20
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -1316,8 +1316,8 @@ void __init e820__memblock_setup(void)
 	 */
 	memblock_allow_resize();
=20
-	for (i =3D 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry =3D &e820_table->entries[i];
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		struct e820_entry *entry =3D &e820_table->entries[idx];
=20
 		end =3D entry->addr + entry->size;
 		if (end !=3D (resource_size_t)end)

