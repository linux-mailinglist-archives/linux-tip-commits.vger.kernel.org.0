Return-Path: <linux-tip-commits+bounces-4483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610AAA6EC36
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E81896F3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD65256C60;
	Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPAtjdb+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbU8mVuG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E31EA7F5;
	Tue, 25 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893548; cv=none; b=d61FOkjfRqFO4uioJMFmNfUkVnr9oaPDfSN4g0Msz4TKIhKjucSDVhjN76FBXkfZQtQmuzgyjzqhhYh3SA5M+aEwsQSwnXZ/0RhwqGe3WYo9EAB0kW5rBEaDgZ9wSrTlr7+GnAEHMYb+wAsvlI1sWcpFMJjQ2asiAXV/zTBNx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893548; c=relaxed/simple;
	bh=9GewMnNf1XR+q+D8Z6NzBeUQRLLmfFAyWh9F1b6oPG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=luNMgCcVjPKfRk2JzpStAwF3uAX//Y95vyty1v+eV83IgovvqLkE8+04hDWfew01DGd4mZH5zWtLTKKI4WiL/V1IFZ4Vlub/nNmfv9Av3bPC4H11CeYtAVoOfEDFVv41sdN/3V0cOw9Iy5ha8FIopTsnCMkvLJmLxYEKrMzeU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPAtjdb+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbU8mVuG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnDng/8zItsgFjGZqQa15MDxU1lIjPb9u0Z4sNFEetk=;
	b=mPAtjdb+6v5BeLfEDHERR2WyFcfA+vh+6DsFDrgNCoj9BsEhj/SrUbAsfoNIlIJu5Q+iL3
	yFp1efGrsEeEGdEuUY06TIx3V+npWtaFaJMDWsGiRXZMDrQCB4eOxYiB+4fR7mcG92zATI
	aforDRO0A0kSTPAD8wttznH5rBrPGu6T+YbyX/gVOW5ofbEw43V0xLmQ5NULPAJ9lQHERo
	kKk4F8b0wU9kZ2yDrOR0ROeWV/L8CZea63NbYjrLhPBQ3tanuN4f6hcCtaDSZmF1hAorY7
	zENtG2BlGDiaxVEiRP925Lm92F01n29jqVy85XIL9X10uvxqpA9++cUGti94hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnDng/8zItsgFjGZqQa15MDxU1lIjPb9u0Z4sNFEetk=;
	b=fbU8mVuGrfrwwO2TDiba7c9sTDqnR2C1QkFUCDkljvkE+4Dzbt4FB5F2I0WpQ7El7O/f+S
	0YZZCfiDp+0ijcDA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Remove unused global variable
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-8-darwi@linutronix.de>
References: <20250324142042.29010-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354381.14745.4345397838691422962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2b383ca0896f0ffc24fd4d93440320d2dd5daad1
Gitweb:        https://git.kernel.org/tip/2b383ca0896f0ffc24fd4d93440320d2dd5daad1
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:45 +01:00

tools/x86/kcpuid: Remove unused global variable

The global variable "is_amd" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-8-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index f1dac5b..f268c76 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -79,7 +79,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static bool is_amd;
 static bool show_details;
 static bool show_raw;
 static bool show_flags_only = true;
@@ -559,16 +558,6 @@ static void show_info(void)
 
 static void setup_platform_cpuid(void)
 {
-	 u32 eax, ebx, ecx, edx;
-
-	/* Check vendor */
-	eax = ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	/* "htuA" */
-	if (ebx == 0x68747541)
-		is_amd = true;
-
 	/* Setup leafs for the basic and extended range */
 	leafs_basic = setup_cpuid_range(0x0);
 	leafs_ext = setup_cpuid_range(0x80000000);

