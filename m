Return-Path: <linux-tip-commits+bounces-4391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28213A68AFF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D117B16AFF4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A67266B63;
	Wed, 19 Mar 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymByg8me";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OEHGWtL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BF263F5F;
	Wed, 19 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382251; cv=none; b=BiYj3RNIOsO6RbT3WUmhjX+om8hyVxUdosulnUJjnsETWeGE/9iiv/pYHgKM2+3IcSOQzhYnA3cfErGhSI/F0nD65nlalCXERlVgmG3swcTuZebR75XbT7AcA+gRzMO+oGYZP6jhtHyyaZCf5CmaiF9neYJ4HtzdNo5MbGxyru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382251; c=relaxed/simple;
	bh=+JB2WcmQ1AUhRdZM4JPD/AEQRjdZpLzj3BDysQS8L5Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hwxFRi/KbpvaOe597Jbx50gr0dMoKRGd8fKztiznM2W6njmEUfdyfxt2JMLy26+5U88/+8XB01W+1NFPU4da8bFJw9seNwC89rqkieqED4WJ3/zGw+ZD5k+HjB7iVtKHy2S/Hj+2W2sIj4BruZ2W44mXE9nfZT2wZ/trbZGYK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymByg8me; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OEHGWtL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UktUJfB6CtWEi9c1SdaA9ck7mTIXVHNaOPBwQcZ3Pyw=;
	b=ymByg8meKsGeaZDWsDDDG02C+dLHktQunlrytCxiVeE8AohEUh4GREXoaF0GvAUMTAbgKz
	mhSDZ9jikuTWnaBKzTK4iKIjwnr9i7y+yNUT4jm0F9N3/EFjooPrVMts8zVnEg1TIeYc0B
	IITSh2kwtZHYBJHn+AcufgsfagPRPorI5EDjgowX/bVkGdg0pHfIZnvftyxXSP5z4Pkaea
	eK/Dkl+6by8zfqUfCxiKWB7Lixn54SmQjF8omycruMxZt7oW0Ljh6n56DP8/usFbFs5YVN
	YT8s7C4pTJZcjZ89bt0sMEUhoFaB8QxOdM98I8O+4HpGIm2+8Mjr5xA1Ii131Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UktUJfB6CtWEi9c1SdaA9ck7mTIXVHNaOPBwQcZ3Pyw=;
	b=2OEHGWtLOWOgLD9DCL4AFaEncSRLWqRCpk/a8vLPawCnH380HdHZB20XYs2QSg2FKxzqjI
	OW0DMjSIBFcN7KCQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Use INVLPGB for kernel TLB flushes
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-5-riel@surriel.com>
References: <20250226030129.530345-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224641.14745.6125284611845723280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     82378c6c2f435dba66145609de16bf44a9de6303
Gitweb:        https://git.kernel.org/tip/82378c6c2f435dba66145609de16bf44a9de6303
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm: Use INVLPGB for kernel TLB flushes

Use broadcast TLB invalidation for kernel addresses when available.
Remove the need to send IPIs for kernel TLB flushes.

   [ bp: Integrate dhansen's comments additions, merge the
     flush_tlb_all() change into this one too. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

