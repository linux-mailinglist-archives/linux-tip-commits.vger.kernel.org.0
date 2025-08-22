Return-Path: <linux-tip-commits+bounces-6319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B805EB321A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 19:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C3FA02D39
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869D27EFE9;
	Fri, 22 Aug 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlSGzuSx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MKF8C19"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387C1F4174;
	Fri, 22 Aug 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884607; cv=none; b=WxCEFr7pqFs+nL5P2gbE1tKh5h/ozdwopXdR8avJ2p5G641O/zh4135rf/jTzUacEmFCd/amwtRsZOpwvILXQhchrIFefVIf9P6JdXiIhwWuJwAyt9B7QYCpP775dP1RdMF30or/Hmu8w1Q10SPfOX5IPFT9XivKdPC4SCNVPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884607; c=relaxed/simple;
	bh=oEfasGh41KBh5fYdN6nlrGlV8sW7nRXIke3x3+XapnM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gjAFLWDoIzZHoKhjjRQ1yuoJAg70EsftpcfELvfl+wNuKEoHqSbbTpKYY/thDgFVfe2ReS5fyvyTxTVHXnmK1SzCpl+K0VsChOAdEwRfMGpSSNjtP2aW17HpWQDVM1f+rSOeq+FeZ+Jw+d/57QbFTl3kbhDJknniWAP09cQsU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlSGzuSx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MKF8C19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 17:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755884601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uKiUmkV2XJhzDpHbwftiaFG3YLHKpDS1BDzRvK2c0CI=;
	b=dlSGzuSxGk0DPg1528fQkOACTGP4OKGSGmBcwGOTOxEiSSfIVMzSg1IwzYvX5mf4QaOIOl
	SaGZEJkmCwZIcqvm9ZUHt/5ZPguhJZxci9CY+gTDFFQq9VLh4lqi7EBo4OKEYjJOI9J4df
	7RkNMGn+YGyl0dOvjSlfudvtDViFOSXWYZkL/4kDv/VDefJtSnFOphvyQgJ3TbsBWop4tn
	wKBgSORt9tRhOxE85VxA3llylAedLHebsotBUTaoT3Ro3ZEjAkxuqB+AQNUhQMMUy9dQMu
	D5xTW4B9LlrJIJq8pafG+/G74R4HGyTYYDFggXFaMfAItKuVvRfWLzj9M5XYdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755884601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uKiUmkV2XJhzDpHbwftiaFG3YLHKpDS1BDzRvK2c0CI=;
	b=3MKF8C19Xom+AuXIWBPCaKz2wzV0s9ARqB5x2CS5uthXFhDUekb5f9r4GJyePhYvVbmgpD
	6LRtb60bigOAyQBA==
From: "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Change cpa_flush() to call flush_kernel_range()
 directly
Cc: "Yu-cheng Yu" <yu-cheng.yu@intel.com>, Rik van Riel <riel@surriel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175588460052.1420.3714146338769865045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     86e6815b316ec0ea8c4bb3c16a033219a52b6060
Gitweb:        https://git.kernel.org/tip/86e6815b316ec0ea8c4bb3c16a033219a52=
b6060
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Fri, 06 Jun 2025 13:10:35 -04:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:55:21 -07:00

x86/mm: Change cpa_flush() to call flush_kernel_range() directly

The function cpa_flush() calls __flush_tlb_one_kernel() and
flush_tlb_all().

Replacing that with a call to flush_tlb_kernel_range() allows
cpa_flush() to make use of INVLPGB or RAR without any additional
changes.

Initialize invlpgb_count_max to 1, since flush_tlb_kernel_range()
can now be called before invlpgb_count_max has been initialized
to the value read from CPUID.

[riel: remove now unused __cpa_flush_tlb]

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250606171112.4013261-4-riel%40surriel.com
---
 arch/x86/mm/pat/set_memory.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76..d2d54b8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -399,15 +399,6 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
=20
-static void __cpa_flush_tlb(void *data)
-{
-	struct cpa_data *cpa =3D data;
-	unsigned int i;
-
-	for (i =3D 0; i < cpa->numpages; i++)
-		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
-}
-
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtabl=
es);
=20
 static void cpa_collapse_large_pages(struct cpa_data *cpa)
@@ -444,6 +435,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
=20
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
+	unsigned long start, end;
 	unsigned int i;
=20
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
@@ -453,10 +445,12 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 		goto collapse_large_pages;
 	}
=20
-	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
-		flush_tlb_all();
-	else
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
+	start =3D fix_addr(__cpa_addr(cpa, 0));
+	end =3D   fix_addr(__cpa_addr(cpa, cpa->numpages));
+	if (cpa->force_flush_all)
+		end =3D TLB_FLUSH_ALL;
+
+	flush_tlb_kernel_range(start, end);
=20
 	if (!cache)
 		goto collapse_large_pages;

