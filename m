Return-Path: <linux-tip-commits+bounces-4403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D908A69BD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 23:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873C9188AE17
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DD21B9C5;
	Wed, 19 Mar 2025 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rca/ZsR6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAEVG1jl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5121B1AA;
	Wed, 19 Mar 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422321; cv=none; b=Ewa+5R9d/9D2OU7FVm778Nu0a8n3E8I4PDJmWCFhkW178igptzO3R6KsNwAMIUn0gYgbbeyrOqtoZXvr/LeqKiTKczpn2CukrNo3nkfQtSb//BARnrBhCo6v+CY0PrGpjylnAn5gTStjm7cox4jZ/zGn+ajxRGqMpYt29OBf7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422321; c=relaxed/simple;
	bh=PtT/y9CfyX6PGTbmPlYJM7rYXOOIobytABGXBuac8oE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hJzK4UVAmj6Ll0oS0skfBlFUd8SXZsH7pRb9daAaA/T9399flXa3wzOOHLF1uRy+fgvjuZhMwPtAJ6emrkiOS6rRuU0Lzt+ZGPbw+SP3x5MLSmxZfDvnJo4QSeoi268TTsNJtQaUtzDzCg19/Pw4wnXwF2YSiG8s4R3ffvgLftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rca/ZsR6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAEVG1jl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 22:11:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742422317;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1wgm22ACIApbBEyn1db+OiqsIfdgtbxXLlxZ1egcqI=;
	b=Rca/ZsR6JnZJcsJqjUyVYVPcgAwvSGGbIj12IOIBLGrpvlzX7z9ycoUmcDrB91LLQoXYMf
	XW3V1HYh3+s9g1cfdGMyc3MA//zWFm9AdH0lbwgnTjjbw7jlPKtl64pZ7fzWuCDw+6GsHS
	I25pvh91ETTae2ZQz+PBSrBZJKeDOUqXAFXWv8RE7FcganAZ6lLwOG6T2o1nkwvYVn3gQG
	ynXIp3IXnYsxZMfgLFribBkA3b+TGoJGnZHu6GSXIGt05Y9Gb2NALSj0r+NzZkyJXB4THv
	3FkNPO3AgNUWGKduDGNM+lnW7KU955mhCY8ndbRsRIMQqXycuQPNsHNcjLxXJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742422317;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1wgm22ACIApbBEyn1db+OiqsIfdgtbxXLlxZ1egcqI=;
	b=CAEVG1jlvHWud8t4BBX3gbXYIe7lDGBbX2pph3AJ9M8aXeQK+5w26js8gUZ555ynY74q06
	c823on4sSAuggYBw==
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
Message-ID: <174242231316.14745.5519157342087381003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     86049b4cf7a41cc5b33a556fc25772cc325f474f
Gitweb:        https://git.kernel.org/tip/86049b4cf7a41cc5b33a556fc25772cc325f474f
Author:        Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
AuthorDate:    Fri, 14 Mar 2025 17:48:18 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:37:32 +01:00

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

[ mingo: Issue a boot time warning to give VMs a chance to fix this. ]

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp
---
 arch/x86/kernel/cpu/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..4e6cf0b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -519,6 +519,17 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	if (c == &boot_cpu_data) {
 		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
 			return;
+		if (!cpu_has_xfeatures(XFEATURE_PKRU, NULL)) {
+			/*
+			 * Missing XFEATURE_PKRU is not really a valid
+			 * configuration at this point, but apparently
+			 * Apple Virtualization is affected by this,
+			 * so return with a FW warning instead of crashing
+			 * the bootup:
+			 */
+			WARN_ONCE(1, FW_BUG "Invalid XFEATURE_PKRU configuration.\n");
+			return;
+		}
 		/*
 		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
 		 * bit to be set.  Enforce it.

