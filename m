Return-Path: <linux-tip-commits+bounces-2450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B676499FB64
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414CB1F242BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D21CEAD3;
	Tue, 15 Oct 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRyH+gjM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1NNA1cs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F51B6D15;
	Tue, 15 Oct 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030992; cv=none; b=CYJoCr25pl6HsE0oBSnxxdAn1DQ9q7FQ/5I/18IwKwz3MEkhrt2VQ5ZfQk3zZAHtSHG2njjjUfJ8rsusZ81QIhMy4pDGF+SWCj+rDqdULIRVNZR+GU3Xvn7D1tOpS44XhoZK/Iei2eEm6P2wrYnPzRWuTZJCelxenwiIf/L5/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030992; c=relaxed/simple;
	bh=rIcuuLCIQYmwXGsa7K5nWaFXf1EBD9kalLS+8ELbT2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fqvexlHqKnIFtevRsTHuwSUMlou3Fn/GIuqc9SHA8x/Ri16DBqbBzTBhdVLIgiP8cNgqgiTrtA0GMZkDFWIx+mMfudSujz5EdfjMiR6yCL3zjxKYh3Af6dg4jq59xBjnWrKcJK+2EWqLfSbu1xItxhfVCS5AGTHamILyrw6ArbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRyH+gjM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z1NNA1cs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729030988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scT1QWQ9XVcCt9qJ3DqvZ+aOFee/ZHXTFLd01jCF4QY=;
	b=FRyH+gjMytQw9mzy52oQ3aJ9C8CeR9duPhnYSYCkbmqqyQVpea3qX+jwFfqS6WHhISU2Nl
	L3ENZjhcSLp1619ujQXRU1ioSnn4fqZEKu2/welrFVJtfinagb0ZTRk8J1mlGU9eoKSr/e
	3yFXVJAeUrmAkStCUiPR0JFbntv6NXaKPn8RRlBF3i5S1dSmBt3vUMroxFGxOiyY2OpKVc
	dj0cC8TnQEqFwty/Ux5Z2bPx3ayqq+AU9QDAFHCrrNaK4fnRxtQiNKKrbR+nmlvLnMzkE8
	Z3r2jl33meOAKPI7YfwF5lkB/BUeDp3p0JpPeT5BotMcrTRw+4WLzpN4lnstgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729030988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scT1QWQ9XVcCt9qJ3DqvZ+aOFee/ZHXTFLd01jCF4QY=;
	b=Z1NNA1csf0yV2bwOJGR1Tg/ZFpbeJ8/6mP99+n9TT4a51xmSNRbjhdqlCFDgOwprgZ6Hv8
	twzeu77SPVMe6LDA==
From: "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] s390: Remove remaining _PAGE_* macros
Cc: kernel test robot <lkp@intel.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014151340.1639555-4-vincenzo.frascino@arm.com>
References: <20241014151340.1639555-4-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903098795.1442.8549736586423995168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     6febe0efb2df49105b839d6a3a45ab63d40f315a
Gitweb:        https://git.kernel.org/tip/6febe0efb2df49105b839d6a3a45ab63d40f315a
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 14 Oct 2024 16:13:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:13:04 +02:00

s390: Remove remaining _PAGE_* macros

The introduction of vdso/page.h made the definition of _PAGE_SHIFT,
_PAGE_SIZE, _PAGE_MASK redundant.

Refactor the code to remove the macros.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241014151340.1639555-4-vincenzo.frascino@arm.com
Closes: https://lore.kernel.org/oe-kbuild-all/202410112106.mvc2U2p0-lkp@intel.com/
---
 arch/s390/include/asm/page.h    | 3 ---
 arch/s390/include/asm/pgtable.h | 2 +-
 arch/s390/mm/fault.c            | 2 +-
 arch/s390/mm/gmap.c             | 6 +++---
 arch/s390/mm/pgalloc.c          | 4 ++--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index dbc25dc..b7ba87f 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -13,9 +13,6 @@
 
 #include <vdso/page.h>
 
-#define _PAGE_SHIFT	PAGE_SHIFT
-#define _PAGE_SIZE	PAGE_SIZE
-#define _PAGE_MASK	PAGE_MASK
 #define PAGE_DEFAULT_ACC	_AC(0, UL)
 /* storage-protection override */
 #define PAGE_SPO_ACC		9
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0ffbaf7..8b67036 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline int is_module_addr(void *addr)
 #define _REGION2_INDEX	(0x7ffUL << _REGION2_SHIFT)
 #define _REGION3_INDEX	(0x7ffUL << _REGION3_SHIFT)
 #define _SEGMENT_INDEX	(0x7ffUL << _SEGMENT_SHIFT)
-#define _PAGE_INDEX	(0xffUL  << _PAGE_SHIFT)
+#define _PAGE_INDEX	(0xffUL  << PAGE_SHIFT)
 
 #define _REGION1_SIZE	(1UL << _REGION1_SHIFT)
 #define _REGION2_SIZE	(1UL << _REGION2_SHIFT)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ad8b0d6..12e1026 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -147,7 +147,7 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 			goto out;
 		table = __va(entry & _SEGMENT_ENTRY_ORIGIN);
 	}
-	table += (address & _PAGE_INDEX) >> _PAGE_SHIFT;
+	table += (address & _PAGE_INDEX) >> PAGE_SHIFT;
 	if (get_kernel_nofault(entry, table))
 		goto bad;
 	pr_cont("P:%016lx ", entry);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index eb0b51a..346ec05 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -851,7 +851,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = __va(*table & _SEGMENT_ENTRY_ORIGIN);
-		table += (gaddr & _PAGE_INDEX) >> _PAGE_SHIFT;
+		table += (gaddr & _PAGE_INDEX) >> PAGE_SHIFT;
 	}
 	return table;
 }
@@ -1317,7 +1317,7 @@ static void gmap_unshadow_page(struct gmap *sg, unsigned long raddr)
 	table = gmap_table_walk(sg, raddr, 0); /* get page table pointer */
 	if (!table || *table & _PAGE_INVALID)
 		return;
-	gmap_call_notifier(sg, raddr, raddr + _PAGE_SIZE - 1);
+	gmap_call_notifier(sg, raddr, raddr + PAGE_SIZE - 1);
 	ptep_unshadow_pte(sg->mm, raddr, (pte_t *) table);
 }
 
@@ -1335,7 +1335,7 @@ static void __gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr,
 	int i;
 
 	BUG_ON(!gmap_is_shadow(sg));
-	for (i = 0; i < _PAGE_ENTRIES; i++, raddr += _PAGE_SIZE)
+	for (i = 0; i < _PAGE_ENTRIES; i++, raddr += PAGE_SIZE)
 		pgt[i] = _PAGE_INVALID;
 }
 
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f691e0f..58696a0 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -278,7 +278,7 @@ static inline unsigned long base_##NAME##_addr_end(unsigned long addr,	\
 	return (next - 1) < (end - 1) ? next : end;			\
 }
 
-BASE_ADDR_END_FUNC(page,    _PAGE_SIZE)
+BASE_ADDR_END_FUNC(page,    PAGE_SIZE)
 BASE_ADDR_END_FUNC(segment, _SEGMENT_SIZE)
 BASE_ADDR_END_FUNC(region3, _REGION3_SIZE)
 BASE_ADDR_END_FUNC(region2, _REGION2_SIZE)
@@ -302,7 +302,7 @@ static int base_page_walk(unsigned long *origin, unsigned long addr,
 	if (!alloc)
 		return 0;
 	pte = origin;
-	pte += (addr & _PAGE_INDEX) >> _PAGE_SHIFT;
+	pte += (addr & _PAGE_INDEX) >> PAGE_SHIFT;
 	do {
 		next = base_page_addr_end(addr, end);
 		*pte = base_lra(addr);

