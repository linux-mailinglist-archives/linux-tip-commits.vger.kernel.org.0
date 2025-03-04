Return-Path: <linux-tip-commits+bounces-3981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5DA4EDA9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81051894237
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA925FA0E;
	Tue,  4 Mar 2025 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1jgCh0N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWAbr7xd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4824C06D;
	Tue,  4 Mar 2025 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117435; cv=none; b=gemW9qq52iQvyVLMeN5VuFyk+nC4hvFTawr4VRk/ztp0ho3VGvckifx+X0u2dPovPt6pYbhxUyMAb+472cfwA3ctMPgn+e7gh0YmItkW9QACW388Dbibq1lhMCGej1pAJwJDQplVQ5wN1QgHFC5l5yMk+2b8ZCmVPtweN17VmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117435; c=relaxed/simple;
	bh=lzBBzLTs7ggGlsrXOGUScDSTY8t0LEkcvXKHFLQYu44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m/5hc3jZ5qt4V4JsB1BPQF224xVHd8Rbx/2c0J8UPxkYpUEJbJJAmhMQF6DKqCX4Hl85531pK+U+2Wv9qNCksGRO1Qsi5UpF4MwrE1YpZWpPlqf72vM1D8HDcMgaLRyp/ROAnFIe96jKnxzwv9zpKtko8P2tXN/IAOaf0BuI6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1jgCh0N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWAbr7xd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741117432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPSmtH0LvbGMOwEsYU9qagSinArtdRPYA8/wEMInrzk=;
	b=Q1jgCh0NcMx+hOmTXXZs6iUDetm0njT9LfLBgvaUM3ZEhazQESN5bFDIyGgbPjNMWCQvr0
	rlCYLC6noVteIcRaNXVu4vNehqpqXdbCAK5w6BMK+oWiXNF+uAXyB399G7yyhn5zgcz6qf
	4hiXHsYSRa9b0opdWPv+0tLtlrFrQODEGzcM2VJHrCAEwiXhBvoASlwEWpZlMgrqL/u6tN
	9wdHNIfKHT4EQSmThWd8rLTd4HGTv9csDoMa9Z/TlOVILW2zR0VokFVpvhJUF8OGojGs4K
	Y0wlmOAlMYxKTWRg3S6wltUrnTPEKrjTU0Ildls6H7REvxpvWmn3f1CGGQaF+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741117432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPSmtH0LvbGMOwEsYU9qagSinArtdRPYA8/wEMInrzk=;
	b=rWAbr7xdRTuRD5EZw2KVeXTZIm83IBla9R1pOD8eCArLmO0VGBnro9vMaL+5HWzzXL+Y2e
	losiBJJM/OKoo/DA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/stackprotector: Move __stack_chk_guard to percpu
 hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-11-brgerst@gmail.com>
References: <20250303165246.2175811-11-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111743160.14745.15920633113743300715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f3856cd343b6371530c9af3c97354cdc003f3203
Gitweb:        https://git.kernel.org/tip/f3856cd343b6371530c9af3c97354cdc003f3203
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:30:33 +01:00

x86/stackprotector: Move __stack_chk_guard to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-11-brgerst@gmail.com
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb58..cd761b1 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3f45fdd..5809534 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2147,7 +2147,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif

