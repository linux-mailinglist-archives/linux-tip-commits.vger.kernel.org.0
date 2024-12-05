Return-Path: <linux-tip-commits+bounces-2976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06F9E556F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8148F18831E5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3203921882D;
	Thu,  5 Dec 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gv7jtrTJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ethZW9zV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5D218597;
	Thu,  5 Dec 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401694; cv=none; b=I2It9UlXe39zybShKnV4KLthank4IhqpqT4ulzrIyeZU6+BEqiuFFeUEw5fv6LryXBXswJh/PMGZ9ISjLyNpc3dytZINpTJ/wNewRcRs8pJF35llliCp6PToGdeSaN+aQ1pqw1ADMdFd85gtj4hvJBqsP55OVlwa1FluQO3IaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401694; c=relaxed/simple;
	bh=sLzru2pVdodM4w+/LxLNs710/62IGVRqbwWzukP9XwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B6uDmXkloBhIB6DDCWjuRFiSGW3ILrsjxR+H8MWwQu3edwAZHO/VfGxmH0CcI3b2epK5TnA/qB7mN16oRe9Ejcb3wDHNiz1YOsaK1kJbIaiW6gpk7bByuBwjE87zFxhOSnt6D3v6lSXm+ik6C2Lq/XLeHb0xITUiVjkXe1i34I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gv7jtrTJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ethZW9zV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvFVvWEeh7YxSzayaR+TuV2qDpZt0upSCecdM3J72lY=;
	b=Gv7jtrTJM2LAT025Bdrj0TVXBys6p8Y9b4l2sJUYsb9Q3Niy6jUxNtQRPEwWXtoBgIl6gd
	lr6a1nQl0vU9a8EH4NqpXvns7DX01++DYJrjIQuA+1a78z9Qxdp8T2Yf12Dz11yHNFITF2
	mLOXz2lA8JL2rVQjlfzUCDh+w8G0zCcRGCviagMIwdFusM3SFpdlINPlyFzfuOCDwNBcm5
	tOMpYhRJNB58vXOZMpjbTWkbtD8nBYd53WOoSdLThTohf4jQ8SP69tcdocqXdTXpuPa+Ry
	nFx5EoUhjkaGIKoYTCKBCUAfnLj+a0S/G3YR3XjZiD4pYzK6aGM4ZXRh6+eVhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvFVvWEeh7YxSzayaR+TuV2qDpZt0upSCecdM3J72lY=;
	b=ethZW9zVei8b0WD/NZ21ef05ORvqj7A+COfeuyyxTMuTkOIkpQoxwVeE5kK63uW61T5rt6
	srlB7JUVwmENflDw==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating
 userspace page tables
Cc: Dave Hansen <dave.hansen@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Ingo Molnar <mingo@kernel.org>, stable@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <412c90a4df7aef077141d9f68d19cbe5602d6c6d.camel@infradead.org>
References: <412c90a4df7aef077141d9f68d19cbe5602d6c6d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340168546.412.3607698464296519657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d0ceea662d459726487030237689835fcc0483e5
Gitweb:        https://git.kernel.org/tip/d0ceea662d459726487030237689835fcc0483e5
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 04 Dec 2024 11:27:14 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:04:00 +01:00

x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables

The set_p4d() and set_pgd() functions (in 4-level or 5-level page table setups
respectively) assume that the root page table is actually a 8KiB allocation,
with the userspace root immediately after the kernel root page table (so that
the former can enforce NX on on all the subordinate page tables, which are
actually shared).

However, users of the kernel_ident_mapping_init() code do not give it an 8KiB
allocation for its PGD. Both swsusp_arch_resume() and acpi_mp_setup_reset()
allocate only a single 4KiB page. The kexec code on x86_64 currently gets
away with it purely by chance, because it allocates 8KiB for its "control
code page" and then actually uses the first half for the PGD, then copies the
actual trampoline code into the second half only after the identmap code has
finished scribbling over it.

Fix this by defining a _PAGE_NOPTISHADOW bit (which can use the same bit as
_PAGE_SAVED_DIRTY since one is only for the PGD/P4D root and the other is
exclusively for leaf PTEs.). This instructs __pti_set_user_pgtbl() not to
write to the userspace 'shadow' PGD.

Strictly, the _PAGE_NOPTISHADOW bit doesn't need to be written out to the
actual page tables; since __pti_set_user_pgtbl() returns the value to be
written to the kernel page table, it could be filtered out. But there seems
to be no benefit to actually doing so.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/412c90a4df7aef077141d9f68d19cbe5602d6c6d.camel@infradead.org
Cc: stable@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/pgtable_types.h | 8 ++++++--
 arch/x86/mm/ident_map.c              | 6 +++---
 arch/x86/mm/pti.c                    | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 6f82e75..4b80453 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -36,10 +36,12 @@
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD) */
 #else
 /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD) */
 #endif
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
@@ -139,6 +141,8 @@
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
+#define _PAGE_NOPTISHADOW (_AT(pteval_t, 1) << _PAGE_BIT_NOPTISHADOW)
+
 /*
  * Set of bits not changed in pte_modify.  The pte's
  * protection key is treated like _PAGE_RW, for
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 437e96f..5ab7bd2 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -174,7 +174,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		if (result)
 			return result;
 
-		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
+		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 	}
 
 	return 0;
@@ -218,14 +218,14 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		if (result)
 			return result;
 		if (pgtable_l5_enabled()) {
-			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		} else {
 			/*
 			 * With p4d folded, pgd is equal to p4d.
 			 * The pgd entry has to point to the pud page table in this case.
 			 */
 			pud_t *pud = pud_offset(p4d, 0);
-			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		}
 	}
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f..5f0d579 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -132,7 +132,7 @@ pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 	 * Top-level entries added to init_mm's usermode pgd after boot
 	 * will not be automatically propagated to other mms.
 	 */
-	if (!pgdp_maps_userspace(pgdp))
+	if (!pgdp_maps_userspace(pgdp) || (pgd.pgd & _PAGE_NOPTISHADOW))
 		return pgd;
 
 	/*

