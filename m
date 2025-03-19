Return-Path: <linux-tip-commits+bounces-4334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249EA68A9C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB564424136
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E312255E26;
	Wed, 19 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chF0Lk8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHgQm0Vg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D06255258;
	Wed, 19 Mar 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382217; cv=none; b=QPIILAgZ8p5gK90LQW6NHSTT+Bmi9wZtrKiz/z5X9Byf9hxKYGVX8TXFWuMbq+Yz2ZGUnaFWaBBCh3eukWdfKV7U9yxB66aQ27bc7mPf6qgffteuRpBba/vnohvZIu9x9UVriHshQK1zdQ017GAJUcNaTIZ+b4+XwEvQMRcmRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382217; c=relaxed/simple;
	bh=JDAg48wgFS9+4uQfdksXFtscJ+HV3+b2Mx2xx01YfMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aO+85ziSylk/pcHrbefGLCF2lvJx3pMhVEHXEVjgWhZlsjsrJYMWBn9YJdsda0fRvNgq5uyKs09GnXxokflhXXZOUutW04+MV7PKUbRyP9B+8fu4O0xuNWAz8DyAiQaEv41m1Eb0Kx6X4qAfZfstju7bvQbu+9nb2EeXKhj7Qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=chF0Lk8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHgQm0Vg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWOtu/5tvxcyIUW/iucSXn+vIMEPpLX/rK8GkjNz+TI=;
	b=chF0Lk8iMdVWJCr4bzrhWVTscvtTHaOSwuUfUT9sYmVbKy+N3b1c6RJqZjxldaI6rwn2Do
	FW7krZNU6g+0/xy1ZUS/QYLDDCtAUom1xPbSfuvk6J/7JMNIW6lsY94suYC9EVQ8Ke3YtV
	yHC1fvCJFO1I9sFSfREfUQNetryvIFo51bUZxXY1eo6zQ0tZenw/DsFNYuKxLk9493/zFg
	N8ftN9IIO3TPC48xBdO+QkBKeqBbX9Qy9Qb7PQbhf5i2kHgtuYip2PSx29LuOBQTLmn8e0
	XhAkZNsvdQ7cAcEEfXCdSjEfRFRUCh4P511mq6bPQ2PUaW/DWGv4XWKAjSEyYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWOtu/5tvxcyIUW/iucSXn+vIMEPpLX/rK8GkjNz+TI=;
	b=RHgQm0Vgt7ppy33TQBS9UkZTev22ia41eK2wQVSmy8C/vfrfihtf+mnzI1S7HU3wV+EIJm
	lHgBpa8azyNwvDCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/hweight: Use asm_inline() instead of asm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312123905.149298-3-ubizjak@gmail.com>
References: <20250312123905.149298-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221280.14745.13329339067414098293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     21fe2514849bb4de05fbd098e311a87de6a62d4b
Gitweb:        https://git.kernel.org/tip/21fe2514849bb4de05fbd098e311a87de6a62d4b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/hweight: Use asm_inline() instead of asm()

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports slight reduction of the code size
for x86_64 defconfig object file, compiled with gcc-14.2:

  add/remove: 6/12 grow/shrink: 59/50 up/down: 3389/-3560 (-171)
  Total: Before=22734393, After=22734222, chg -0.00%

where 29 instances of code blocks involving POPCNT now gets inlined,
resulting in the removal of several functions:

  format_is_yuv_semiplanar.part.isra            41       -     -41
  cdclk_divider                                 69       -     -69
  intel_joiner_adjust_timings                  140       -    -140
  nl80211_send_wowlan_tcp_caps                 369       -    -369
  nl80211_send_iftype_data                     579       -    -579
  __do_sys_pidfd_send_signal                   809       -    -809

One noticeable change is:

  pcpu_page_first_chunk                       1075    1060     -15

Where the compiler now inlines 4 more instances of POPCNT insns,
but still manages to compile to a function with smaller code size.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312123905.149298-3-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index f233eb0..b5982b9 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,7 +16,8 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+	asm_inline (ALTERNATIVE("call __sw_hweight32",
+				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
@@ -44,7 +45,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+	asm_inline (ALTERNATIVE("call __sw_hweight64",
+				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 

