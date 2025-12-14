Return-Path: <linux-tip-commits+bounces-7670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73CCBB835
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 914CC3021776
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8572D23A3;
	Sun, 14 Dec 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3Y3AFTP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAwGbLhc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D62C0F93;
	Sun, 14 Dec 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701449; cv=none; b=t4SD+FVWVXGuTPGWga0bF1nC1D+mZBgFQpAHjig5N2UGMzqx3IKw8ZsMTf2YM1RAimjGFLODEc185v4szMOxfVAzZBiAK8TSPIgze8MvsIEAQs1mq0RI08yihnHkGFCeN5vrMFrlnDKNJAbzH9uiMt5SUVVjEB8zAk7aRNvAL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701449; c=relaxed/simple;
	bh=jWCgJAsVmuTtTvg4DOX1NbspIjk9DzXFSqKY+6yEw7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CnwHtybwAZQ8r/+/PmsVbi/vAZ/BJFvBg29MT5lV9Hfcla7L9PGs47K29+bqq2P7UVl7MvWY4E2vFJ0eeSOIa8UGdVDmNz7WG0lc2C1PTycOPHjMdW09yRFSXBmNzvZksDoBq0T7VqnZwIC8GJFhkHhzEx05MvdDFU5BuzYp2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y3Y3AFTP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAwGbLhc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW8Ohkle8BaHc6qaxEU+JZ/3f7dz9h4oZ/Vq6jlRDzs=;
	b=Y3Y3AFTPS7esPyw5V8P9zi+rzrZtIeli4ZGkYurt1RZgIG6EeuCTNNZaF7dJIkjebcUSGY
	haIT5o2tre3mLfdjBpDsAN2Q2pwfmCGkGgKTc7U132GHOBoBqKZvXmSmMA+qYelQZKhfMV
	097IGP752KexWk9CNXzm4Xohip4F1GLymyqI0FQKZxPcSzSGMocpudZjKpVozahg+dmcFa
	il9DmywbLbPPdCU185AstgTojv42MBiV1uRima4izXEiMukQRQtnnF5Z0rhlG/GbAIpuWH
	tSx6a6TScaO6NJSc71M+N4OK/O9pn32Dc//b9p/Oa1jc6l4Umtvsy/ykAtoUvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW8Ohkle8BaHc6qaxEU+JZ/3f7dz9h4oZ/Vq6jlRDzs=;
	b=rAwGbLhcxfvPci1hNsLRXhjIU9T68GZr+/K3PUhWhPhwHkV1hMGQhmx17y6zoVDpy8iahe
	K8Na4x/chCobhJDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Standardize __init/__initdata tag placement
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-25-mingo@kernel.org>
References: <20250515120549.2820541-25-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144370.498.7084624150488644556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     af0cf1646d9de812465c3fa134c8c5bcf85de118
Gitweb:        https://git.kernel.org/tip/af0cf1646d9de812465c3fa134c8c5bcf85=
de118
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:41 +01:00

x86/boot/e820: Standardize __init/__initdata tag placement

So the e820.c file has a hodgepodge of __init and __initdata tag
placements:

    static int __init e820_search_gap(unsigned long *max_gap_start, unsigned =
long *max_gap_size)
    __init void e820__setup_pci_gap(void)
    __init void e820__reallocate_tables(void)
    void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
    void __init e820__register_nosave_regions(unsigned long limit_pfn)
    static int __init e820__register_nvs_regions(void)
    u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)

Standardize on the style used by e820__setup_pci_gap() and place
them before the storage class.

In addition to the consistency, as a bonus this makes the grep output
rather clean looking:

    __init void e820__range_remove(u64 start, u64 size, enum e820_type filter=
_type)
    __init void e820__update_table_print(void)
    __init static void e820__update_table_kexec(void)
    __init static int e820_search_gap(unsigned long *max_gap_start, unsigned =
long *max_gap_size)
    __init void e820__setup_pci_gap(void)
    __init void e820__reallocate_tables(void)
    __init void e820__memory_setup_extended(u64 phys_addr, u32 data_len)
    __init void e820__register_nosave_regions(unsigned long limit_pfn)
    __init static int e820__register_nvs_regions(void)

... and if one learns to just ignore the leftmost '__init' noise then
the rest of the line looks just like a regular C function definition.

With the 'mixed' tag placement style the __init tag breaks up the function's
prototype for no good reason.

Do the same for __initdata.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-25-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 92 ++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4758099..4696080 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -55,9 +55,9 @@
  * re-propagated. So its main role is a temporary bootstrap storage of firmw=
are
  * specific memory layout data during early bootup.
  */
-static struct e820_table e820_table_init		__initdata;
-static struct e820_table e820_table_kexec_init		__initdata;
-static struct e820_table e820_table_firmware_init	__initdata;
+__initdata static struct e820_table e820_table_init;
+__initdata static struct e820_table e820_table_kexec_init;
+__initdata static struct e820_table e820_table_firmware_init;
=20
 __refdata struct e820_table *e820_table			=3D &e820_table_init;
 __refdata struct e820_table *e820_table_kexec		=3D &e820_table_kexec_init;
@@ -144,7 +144,7 @@ static struct e820_entry *__e820__mapped_all(u64 start, u=
64 end,
 /*
  * This function checks if the entire range <start,end> is mapped with type.
  */
-bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
+__init bool e820__mapped_all(u64 start, u64 end, enum e820_type type)
 {
 	return __e820__mapped_all(start, end, type);
 }
@@ -162,7 +162,7 @@ int e820__get_entry_type(u64 start, u64 end)
 /*
  * Add a memory region to the kernel E820 map.
  */
-static void __init __e820__range_add(struct e820_table *table, u64 start, u6=
4 size, enum e820_type type)
+__init static void __e820__range_add(struct e820_table *table, u64 start, u6=
4 size, enum e820_type type)
 {
 	u32 idx =3D table->nr_entries;
 	struct e820_entry *entry_new;
@@ -182,12 +182,12 @@ static void __init __e820__range_add(struct e820_table =
*table, u64 start, u64 si
 	table->nr_entries++;
 }
=20
-void __init e820__range_add(u64 start, u64 size, enum e820_type type)
+__init void e820__range_add(u64 start, u64 size, enum e820_type type)
 {
 	__e820__range_add(e820_table, start, size, type);
 }
=20
-static void __init e820_print_type(enum e820_type type)
+__init static void e820_print_type(enum e820_type type)
 {
 	switch (type) {
 	case E820_TYPE_RAM:		pr_cont(" System RAM");				break;
@@ -202,7 +202,7 @@ static void __init e820_print_type(enum e820_type type)
 	}
 }
=20
-static void __init e820__print_table(const char *who)
+__init static void e820__print_table(const char *who)
 {
 	u64 range_end_prev =3D 0;
 	u32 idx;
@@ -301,12 +301,12 @@ struct change_member {
 	u64			addr;
 };
=20
-static struct change_member	change_point_list[2*E820_MAX_ENTRIES]	__initdata;
-static struct change_member	*change_point[2*E820_MAX_ENTRIES]	__initdata;
-static struct e820_entry	*overlap_list[E820_MAX_ENTRIES]		__initdata;
-static struct e820_entry	new_entries[E820_MAX_ENTRIES]		__initdata;
+__initdata static struct change_member	change_point_list[2*E820_MAX_ENTRIES];
+__initdata static struct change_member	*change_point[2*E820_MAX_ENTRIES];
+__initdata static struct e820_entry	*overlap_list[E820_MAX_ENTRIES];
+__initdata static struct e820_entry	new_entries[E820_MAX_ENTRIES];
=20
-static int __init cpcompare(const void *a, const void *b)
+__init static int cpcompare(const void *a, const void *b)
 {
 	struct change_member * const *app =3D a, * const *bpp =3D b;
 	const struct change_member *ap =3D *app, *bp =3D *bpp;
@@ -341,7 +341,7 @@ static bool e820_type_mergeable(enum e820_type type)
 	return true;
 }
=20
-int __init e820__update_table(struct e820_table *table)
+__init int e820__update_table(struct e820_table *table)
 {
 	struct e820_entry *entries =3D table->entries;
 	u32 max_nr_entries =3D ARRAY_SIZE(table->entries);
@@ -441,7 +441,7 @@ int __init e820__update_table(struct e820_table *table)
 	return 0;
 }
=20
-static int __init __append_e820_table(struct boot_e820_entry *entries, u32 n=
r_entries)
+__init static int __append_e820_table(struct boot_e820_entry *entries, u32 n=
r_entries)
 {
 	struct boot_e820_entry *entry =3D entries;
=20
@@ -472,7 +472,7 @@ static int __init __append_e820_table(struct boot_e820_en=
try *entries, u32 nr_en
  * will have given us a memory map that we can use to properly
  * set up memory.  If we aren't, we'll fake a memory map.
  */
-static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_=
entries)
+__init static int append_e820_table(struct boot_e820_entry *entries, u32 nr_=
entries)
 {
 	/* Only one memory region (or negative)? Ignore it */
 	if (nr_entries < 2)
@@ -481,7 +481,7 @@ static int __init append_e820_table(struct boot_e820_entr=
y *entries, u32 nr_entr
 	return __append_e820_table(entries, nr_entries);
 }
=20
-static u64 __init
+__init static u64
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e82=
0_type old_type, enum e820_type new_type)
 {
 	u64 end;
@@ -549,19 +549,19 @@ __e820__range_update(struct e820_table *table, u64 star=
t, u64 size, enum e820_ty
 	return real_updated_size;
 }
=20
-u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, =
enum e820_type new_type)
+__init u64 e820__range_update(u64 start, u64 size, enum e820_type old_type, =
enum e820_type new_type)
 {
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
=20
-u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 siz=
e,
+__init u64 e820__range_update_table(struct e820_table *t, u64 start, u64 siz=
e,
 				    enum e820_type old_type, enum e820_type new_type)
 {
 	return __e820__range_update(t, start, size, old_type, new_type);
 }
=20
 /* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, =
bool check_type)
+__init u64 e820__range_remove(u64 start, u64 size, enum e820_type old_type, =
bool check_type)
 {
 	u32 idx;
 	u64 end;
@@ -622,7 +622,7 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
 	return real_removed_size;
 }
=20
-void __init e820__update_table_print(void)
+__init void e820__update_table_print(void)
 {
 	if (e820__update_table(e820_table))
 		return;
@@ -631,7 +631,7 @@ void __init e820__update_table_print(void)
 	e820__print_table("modified");
 }
=20
-static void __init e820__update_table_kexec(void)
+__init static void e820__update_table_kexec(void)
 {
 	e820__update_table(e820_table_kexec);
 }
@@ -641,7 +641,7 @@ static void __init e820__update_table_kexec(void)
 /*
  * Search for a gap in the E820 memory space from 0 to MAX_GAP_END (4GB).
  */
-static int __init e820_search_gap(unsigned long *max_gap_start, unsigned lon=
g *max_gap_size)
+__init static int e820_search_gap(unsigned long *max_gap_start, unsigned lon=
g *max_gap_size)
 {
 	u64 last =3D MAX_GAP_END;
 	int idx =3D e820_table->nr_entries;
@@ -744,7 +744,7 @@ __init void e820__reallocate_tables(void)
  * the remaining (if any) entries are passed via the SETUP_E820_EXT node of
  * struct setup_data, which is parsed here.
  */
-void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
+__init void e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 {
 	int entries;
 	struct boot_e820_entry *extmap;
@@ -773,7 +773,7 @@ void __init e820__memory_setup_extended(u64 phys_addr, u3=
2 data_len)
  * This function requires the E820 map to be sorted and without any
  * overlapping entries.
  */
-void __init e820__register_nosave_regions(unsigned long limit_pfn)
+__init void e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	u32 idx;
 	u64 last_addr =3D 0;
@@ -798,7 +798,7 @@ void __init e820__register_nosave_regions(unsigned long l=
imit_pfn)
  * Register ACPI NVS memory regions, so that we can save/restore them during
  * hibernation and the subsequent resume:
  */
-static int __init e820__register_nvs_regions(void)
+__init static int e820__register_nvs_regions(void)
 {
 	u32 idx;
=20
@@ -822,7 +822,7 @@ core_initcall(e820__register_nvs_regions);
  * This allows kexec to fake a new mptable, as if it came from the real
  * system.
  */
-u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
+__init u64 e820__memblock_alloc_reserved(u64 size, u64 align)
 {
 	u64 addr;
=20
@@ -849,7 +849,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 al=
ign)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820__end_ram_pfn(unsigned long limit_pfn)
+__init static unsigned long e820__end_ram_pfn(unsigned long limit_pfn)
 {
 	u32 idx;
 	unsigned long last_pfn =3D 0;
@@ -885,20 +885,20 @@ static unsigned long __init e820__end_ram_pfn(unsigned =
long limit_pfn)
 	return last_pfn;
 }
=20
-unsigned long __init e820__end_of_ram_pfn(void)
+__init unsigned long e820__end_of_ram_pfn(void)
 {
 	return e820__end_ram_pfn(MAX_ARCH_PFN);
 }
=20
-unsigned long __init e820__end_of_low_ram_pfn(void)
+__init unsigned long e820__end_of_low_ram_pfn(void)
 {
 	return e820__end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
=20
-static int userdef __initdata;
+__initdata static int userdef;
=20
 /* The "mem=3Dnopentium" boot option disables 4MB page tables on 32-bit kern=
els: */
-static int __init parse_memopt(char *p)
+__init static int parse_memopt(char *p)
 {
 	u64 mem_size;
=20
@@ -932,7 +932,7 @@ static int __init parse_memopt(char *p)
 }
 early_param("mem", parse_memopt);
=20
-static int __init parse_memmap_one(char *p)
+__init static int parse_memmap_one(char *p)
 {
 	char *oldp;
 	u64 start_at, mem_size;
@@ -989,7 +989,7 @@ static int __init parse_memmap_one(char *p)
 	return *p =3D=3D '\0' ? 0 : -EINVAL;
 }
=20
-static int __init parse_memmap_opt(char *str)
+__init static int parse_memmap_opt(char *str)
 {
 	while (str) {
 		char *k =3D strchr(str, ',');
@@ -1010,7 +1010,7 @@ early_param("memmap", parse_memmap_opt);
  * have been processed, in which case we already have an E820 table filled in
  * via the parameter callback function(s), but it's not sorted and printed y=
et:
  */
-void __init e820__finish_early_params(void)
+__init void e820__finish_early_params(void)
 {
 	if (userdef) {
 		if (e820__update_table(e820_table) < 0)
@@ -1021,7 +1021,7 @@ void __init e820__finish_early_params(void)
 	}
 }
=20
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+__init static const char * e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RAM:		return "System RAM";
@@ -1036,7 +1036,7 @@ static const char *__init e820_type_to_string(struct e8=
20_entry *entry)
 	}
 }
=20
-static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
+__init static unsigned long e820_type_to_iomem_type(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RAM:		return IORESOURCE_SYSTEM_RAM;
@@ -1051,7 +1051,7 @@ static unsigned long __init e820_type_to_iomem_type(str=
uct e820_entry *entry)
 	}
 }
=20
-static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
+__init static unsigned long e820_type_to_iores_desc(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_ACPI:		return IORES_DESC_ACPI_TABLES;
@@ -1069,13 +1069,13 @@ static unsigned long __init e820_type_to_iores_desc(s=
truct e820_entry *entry)
 /*
  * We assign one resource entry for each E820 map entry:
  */
-static struct resource __initdata *e820_res;
+__initdata static struct resource *e820_res;
=20
 /*
  * Is this a device address region that should not be marked busy?
  * (Versus system address regions that we register & lock early.)
  */
-static bool __init e820_device_region(enum e820_type type, struct resource *=
res)
+__init static bool e820_device_region(enum e820_type type, struct resource *=
res)
 {
 	/* This is the legacy BIOS/DOS ROM-shadow + MMIO region: */
 	if (res->start < (1ULL<<20))
@@ -1104,7 +1104,7 @@ static bool __init e820_device_region(enum e820_type ty=
pe, struct resource *res)
 /*
  * Mark E820 system regions as busy for the resource manager:
  */
-void __init e820__reserve_resources(void)
+__init void e820__reserve_resources(void)
 {
 	u32 idx;
 	struct resource *res;
@@ -1151,7 +1151,7 @@ void __init e820__reserve_resources(void)
 /*
  * How much should we pad the end of RAM, depending on where it is?
  */
-static unsigned long __init ram_alignment(resource_size_t pos)
+__init static unsigned long ram_alignment(resource_size_t pos)
 {
 	unsigned long mb =3D pos >> 20;
=20
@@ -1169,7 +1169,7 @@ static unsigned long __init ram_alignment(resource_size=
_t pos)
=20
 #define MAX_RESOURCE_SIZE ((resource_size_t)-1)
=20
-void __init e820__reserve_resources_late(void)
+__init void e820__reserve_resources_late(void)
 {
 	u32 idx;
 	struct resource *res;
@@ -1219,7 +1219,7 @@ void __init e820__reserve_resources_late(void)
 /*
  * Pass the firmware (bootloader) E820 map to the kernel and process it:
  */
-char *__init e820__memory_setup_default(void)
+__init char * e820__memory_setup_default(void)
 {
 	char *who =3D "BIOS-e820";
=20
@@ -1257,7 +1257,7 @@ char *__init e820__memory_setup_default(void)
  * E820 map - with an optional platform quirk available for virtual platforms
  * to override this method of boot environment processing:
  */
-void __init e820__memory_setup(void)
+__init void e820__memory_setup(void)
 {
 	char *who;
=20
@@ -1273,7 +1273,7 @@ void __init e820__memory_setup(void)
 	e820__print_table(who);
 }
=20
-void __init e820__memblock_setup(void)
+__init void e820__memblock_setup(void)
 {
 	u32 idx;
 	u64 end;

