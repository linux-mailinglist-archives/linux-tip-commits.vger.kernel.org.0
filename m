Return-Path: <linux-tip-commits+bounces-4168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73883A5E47E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2DB3BD391
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306F2500BE;
	Wed, 12 Mar 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9iIs46N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zj9AhqC+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AF1CCEC8;
	Wed, 12 Mar 2025 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808006; cv=none; b=IOTkh+O0eQmVLvMuuFgKdgnhDs1dDtYyfqw2AJ4LFKgo5f6JMZyJ33Y3hHeQNfXcZ/wn4wKm+zQKkKMKyiEzetwNKYq57BqGqwfwfVvgSIQGVYNc0qi/C4j7BqpkOFTOBBHC26DboUUfVB8d9sPmh2cIqRonjG0ndx7R+J1x1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808006; c=relaxed/simple;
	bh=7tJg4mI+oLE9z2COkN//pCKDg5WUcAlBEljaJuJSXkg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jb7crtSNlXsax2PBu1saH877U/MamSeQUEpq+fkZ/X7xrETrHbHjrCEGr8iFiZol2lolWVtAfV4EkSSHz5PIzrmqnpKhNh5q3kk09fQMGExAfyIjebxvoIWDQe75/Qw3ih42EdtOAkqBpGI9RRckEMsW3HnLqTLdpiYJhtaeucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9iIs46N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zj9AhqC+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 19:33:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741808002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmvcWxqFwtQEJyL/CIdKk3lGjOpO4/62ZCO8Rh8gr7w=;
	b=a9iIs46NjOuRl3VZEf0e19VQQ8Q2DTd4CcUYbjT3jxZ9VNeTQBD6JlCnT6GDPCnlwXWXmf
	D1p238fOe2jkJbMoDyJIR48J1En3LCZJUVLAvPx658HhdR4oTGotOgJ4IvpUEEfa7mw+SV
	oV9n2urUe5AEnrOxAfo2d0Y26MHP96HnguWBF/AAv2uKrPYi34veqQE0l3hFxYRHNHnlJI
	4RIirU7mgfoHNOWfV7ZQcjR02LSEbLHYBvS7hRXXebX5MBrP3CCwKhlOecBFU93b4pDsV7
	uExFGNtpo0ke9MGlrnuuVFY82mJ6MczV1XaA8sZFUOJGc7ZGHJLRNRE+4Buadg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741808002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmvcWxqFwtQEJyL/CIdKk3lGjOpO4/62ZCO8Rh8gr7w=;
	b=Zj9AhqC+3ckmA0SR5TAltIoxVLe57tJJfNcfhcaubuCjDjuXG6Z21WIpQViq71G0SelKEX
	nULsumndLmXLgoDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/hweight: Use asm_inline() instead of asm()
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
Message-ID: <174180799888.14745.11611901252812259483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3aeb02062eae312550be0d4344466d0bced8c8ad
Gitweb:        https://git.kernel.org/tip/3aeb02062eae312550be0d4344466d0bced8c8ad
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 20:18:29 +01:00

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
 

