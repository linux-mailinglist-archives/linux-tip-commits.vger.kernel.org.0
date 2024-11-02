Return-Path: <linux-tip-commits+bounces-2719-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549929B9EBA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A90D282D97
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2441AB6F1;
	Sat,  2 Nov 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVFNr8Gk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJLROmIF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA419E97B;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542223; cv=none; b=LVFiT+0ypEHNzk7JWH2LaqxYvUkTNgSQAZyiBL/N2AWm2TnMKAhNvcZ/Yee1NCjKf8ggb541E7wnW/H1YvFc6skVAQJE8BY/E8lgJ/pPg8C/EFVKrvWao9OSekiS1XfCjGy7VXuYyuGmHAmIftzv4/3Je/N7xeWu4OjN26VbR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542223; c=relaxed/simple;
	bh=JUfft22niKHtE2y8VEFtJbkM2hLEEkCyi3fXdNUSM/Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ivLgmHASj0prXcRKOiYq6GWcGK9twvTh8IGZGvizhkJRvY5EgA4Z+F71JTcOeODGWMjSeaX618ue0tsdnGSVBzsGfjTUTE0CN10AhWHCKBt1MvntX+M+dgDjcbFWARzeYMysp4LG5BGx+gKzht5ebJ6M4fshjPBsDKMqQO4NiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVFNr8Gk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJLROmIF; arc=none smtp.client-ip=193.142.43.55
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
	bh=Sj//pWUcuTA9rXHiCA9WljblSGQ8QvHIJHKvll4H4wU=;
	b=ZVFNr8GkSc9Oqc09YwjOSvL84KQ0jxKzSjap9hkIB3ljEaklzL8zdD7MYhlTMwtGQyzaUi
	5hE4S57NewPxq38rmxvdPkd8qEIsBY+gAGJb+FMO/CizOxhQCFxlCHYdeni49+iDli3i3g
	KWUW2bBI0BSX22XczZmvqToqWqwoqV6BUPnzNd/11BzfkowTr6PIRUUV/v4Ocdqut4d2r1
	WBTCYTHzlnF0WhRyF9fnMDLRImpwPAJCYoGgoyIfbC9MuUSAf6GA18DooCRKzXTEqXj65l
	TFdBQvNaB/KLWDiO+lTmMuWvSBzVHLKUzD/xzBywHWguCsudrH0QVhb9ccj5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sj//pWUcuTA9rXHiCA9WljblSGQ8QvHIJHKvll4H4wU=;
	b=OJLROmIF69feLBLy/6rPZ3ZWDA7j9EuVGDBsWzuZmCkYEWQ0t1tADVVJhVifG3QvWfl7JT
	sIqJeJMKwyEffgAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vdso: Use only one single vvar mapping
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-5-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-5-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221794.3137.17543302411698899887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     63ec3218c766facf572dd5b1d5e6b2a93adb42b0
Gitweb:        https://git.kernel.org/tip/63ec3218c766facf572dd5b1d5e6b2a93ad=
b42b0
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

arm64: vdso: Use only one single vvar mapping

The vvar mapping is the same for all processes. Use a single mapping to
simplify the logic and align it with the other architectures.

In addition this will enable the move of the vvar handling into generic code.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-5-b64f0842d51=
2@linutronix.de

---
 arch/arm64/kernel/vdso.c | 43 +++++++++++----------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 8ef20c1..e8ed8e5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -38,8 +38,6 @@ struct vdso_abi_info {
 	const char *vdso_code_start;
 	const char *vdso_code_end;
 	unsigned long vdso_pages;
-	/* Data Mapping */
-	struct vm_special_mapping *dm;
 	/* Code Mapping */
 	struct vm_special_mapping *cm;
 };
@@ -112,6 +110,8 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
=20
+static const struct vm_special_mapping vvar_map;
+
 /*
  * The vvar mapping contains data for a specific time namespace, so when a t=
ask
  * changes namespace we must unmap its vvar data for the old namespace.
@@ -128,12 +128,8 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_lock(mm);
=20
 	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
-			zap_vma_pages(vma);
-#ifdef CONFIG_COMPAT_VDSO
-		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA32].dm))
+		if (vma_is_special_mapping(vma, &vvar_map))
 			zap_vma_pages(vma);
-#endif
 	}
=20
 	mmap_read_unlock(mm);
@@ -175,6 +171,11 @@ static vm_fault_t vvar_fault(const struct vm_special_map=
ping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
=20
+static const struct vm_special_mapping vvar_map =3D {
+	.name   =3D "[vvar]",
+	.fault =3D vvar_fault,
+};
+
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -198,7 +199,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
=20
 	ret =3D _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_PFNMAP,
-				       vdso_info[abi].dm);
+				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
@@ -228,7 +229,6 @@ up_fail:
 enum aarch32_map {
 	AA32_MAP_VECTORS, /* kuser helpers */
 	AA32_MAP_SIGPAGE,
-	AA32_MAP_VVAR,
 	AA32_MAP_VDSO,
 };
=20
@@ -253,10 +253,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] =3D=
 {
 		.pages	=3D &aarch32_sig_page,
 		.mremap	=3D aarch32_sigpage_mremap,
 	},
-	[AA32_MAP_VVAR] =3D {
-		.name =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
 	[AA32_MAP_VDSO] =3D {
 		.name =3D "[vdso]",
 		.mremap =3D vdso_mremap,
@@ -306,7 +302,6 @@ static int __init __aarch32_alloc_vdso_pages(void)
 	if (!IS_ENABLED(CONFIG_COMPAT_VDSO))
 		return 0;
=20
-	vdso_info[VDSO_ABI_AA32].dm =3D &aarch32_vdso_maps[AA32_MAP_VVAR];
 	vdso_info[VDSO_ABI_AA32].cm =3D &aarch32_vdso_maps[AA32_MAP_VDSO];
=20
 	return __vdso_init(VDSO_ABI_AA32);
@@ -401,26 +396,14 @@ out:
 }
 #endif /* CONFIG_COMPAT */
=20
-enum aarch64_map {
-	AA64_MAP_VVAR,
-	AA64_MAP_VDSO,
-};
-
-static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init =3D {
-	[AA64_MAP_VVAR] =3D {
-		.name	=3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
-	[AA64_MAP_VDSO] =3D {
-		.name	=3D "[vdso]",
-		.mremap =3D vdso_mremap,
-	},
+static struct vm_special_mapping aarch64_vdso_map __ro_after_init =3D {
+	.name	=3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 static int __init vdso_init(void)
 {
-	vdso_info[VDSO_ABI_AA64].dm =3D &aarch64_vdso_maps[AA64_MAP_VVAR];
-	vdso_info[VDSO_ABI_AA64].cm =3D &aarch64_vdso_maps[AA64_MAP_VDSO];
+	vdso_info[VDSO_ABI_AA64].cm =3D &aarch64_vdso_map;
=20
 	return __vdso_init(VDSO_ABI_AA64);
 }

