Return-Path: <linux-tip-commits+bounces-6570-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C570AB53BBE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1441889868
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60E2DC765;
	Thu, 11 Sep 2025 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3VTVgYa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tv0QVVLK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141E18E25;
	Thu, 11 Sep 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616219; cv=none; b=ah3/W8a58bdP3IRstSYnr6TQH9f8RdRO7YBRSsWb4ycV3RkY8BBAHJqst5ma9WIWITyf3Qp1eLAOID8AsjEywcdya3mhnhiOS97QwJIAppwCaYDGWXbiS6rcrfqDHLBBpOuhM/hIGU2GieQL008MRdWoWK+wVPbeGvMe3MKrpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616219; c=relaxed/simple;
	bh=BDxQOdVVBMTn9aNH5Xz6oOcBeuuA45KdEfLblmt03T8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MIwQlXkY677OnkGx20K/pjfYuuyOQ1xLpiS+6BCSHRk9ANA7FDWkECQMkYBKfDZ6EZ8NihWtC/EPVaLNZ/aj0mZPrJyyGGue+PQmRcxySA1xEbJ0vqXAfL0RDU5h5js5XMFVu+SIs56DPoGH4eB3nFw4xCPNh1DQoPEzsjbcAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3VTVgYa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tv0QVVLK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 18:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757616215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M+SwbaV+z741t7Z4xx5J9hnTfc7fGZ0sO6dSGu6a1TU=;
	b=J3VTVgYaaaX0reWV8bIGv6hZhPlJsJwnxQB3BgDQbRSkwHsFdcEeKkMXitmIKSa4nwZTo1
	YsUr9N3jtDq5CprJJLZDcti5ZQDwf1ke5RQyivJqqR71MOCny1cHbOUuiBTRWabPzRCqrV
	mbl/dn/DRabBafAMDuDPkSHsIUZxTRacYbG2AkQ6kTiCfPkQb21rd4CD1eo7BYLuegkBOZ
	WWEUc0pH7pGQNsRgtnKB+Q5p7bAUQst6RIxPhLfFB/nyfssy5svem+Dlsh1Q6RL1o54SZj
	O8MnDYlr0smt0OV/s4tIdgri9b6z2tJgPI4wRabFVINyno51FY2SH0CdvON5Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757616215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M+SwbaV+z741t7Z4xx5J9hnTfc7fGZ0sO6dSGu6a1TU=;
	b=Tv0QVVLKn9tECTiU7+XWnxS+eyG9BMzhHSyxOL4tGqg4nQrNoAMZdEnLuwyi0dWMRhulZC
	GwufA5iYAvRMcDAA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] x86/virt/tdx: Use precalculated TDVPR page physical address
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Farrah Chen <farrah.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175761621420.709179.7149926715895756681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     e414b1005891d74bb0c3d27684c58dfbfbd1754b
Gitweb:        https://git.kernel.org/tip/e414b1005891d74bb0c3d27684c58dfbfbd=
1754b
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 09 Sep 2025 19:55:53 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 11 Sep 2025 11:38:28 -07:00

x86/virt/tdx: Use precalculated TDVPR page physical address

All of the x86 KVM guest types (VMX, SEV and TDX) do some special context
tracking when entering guests. This means that the actual guest entry
sequence must be noinstr.

Part of entering a TDX guest is passing a physical address to the TDX
module. Right now, that physical address is stored as a 'struct page'
and converted to a physical address at guest entry. That page=3D>phys
conversion can be complicated, can vary greatly based on kernel
config, and it is definitely _not_ a noinstr path today.

There have been a number of tinkering approaches to try and fix this
up, but they all fall down due to some part of the page=3D>phys
conversion infrastructure not being noinstr friendly.

Precalculate the page=3D>phys conversion and store it in the existing
'tdx_vp' structure.  Use the new field at every site that needs a
tdvpr physical address. Remove the now redundant tdx_tdvpr_pa().
Remove the __flatten remnant from the tinkering.

Note that only one user of the new field is actually noinstr. All
others can use page_to_phys(). But, they might as well save the effort
since there is a pre-calculated value sitting there for them.

[ dhansen: rewrite all the text ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/kvm/vmx/tdx.c      |  9 +++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 21 ++++++++-------------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 6120461..6b338d7 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -171,6 +171,8 @@ struct tdx_td {
 struct tdx_vp {
 	/* TDVP root page */
 	struct page *tdvpr_page;
+	/* precalculated page_to_phys(tdvpr_page) for use in noinstr code */
+	phys_addr_t tdvpr_pa;
=20
 	/* TD vCPU control structure: */
 	struct page **tdcx_pages;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04b6d33..75326a7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -852,6 +852,7 @@ void tdx_vcpu_free(struct kvm_vcpu *vcpu)
 	if (tdx->vp.tdvpr_page) {
 		tdx_reclaim_control_page(tdx->vp.tdvpr_page);
 		tdx->vp.tdvpr_page =3D 0;
+		tdx->vp.tdvpr_pa =3D 0;
 	}
=20
 	tdx->state =3D VCPU_TD_STATE_UNINITIALIZED;
@@ -2931,6 +2932,13 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64=
 vcpu_rcx)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page =3D page;
=20
+	/*
+	 * page_to_phys() does not work in 'noinstr' code, like guest
+	 * entry via tdh_vp_enter(). Precalculate and store it instead
+	 * of doing it at runtime later.
+	 */
+	tdx->vp.tdvpr_pa =3D page_to_phys(tdx->vp.tdvpr_page);
+
 	tdx->vp.tdcx_pages =3D kcalloc(kvm_tdx->td.tdcx_nr_pages, sizeof(*tdx->vp.t=
dcx_pages),
 			       	     GFP_KERNEL);
 	if (!tdx->vp.tdcx_pages) {
@@ -2993,6 +3001,7 @@ free_tdvpr:
 	if (tdx->vp.tdvpr_page)
 		__free_page(tdx->vp.tdvpr_page);
 	tdx->vp.tdvpr_page =3D 0;
+	tdx->vp.tdvpr_pa =3D 0;
=20
 	return ret;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 330b560..eac4032 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1504,11 +1504,6 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
=20
-static inline u64 tdx_tdvpr_pa(struct tdx_vp *td)
-{
-	return page_to_phys(td->tdvpr_page);
-}
-
 /*
  * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
  * a CLFLUSH of pages is required before handing them to the TDX module.
@@ -1520,9 +1515,9 @@ static void tdx_clflush_page(struct page *page)
 	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
 }
=20
-noinstr __flatten u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args=
 *args)
+noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
-	args->rcx =3D tdx_tdvpr_pa(td);
+	args->rcx =3D td->tdvpr_pa;
=20
 	return __seamcall_dirty_cache(__seamcall_saved_ret, TDH_VP_ENTER, args);
 }
@@ -1583,7 +1578,7 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_p=
age)
 {
 	struct tdx_module_args args =3D {
 		.rcx =3D page_to_phys(tdcx_page),
-		.rdx =3D tdx_tdvpr_pa(vp),
+		.rdx =3D vp->tdvpr_pa,
 	};
=20
 	tdx_clflush_page(tdcx_page);
@@ -1652,7 +1647,7 @@ EXPORT_SYMBOL_GPL(tdh_mng_create);
 u64 tdh_vp_create(struct tdx_td *td, struct tdx_vp *vp)
 {
 	struct tdx_module_args args =3D {
-		.rcx =3D tdx_tdvpr_pa(vp),
+		.rcx =3D vp->tdvpr_pa,
 		.rdx =3D tdx_tdr_pa(td),
 	};
=20
@@ -1708,7 +1703,7 @@ EXPORT_SYMBOL_GPL(tdh_mr_finalize);
 u64 tdh_vp_flush(struct tdx_vp *vp)
 {
 	struct tdx_module_args args =3D {
-		.rcx =3D tdx_tdvpr_pa(vp),
+		.rcx =3D vp->tdvpr_pa,
 	};
=20
 	return seamcall(TDH_VP_FLUSH, &args);
@@ -1754,7 +1749,7 @@ EXPORT_SYMBOL_GPL(tdh_mng_init);
 u64 tdh_vp_rd(struct tdx_vp *vp, u64 field, u64 *data)
 {
 	struct tdx_module_args args =3D {
-		.rcx =3D tdx_tdvpr_pa(vp),
+		.rcx =3D vp->tdvpr_pa,
 		.rdx =3D field,
 	};
 	u64 ret;
@@ -1771,7 +1766,7 @@ EXPORT_SYMBOL_GPL(tdh_vp_rd);
 u64 tdh_vp_wr(struct tdx_vp *vp, u64 field, u64 data, u64 mask)
 {
 	struct tdx_module_args args =3D {
-		.rcx =3D tdx_tdvpr_pa(vp),
+		.rcx =3D vp->tdvpr_pa,
 		.rdx =3D field,
 		.r8 =3D data,
 		.r9 =3D mask,
@@ -1784,7 +1779,7 @@ EXPORT_SYMBOL_GPL(tdh_vp_wr);
 u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
 {
 	struct tdx_module_args args =3D {
-		.rcx =3D tdx_tdvpr_pa(vp),
+		.rcx =3D vp->tdvpr_pa,
 		.rdx =3D initial_rcx,
 		.r8 =3D x2apicid,
 	};

