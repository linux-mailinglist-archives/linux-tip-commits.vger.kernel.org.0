Return-Path: <linux-tip-commits+bounces-27-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7129812016
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6971828227C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Dec 2023 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970054664;
	Wed, 13 Dec 2023 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+cuITri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlT+slEw"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2B99;
	Wed, 13 Dec 2023 12:37:09 -0800 (PST)
Date: Wed, 13 Dec 2023 20:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702499827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tdgEFmJtgiJ/hsWpMo64wL16sVk4He/t45frB5SOHw=;
	b=R+cuITriSuDmpM32izQ4dtf2ecIG7/QtBgWUJujQeiM2KLrch6Ytc5Fzmvt2NmJRfBpwfj
	PPq9GAbu+SCC6LxtEHhz8U2Uaaaa07H3t7nSsYlSKYmT/JGu8TDg0Kg5fv5d6gzgG2VU8J
	24D0tRrzwFP8/3jeYOsK/0iJT+HSBBSBsLrlXnnE1Fbq5KKNkTauhqioUJgc4nyE4WuSht
	epn6cLmGAWxu4GD15AXROHTZ3Y9BRfBno6J780UHGTPQtcyHA7A1HKALArmbgFBIAtMD99
	yjZYBoTThhz6ElSu0MVXWaKMCZBJ7WsU7BJ9y0W3ZMmtRCxb4ifa0Z0Mu0KyTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702499827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tdgEFmJtgiJ/hsWpMo64wL16sVk4He/t45frB5SOHw=;
	b=KlT+slEwlTUqXddfrYmCwENX1Vxkn9FkXTziZZ6+3CiQ+2VCoyNsd/YRLkAOZwGDVgVrW6
	Ay+9NHZMHWEdcbCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Do the C-bit verification only on the BSP
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231130132601.10317-1-bp@alien8.de>
References: <20231130132601.10317-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170249982674.398.5844405041679284531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     30579c8baa5b4bd986420a984dad2940f1ff65d3
Gitweb:        https://git.kernel.org/tip/30579c8baa5b4bd986420a984dad2940f1ff65d3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 30 Nov 2023 14:26:01 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 13 Dec 2023 21:07:56 +01:00

x86/sev: Do the C-bit verification only on the BSP

There's no need to do it on every AP.

The C-bit value read on the BSP and also verified there, is used
everywhere from now on.

No functional changes - just a bit faster booting APs.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20231130132601.10317-1-bp@alien8.de
---
 arch/x86/kernel/head_64.S | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3..d1dc39a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -114,6 +114,28 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	mov	%rax, %rdi
+	mov	%rax, %r14
+
+	addq	phys_base(%rip), %rdi
+
+	/*
+	 * For SEV guests: Verify that the C-bit is correct. A malicious
+	 * hypervisor could lie about the C-bit position to perform a ROP
+	 * attack on the guest by writing to the unencrypted stack and wait for
+	 * the next RET instruction.
+	 */
+	call	sev_verify_cbit
+
+	/*
+	 * Restore CR3 value without the phys_base which will be added
+	 * below, before writing %cr3.
+	 */
+	 mov	%r14, %rax
+#endif
+
 	jmp 1f
 SYM_CODE_END(startup_64)
 
@@ -193,15 +215,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	phys_base(%rip), %rax
 
 	/*
-	 * For SEV guests: Verify that the C-bit is correct. A malicious
-	 * hypervisor could lie about the C-bit position to perform a ROP
-	 * attack on the guest by writing to the unencrypted stack and wait for
-	 * the next RET instruction.
-	 */
-	movq	%rax, %rdi
-	call	sev_verify_cbit
-
-	/*
 	 * Switch to new page-table
 	 *
 	 * For the boot CPU this switches to early_top_pgt which still has the

