Return-Path: <linux-tip-commits+bounces-5050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E24A92595
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B53AEF04
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AD258CDE;
	Thu, 17 Apr 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UglaqSNn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrR3DvVQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93537257451;
	Thu, 17 Apr 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913011; cv=none; b=rFyz1dvh6MEdJ17TOn23Quo0IbkI5TqsH8Sb6whD5SmY69Ti3PVCiIe831Ur6IkiCVLaBVHYHBU1vwf+zNc0fwdwY7JHrkFZc0fK7jHnhkXH/i25BG8btFk8t1Po6oszOiR7IyYqgqo8YLSvK3rq9D2mmhXMfW0V0rm1dZjI3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913011; c=relaxed/simple;
	bh=ZvMaNtTc6Gm2PvC9YtSSuxInQDyRED54ncDNlu94fBo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IqUeuXiTx8+AIVS43DNL+7acvQgiwxZG/RDwNtxrNQjub09kgaarguFywsQCRZjkC6s4nSpj45RNRjd2r+wobPyXqe7hQPNximRYEAVKIzYVE8y9AX0y04tJ3be2PHMInjckRJEidR7KweKoT7eD5YBeNSKUog595WSVVuvmiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UglaqSNn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrR3DvVQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aCyqZYsbGLAaO0GmNOqxYS3gBjZBlryVgZ0+1AzxPQM=;
	b=UglaqSNnIOfJW8/uQREqbooS7m90gdfWYPuigksXUyNV3DKto4EfXyCTLhtjUDQ8Hzn0yd
	XsFsERmZQdTWFl95Q2dftv8W2MFHgq6FRjuqArGvEWgqhz5Olo1UGysnEbQkLt1X7OpOFT
	QoDq8Qp2OuEN+WB1Y1YAqcRP86J7QV6Tr97b9hdUOhlp3XYYJR9isE7rbQCF2NEJ2KgDPJ
	bjHLKdZ1U7RKaiZisgsMbrS11v9qfV9yNJHmJeGbXnZQev0gJmqwP32SvuzvhYAug0yLAA
	4eKT4GWcXV3CCu51Ck2sd51CVqttqeVa0bdSbUnEJOQh23fGi4OxTRBljuve7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aCyqZYsbGLAaO0GmNOqxYS3gBjZBlryVgZ0+1AzxPQM=;
	b=RrR3DvVQzKeMVMU0nEaV301OOL21uA47fNXfQweZ7/BfH25MKmii+nNVaD62RsH8qL2hsN
	ic+ea86GGDHoEGBQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Simplify PAE PGD sharing macros
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300671.31282.764853988155878867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     45fb940563f80b8138f465f18d71c2d3e4a0724e
Gitweb:        https://git.kernel.org/tip/45fb940563f80b8138f465f18d71c2d3e4a0724e
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:38 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Simplify PAE PGD sharing macros

There are a few too many levels of abstraction here.

First, just expand the PREALLOCATED_PMDS macro in place to make it
clear that it is only conditional on PTI.

Second, MAX_PREALLOCATED_PMDS is only used in one spot for an
on-stack allocation. It has a *maximum* value of 4. Do not bother
with the macro MAX() magic.  Just set it to 4.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173238.6E3CDA56%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pgtable.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f1c5886..027e1d3 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -68,12 +68,6 @@ static inline void pgd_list_del(pgd_t *pgd)
 	list_del(&ptdesc->pt_list);
 }
 
-#define UNSHARED_PTRS_PER_PGD				\
-	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
-#define MAX_UNSHARED_PTRS_PER_PGD			\
-	MAX_T(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
-
-
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
 {
 	virt_to_ptdesc(pgd)->pt_mm = mm;
@@ -132,8 +126,9 @@ static void pgd_dtor(pgd_t *pgd)
  * not shared between pagetables (!SHARED_KERNEL_PMDS), we allocate
  * and initialize the kernel pmds here.
  */
-#define PREALLOCATED_PMDS	UNSHARED_PTRS_PER_PGD
-#define MAX_PREALLOCATED_PMDS	MAX_UNSHARED_PTRS_PER_PGD
+#define PREALLOCATED_PMDS	(static_cpu_has(X86_FEATURE_PTI) ? \
+					PTRS_PER_PGD : KERNEL_PGD_BOUNDARY)
+#define MAX_PREALLOCATED_PMDS	PTRS_PER_PGD
 
 /*
  * We allocate separate PMDs for the kernel part of the user page-table

