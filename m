Return-Path: <linux-tip-commits+bounces-1900-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD529944CBC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615DE281954
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394401A3BA7;
	Thu,  1 Aug 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BNggRUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEC8FGyd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF8196DA1;
	Thu,  1 Aug 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517438; cv=none; b=DBZF+MoPziPhXa7qGg9kgDGGfxLMi51dNV7BnD1OV1doUHxSR7wQA20FPpPDApz9mcQPDoTV4mPiiWNklO7TclWMSG2E86bnNAyPomaIYQ1bCmbqpMkEgB1MzXSAZAPfrBatgyRYRYmeWWIA5yYTdK7v4S4tdk/49t/OchZi1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517438; c=relaxed/simple;
	bh=dAnYnOP+k5yZIiN61+gLuV6ApuRu/GLddOxZrDHSqqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DjfClP5kVE3RjDutBzT+k9UMf1XC6EN0IOZQMtg/bOrBCEkO56fFFlLt3eEuF5kuRE7xgkTG5NijttX66MPINGaS9DsR/76rJpxnKKcpmmU2hd6BIUh+/ZpDAIYv+tHhV2AmgZJ0gIMEgv8SZfc5rmj7pMa8QR0tUzc9nt48KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1BNggRUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEC8FGyd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 13:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722517433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Antr6tCQMkLGv2iNaBPBr5/gbn8+23EmQuDKsOGBvgo=;
	b=1BNggRUYvqBYIHFiMY4DwJ4mlKK1LqaOyiQENoIubb98FQtq47jT7M0mRXTekHrr/Chbup
	hS+8pMS4DQwXrlgT3RaHQqrpaezmXLIO4SdU0d1DDckveHCJyxPuss64Pq7DILWkwWoynA
	s0tkoZWiYk3AIuKoAUFNU2bAKqFjp06R5faTh52iFLRwBjbT5IEoygWC6WF+A8AAoHsjpY
	NLcq6G/p7xptg6ZLdCRG+h7gyr+D0X2VPeoFi6sweZNJ87PwUnydiUj2QFUpyIuyhPcV/2
	O7qnxCIR8R2ZMMvPZUaVqGBKRq/IyxbdE0k1JbEJaBoXejH74o+KlRO82V2H2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722517433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Antr6tCQMkLGv2iNaBPBr5/gbn8+23EmQuDKsOGBvgo=;
	b=GEC8FGydmm/Q7uClulyKcqcDTrzde7QUhtu2KM6B63ZNE1gKJ4BoK3DryHkRK/U6wgWPA/
	/VUnLwgOI6c+DODw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mm: Fix pti_clone_pgtable() alignment assumption
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731163105.GG33588@noisy.programming.kicks-ass.net>
References: <20240731163105.GG33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172251743275.2215.17864731410820647469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     41e71dbb0e0a0fe214545fe64af031303a08524c
Gitweb:        https://git.kernel.org/tip/41e71dbb0e0a0fe214545fe64af031303a08524c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 Jul 2024 18:31:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Aug 2024 14:52:56 +02:00

x86/mm: Fix pti_clone_pgtable() alignment assumption

Guenter reported dodgy crashes on an i386-nosmp build using GCC-11
that had the form of endless traps until entry stack exhaust and then
#DF from the stack guard.

It turned out that pti_clone_pgtable() had alignment assumptions on
the start address, notably it hard assumes start is PMD aligned. This
is true on x86_64, but very much not true on i386.

These assumptions can cause the end condition to malfunction, leading
to a 'short' clone. Guess what happens when the user mapping has a
short copy of the entry text?

Use the correct increment form for addr to avoid alignment
assumptions.

Fixes: 16a3fe634f6a ("x86/mm/pti: Clone kernel-image on PTE level for 32 bit")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240731163105.GG33588@noisy.programming.kicks-ass.net
---
 arch/x86/mm/pti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 2e69abf..48c5032 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 */
 			*target_pmd = *pmd;
 
-			addr += PMD_SIZE;
+			addr = round_up(addr + 1, PMD_SIZE);
 
 		} else if (level == PTI_CLONE_PTE) {
 
 			/* Walk the page-table down to the pte level */
 			pte = pte_offset_kernel(pmd, addr);
 			if (pte_none(*pte)) {
-				addr += PAGE_SIZE;
+				addr = round_up(addr + 1, PAGE_SIZE);
 				continue;
 			}
 
@@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte = *pte;
 
-			addr += PAGE_SIZE;
+			addr = round_up(addr + 1, PAGE_SIZE);
 
 		} else {
 			BUG();

