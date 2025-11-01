Return-Path: <linux-tip-commits+bounces-7143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F0C2871F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AC3421AC1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F39309DBD;
	Sat,  1 Nov 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1l+zJ0c+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqjH0ZdL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610D3081B6;
	Sat,  1 Nov 2025 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026472; cv=none; b=R4VssHGlc1llsd5VA5l8aq9Rg/R+2iVPEIVyFpgfVroFLyuNv9w2C7t6QDxS4lilfhXH1DlqRdnOXtHqQWaYBVWYo19vCPViY+3jYuOCLGrOIe7nikmlVyqwJLjqL7Kce0z7JEJC5bg0LFhOd45NuqgOFxHdY0WUvfF0snMlGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026472; c=relaxed/simple;
	bh=NtCpt91lJKibUCNAsAWYRb8pNTVDL3nUS0s8iYH6/i0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uKqtE3yY+EAuVIs2CiM7bOcy86YWtEvFq9bwXiENRTX2cdxrgeD5oHf0uOL1bT/9Mm67dlXHeold0ND49n52Ii7rPUWVW0zwWoLzyAEuUhXIIpFq/8yY+PPboWIc11YitddOIEZf/NtCAhe6wOJQDl9wxMm97yJirhSD9XLyI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1l+zJ0c+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqjH0ZdL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d6zk+TGX/P9mIURCPBJBzmt5GT/GWoz2f3FYq2OyCU=;
	b=1l+zJ0c+r8KUZLQ7C/Dzn00LRJz3mLBgKeoTRZgyR91O9/FpVbO1sZTZG7eOnX0x/mYjXc
	Gt+PmEcowkn58sbedscHCCccfOTk7bQWE2dhEUdfa2tcZPc6/s3hhtLJovlaS/th7zaQqK
	4y/4rIkHjd/Sp5+lZUH9gdR2rFl5fK1TkLgkMdJgZT5ktf9ZyklS0Dx4xLAnN0DvYW9QLn
	aGiiS1D6neGrR2t2A+7dLIYZTsdMdDR9BrDr+zAuUwhKiujY8v+icKbPU+9/ur0whUZAIC
	b9TOW8HE042deM+RE3basxbTvuOY0kmFcNJGij7qpZ81ORi7V89CPlrQf8KUCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d6zk+TGX/P9mIURCPBJBzmt5GT/GWoz2f3FYq2OyCU=;
	b=DqjH0ZdLjaK4PmxcynNZRMgTB4+5rJxfPmdBg6ylW6wGiZRdvKZY+FfUr9wQSg6u2hSuYz
	SXDlZNyxjLnDheDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datastore: Map pages through struct page
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202646793.2601451.2396648642285838920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     6a011a22829362bfee8ff9fc1212f803c18af5f2
Gitweb:        https://git.kernel.org/tip/6a011a22829362bfee8ff9fc1212f803c18=
af5f2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:06 +01:00

vdso/datastore: Map pages through struct page

An upcoming change will allocate the datapages dynamically instead of as
part of the kernel image. Such pages can only be mapped through
'struct page' and not through PFNs.

Prepare for the dynamic allocation by mapping through 'struct page'.

VM_MIXEDMAP is necessary for the call to vmf_insert_page() in the timens
prefault path to work.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-23-e0607bf4=
9dea@linutronix.de
---
 lib/vdso/datastore.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 7377fcb..6e5feb4 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -39,14 +39,15 @@ struct vdso_arch_data *vdso_k_arch_data =3D &vdso_arch_da=
ta_store.data;
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long pfn;
+	struct page *page, *timens_page;
+
+	timens_page =3D find_timens_vvar_page(vma);
=20
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
 			return VM_FAULT_SIGBUS;
-		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page =3D virt_to_page(vdso_k_time_data);
 		if (timens_page) {
 			/*
 			 * Fault in VVAR page too, since it will be accessed
@@ -56,10 +57,10 @@ static vm_fault_t vvar_fault(const struct vm_special_mapp=
ing *sm,
 			vm_fault_t err;
=20
 			addr =3D vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err =3D vmf_insert_pfn(vma, addr, pfn);
+			err =3D vmf_insert_page(vma, addr, page);
 			if (unlikely(err & VM_FAULT_ERROR))
 				return err;
-			pfn =3D page_to_pfn(timens_page);
+			page =3D timens_page;
 		}
 		break;
 	case VDSO_TIMENS_PAGE_OFFSET:
@@ -72,24 +73,25 @@ static vm_fault_t vvar_fault(const struct vm_special_mapp=
ing *sm,
 		 */
 		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
 			return VM_FAULT_SIGBUS;
-		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page =3D virt_to_page(vdso_k_time_data);
 		break;
 	case VDSO_RNG_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 			return VM_FAULT_SIGBUS;
-		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		page =3D virt_to_page(vdso_k_rng_data);
 		break;
 	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
 			return VM_FAULT_SIGBUS;
-		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
-			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		page =3D virt_to_page(vdso_k_arch_data) + vmf->pgoff - VDSO_ARCH_PAGES_STA=
RT;
 		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}
=20
-	return vmf_insert_pfn(vma, vmf->address, pfn);
+	get_page(page);
+	vmf->page =3D page;
+	return 0;
 }
=20
 const struct vm_special_mapping vdso_vvar_mapping =3D {
@@ -101,7 +103,7 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct m=
m_struct *mm, unsigned=20
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
 					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
-					VM_PFNMAP | VM_SEALED_SYSMAP,
+					VM_MIXEDMAP | VM_SEALED_SYSMAP,
 					&vdso_vvar_mapping);
 }
=20

