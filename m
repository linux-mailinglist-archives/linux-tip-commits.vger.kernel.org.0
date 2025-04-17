Return-Path: <linux-tip-commits+bounces-5053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036BA9259E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E51B61FC2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE325EFA3;
	Thu, 17 Apr 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SwQ+xkFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtZpe7zv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43779258CD6;
	Thu, 17 Apr 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913012; cv=none; b=ZxZ7UuR40bpCPYotju1V0N86ea1GO7SmR5LJ92fjto9qnlc4lTobV54AzICld1xkeetJ/W6DEXMazSRD9Kg4ee+tVTXYNbcdfxuBdBsgCppVlDJK+TJxH4oUvv93Je+y/CYLV5tsOCOSWPzJs6rbsyfWcFR/pKFwjIDnFt+HY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913012; c=relaxed/simple;
	bh=+t9zJbQ0JltkHvqRHbXezRt65OGPMfBum+XNcSTfRuQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=psSHvAawi1gMFRWcYJQP42qhw32aOYlaRIBjAJ1KTiOZF1r6fWs/ijMNRvVM9V/IUJ2Q3Ws41mhbK91y4C3gXqshIghgpN8LU1I3v7Um3596/36midwpywMC02TtRgsecGP6/8ltFmEoTgX1RfqeRgpCL8h4deUkJaL9eWRDns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SwQ+xkFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtZpe7zv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=w4MOnZjH94ClsFkVXhMSrzdThD0j+bxaNzheCiKyzZk=;
	b=SwQ+xkFFir+el/qpBeBg9Qg1g8hlvI8uNeRuY4jT3gpn56s0ePk4whuqOHeVstaMy/sMjV
	olG0p3vvcJH64w/ixNdda83iM4VAS+Zrwb5SOJyRRCe6JRHnEOfPGE9TPsTtG7AGnzxiKy
	JLXe35tkA+FV2Xx3U5OJBV2soVdKAoIFkzCw9Saz+Hl0ULNbUIM/L73/ZakgpLMJWc4Wvs
	MvHVqReCk3MDk4OGcOFHlrefEjJe5cqcwoqwveB0BhLfqfRXzJzVrAw0WLcwlyk1CQ+Ic0
	4N8uxCOKiW2z45ZiPD5aYyHUpbcIIBQWiloliPoxqoGNAMsH8hp1gUVFh2tLFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=w4MOnZjH94ClsFkVXhMSrzdThD0j+bxaNzheCiKyzZk=;
	b=MtZpe7zv5iG9Fiu2rDNP+IaOC8taLG8yy1yu7fjtm4mJ/v+J2BV6zOnU/Do7fb0vC853nY
	OeRTxedYlnkvpXBQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Always allocate a whole page for PAE PGDs
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300872.31282.11754944062858812203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     780f97e309302fdee05b31c91a4dc81ded4c3702
Gitweb:        https://git.kernel.org/tip/780f97e309302fdee05b31c91a4dc81ded4c3702
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:34 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:24 -07:00

x86/mm: Always allocate a whole page for PAE PGDs

A hardware PAE PGD is only 32 bytes. A PGD is PAGE_SIZE in the other
paging modes. But for reasons*, the kernel _sometimes_ allocates a
whole page even though it only ever uses 32 bytes.

Make PAE less weird. Just allocate a page like the other paging modes.
This was already being done for PTI (and Xen in the past) and nobody
screamed that loudly about it so it can't be that bad.

 * The original reason for PAGE_SIZE allocations for the PAE PGDs was
   Xen's need to detect page table writes. But 32-bit PTI forced it too
   for reasons I'm unclear about.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173234.D34F0C3E%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pgtable.c | 62 ++----------------------------------------
 1 file changed, 4 insertions(+), 58 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a05fcdd..ea01b55 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -318,68 +318,15 @@ static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
 {
 }
 #endif
-/*
- * Xen paravirt assumes pgd table should be in one page. 64 bit kernel also
- * assumes that pgd should be in one page.
- *
- * But kernel with PAE paging that is not running as a Xen domain
- * only needs to allocate 32 bytes for pgd instead of one page.
- */
-#ifdef CONFIG_X86_PAE
-
-#include <linux/slab.h>
-
-#define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
-#define PGD_ALIGN	32
-
-static struct kmem_cache *pgd_cache;
-
-void __init pgtable_cache_init(void)
-{
-	/*
-	 * When PAE kernel is running as a Xen domain, it does not use
-	 * shared kernel pmd. And this requires a whole page for pgd.
-	 */
-	if (!SHARED_KERNEL_PMD)
-		return;
-
-	/*
-	 * when PAE kernel is not running as a Xen domain, it uses
-	 * shared kernel pmd. Shared kernel pmd does not require a whole
-	 * page for pgd. We are able to just allocate a 32-byte for pgd.
-	 * During boot time, we create a 32-byte slab for pgd table allocation.
-	 */
-	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
-				      SLAB_PANIC, NULL);
-}
 
 static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 {
 	/*
-	 * If no SHARED_KERNEL_PMD, PAE kernel is running as a Xen domain.
-	 * We allocate one page for pgd.
-	 */
-	if (!SHARED_KERNEL_PMD)
-		return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
-
-	/*
-	 * Now PAE kernel is not running as a Xen domain. We can allocate
-	 * a 32-byte slab for pgd to save memory space.
+	 * PTI and Xen need a whole page for the PAE PGD
+	 * even though the hardware only needs 32 bytes.
+	 *
+	 * For simplicity, allocate a page for all users.
 	 */
-	return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
-}
-
-static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	if (!SHARED_KERNEL_PMD)
-		__pgd_free(mm, pgd);
-	else
-		kmem_cache_free(pgd_cache, pgd);
-}
-#else
-
-static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
-{
 	return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
 }
 
@@ -387,7 +334,6 @@ static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	__pgd_free(mm, pgd);
 }
-#endif /* CONFIG_X86_PAE */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {

