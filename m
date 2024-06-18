Return-Path: <linux-tip-commits+bounces-1449-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6890D491
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3264A1F22BDF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596A16CD1C;
	Tue, 18 Jun 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwFaVEpr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hOlbLPK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4C16B395;
	Tue, 18 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719311; cv=none; b=hewkcWvyeGeTwb5NQlPFWkBIs6B7j77Q/UYjck4LRv0gHsr6LzTsXs+WY1OU/nweBb0HOb0U+ar7ddsSOICvWJ1+FnetgjTL+5hb6fh+A523SrMCgX1ZlqvqTGT1TxNHm3wTzqUOEMGJcN1MsuLanOCq0csVfUHr93B7+ffmq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719311; c=relaxed/simple;
	bh=drl5ZcpFSV63TrjKinWvrP5dtzaqDl4AFmldhMYg5C8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MoYaFNpXCfiyRrYdjwz6g9iO32t/Kda458MpxGRvjdhX0OIKad8nkY/I0I/loeldJRj+pTllhmmAE+gVgjyCAnPQFpYDcT+A1QmVYsWg4AO41tU2qKsaI4f91D13Y5PMVp5ezI2xmG5kM8WjIkvWroOPgFS2MyFHo6t/GN8oCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwFaVEpr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hOlbLPK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRSpy01+qXtx+YAB4MBOI1ifH6gyaeRAiqmiTZPAE7o=;
	b=JwFaVEprW34FnzyBt1+XRS4NXfjWy2Ie93ZTD0oIluTWtxUGDcLL1AQIb+XOWCFhQX8W68
	8hhPem5+6DUGOSLeba9GRKdwytByU3Vy2T7rOY0hUsOddcGM3nK1PiNgJPheuQRGEXmBNk
	vGUHeJjbvx5hLQx0oTYc3wQ+fDbVBWS6QinUBJE4rld0axF21f8GdxBwxlC3oR69ZoxQlt
	9LbzDVAk7Pos7WGSL/e4Fq4vrCrxZpRogLAPEDkSXEDinaq8dnbk0kV9a2ttRiEFoqZh6g
	9Nqn0bF8VedoZQSpzsdrG6itQ87w2TpumlEcp4PVlw+Pt/vLN4PW2e4AdGkM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRSpy01+qXtx+YAB4MBOI1ifH6gyaeRAiqmiTZPAE7o=;
	b=3hOlbLPKOgBHktEklqpDwuSWtxeXCxsYVWkHmSAxD41AKXlGfe5tAYHj2GOoXoOUiuWLED
	uZfUomy1dhwig8Aw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/mm: Do not zap page table entries mapping
 unaccepted memory table during kdump
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-14-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-14-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930008.10875.6773960991759167388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     5574b368873d4f24e2ae8fab3a1105ede252e542
Gitweb:        https://git.kernel.org/tip/5574b368873d4f24e2ae8fab3a1105ede252e542
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:58 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:12 +02:00

x86/mm: Do not zap page table entries mapping unaccepted memory table during kdump

During crashkernel boot only pre-allocated crash memory is presented as
E820_TYPE_RAM.

This can cause page table entries mapping unaccepted memory table to be zapped
during phys_pte_init(), phys_pmd_init(), phys_pud_init() and phys_p4d_init() as
SNP/TDX guest use E820_TYPE_ACPI to store the unaccepted memory table and pass
it between the kernels on kexec/kdump.

E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might be
required by kernel to function properly.

The problem was discovered during debugging kdump for SNP guest. The unaccepted
memory table stored with E820_TYPE_ACPI and passed between the kernels on kdump
was getting zapped as the PMD entry mapping this is above the E820_TYPE_RAM
range for the reserved crashkernel memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240614095904.1345461-14-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/init_64.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7e17785..28002cc 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -469,7 +469,9 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pte_init(pte, __pte(0), init);
 			continue;
 		}
@@ -524,7 +526,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
@@ -611,7 +615,9 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pud_init(pud, __pud(0), init);
 			continue;
 		}
@@ -698,7 +704,9 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_p4d_init(p4d, __p4d(0), init);
 			continue;
 		}

