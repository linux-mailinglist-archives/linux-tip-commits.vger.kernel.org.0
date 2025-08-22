Return-Path: <linux-tip-commits+bounces-6317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7202B31DDF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD88B45098
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3051DE2A0;
	Fri, 22 Aug 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fnw2lP6r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAow2dWp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA771CB518;
	Fri, 22 Aug 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874866; cv=none; b=MDYoUlszPRP/d67Ry54CapKiCbba/s3HUBEd9vWyVvBXCz4Fi1ShFIeaOPdSnUdsZJ0U4QRYRAk4vYqIR6n3/cWyBu8csa6aD2qcNjaX++2O4AmirTiLGyWN49QWUxrqFuV/TYTqly70ue2ZQrWsU7evdZ4eqezQNTghnV1LLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874866; c=relaxed/simple;
	bh=k1mCD4aoF34nNMPH+rTXlzZPHqohx0wOi3GsOX/qIhc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Fvr8Umo8vd98878cpeqcvzYzIzDodwX1bhcuLB6uJhGmMiZJOHgeYbP0qVOOi6QJuIOpIj2FfzvKVu1bYdkdmGGgJhEN0/3bd7gPhh2BYXxn/R/Nu7ibKL052/meBEd56lGAlMowVW2v+QQerd74OUNWrrgQbfEhsqJZRxqz4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fnw2lP6r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAow2dWp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 15:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755874861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=73snTadtlVEFtLHKEQcb1nRxmIfD/xGwlcWBPAYiAoQ=;
	b=Fnw2lP6rFKZy08iSilhLNoEtcY0JhSO513+S05k4j0jODSw0Bx+PnMdh0k74u5XUE+RApn
	uvmv04zIuFmLNhseh9WqErAuPiINAr7X4dZW50mahzrWivQZOszzc8MC/npI5ZjDk1oAa/
	2Q7zK8hUcwwllGeddtoJCsa3HrNSgZ2K6xV3Vo5PanIZkhl/pthc9ptSryqGy9q1pn6kLG
	Uf73oZKUfFqv+CNIHjheFX/zA+TxN2SEK+aT1k/aESMDvN9ecpyfA7gaow2CQEVrvpzv2z
	fNreBuMhO7h3a8AYWpCyGfuWwy9NAX6mxyimDCHAYhy4vqAHYPqQyklwMOdnIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755874861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=73snTadtlVEFtLHKEQcb1nRxmIfD/xGwlcWBPAYiAoQ=;
	b=nAow2dWpST9d1tUHYPgIw5bBYZTvMpoISA7i9/apzF7A8kiFRSmo2h1/NSniBxwJQ9brzm
	WevUUGEIprDKHZAA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Eliminate duplicate code in tdx_clear_page()
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175587486008.1420.155372414308617864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     94272b084a745940e076a170d8193ac3427292e6
Gitweb:        https://git.kernel.org/tip/94272b084a745940e076a170d8193ac3427=
292e6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 19 Aug 2025 18:58:09 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:45:50 -07:00

x86/tdx: Eliminate duplicate code in tdx_clear_page()

tdx_clear_page() and reset_tdx_pages() duplicate the TDX page clearing
logic.  Rename reset_tdx_pages() to tdx_quirk_reset_paddr() and create
tdx_quirk_reset_page() to call tdx_quirk_reset_paddr() and be used in
place of tdx_clear_page().

The new name reflects that, in fact, the clearing is necessary only for
hardware with a certain quirk.  That is dealt with in a subsequent patch
but doing the rename here avoids additional churn.

Note reset_tdx_pages() is slightly different from tdx_clear_page() because,
more appropriately, it uses mb() in place of __mb().  Except when extra
debugging is enabled (kcsan at present), mb() just calls __mb().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Vishal Annapurve <vannapurve@google.com>
Link: https://lore.kernel.org/all/20250819155811.136099-2-adrian.hunter%40int=
el.com
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/kvm/vmx/tdx.c      | 25 +++----------------------
 arch/x86/virt/vmx/tdx/tdx.c | 10 ++++++++--
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 7ddef3a..57b46f0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -131,6 +131,8 @@ int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
=20
+void tdx_quirk_reset_page(struct page *page);
+
 struct tdx_td {
 	/* TD root structure: */
 	struct page *tdr_page;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 66744f5..f457b2e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -281,25 +281,6 @@ static inline void tdx_disassociate_vp(struct kvm_vcpu *=
vcpu)
 	vcpu->cpu =3D -1;
 }
=20
-static void tdx_clear_page(struct page *page)
-{
-	const void *zero_page =3D (const void *) page_to_virt(ZERO_PAGE(0));
-	void *dest =3D page_to_virt(page);
-	unsigned long i;
-
-	/*
-	 * The page could have been poisoned.  MOVDIR64B also clears
-	 * the poison bit so the kernel can safely use the page again.
-	 */
-	for (i =3D 0; i < PAGE_SIZE; i +=3D 64)
-		movdir64b(dest + i, zero_page);
-	/*
-	 * MOVDIR64B store uses WC buffer.  Prevent following memory reads
-	 * from seeing potentially poisoned cache.
-	 */
-	__mb();
-}
-
 static void tdx_no_vcpus_enter_start(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
@@ -345,7 +326,7 @@ static int tdx_reclaim_page(struct page *page)
=20
 	r =3D __tdx_reclaim_page(page);
 	if (!r)
-		tdx_clear_page(page);
+		tdx_quirk_reset_page(page);
 	return r;
 }
=20
@@ -593,7 +574,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err);
 		return;
 	}
-	tdx_clear_page(kvm_tdx->td.tdr_page);
+	tdx_quirk_reset_page(kvm_tdx->td.tdr_page);
=20
 	__free_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page =3D NULL;
@@ -1714,7 +1695,7 @@ static int tdx_sept_drop_private_spte(struct kvm *kvm, =
gfn_t gfn,
 		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err);
 		return -EIO;
 	}
-	tdx_clear_page(page);
+	tdx_quirk_reset_page(page);
 	tdx_unpin(kvm, page);
 	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c7a9a08..fc8d8e4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -637,7 +637,7 @@ err:
  * clear these pages.  Note this function doesn't flush cache of
  * these TDX private pages.  The caller should make sure of that.
  */
-static void reset_tdx_pages(unsigned long base, unsigned long size)
+static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 {
 	const void *zero_page =3D (const void *)page_address(ZERO_PAGE(0));
 	unsigned long phys, end;
@@ -654,9 +654,15 @@ static void reset_tdx_pages(unsigned long base, unsigned=
 long size)
 	mb();
 }
=20
+void tdx_quirk_reset_page(struct page *page)
+{
+	tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
+}
+EXPORT_SYMBOL_GPL(tdx_quirk_reset_page);
+
 static void tdmr_reset_pamt(struct tdmr_info *tdmr)
 {
-	tdmr_do_pamt_func(tdmr, reset_tdx_pages);
+	tdmr_do_pamt_func(tdmr, tdx_quirk_reset_paddr);
 }
=20
 static void tdmrs_reset_pamt_all(struct tdmr_info_list *tdmr_list)

