Return-Path: <linux-tip-commits+bounces-7676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09FCBB81A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57CA0300CCFA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882A2D73A7;
	Sun, 14 Dec 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lh3sJ9v/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhcEFqDA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7642D3EF5;
	Sun, 14 Dec 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701455; cv=none; b=dL2zZha8eEPWCrH07Ec1TCeZpVaJh5dHVb25fgxFLXyD7Fbpr5S5yBu+WXNGiqUP9YZ0+nu4Frcrq/4Z15e3qf2i78gMdF6AGbqzxWRMXzDou3g9eZDCPSC9spLb1m/7AlGuc5yJRWOFc0foXq2c4oWv0mEJQN+ILK2GbpsY1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701455; c=relaxed/simple;
	bh=FTkrc6fAkCCy4aVlxcARa5VJq0dWbFKqixTkGSFFADg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jghjCnu3FSOhx1eJPfCkob5EkhJBDjW6/vHYa3ejyIA+XdWkCQ2bL4IAUbgZfrPvqCLcYfShCbZB7KKOqg1lGFQ1B49+XmmN1vpbHMID7KMCoROWXF0L0o8BdUmQnU26327fsjnkaH+3HmY++Sc31G72I46ICMO0NzabQ8P+nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lh3sJ9v/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fhcEFqDA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/SY+2LjM1361l2HoQ8pa2F8vVGZVRv1Zmj2CrAR+Zc=;
	b=Lh3sJ9v/bIKTpHWXsesdqXs5fRSqdAo6O0T95jQtunJr6tzD5Hrmdy/7pDOAzpe00uinXm
	a51isCCw/B2SjifKt/DFo3sumNsZO8YzeZl0O6ceu/1ZUKHPEj/G8+WL1gYlhNoID+Bk5u
	qlNrDoAceZDj9UIkq4hrK78AhCUAc0iDG2A4ISCBQMHcDDhS4kVez8EsyXcse67nng1lf1
	yZvAqu9E+zdN/60hGv9+fd+CDdszgJG/bbmBiuHh8rJX9kVHnBNZUCByunncsO1CCRL0oi
	w8VWlXUC67aDtE3QVEBqKndYKY3rCExo0ZfSzQLG5R1xn4fnt1v0iHmICigfew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/SY+2LjM1361l2HoQ8pa2F8vVGZVRv1Zmj2CrAR+Zc=;
	b=fhcEFqDAvXOombMNhYGZag98vLrUyIYSKPQ7HmpJFIc7clbWGJc6bkyDQmtO1Pk/tst6rc
	dPdO7gU3f2aKsKAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Standardize e820 table index variable
 types under 'u32'
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-19-mingo@kernel.org>
References: <20250515120549.2820541-19-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145055.498.8713639927474068315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     58dcd82d2e2543e0aba4915613debec3c309849b
Gitweb:        https://git.kernel.org/tip/58dcd82d2e2543e0aba4915613debec3c30=
9849b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:40 +01:00

x86/boot/e820: Standardize e820 table index variable types under 'u32'

So we have 'idx' types of 'int' and 'unsigned int', and sometimes
we assign 'u32' fields such as e820_table::nr_entries to these 'int'
values.

While there's no real risk of overflow with these tables, make it
all cleaner by standardizing on a single type: u32.

This also happens to shrink the code a bit:

   text      data      bss        dec        hex    filename
   7745     44072        0      51817       ca69    e820.o.before
   7613     44072        0      51685       c9e5    e820.o.after

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
Link: https://patch.msgid.link/20250515120549.2820541-19-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index a7dabf8..39f29bf 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -76,7 +76,7 @@ EXPORT_SYMBOL(pci_mem_start);
 static bool _e820__mapped_any(struct e820_table *table,
 			      u64 start, u64 end, enum e820_type type)
 {
-	int idx;
+	u32 idx;
=20
 	for (idx =3D 0; idx < table->nr_entries; idx++) {
 		struct e820_entry *entry =3D &table->entries[idx];
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(e820__mapped_any);
 static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
 					     enum e820_type type)
 {
-	int idx;
+	u32 idx;
=20
 	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
 		struct e820_entry *entry =3D &e820_table->entries[idx];
@@ -164,7 +164,7 @@ int e820__get_entry_type(u64 start, u64 end)
  */
 static void __init __e820__range_add(struct e820_table *table, u64 start, u6=
4 size, enum e820_type type)
 {
-	int idx =3D table->nr_entries;
+	u32 idx =3D table->nr_entries;
=20
 	if (idx >=3D ARRAY_SIZE(table->entries)) {
 		pr_err("too many E820 table entries; ignoring [mem %#010llx-%#010llx]\n",
@@ -202,7 +202,7 @@ static void __init e820_print_type(enum e820_type type)
 static void __init e820__print_table(const char *who)
 {
 	u64 range_end_prev =3D 0;
-	int idx;
+	u32 idx;
=20
 	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
 		struct e820_entry *entry =3D e820_table->entries + idx;
@@ -482,7 +482,7 @@ static u64 __init
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e82=
0_type old_type, enum e820_type new_type)
 {
 	u64 end;
-	unsigned int idx;
+	u32 idx;
 	u64 real_updated_size =3D 0;
=20
 	BUG_ON(old_type =3D=3D new_type);
@@ -560,7 +560,7 @@ u64 __init e820__range_update_table(struct e820_table *t,=
 u64 start, u64 size,
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, =
bool check_type)
 {
-	int idx;
+	u32 idx;
 	u64 end;
 	u64 real_removed_size =3D 0;
=20
@@ -772,7 +772,7 @@ void __init e820__memory_setup_extended(u64 phys_addr, u3=
2 data_len)
  */
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
-	int idx;
+	u32 idx;
 	u64 last_addr =3D 0;
=20
 	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
@@ -797,7 +797,7 @@ void __init e820__register_nosave_regions(unsigned long l=
imit_pfn)
  */
 static int __init e820__register_nvs_regions(void)
 {
-	int idx;
+	u32 idx;
=20
 	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
 		struct e820_entry *entry =3D &e820_table->entries[idx];
@@ -848,7 +848,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 al=
ign)
  */
 static unsigned long __init e820__end_ram_pfn(unsigned long limit_pfn)
 {
-	int idx;
+	u32 idx;
 	unsigned long last_pfn =3D 0;
 	unsigned long max_arch_pfn =3D MAX_ARCH_PFN;
=20
@@ -1103,7 +1103,7 @@ static bool __init e820_device_region(enum e820_type ty=
pe, struct resource *res)
  */
 void __init e820__reserve_resources(void)
 {
-	int idx;
+	u32 idx;
 	struct resource *res;
 	u64 end;
=20
@@ -1168,7 +1168,7 @@ static unsigned long __init ram_alignment(resource_size=
_t pos)
=20
 void __init e820__reserve_resources_late(void)
 {
-	int idx;
+	u32 idx;
 	struct resource *res;
=20
 	/*
@@ -1272,7 +1272,7 @@ void __init e820__memory_setup(void)
=20
 void __init e820__memblock_setup(void)
 {
-	int idx;
+	u32 idx;
 	u64 end;
=20
 #ifdef CONFIG_MEMORY_HOTPLUG

