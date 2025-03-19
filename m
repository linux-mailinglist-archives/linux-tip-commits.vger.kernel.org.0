Return-Path: <linux-tip-commits+bounces-4332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB7A68A95
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088AA171C1D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9355254AF0;
	Wed, 19 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ne1V8hcu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3nzELvZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072E1F4CBE;
	Wed, 19 Mar 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382210; cv=none; b=HuZVuWGtZthUyVeXJm16EJ3SCtxeL61yFdenbta/HlVZWc1p2mSvMMH3qfTf9vX+8a/IsoA6ZSVm6SGjokQEF5B+OUsJ6+XcLW02mmByyYvqlzg7bvkyNdxT87QnruEvkEaqc/pbhPtilXmJEgsvAzSc7Y4UB4x2Je4K520qYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382210; c=relaxed/simple;
	bh=iDlECKMjhlX7lJ7nt+EnWRcTRu9ct/rwsblBoW+pBEw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pZhy6y9LEtC7Vrn6ivqf2nrY2tEw9NVJMXqa9pARi0pNKvkaaaP0mmGXQgeycF8KoBK5NxyOcFH3jrHbe0/RiYoihU4qsM7OTQZ88mX4scCKfOwgnEOizLOydIljQgO6z5b/8I3Phm5guhDofYraWATHM/mBPUhNwVBRij+KfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ne1V8hcu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3nzELvZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcHquKdt/hF5Iqscnf0lGihtb2Joaz6lIyMkEGoms9U=;
	b=Ne1V8hcuSdlIj1oRS77WCpw7zP7xSBJp3Q7QgyiQKpEh0cbqQCX6SfRgS6JQmqlwV85ZN1
	PayPLJ65nv6DwF45dYKxJKSylSoqsC02sXPlgqIM78nkyi3v+VQz7H+9PuvxB9Q4EywTVl
	SDKNR8VCAv8htIEeBYlotLH4T8lBw2Un+lsZe6+Vjk3WHzcSFFx6v9te4IEFmBkg+KtfrL
	aklyQZAc8d2WgiDEc40r+pAQEj1K4vh1wcHMqdtOFL7lG3Y2W7w1N9j8UhS9xc474wFztw
	DHwVcEEyMNM8kK76PDnzaySEUw06xGdTe6vnh9Ivu69NwAIyPIcbN27LujY6JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcHquKdt/hF5Iqscnf0lGihtb2Joaz6lIyMkEGoms9U=;
	b=P3nzELvZyTawWx4sM/No7nmmmabHgR5HZNJba1gwup2zs6jVHk1fbCrV70zREGmY3WyXAE
	h1M1qu1LBcIe5fBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Use asm_inline() instead of asm() in clwb()
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
Message-ID: <174238220611.14745.15730655446610951136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f685a96bfd7963a587c76bd5709f2d9170820875
Gitweb:        https://git.kernel.org/tip/f685a96bfd7963a587c76bd5709f2d9170820875
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 11:26:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

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
index 9b10bd1..6266d6b 100644
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

