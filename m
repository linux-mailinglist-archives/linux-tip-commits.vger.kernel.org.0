Return-Path: <linux-tip-commits+bounces-4382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A8A68AF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD2416BFF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C526037D;
	Wed, 19 Mar 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wo/COuON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYfnB1sL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476125EF99;
	Wed, 19 Mar 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382245; cv=none; b=cEiSrJN48q3ErK+FeZqgtMCVXZ8ghQHXyHS906eQBkvfOsI/tMCX/s9PXDnFpRMJvNmeY/ixqwDdIrbcFuu9Jjg6wG2mHC6AXYdHtRXsKygjkDP9eVZttpjfLbCfp/qOe3kuLUfZnre9T4rl8kIi+LhFVuvds6ynUWX4z5Ag9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382245; c=relaxed/simple;
	bh=0NxGAspOVuPvqMDNHILeuJT/ojPQsxuMAWFyf3QwJhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I2VuBX1RacCFmJwaBMO2SnXUve1rZLPeel+WQ3Uc7Hg9PSPRCr9Yw7taWPfwa/12VPTsXezCpDuyouL00Cv/tz9dnU6pFU/07gwpa8mzD8bQ3ImCuWh99qY4gaKt9UXh5C0uRVccNHG5uXOTd9ueUclPsEnZ8LOtDrrgwJWkxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wo/COuON; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYfnB1sL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYXXT8Shvqd40FhCYljTXJdxygmgB47yPlpSayHjhlg=;
	b=wo/COuONMVde5MW6GDkE0R7bKoeh94yHTqoRjccTiiWbGnTCnYlOcDdPsxo60XMGhHQ2R0
	P5g5mae/tE/SpafwtPfByZr2VD/jl10pLWkDdouVMeNZhgxPGyGvMLdsE3EECnGg6Gn60I
	HlF0ExhrdM/KYFWskPHlO/cr6eFVXY4mZM1eAIPCXXYZSYSk1epd8yWz+nmSudmzMfkWhD
	UTTvGk/VWcf5x/UGISJbgy1Se9xbfwK3mqHwIQ7qJc7U9dpfLEe/ilFZZeranLO8MuTkcJ
	Rjh4+wmXsVhL19DafFBPh64OU7pE1tHORoHE1mkoCUlCJqPvblx7TDREynnLCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYXXT8Shvqd40FhCYljTXJdxygmgB47yPlpSayHjhlg=;
	b=HYfnB1sLM6kvKzckIIyPOzHGWDeZtWpnUEtRXO5h2X7vhodto1iEaqWD+s3fzUEKCapy1J
	oGZkpzjNEBiI+AAw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Kai Huang <kai.huang@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
References: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224117.14745.16672314465337187877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f666c92090a41ac5524dade63ff96b3adcf8c2ab
Gitweb:        https://git.kernel.org/tip/f666c92090a41ac5524dade63ff96b3adcf8c2ab
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 16 Oct 2024 14:14:55 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm/ident_map: Fix theoretical virtual address overflow to zero

The current calculation of the 'next' virtual address in the
page table initialization functions in arch/x86/mm/ident_map.c
doesn't protect against wrapping to zero.

This is a theoretical issue that cannot happen currently,
the problematic case is possible only if the user sets a
high enough x86_mapping_info::offset value - which no
current code in the upstream kernel does.

( The wrapping to zero only occurs if the top PGD entry is accessed.
  There are no such users upstream. Only hibernate_64.c uses
  x86_mapping_info::offset, and it operates on the direct mapping
  range, which is not the top PGD entry. )

Should such an overflow happen, it can result in page table
corruption and a hang.

To future-proof this code, replace the manual 'next' calculation
with p?d_addr_end() which handles wrapping correctly.

[ Backporter's note: there's no need to backport this patch. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241016111458.846228-2-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/ident_map.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 5ab7bd2..bd5d101 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -101,9 +101,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pmd_t *pmd;
 		bool use_gbpage;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
+		next = pud_addr_end(addr, end);
 
 		/* if this is already a gbpage, this portion is already mapped */
 		if (pud_leaf(*pud))
@@ -154,10 +152,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		p4d_t *p4d = p4d_page + p4d_index(addr);
 		pud_t *pud;
 
-		next = (addr & P4D_MASK) + P4D_SIZE;
-		if (next > end)
-			next = end;
-
+		next = p4d_addr_end(addr, end);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
 			result = ident_pud_init(info, pud, addr, next);
@@ -199,10 +194,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
 
-		next = (addr & PGDIR_MASK) + PGDIR_SIZE;
-		if (next > end)
-			next = end;
-
+		next = pgd_addr_end(addr, end);
 		if (pgd_present(*pgd)) {
 			p4d = p4d_offset(pgd, 0);
 			result = ident_p4d_init(info, p4d, addr, next);

