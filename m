Return-Path: <linux-tip-commits+bounces-7959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA615D19C4F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEBC830024E6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E72D8DD6;
	Tue, 13 Jan 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJ7umxrG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbfSyObv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE872EA743;
	Tue, 13 Jan 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317182; cv=none; b=uDMzcw9QbJug/AHaBe/Vxfiq7esmEYrKEdNWYg/mCMFPGBopEo3iudMBWgFAgCRkxPMhERpLTraqlqAumvrYC7iR56tYNdR0fBwSaa6mHoRCCeQb6YI8H7JHqwHnihRDeRdui6nMLFZrd7eMNCoxKYm/AxMWrXuQ30/av0Qow90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317182; c=relaxed/simple;
	bh=jXlXW/u0kCpJvoRVV4u0yvDRT9ZtkuTb66Eqyino+qk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a1mpODjx5IaJu+QttIEK0o0HFnAQive0bSNFFX3YJgz8cbARA//0P+NMrtP9vSxE2Bmt2Dv+WepFXz8gJyXMMWX6s+FhAx16ee2rSV4vl7uMmVDyHAu8VpwuJwHlKuJiA9/9rXTAtOLHL0lpRSdjSz37fYN9KVO2CPPXyYjOiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJ7umxrG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbfSyObv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 15:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768317178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/T2DZY19TZg9CUdNa+UMziQkAETs18/NeJDZH1NE8A=;
	b=sJ7umxrGdOC0ZcAuljiKw7bo86d8LXSzXgLBFfWliCQs0EZCN5O48ztVdkkZ0XC4/v9Alr
	EzmP3FPCYwnH0QxYUIrJFxh24BfyEtKoJ4qe4QJFsgPUcQ8g4+oOzs2ki0kJYSW2LnICVf
	1+27sln5+3YNteCmDFQsnWtEVjEaF9wv/TpjI4bWwCtk6Rbcf6ccLSVLPvVqBBXnB6vue0
	Xka3+t25p+50XIJkdKbJWF+jLJtB/eRAVq4qeB5EUCMZAAMEn1Sn2pY2yBiwBP9xtAfM5b
	AkPAPklWhDO1XkJuY7J1gJ5Mm6cMK0S/NOs7V7SscHY5k9Pz1sILuHL2T76v6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768317178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/T2DZY19TZg9CUdNa+UMziQkAETs18/NeJDZH1NE8A=;
	b=BbfSyObv4iz5yAbG8yLBjQFlFztkpqJQFN13Bl6aS2fGcEB+0EyLylnlIJCeClj69LjcWv
	2oV4tuTAqDOU9eDg==
From: "tip-bot2 for Coiby Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/crash: Use set_memory_p() instead of
 __set_memory_prot()
Cc: Coiby Xu <coxu@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106095100.656292-1-coxu@redhat.com>
References: <20260106095100.656292-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831717666.510.18263565875642068854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8a4e92b3260ae7664d0531e1b42c38d336e7717a
Gitweb:        https://git.kernel.org/tip/8a4e92b3260ae7664d0531e1b42c38d336e=
7717a
Author:        Coiby Xu <coxu@redhat.com>
AuthorDate:    Tue, 06 Jan 2026 17:50:58 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 15:28:59 +01:00

x86/crash: Use set_memory_p() instead of __set_memory_prot()

set_memory_p() is available to use outside of its compilation unit since:

  030ad7af9437 ("x86/mm: Regularize set_memory_p() parameters and make non-st=
atic").

There is no use for __set_memory_prot() anymore so drop it too.

  [ bp: Massage commit message. ]

Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260106095100.656292-1-coxu@redhat.com
---
 arch/x86/include/asm/set_memory.h  |  1 -
 arch/x86/kernel/machine_kexec_64.c |  5 +----
 arch/x86/mm/pat/set_memory.c       | 13 -------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_mem=
ory.h
index 61f56cd..4362c26 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -38,7 +38,6 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
=20
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index 201137b..0590d39 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -673,10 +673,7 @@ static void kexec_mark_dm_crypt_keys(bool protect)
 		if (protect)
 			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
 		else
-			__set_memory_prot(
-				(unsigned long)phys_to_virt(start_paddr),
-				nr_pages,
-				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+			set_memory_p((unsigned long)phys_to_virt(start_paddr), nr_pages);
 	}
 }
=20
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6c6eb48..40581a7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2145,19 +2145,6 @@ static inline int cpa_clear_pages_array(struct page **=
pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
=20
-/*
- * __set_memory_prot is an internal helper for callers that have been passed
- * a pgprot_t value from upper layers and a reservation has already been tak=
en.
- * If you want to set the pgprot to a specific page protocol, use the
- * set_memory_xx() functions.
- */
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
-{
-	return change_page_attr_set_clr(&addr, numpages, prot,
-					__pgprot(~pgprot_val(prot)), 0, 0,
-					NULL);
-}
-
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*

