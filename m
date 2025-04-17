Return-Path: <linux-tip-commits+bounces-5048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895AA925E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9267B61EB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FA257AC2;
	Thu, 17 Apr 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVGD7xjF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rbuVZ9Vl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358F1EB1BF;
	Thu, 17 Apr 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913009; cv=none; b=tLDDjgWoSV28qYC36oGec+413ba1LyY7IbyJJRwmEIeAfOQdnETyd9tej4nzUu2t/OE7vhZWv0DgaYcA+jYOz/Ngs4AE3eDKhqoDL2Dox164md1s/yRIwm93CVQc2s7H9vA4VTVWU1YKtutHuxvVAP4FfXfGuR8H2fFcGaRVkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913009; c=relaxed/simple;
	bh=xPztG5wmdGiJK341Tf8Fn890tlmGDPg15aKO2BJHYaE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gHZcmOQ/VJbt3JI1gyDibp+n/QHX37oss+uboN34oTPUHPrAsyWXZJS3IPiYnTDAMWPlsA39eGylom5VeMiL+FE37YtDF6n1DT7W0uNWQ6W4TZX1m2lQkTKQ/+GZYJ31wsVFq+He7m8scp7IVhWWWdA/4vBsODo5Lc5nJ7yKPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVGD7xjF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rbuVZ9Vl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uhEx+dFtU5a+nA+flpSZ6OqqcO6apZEwjUbR4CHkMUI=;
	b=MVGD7xjFUQ5qRNujvy2LzYhZu8AcG7TRVomoZhGdTSWYmR/nlkY1qtj/2u1eLD5I7/xo5Y
	ZV286W42fm1BH/SsHcPYJJDWG9UuEhruC/Q7crJJzRvtNEJloAL4Haqp4H38jdw72U2olN
	YqXr5sTLLriLLOZRrpLEuFyK45fz2KhZZgYNMZKClahXn8jOS/+9ouHbaa17YzXtF6eUGJ
	a0o83B/bRGG7TP8acEYSYeQp7nb2Y6l0VGBNvbSvUHJ3RjoZXW/gI8cYHzDNcaWI//9Mvp
	kbBzdjiuX9vEYPHiQ5Xz0bc+N0XzEMN7V626nh99hSp1TYJCS1K82AP/QOyHjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uhEx+dFtU5a+nA+flpSZ6OqqcO6apZEwjUbR4CHkMUI=;
	b=rbuVZ9Vl0MjvhCMZsxzbClAHC7JQ9rTw3CRwLiD4m3WuPDT5QPJQuerPYPDKcTYFOATCSl
	olbqwiy7yL2mUQCw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Preallocate all PAE page tables
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300499.31282.12749824705521273948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     454e65b4fb38ddeea62472649ef16b5e8d285015
Gitweb:        https://git.kernel.org/tip/454e65b4fb38ddeea62472649ef16b5e8d285015
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:41 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Preallocate all PAE page tables

Finally, move away from having PAE kernels share any PMDs across
processes.

This was already the default on PTI kernels which are  the common
case.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173241.1288CAB4%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pgtable.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ca07db5..f4fa8fa 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -80,16 +80,11 @@ struct mm_struct *pgd_page_get_mm(struct page *page)
 
 static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
 {
-	/* If the pgd points to a shared pagetable level (either the
-	   ptes in non-PAE, or shared PMD in PAE), then just copy the
-	   references from swapper_pg_dir. */
-	if (CONFIG_PGTABLE_LEVELS == 2 ||
-	    (CONFIG_PGTABLE_LEVELS == 3 && SHARED_KERNEL_PMD) ||
-	    CONFIG_PGTABLE_LEVELS >= 4) {
+	/* PAE preallocates all its PMDs.  No cloning needed. */
+	if (!IS_ENABLED(CONFIG_X86_PAE))
 		clone_pgd_range(pgd + KERNEL_PGD_BOUNDARY,
 				swapper_pg_dir + KERNEL_PGD_BOUNDARY,
 				KERNEL_PGD_PTRS);
-	}
 
 	/* List used to sync kernel mapping updates */
 	pgd_set_mm(pgd, mm);
@@ -122,8 +117,7 @@ static void pgd_dtor(pgd_t *pgd)
  * all 4 top-level entries are used almost immediately in a
  * new process's life, we just pre-populate them here.
  */
-#define PREALLOCATED_PMDS	(static_cpu_has(X86_FEATURE_PTI) ? \
-					PTRS_PER_PGD : KERNEL_PGD_BOUNDARY)
+#define PREALLOCATED_PMDS	PTRS_PER_PGD
 #define MAX_PREALLOCATED_PMDS	PTRS_PER_PGD
 
 /*

