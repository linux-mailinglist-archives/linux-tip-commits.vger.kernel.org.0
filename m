Return-Path: <linux-tip-commits+bounces-7984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB7D1E2E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82B0630AB95C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58133939DE;
	Wed, 14 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c09v5t3D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlpu25FY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48518389E1F;
	Wed, 14 Jan 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387211; cv=none; b=hMSy8niZt+2vv0wz6x7/o+/fqNLak+XlKrMeyLQrNTJ8niR1Tp33tAJ02A2+qFM8n3htxtKU6HUOiQrB3RrB6vBr3bTZTxPVdlQBX+abL9isnEyEIY471VstPwlwwtP2kiQxIBamz96d0MtTVR/tYMsoU5ymTwSOaNzwjcU2Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387211; c=relaxed/simple;
	bh=lBlpgKfk3T+HzCuUB7KDJqGxDYV9urRo/WnaAG7tiIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hw+JPuUYd2KGdy3vTKedTV3fn5Y0WtObMJyZlLctzr8bUKaCDltMljR6eqwt2a50Y9ZGaBeL6/6UxOErFAkgjnnjb9vEz1RxKMyfUXiPqGcq3CYiOQwgaoLzfe2UF+OJAhOnvMb8jHk/nx+g/J8rV01Qi8biNxz3mxyj9ZVnefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c09v5t3D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlpu25FY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vN2Ac9F2RscqSbUPTwvGs0N6lbJa5O5Qfd0lWJNYQb8=;
	b=c09v5t3DaSqXMJjpMSStsTMYfxTx1Asl8gu4Lh7Tmfjd0gfpJL7RYGTI/iloAcKNCEnKAF
	ilcqVHLTo1DpzVrZZPxy4vQwC6E2AbQ5U1DQ4oW5T2Qm5xmcBH9cN7yPJh/GPxlZ2PhoGe
	EOqXJPsimLjKRlXnABH6KsZ9eZgggYMqGVLqVDlEy0O8XV/mfaJd8yMKWe5ul/TboTn3DF
	g0AoljlAIxRaOMHHc56BNtAHqfVjIsiG6e7tHTj0GGojGpmPXskMlL5osBAkwGFH4qwto4
	t1CRvWQ+SziaqjiPm85b8P1wd5b4jETlvKdRHwzRISu4shLwcs9xgcaa4DgYRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vN2Ac9F2RscqSbUPTwvGs0N6lbJa5O5Qfd0lWJNYQb8=;
	b=tlpu25FYlcSZ8CG4EvmE2XXPIgRezzH7EABZUDmyUgWuBvukruZyGD0er+BGL4SUb7h26d
	NomNNmp7mBZFaYAQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/xen: Drop xen_mmu_ops
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-18-jgross@suse.com>
References: <20260105110520.21356-18-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720366.510.13860423418994922103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     7aef17f367c94d6cef00f45b193e37d30ff4a3b5
Gitweb:        https://git.kernel.org/tip/7aef17f367c94d6cef00f45b193e37d30ff=
4a3b5
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:16 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 21:44:34 +01:00

x86/xen: Drop xen_mmu_ops

Instead of having a pre-filled array xen_mmu_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

This is in preparation of reducing the paravirt include hell by
splitting paravirt.h into multiple more fine grained header files,
which will in turn require to split up the pv_ops vector as well.
Dropping the pre-filled array makes life easier for objtool to
detect missing initializers in multiple pv_ops_ arrays.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://patch.msgid.link/20260105110520.21356-18-jgross@suse.com
---
 arch/x86/xen/mmu_pv.c | 100 +++++++++++++++--------------------------
 tools/objtool/check.c |   1 +-
 2 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2a4a8de..9fa00c4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2175,73 +2175,49 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
=20
-static const typeof(pv_ops) xen_mmu_ops __initconst =3D {
-	.mmu =3D {
-		.read_cr2 =3D __PV_IS_CALLEE_SAVE(xen_read_cr2),
-		.write_cr2 =3D xen_write_cr2,
-
-		.read_cr3 =3D xen_read_cr3,
-		.write_cr3 =3D xen_write_cr3_init,
-
-		.flush_tlb_user =3D xen_flush_tlb,
-		.flush_tlb_kernel =3D xen_flush_tlb,
-		.flush_tlb_one_user =3D xen_flush_tlb_one_user,
-		.flush_tlb_multi =3D xen_flush_tlb_multi,
-
-		.pgd_alloc =3D xen_pgd_alloc,
-		.pgd_free =3D xen_pgd_free,
-
-		.alloc_pte =3D xen_alloc_pte_init,
-		.release_pte =3D xen_release_pte_init,
-		.alloc_pmd =3D xen_alloc_pmd_init,
-		.release_pmd =3D xen_release_pmd_init,
-
-		.set_pte =3D xen_set_pte_init,
-		.set_pmd =3D xen_set_pmd_hyper,
-
-		.ptep_modify_prot_start =3D xen_ptep_modify_prot_start,
-		.ptep_modify_prot_commit =3D xen_ptep_modify_prot_commit,
-
-		.pte_val =3D PV_CALLEE_SAVE(xen_pte_val),
-		.pgd_val =3D PV_CALLEE_SAVE(xen_pgd_val),
-
-		.make_pte =3D PV_CALLEE_SAVE(xen_make_pte_init),
-		.make_pgd =3D PV_CALLEE_SAVE(xen_make_pgd),
-
-		.set_pud =3D xen_set_pud_hyper,
-
-		.make_pmd =3D PV_CALLEE_SAVE(xen_make_pmd),
-		.pmd_val =3D PV_CALLEE_SAVE(xen_pmd_val),
-
-		.pud_val =3D PV_CALLEE_SAVE(xen_pud_val),
-		.make_pud =3D PV_CALLEE_SAVE(xen_make_pud),
-		.set_p4d =3D xen_set_p4d_hyper,
-
-		.alloc_pud =3D xen_alloc_pmd_init,
-		.release_pud =3D xen_release_pmd_init,
-
-		.p4d_val =3D PV_CALLEE_SAVE(xen_p4d_val),
-		.make_p4d =3D PV_CALLEE_SAVE(xen_make_p4d),
-
-		.enter_mmap =3D xen_enter_mmap,
-		.exit_mmap =3D xen_exit_mmap,
-
-		.lazy_mode =3D {
-			.enter =3D xen_enter_lazy_mmu,
-			.leave =3D xen_leave_lazy_mmu,
-			.flush =3D xen_flush_lazy_mmu,
-		},
-
-		.set_fixmap =3D xen_set_fixmap,
-	},
-};
-
 void __init xen_init_mmu_ops(void)
 {
 	x86_init.paging.pagetable_init =3D xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem =3D xen_after_bootmem;
=20
-	pv_ops.mmu =3D xen_mmu_ops.mmu;
+	pv_ops.mmu.read_cr2 =3D __PV_IS_CALLEE_SAVE(xen_read_cr2);
+	pv_ops.mmu.write_cr2 =3D xen_write_cr2;
+	pv_ops.mmu.read_cr3 =3D xen_read_cr3;
+	pv_ops.mmu.write_cr3 =3D xen_write_cr3_init;
+	pv_ops.mmu.flush_tlb_user =3D xen_flush_tlb;
+	pv_ops.mmu.flush_tlb_kernel =3D xen_flush_tlb;
+	pv_ops.mmu.flush_tlb_one_user =3D xen_flush_tlb_one_user;
+	pv_ops.mmu.flush_tlb_multi =3D xen_flush_tlb_multi;
+	pv_ops.mmu.pgd_alloc =3D xen_pgd_alloc;
+	pv_ops.mmu.pgd_free =3D xen_pgd_free;
+	pv_ops.mmu.alloc_pte =3D xen_alloc_pte_init;
+	pv_ops.mmu.release_pte =3D xen_release_pte_init;
+	pv_ops.mmu.alloc_pmd =3D xen_alloc_pmd_init;
+	pv_ops.mmu.release_pmd =3D xen_release_pmd_init;
+	pv_ops.mmu.set_pte =3D xen_set_pte_init;
+	pv_ops.mmu.set_pmd =3D xen_set_pmd_hyper;
+	pv_ops.mmu.ptep_modify_prot_start =3D xen_ptep_modify_prot_start;
+	pv_ops.mmu.ptep_modify_prot_commit =3D xen_ptep_modify_prot_commit;
+	pv_ops.mmu.pte_val =3D PV_CALLEE_SAVE(xen_pte_val);
+	pv_ops.mmu.pgd_val =3D PV_CALLEE_SAVE(xen_pgd_val);
+	pv_ops.mmu.make_pte =3D PV_CALLEE_SAVE(xen_make_pte_init);
+	pv_ops.mmu.make_pgd =3D PV_CALLEE_SAVE(xen_make_pgd);
+	pv_ops.mmu.set_pud =3D xen_set_pud_hyper;
+	pv_ops.mmu.make_pmd =3D PV_CALLEE_SAVE(xen_make_pmd);
+	pv_ops.mmu.pmd_val =3D PV_CALLEE_SAVE(xen_pmd_val);
+	pv_ops.mmu.pud_val =3D PV_CALLEE_SAVE(xen_pud_val);
+	pv_ops.mmu.make_pud =3D PV_CALLEE_SAVE(xen_make_pud);
+	pv_ops.mmu.set_p4d =3D xen_set_p4d_hyper;
+	pv_ops.mmu.alloc_pud =3D xen_alloc_pmd_init;
+	pv_ops.mmu.release_pud =3D xen_release_pmd_init;
+	pv_ops.mmu.p4d_val =3D PV_CALLEE_SAVE(xen_p4d_val);
+	pv_ops.mmu.make_p4d =3D PV_CALLEE_SAVE(xen_make_p4d);
+	pv_ops.mmu.enter_mmap =3D xen_enter_mmap;
+	pv_ops.mmu.exit_mmap =3D xen_exit_mmap;
+	pv_ops.mmu.lazy_mode.enter =3D xen_enter_lazy_mmu;
+	pv_ops.mmu.lazy_mode.leave =3D xen_leave_lazy_mmu;
+	pv_ops.mmu.lazy_mode.flush =3D xen_flush_lazy_mmu;
+	pv_ops.mmu.set_fixmap =3D xen_set_fixmap;
=20
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8ab88f2..61f3e0c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -570,7 +570,6 @@ static int init_pv_ops(struct objtool_file *file)
 {
 	static const char *pv_ops_tables[] =3D {
 		"pv_ops",
-		"xen_mmu_ops",
 		NULL,
 	};
 	const char *pv_ops;

