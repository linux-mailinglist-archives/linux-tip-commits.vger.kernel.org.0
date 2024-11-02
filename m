Return-Path: <linux-tip-commits+bounces-2716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAB9B9EB0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC2F1F24348
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB51A0BF1;
	Sat,  2 Nov 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XoBldCEW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZJ/keT1o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F318A935;
	Sat,  2 Nov 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542221; cv=none; b=LngzCAcZx7IGZjOgJSOLKpu5ufwy2N1cq1/qzkLnPDIPYo5Saqjo+bxYv7nDdzKpX3Y3Hg5kmCexmFiUd4aaumjXpU7J1lEASfewtuFJ+/c6fUn24y6hl52tFDg90KPNdImCNKJr845HX08cFQJ45+xC3HRX5vP3IUzPUdPPFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542221; c=relaxed/simple;
	bh=bEjljXuw2HyjS2XCD6cc9N/dlZfhWYhE3eispGRRPpo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RxNUwCw7FFAaPSUUl6Fod7QHZmKPpzVoLqJmfZahBYrWsxj04UPQb8Kvs8vjtaHCFJeY2pe7qtTbLvHm/fZIGf6gb40NpaHE3n6PNfA6xO3FEuZVFzk5YPg/rEO/Mb2TitfXH7H+euYIM6T9NjqF6GkJDcDSis5M4nEFH2jHWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XoBldCEW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZJ/keT1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QH+h0+LCUBDfNdGRKyE0uW//suynBE0BZqk9m6AbmM4=;
	b=XoBldCEWAK+PiBlhDRULscOp6TDCTU1BlMnexWFpFxuQjL2sj3eC3OjDq9YuvEuaxYXRml
	vybElKl9AZXnxFegmg+1q+qocXRk9UUUg2rRCn3GhqWyJj5gaEBNYImeBpkjiS4qKPd3aT
	ZMHlzz/8Y9+W78KCUlYpsZ2/kDuFoppbJs5aMSiRJtH68W5T4psyzLHjwaAxSmO2WbWJ5B
	7NSEacTPNP6L95fbESxFOZYp1fW85xTdXpCurBXr9lvuBzRssDh62Q2akbsCsRo8wNMDAi
	Musu5AqJjt0YwW80AmJCbj85M96HenY4575XMFiSGXAJXEWVHnYjfXVgEHfUbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QH+h0+LCUBDfNdGRKyE0uW//suynBE0BZqk9m6AbmM4=;
	b=ZJ/keT1oEatb4/3RUb2wdajymR8s/ojbScX8Qg7859xcu0Cn4uDK6usBwfOW6bfpYQtNod
	ekkeg0+POB/nuvBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] riscv: vdso: Use only one single vvar mapping
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-6-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-6-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221726.3137.4497967603302313710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fbea49c3a44649c4edb607a4aa0ca793e02bb875
Gitweb:        https://git.kernel.org/tip/fbea49c3a44649c4edb607a4aa0ca793e02=
bb875
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

riscv: vdso: Use only one single vvar mapping

The vvar mapping is the same for all processes. Use a single mapping to
simplify the logic and align it with the other architectures.

In addition this will enable the move of the vvar handling into generic code.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-6-b64f0842d51=
2@linutronix.de

---
 arch/riscv/kernel/vdso.c | 52 ++++++++++++---------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 98315b9..3ca3ae4 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -23,11 +23,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES,
 };
=20
-enum rv_vdso_map {
-	RV_VDSO_MAP_VVAR,
-	RV_VDSO_MAP_VDSO,
-};
-
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
=20
 static union vdso_data_store vdso_data_store __page_aligned_data;
@@ -38,8 +33,6 @@ struct __vdso_info {
 	const char *vdso_code_start;
 	const char *vdso_code_end;
 	unsigned long vdso_pages;
-	/* Data Mapping */
-	struct vm_special_mapping *dm;
 	/* Code Mapping */
 	struct vm_special_mapping *cm;
 };
@@ -92,6 +85,8 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
=20
+static const struct vm_special_mapping rv_vvar_map;
+
 /*
  * The vvar mapping contains data for a specific time namespace, so when a t=
ask
  * changes namespace we must unmap its vvar data for the old namespace.
@@ -108,12 +103,8 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_lock(mm);
=20
 	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, vdso_info.dm))
-			zap_vma_pages(vma);
-#ifdef CONFIG_COMPAT
-		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+		if (vma_is_special_mapping(vma, &rv_vvar_map))
 			zap_vma_pages(vma);
-#endif
 	}
=20
 	mmap_read_unlock(mm);
@@ -155,43 +146,34 @@ static vm_fault_t vvar_fault(const struct vm_special_ma=
pping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
=20
-static struct vm_special_mapping rv_vdso_maps[] __ro_after_init =3D {
-	[RV_VDSO_MAP_VVAR] =3D {
-		.name   =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[RV_VDSO_MAP_VDSO] =3D {
-		.name   =3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static const struct vm_special_mapping rv_vvar_map =3D {
+	.name   =3D "[vvar]",
+	.fault =3D vvar_fault,
+};
+
+static struct vm_special_mapping rv_vdso_map __ro_after_init =3D {
+	.name   =3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static struct __vdso_info vdso_info __ro_after_init =3D {
 	.name =3D "vdso",
 	.vdso_code_start =3D vdso_start,
 	.vdso_code_end =3D vdso_end,
-	.dm =3D &rv_vdso_maps[RV_VDSO_MAP_VVAR],
-	.cm =3D &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+	.cm =3D &rv_vdso_map,
 };
=20
 #ifdef CONFIG_COMPAT
-static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init =3D {
-	[RV_VDSO_MAP_VVAR] =3D {
-		.name   =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[RV_VDSO_MAP_VDSO] =3D {
-		.name   =3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static struct vm_special_mapping rv_compat_vdso_map __ro_after_init =3D {
+	.name   =3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static struct __vdso_info compat_vdso_info __ro_after_init =3D {
 	.name =3D "compat_vdso",
 	.vdso_code_start =3D compat_vdso_start,
 	.vdso_code_end =3D compat_vdso_end,
-	.dm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
-	.cm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
+	.cm =3D &rv_compat_vdso_map,
 };
 #endif
=20
@@ -227,7 +209,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	}
=20
 	ret =3D _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info->dm);
+		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
=20

