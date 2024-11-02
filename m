Return-Path: <linux-tip-commits+bounces-2730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67CE9B9F9C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FE02826A9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944FB19CC25;
	Sat,  2 Nov 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0KEWjNY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtXLYy1w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75C18A946;
	Sat,  2 Nov 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548221; cv=none; b=qmr28KtrfmHVb66D+N4ZMTQJSJILkk3/PWFXfga5AsGlqkLAkEIOof5KbfUXmNSHU1T2TkocWwL8I3OrQbgv+Xv0pigtB1myyuosD5UYJVjJOvk4Cu6YWEiybnyUqIWoG+jSVWwV1qYRLKxnNU/YmLP9ROhfYtmX4gF4YesTccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548221; c=relaxed/simple;
	bh=+R9BTi8m1fBtbDdJcmwWGoKw2qfNA7tubmAjJU/RxHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UjB/hXk722MUnN606Q39jeJOqgj21btkzdYtUFjdbR7tVIB38qGiI8hsWV8qGQ/OBdDzrNT88AQJ63G2rJkh/ohnJCYEwnnGo4KfuQwQKaR9NbCwzSkRqBHpabjCTuRJW9EJ5jY0aTy1gpqkJ6ussjvj38778cYufrdBmxwlYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0KEWjNY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtXLYy1w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlTScRV1iYSkOEKm8TjNCkbkH1Ig9lSSd9TDa973On0=;
	b=l0KEWjNYou6YpPGdfy1u0YluwmrO72RYjXafk0QX+lLEl4cE4uWOoulo/NVIJLU0jjnSZK
	QO888yM2BylL85Ncd1IwlSYzTq3pzXb+1PVwtSIjQV1fO/zR+zg9EyhFx2Vnz7HDY8YBrl
	XV8S6SXN+E5ETH+UM/NWDzXB06JbJnLg1L363NwQz2SpJanxEWVlQY2kEXFKR90yG+Mzz5
	aAqOwHhx0qZZ3shR8QCDoaDmOBFEMoICB9SwCdDRLdHoCgVZ1fOldU4/tt5MRZwV67Szw8
	wAH6uDenu1sVYeCFatEJf0hWEPktsORO1Oa33evohRZr4a/7CtBA7jZVCq2Kbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlTScRV1iYSkOEKm8TjNCkbkH1Ig9lSSd9TDa973On0=;
	b=TtXLYy1wG9HYstN/6+PQgNHXwprzOpB1oXvbI6nWx/O4sizIE6qE3G0/T+chrmPDY+Q1H1
	B2gFCkHnSBFugwDw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] x86/vdso: Split virtual clock pages into dedicated mapping
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-20-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-20-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054821745.3137.6948041005399084379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e93d2521b27f0439872dfa4e4b92a9be6d73496f
Gitweb:        https://git.kernel.org/tip/e93d2521b27f0439872dfa4e4b92a9be6d7=
3496f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

x86/vdso: Split virtual clock pages into dedicated mapping

The generic vdso data storage cannot handle the special pvclock and
hvclock pages. Split them into their own mapping, so the other vdso
storage can be migrated to the generic code.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-20-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S | 10 ++--
 arch/x86/entry/vdso/vma.c             | 70 +++++++++++++++++++-------
 arch/x86/include/asm/vdso/vsyscall.h  |  5 ++-
 3 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 9e602c0..872947c 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -17,14 +17,16 @@ SECTIONS
 	 * segment.
 	 */
=20
-	vvar_start =3D . - 4 * PAGE_SIZE;
+	vvar_start =3D . - __VVAR_PAGES * PAGE_SIZE;
 	vvar_page  =3D vvar_start;
=20
 	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
=20
-	pvclock_page =3D vvar_start + PAGE_SIZE;
-	hvclock_page =3D vvar_start + 2 * PAGE_SIZE;
-	timens_page  =3D vvar_start + 3 * PAGE_SIZE;
+	timens_page  =3D vvar_start + PAGE_SIZE;
+
+	vclock_pages =3D vvar_start + VDSO_NR_VCLOCK_PAGES * PAGE_SIZE;
+	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
+	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
 	. =3D SIZEOF_HEADERS;
=20
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5731dc3..7e5921a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -24,6 +24,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
+#include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
=20
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
@@ -175,19 +176,7 @@ static vm_fault_t vvar_fault(const struct vm_special_map=
ping *sm,
 		}
=20
 		return vmf_insert_pfn(vma, vmf->address, pfn);
-	} else if (sym_offset =3D=3D image->sym_pvclock_page) {
-		struct pvclock_vsyscall_time_info *pvti =3D
-			pvclock_get_pvti_cpu0_va();
-		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK)) {
-			return vmf_insert_pfn_prot(vma, vmf->address,
-					__pa(pvti) >> PAGE_SHIFT,
-					pgprot_decrypted(vma->vm_page_prot));
-		}
-	} else if (sym_offset =3D=3D image->sym_hvclock_page) {
-		pfn =3D hv_get_tsc_pfn();
=20
-		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
-			return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset =3D=3D image->sym_timens_page) {
 		struct page *timens_page =3D find_timens_vvar_page(vma);
=20
@@ -201,6 +190,33 @@ static vm_fault_t vvar_fault(const struct vm_special_map=
ping *sm,
 	return VM_FAULT_SIGBUS;
 }
=20
+static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
+				    struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	switch (vmf->pgoff) {
+#ifdef CONFIG_PARAVIRT_CLOCK
+	case VDSO_PAGE_PVCLOCK_OFFSET:
+		struct pvclock_vsyscall_time_info *pvti =3D
+			pvclock_get_pvti_cpu0_va();
+		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK))
+			return vmf_insert_pfn_prot(vma, vmf->address,
+					__pa(pvti) >> PAGE_SHIFT,
+					pgprot_decrypted(vma->vm_page_prot));
+		break;
+#endif /* CONFIG_PARAVIRT_CLOCK */
+#ifdef CONFIG_HYPERV_TIMER
+	case VDSO_PAGE_HVCLOCK_OFFSET:
+		unsigned long pfn =3D hv_get_tsc_pfn();
+
+		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
+			return vmf_insert_pfn(vma, vmf->address, pfn);
+		break;
+#endif /* CONFIG_HYPERV_TIMER */
+	}
+
+	return VM_FAULT_SIGBUS;
+}
+
 static const struct vm_special_mapping vdso_mapping =3D {
 	.name =3D "[vdso]",
 	.fault =3D vdso_fault,
@@ -210,6 +226,10 @@ static const struct vm_special_mapping vvar_mapping =3D {
 	.name =3D "[vvar]",
 	.fault =3D vvar_fault,
 };
+static const struct vm_special_mapping vvar_vclock_mapping =3D {
+	.name =3D "[vvar_vclock]",
+	.fault =3D vvar_vclock_fault,
+};
=20
 /*
  * Add vdso and vvar mappings to current process.
@@ -252,7 +272,7 @@ static int map_vdso(const struct vdso_image *image, unsig=
ned long addr)
=20
 	vma =3D _install_special_mapping(mm,
 				       addr,
-				       -image->sym_vvar_start,
+				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
 				       VM_PFNMAP,
 				       &vvar_mapping);
@@ -260,11 +280,26 @@ static int map_vdso(const struct vdso_image *image, uns=
igned long addr)
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
-	} else {
-		current->mm->context.vdso =3D (void __user *)text_start;
-		current->mm->context.vdso_image =3D image;
+		goto up_fail;
 	}
=20
+	vma =3D _install_special_mapping(mm,
+				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
+				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
+				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
+				       VM_PFNMAP,
+				       &vvar_vclock_mapping);
+
+	if (IS_ERR(vma)) {
+		ret =3D PTR_ERR(vma);
+		do_munmap(mm, text_start, image->size, NULL);
+		do_munmap(mm, addr, image->size, NULL);
+		goto up_fail;
+	}
+
+	current->mm->context.vdso =3D (void __user *)text_start;
+	current->mm->context.vdso_image =3D image;
+
 up_fail:
 	mmap_write_unlock(mm);
 	return ret;
@@ -286,7 +321,8 @@ int map_vdso_once(const struct vdso_image *image, unsigne=
d long addr)
 	 */
 	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
-				vma_is_special_mapping(vma, &vvar_mapping)) {
+				vma_is_special_mapping(vma, &vvar_mapping) ||
+				vma_is_special_mapping(vma, &vvar_vclock_mapping)) {
 			mmap_write_unlock(mm);
 			return -EEXIST;
 		}
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 6a933f0..37b4a70 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -3,6 +3,11 @@
 #define __ASM_VDSO_VSYSCALL_H
=20
 #define __VDSO_RND_DATA_OFFSET  640
+#define __VVAR_PAGES	4
+
+#define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_PAGE_PVCLOCK_OFFSET	0
+#define VDSO_PAGE_HVCLOCK_OFFSET	1
=20
 #ifndef __ASSEMBLY__
=20

