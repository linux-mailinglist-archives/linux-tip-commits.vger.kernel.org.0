Return-Path: <linux-tip-commits+bounces-4176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2220A5F1C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A7316A82A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95157257AE4;
	Thu, 13 Mar 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10fV8290";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyD+aO15"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2141EF084;
	Thu, 13 Mar 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863749; cv=none; b=J+/OaXibRWMIj2LNK3zHYgyVOr05SnG5MBJLrwMXQoh29eSBd/mllwWWdSz63e9pyZmKtsiHTKR9rAVtWYIJ/aP272SBoBzYywNAN6bog0YXGyGwI/hp875nLC/iEleKQFqJkHdnCaWBF91W3o0gnUIfQcWIJyYoQOu3j8XGOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863749; c=relaxed/simple;
	bh=gmd+vFJn/CIq5D1WGFAbR1IkJcgk/J79zaFkakN2rNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uk1fmYg02//OksyTcN53H2lxiu+UluXvj956zL/B3b8Hxdj9xdoROwhkCAzgt4uVB6nyWroRFGn9pJsJlw9d2z+qRmTm4PP+Z14gJ7YJJKxFyN8Khz01J4tUiKJq5kTKjXY3zV9ESjiUk0y4/TECpoL7fOffNrk8Y399T4IeN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10fV8290; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RyD+aO15; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741863746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGaiGM/YpXVS342vHkME08fQn1Vtg+sQcj7Tsw5pmrY=;
	b=10fV8290jPA7G/HF6qV21uvO4Tnw9VBkI+EHPtFvRLyGM/rV5EEqTayQegwauxMoVDgmM/
	iLxtFZN95l+I2DirKOQF87vIBQgCxB5MpzHdpxje7GPi1UmtXjSo33VpHunC99UHSRsze9
	8dk6mHTA5l+PXtO5UrHoiyeAYMP1VCA4Jb39A751ZjOzrB5ndQ/Yh2pp0n3/o4BRT9y23A
	EfRY9vwZQvvRI3pd0nqlbtqqyEC0GWnfwYlYPUYg7Ek8bSkAPMyYtV5CfpZc/Gx0p4k5lb
	oBwdzZZh9R4E8IQcNRex91tj+5vN34/IV5XBKZuQrIcNNgeuDNKaPmRKJgbnIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741863746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGaiGM/YpXVS342vHkME08fQn1Vtg+sQcj7Tsw5pmrY=;
	b=RyD+aO152Fxywma2+g7+Wsha1bwU0g/F/ZHkr/bGSkMRGks4T99sz3zGT7tgBlyL2+RtUS
	ZlLmyMwV/zqDpvDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Use asm_inline() instead of asm() in clwb()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313102715.333142-2-ubizjak@gmail.com>
References: <20250313102715.333142-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186374489.14745.3324838262167564569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6e9e4961767b76ec67268c991ae90116ce76cc70
Gitweb:        https://git.kernel.org/tip/6e9e4961767b76ec67268c991ae90116ce76cc70
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 11:26:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 11:50:14 +01:00

x86/asm: Use asm_inline() instead of asm() in clwb()

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports slight increase of the code size
for x86_64 defconfig object file, compiled with gcc-14.2:

  add/remove: 0/2 grow/shrink: 3/0 up/down: 190/-59 (131)

  Function                                     old     new   delta
  __copy_user_flushcache                       166     247     +81
  __memcpy_flushcache                          369     437     +68
  arch_wb_cache_pmem                             6      47     +41
  __pfx_clean_cache_range                       16       -     -16
  clean_cache_range                             43       -     -43

  Total: Before=22807167, After=22807298, chg +0.00%

The compiler now inlines and removes the clean_cache_range() function.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250313102715.333142-2-ubizjak@gmail.com
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 856d4ad..f5a8ff4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -185,7 +185,7 @@ static inline void clwb(volatile void *__p)
 {
 	volatile struct { char x[64]; } *p = __p;
 
-	asm volatile(ALTERNATIVE_2(
+	asm_inline volatile(ALTERNATIVE_2(
 		"ds clflush %0",
 		"clflushopt %0", X86_FEATURE_CLFLUSHOPT,
 		"clwb %0", X86_FEATURE_CLWB)

