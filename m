Return-Path: <linux-tip-commits+bounces-2981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86139E557E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB43A1884439
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002F218EB5;
	Thu,  5 Dec 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/mOcu52";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1a4GW2nG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71F218AC1;
	Thu,  5 Dec 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401697; cv=none; b=MvwRhxFfB5DO0mzrL5427r0/bqEvIz6ADP8FNLcjAylpE9RvQgxiZahU78cZdwTQRaAYrFXLrbaf3SRHr+17mv1CDuxT/d4atKzHyvHykN4E7ikJpx4y2WvJ+Dh9btykcSOFl6qIgA5CIsfnE12YvmVMI3ps7IVKaE0iL4R1534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401697; c=relaxed/simple;
	bh=tdDH5pEIqjNP1IJukpVxg6F0wQuvE8RGgO5Ayz2INBE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FYDyUXsv6qbPeWJvNVwCYMdjoGAD1ZltCgV8FaLx5jJv+pPaLOWqeVrM+eUSmHqeICWojju9FI6/JgSsKUS4SVIlNtuRqWU5gR5M4Lk18XLaPJpAcCC2a5x/H+AtHAjLu6atoSSYwCb6NhTB7zhuOTtNBnbdZQ6nwLq//3l8r0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/mOcu52; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1a4GW2nG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRQ3nX6TYvj16dD5YFNicRt6nYI/MT5Yjewj8JBrFuU=;
	b=G/mOcu52sJkC+a3Aw6+bVH/rYtQgsd7j340EtQCKH/GVDuWxZU3UNtQbZI3oFUVzC6tM00
	bGzhHZBQTxQJHmml4GtF1raMSfSJ9bgkWR+GZjctheg5TW1t2iX9QZo03xfWwA64T+g5+F
	bMJzakkSeJEi6pcuEAKkGN2+WtEcnNMU0DRhNQPLYgmYKAwuo4eprfuOnCStouGiLd/cKU
	qZ0tdIlWewtuzHJpUQG1Qo9tfaQ998N+22JxnCN5h/KN/VQu0mNMrfbcL3JBV1RwDFcBmE
	Jyv3f1RmfNbW71+bpl708BG9jwPki9GJrsUouCUQrGhqLH6snecmwu+vRuQDoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRQ3nX6TYvj16dD5YFNicRt6nYI/MT5Yjewj8JBrFuU=;
	b=1a4GW2nGS96DKZXGq+qyJw1ygDevRkd4LqWilNv6NbLW6YAFWpfuPIC2MJGgYQXvG4Xhhz
	0F4xB92Yoc/bQVDg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/sev: Avoid WARN()s and panic()s in early boot code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-10-ardb+git@google.com>
References: <20241205112804.3416920-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340169364.412.10393076400350306074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     09d35045cd0f4265cf1dfe18ef83285fdc294688
Gitweb:        https://git.kernel.org/tip/09d35045cd0f4265cf1dfe18ef83285fdc294688
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:54 +01:00

x86/sev: Avoid WARN()s and panic()s in early boot code

Using WARN() or panic() while executing from the early 1:1 mapping is
unlikely to do anything useful: the string literals are passed using
their kernel virtual addresses which are not even mapped yet. But even
if they were, calling into the printk() machinery from the early 1:1
mapped code is not going to get very far.

So drop the WARN()s entirely, and replace panic() with a deadloop.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-10-ardb+git@google.com
---
 arch/x86/coco/sev/core.c   | 15 +++++----------
 arch/x86/coco/sev/shared.c |  9 +++++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148..499b419 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -777,15 +777,10 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 
 		val = sev_es_rd_ghcb_msr();
 
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
 			goto e_term;
 
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+		if (GHCB_MSR_PSC_RESP_VAL(val))
 			goto e_term;
 
 		/* Page validation must be performed after changing to private */
@@ -821,7 +816,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
@@ -2361,8 +2356,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 	ret = svsm_perform_call_protocol(&call);
-	if (ret)
-		panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n", ret, call.rax_out);
+	while (ret)
+		cpu_relax(); /* too early to panic */
 
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
 	RIP_REL_REF(boot_svsm_caa_pa) = pa;
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de531..afb7ffc 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1243,7 +1243,7 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
-static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -1275,12 +1275,13 @@ static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 
 	ret = svsm_perform_call_protocol(&call);
 	if (ret)
-		svsm_pval_terminate(pc, ret, call.rax_out);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
 	native_local_irq_restore(flags);
 }
 
-static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+				     bool validate)
 {
 	int ret;
 
@@ -1293,7 +1294,7 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
-			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 	}
 }
 

