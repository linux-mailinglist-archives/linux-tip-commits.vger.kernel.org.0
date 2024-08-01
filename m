Return-Path: <linux-tip-commits+bounces-1899-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA79449CC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128BA1F21A6A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D991187861;
	Thu,  1 Aug 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9lk7YvG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Oy372cZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7101332A1;
	Thu,  1 Aug 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509736; cv=none; b=joSdExtAFMuCzSsns3toRPTqvJXdZnQFNh6vXI1xfW4kM/YzCgrHORRNnfi0WrVJS/nKFbesIDR5GkgydMbQzA3rKaWP2tVjxZztn7Lpbz+NihU9Z+oMQ3vD1O1VSYj9cKwonQ2EN7jhGuyJV8/MX/lfLxjOHR04XyyRgv4DVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509736; c=relaxed/simple;
	bh=CdwsiCMalTbSvZmEJxoAkmjQlItxLuyrt2cB0LCE8+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DAnhG1ZKeWV6Ce9VpJvF9VCOSds62zHw+TXsbWxtGW5lbM6vUcE27PMwud3XqUsLnnlIOrZbV9JI563iQ+26n2d2sLKM6C+cG2Vfo+Do8tdAZniHUdMbTsLPDEELKr32eu+/pT+PBqXRRrOa3nAg9Qs9EF5A3DlSA+CanXfiXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9lk7YvG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Oy372cZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 10:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722509733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRf0FChxEvNfyRCekrg+6XpcHZfdsxJpXUFRvME8YKY=;
	b=D9lk7YvGqVgTAi+dSZrsNi/FZ3GFsPNZ7UsKFODqAugMzrcrvefV+F9Z4x28zI90V4Hj52
	Y6kY96jbCb0NIlvaNvyr1JErSry6fwZheDzTubiS2VSekNkkrrO9FSYO1EupUwWs3bXiDR
	9KPjnGNILo8C6dOXX6gg6g4OFGyHjGO+vTBy4I9WHjoXio+so2E9jJLdUdMa7KG23Y+c92
	PhbypSxUMP3qFgjNwg1wjH0+jvu4EpCMh9WlmN7fs9iintAr/fUMhsQHJ6nmK1+UX08VZJ
	M97p5DP+kuR4J/tmVrmQRyn/PJr2IeEIkAr5HlnySiF/NmSKSNoHrrpfFYPpuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722509733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRf0FChxEvNfyRCekrg+6XpcHZfdsxJpXUFRvME8YKY=;
	b=2Oy372cZURPqkrOocIA9To2mhi9s6biK9K/s/nBCcvOQqggzBgqauRW06KoPj3GEPgfR80
	fuqiOwuuLLcnXcDA==
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
Message-ID: <172250973229.2215.8425940959520979454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     36e2dcf9840019de70e517a9df890fff316dd522
Gitweb:        https://git.kernel.org/tip/36e2dcf9840019de70e517a9df890fff316dd522
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 Jul 2024 18:31:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Aug 2024 12:48:22 +02:00

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

