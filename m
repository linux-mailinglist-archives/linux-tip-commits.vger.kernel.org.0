Return-Path: <linux-tip-commits+bounces-1586-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF2925F35
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 13:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872E51C220BE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358E13D61B;
	Wed,  3 Jul 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRLkTuVO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YedSxPgE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E3171E72;
	Wed,  3 Jul 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007580; cv=none; b=eAac+Qgg/cAVfFQKzAlQO89hlgIPMh7naBOG5HdUM9OpDeupKWvTd6z3uXUN/9djEjC50mtTPlpgyL5KR6YXtoUQZNUUO3Qa1wrgggiLCZxyhb0O7a2LNzLUp3omDDgsLeltu/PBHuPx4CvtEEgf2OZNekw0J0/neipGHLex/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007580; c=relaxed/simple;
	bh=4vyCU6ANbjrw1Mvh+Q7mHa7DTpcwVfqc+heLSYWaXoo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A3AdzQiH2IfgvZFtyKoL+OOpTRAYx03g5ycIz+WTxM3aOVwW72ul0nZrFdDybQtF0nz3L1KVEXN6lmtPxLIyTkSozJuGZgasNTMxdOgLITdG2txUh8qptRIFqiiXUla+c0gsXKKek1Pn9KUtkSN+MaiHgsAlixq8WlRZufI/yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IRLkTuVO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YedSxPgE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 11:52:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720007570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1P2TWzsZWnnZZh4FZTxVWZUPrceOOvWG4Mci481hOw=;
	b=IRLkTuVOiDSjujWowBfwlngBQsPyJ1ptrbAiztE1k0B2ey4c0pYLMBIhyPAYdxxDYf2/NZ
	879RwIbTkzD7FAAp9c+Bk9pDPxv6LU31Dn6LtYGjoprMhoDub9pGRlC9bBlJt+5c7sIApn
	KnEY5ksFn1MxtnIpPiJrdK+C6P3Kr+u9SEVphgEze8y1W77FyObNNGnrliCg3h2RxYtIej
	++Ef5hBuROv88odwQ6liJ6WS4LMhad9CK63TxpHIfMiCpibsjjWdXpyHEaKVbOqCLP/2J9
	tnmA8njiVdGJVTYMQYJB3oYz5WCkHUVB+3y0P6PLO+Vt9ktz7HqB86Vz/RueYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720007570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1P2TWzsZWnnZZh4FZTxVWZUPrceOOvWG4Mci481hOw=;
	b=YedSxPgEBZld3dIf80kywfarhFiy5VIkslR/2GcDmpClvhgNaDvFfuvcYZrC32N55O0O9v
	N/DLS/nOpPhQwnDA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/bhi: Avoid warning in #DB handler due to BHI mitigation
Cc: Suman Maity <suman.m.maity@oracle.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240524070459.3674025-1-alexandre.chartre@oracle.com>
References: <20240524070459.3674025-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172000756979.2215.11589165897193201369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ac8b270b61d48fcc61f052097777e3b5e11591e0
Gitweb:        https://git.kernel.org/tip/ac8b270b61d48fcc61f052097777e3b5e11591e0
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 24 May 2024 09:04:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Jul 2024 13:26:30 +02:00

x86/bhi: Avoid warning in #DB handler due to BHI mitigation

When BHI mitigation is enabled, if SYSENTER is invoked with the TF flag set
then entry_SYSENTER_compat() uses CLEAR_BRANCH_HISTORY and calls the
clear_bhb_loop() before the TF flag is cleared. This causes the #DB handler
(exc_debug_kernel()) to issue a warning because single-step is used outside the
entry_SYSENTER_compat() function.

To address this issue, entry_SYSENTER_compat() should use CLEAR_BRANCH_HISTORY
after making sure the TF flag is cleared.

The problem can be reproduced with the following sequence:

  $ cat sysenter_step.c
  int main()
  { asm("pushf; pop %ax; bts $8,%ax; push %ax; popf; sysenter"); }

  $ gcc -o sysenter_step sysenter_step.c

  $ ./sysenter_step
  Segmentation fault (core dumped)

The program is expected to crash, and the #DB handler will issue a warning.

Kernel log:

  WARNING: CPU: 27 PID: 7000 at arch/x86/kernel/traps.c:1009 exc_debug_kernel+0xd2/0x160
  ...
  RIP: 0010:exc_debug_kernel+0xd2/0x160
  ...
  Call Trace:
  <#DB>
   ? show_regs+0x68/0x80
   ? __warn+0x8c/0x140
   ? exc_debug_kernel+0xd2/0x160
   ? report_bug+0x175/0x1a0
   ? handle_bug+0x44/0x90
   ? exc_invalid_op+0x1c/0x70
   ? asm_exc_invalid_op+0x1f/0x30
   ? exc_debug_kernel+0xd2/0x160
   exc_debug+0x43/0x50
   asm_exc_debug+0x1e/0x40
  RIP: 0010:clear_bhb_loop+0x0/0xb0
  ...
  </#DB>
  <TASK>
   ? entry_SYSENTER_compat_after_hwframe+0x6e/0x8d
  </TASK>

  [ bp: Massage commit message. ]

Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
Reported-by: Suman Maity <suman.m.maity@oracle.com>
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240524070459.3674025-1-alexandre.chartre@oracle.com
---
 arch/x86/entry/entry_64_compat.S | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 11c9b8e..ed0a5f2 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -89,10 +89,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	cld
 
-	IBRS_ENTER
-	UNTRAIN_RET
-	CLEAR_BRANCH_HISTORY
-
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT and AC
 	 * ourselves.  To save a few cycles, we can check whether
@@ -116,6 +112,16 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
+	/*
+	 * CPU bugs mitigations mechanisms can call other functions. They
+	 * should be invoked after making sure TF is cleared because
+	 * single-step is ignored only for instructions inside the
+	 * entry_SYSENTER_compat function.
+	 */
+	IBRS_ENTER
+	UNTRAIN_RET
+	CLEAR_BRANCH_HISTORY
+
 	movq	%rsp, %rdi
 	call	do_SYSENTER_32
 	jmp	sysret32_from_system_call

