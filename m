Return-Path: <linux-tip-commits+bounces-5556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F215BAB8D7B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F30C9E1EFE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39125A2C0;
	Thu, 15 May 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dminbUzs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkDAVFQJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B342571DD;
	Thu, 15 May 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329439; cv=none; b=KnZ5f9ZVBR2jIMrCMD+dsui9OJF3NENG1791l2PTzoTSfFnlbtiaaVheUr4bLMVooMEHMBa35IMZL/dx0cVq9tpvmlfRsDV82wmKnlMSGPrPk/Bm5BhNJjUGFbw74L5ULXoJ7sf4h+4nAKB2f9DLPXbyG9spYBAvLjXgBt038Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329439; c=relaxed/simple;
	bh=/CmgR/BeKbegcWFBuOXteK1BblZKwjsFXZTh8XvE3PI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJ2MWsixJHa4Omty9qkkA+y/X7m0V9SL7WVgGplXN3nFPTgEYBtF0Nt9Iv/vA65Km6owhLpqPrzzQd3QNdNhJHlHyQ2hxzIy5x3m87jmzJf9zMy+01UBnAe7OAyrDdYfwJa3ZDXM+Yq4SWcpj74Kre5wbwqGsX+pZKY0tMDVXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dminbUzs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkDAVFQJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iblZEk3+jIzM7xzAWy9XgL8yS0cnrQ7pMPyHYsOTPXM=;
	b=dminbUzslAXZtSJvADTJhM4AMm2qlC2V2j72Sl/LdO8cHV9yfuLbfhX6XgW7NLr76O59ua
	Gsjqy1u+s/eMbBUyia2g8E5vXmc/XIGkIbG0u7LsQ5P4Nx+eWaOQoR8C0Vdl9KizJ5jCwF
	R6b+fFjbGgcZmJEAhSYwsngWJY1HwVcN7QvCWjbuW7zTLTjWWUMIdYcqGEX9buhTukElA8
	4tNLC6RQfYGjBAvPeF47hcS3gdSdbSJExWpB369L+DOyhujXsyQ/qDVLbizkm7M5FpbdAf
	i8VcCuqkNG534F9BrM+7sdA7V3agsF4iP9xbPxykGAMmu8zqnaFoQk6/f6b31Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iblZEk3+jIzM7xzAWy9XgL8yS0cnrQ7pMPyHYsOTPXM=;
	b=OkDAVFQJj/U68dYnQtbzGxzkz8J94RT6umYcveWqfBBbNm2EQxy1CABp+uy+TEZ9GSwf0W
	oAIwz6vApr/xb+Dw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cacheinfo: Rename CPUID(0x2) descriptors iterator
 parameter
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-7-darwi@linutronix.de>
References: <20250508150240.172915-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732943520.406.17897590489687675996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7f6b49644c6cadd9682075bc2dd6a1ba2afd55d8
Gitweb:        https://git.kernel.org/tip/7f6b49644c6cadd9682075bc2dd6a1ba2afd55d8
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:48:10 +02:00

x86/cacheinfo: Rename CPUID(0x2) descriptors iterator parameter

The CPUID(0x2) descriptors iterator has been renamed from:

    for_each_leaf_0x2_entry()

to:

    for_each_cpuid_0x2_desc()

since it iterates over CPUID(0x2) cache and TLB "descriptors", not
"entries".

In the macro's x86/cacheinfo call-site, rename the parameter denoting the
parsed descriptor at each iteration from 'entry' to 'desc'.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-7-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b6349c1..adfa7e8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -381,7 +381,7 @@ static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
 static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	const struct leaf_0x2_table *entry;
+	const struct leaf_0x2_table *desc;
 	union leaf_0x2_regs regs;
 	u8 *ptr;
 
@@ -389,12 +389,12 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 		return;
 
 	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, entry) {
-		switch (entry->c_type) {
-		case CACHE_L1_INST:	l1i += entry->c_size; break;
-		case CACHE_L1_DATA:	l1d += entry->c_size; break;
-		case CACHE_L2:		l2  += entry->c_size; break;
-		case CACHE_L3:		l3  += entry->c_size; break;
+	for_each_cpuid_0x2_desc(regs, ptr, desc) {
+		switch (desc->c_type) {
+		case CACHE_L1_INST:	l1i += desc->c_size; break;
+		case CACHE_L1_DATA:	l1d += desc->c_size; break;
+		case CACHE_L2:		l2  += desc->c_size; break;
+		case CACHE_L3:		l3  += desc->c_size; break;
 		}
 	}
 

