Return-Path: <linux-tip-commits+bounces-4398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E357A69A83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E192F7B1EEA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372A21ADD3;
	Wed, 19 Mar 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJgMpks0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+NY87gwG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB621ADC4;
	Wed, 19 Mar 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418043; cv=none; b=XvyF/xZCnfZcuxMHFVFiuIwm7U5zAcyJNQq3zmtCNHdXfQHntJGisGSkGorkthZ34Ko26ida4tTZMBdSQkrJkpu4z3/YMuW0EuHO+xGW1C5BNxlb5U+8yEorBuRF9KyXH/agQAf2GXRhkuwlQZl7P/tZxo6SmLnA8inF/sjmQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418043; c=relaxed/simple;
	bh=X2RArXuAMmuAhauPZbKaufIB+X+wl1m4dN1NVnsFsLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jv2CYmUai4bdHT2WYIIJOccWfhUTkSDbaDQgY1UmDQxsbQNTfN0NrZ95X+3AHhmyZVJ2yno0uANgHzkn/uSfqbdWxXnpQeDo+jaX1Z3XkRGUEEPj7NjUVJr+d3hBeAOq7+hfJFr0M2ZaehhEwM/SXF06p07cvQsLZqf7DTA213g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJgMpks0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+NY87gwG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 21:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742418039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir8upkND02HSXe4wSidcVis+BSlqylVxwuVikBV4220=;
	b=jJgMpks0yY05lkgSRwRxUbV/SR+MCmvesW9eGucMO2cjKq3psUNJUT8UcnGoRFL7bogb3R
	XQ7CWHu5kCi61GcFVRGZREGqQSMOEbNeuwjGmWa7fz0W0xbsg4/0inQ0zvP6OqTo3GHl/6
	XON7R9v7otZkcG4X4VRdBMJVPt/sk7NnjSwYWh3tasrKcF7tL7nRdqJsTAdnbu80aRTc96
	kG3ZnlkJTFdBCWvETp6rB2BFwY6cxAYIgF58rueNwbMvGJ7nJjXwqcKUVZZXanHMUDcpwD
	TGXe4Jop5aRCnRYsXbmI93ABH7L4QKeaYUMJbK1YJwJvEzjpADRd05lkMHCSJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742418039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir8upkND02HSXe4wSidcVis+BSlqylVxwuVikBV4220=;
	b=+NY87gwGDohKc5puH7oQ8wG3IxEepz2zOIHEixdzBqczGno75ixytyuiJLU3pi5l3GQ8Wa
	hETYmPUJy5Dcc8BA==
From: "tip-bot2 for Akihiro Suda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pkeys: Add quirk to disable PKU when
 XFEATURE_PKRU is missing
Cc: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
References: <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174241802871.14745.6675007869652392275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2ae30fa4ee58535d122f79c6860fbbab87b20b06
Gitweb:        https://git.kernel.org/tip/2ae30fa4ee58535d122f79c6860fbbab87b20b06
Author:        Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
AuthorDate:    Fri, 14 Mar 2025 17:48:18 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 21:47:11 +01:00

x86/pkeys: Add quirk to disable PKU when XFEATURE_PKRU is missing

Even when X86_FEATURE_PKU and X86_FEATURE_OSPKE are available,
XFEATURE_PKRU can be missing on some popular VM environments
such as Apple Virtualization.

In such a case, pkeys has to be disabled to avoid a boot time hang:

  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
  (...)
  Call Trace:
   <TASK>
   ? get_xsave_addr_user+0x28/0x40
   ? __warn.cold+0x8e/0xea
   ? get_xsave_addr_user+0x28/0x40
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? get_xsave_addr_user+0x28/0x40
   copy_fpstate_to_sigframe+0x1be/0x380
   ? __put_user_8+0x11/0x20
   get_sigframe+0xf1/0x280
   x64_setup_rt_frame+0x67/0x2c0
   arch_do_signal_or_restart+0x1b3/0x240
   syscall_exit_to_user_mode+0xb0/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Tested with MacOS 13.5.2 running on MacBook Pro 2020 with
Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..5def904 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -517,7 +517,8 @@ static bool pku_disabled;
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
 	if (c == &boot_cpu_data) {
-		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
+		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU) ||
+		    !cpu_has_xfeatures(XFEATURE_PKRU, NULL))
 			return;
 		/*
 		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid

