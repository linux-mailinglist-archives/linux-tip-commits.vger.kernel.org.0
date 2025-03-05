Return-Path: <linux-tip-commits+bounces-4018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C8A50DC0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD15188E50E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0A2594B7;
	Wed,  5 Mar 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DspcpWbk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQlwqaAL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DB25C708;
	Wed,  5 Mar 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210591; cv=none; b=DJi3hVLXPKusnmIw70CbcyE9xeD0lYfvTXHus3/qivmsG+8LaXIZrKkMQ/ZIJ7Vk5mGLnr9L/HMLOFubDfbUUk7r+LIJROy3OJkioS9tlaIcQiR+ovGdajIQu3V+aJsy5MozBu4yZ6gpZBCoaJATlNBw1dyh0SctQhaFCebCmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210591; c=relaxed/simple;
	bh=yFxzodv3oO5rI7OCWXK5kzmowoz41Q9YnXa0TM6sWUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kbir9oMFG56ysWeW6WrPODF/3gDOKJDWP1Znjv1KWKRVNT/xQBPGnY77cP7gyGEQsXrVUwMklmnH5GG7+hq79imfadZOmEDPR0XyGTOjKhrpQ1ibYjlJ+AhEqRz86RcALUxXPoYRxD+cKUKVO51cO/PuJOyZIdEI3AmmDrJOlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DspcpWbk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQlwqaAL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al6jj9wM2bLoqD39mb0M06nlm1JEG3RNv4H5FccnV/o=;
	b=DspcpWbkuX/Pm/dMV0e0OCpOhRi3xghwEjH4fQsGdMZfqn2kSc3f39l/mTkjxMCq00TFc5
	PpZXTe25EdjDJCywxklOg2dqHYtjTBuud+GSVf34qb9Zdn6GO1y8gd2HFbVOCn+KkjSunU
	J19S6LVuuT7scobci9OV39B+OKasOb38dEhnZ115+8UPg8bywV0OvgmQ8L8EjI7Sjs0ZLU
	bJKruDPoqpOSmYot3vj/aZnn0MZNs6LzXXDSKIW/cXVdQiJHd3Q1KkDthE6xu5PGkvhibV
	jiq4rIIzRl7Y4DFIdVBAhbP1Ahc9qjU8HYmsYuSJFMay1Sv5DetMKVTC+1eeuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al6jj9wM2bLoqD39mb0M06nlm1JEG3RNv4H5FccnV/o=;
	b=CQlwqaAL3t2q0MQTaTCQqifKxYKtdrtxkGVlA36xwXjjoyUL5Mt8ReNwJhqklCkK1V5KQB
	FiIElEnt83bbNCBQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use INVLPGB for kernel TLB flushes
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-5-riel@surriel.com>
References: <20250226030129.530345-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058638.14745.12144603412509021219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ccc19c694b0fe063a90dd27470e9f4ba22990ea1
Gitweb:        https://git.kernel.org/tip/ccc19c694b0fe063a90dd27470e9f4ba22990ea1
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:39 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:52 +01:00

x86/mm: Use INVLPGB for kernel TLB flushes

Use broadcast TLB invalidation for kernel addresses when available.
Remove the need to send IPIs for kernel TLB flushes.

   [ bp: Integrate dhansen's comments additions, merge the
     flush_tlb_all() change into this one too. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-5-riel@surriel.com
---
 arch/x86/mm/tlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index dbcb5c9..8cd084b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1064,7 +1064,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
 
-
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
@@ -1074,7 +1073,32 @@ static void do_flush_tlb_all(void *info)
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
-	on_each_cpu(do_flush_tlb_all, NULL, 1);
+
+	/* First try (faster) hardware-assisted TLB invalidation. */
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_flush_all();
+	else
+		/* Fall back to the IPI-based invalidation. */
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+}
+
+/* Flush an arbitrarily large range of memory with INVLPGB. */
+static void invlpgb_kernel_range_flush(struct flush_tlb_info *info)
+{
+	unsigned long addr, nr;
+
+	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
+		nr = (info->end - addr) >> PAGE_SHIFT;
+
+		/*
+		 * INVLPGB has a limit on the size of ranges it can
+		 * flush. Break up large flushes.
+		 */
+		nr = clamp_val(nr, 1, invlpgb_count_max);
+
+		invlpgb_flush_addr_nosync(addr, nr);
+	}
+	__tlbsync();
 }
 
 static void do_kernel_range_flush(void *info)
@@ -1087,6 +1111,22 @@ static void do_kernel_range_flush(void *info)
 		flush_tlb_one_kernel(addr);
 }
 
+static void kernel_tlb_flush_all(struct flush_tlb_info *info)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_flush_all();
+	else
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+}
+
+static void kernel_tlb_flush_range(struct flush_tlb_info *info)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_kernel_range_flush(info);
+	else
+		on_each_cpu(do_kernel_range_flush, info, 1);
+}
+
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	struct flush_tlb_info *info;
@@ -1097,9 +1137,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 				  TLB_GENERATION_INVALID);
 
 	if (info->end == TLB_FLUSH_ALL)
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		kernel_tlb_flush_all(info);
 	else
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		kernel_tlb_flush_range(info);
 
 	put_flush_tlb_info();
 }

