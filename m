Return-Path: <linux-tip-commits+bounces-3152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B599FE961
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFFC188248C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375471ACED9;
	Mon, 30 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O57qpWoQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bvqgozr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5311A9B54;
	Mon, 30 Dec 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579291; cv=none; b=HaIVnm2/8kPDsjuVguIJdYzqLPznGVbRn6+waeSv5v1ZTkKsRNGU6dj4vY9HHIAAOEsdo1hJq4TNha6eZmr1KaJpe0DGpNGkWaHJLzVmE2UWDIqzY4BwLykYsYx0E8vnsRcg5+soqx7do0y7OaC0rQ1yNsXgYQJYNEpRexA8oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579291; c=relaxed/simple;
	bh=fkfqAy/jouH9Ue2KNMDeMKFmIPAoUyAKDw47LU2pB9o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iiLBfhbjdFrAs5Zm+wJc5pvMK0Lov0Gqz3OOvIHhtP1pxm7rlAtEr6d1/Agf/FmedU7QfKTLseQvxqnSmCDVoKYv463u3szAfvhndTM6jBXMSAKIvf4M5wlbcfbT7jtlKXPc8QrIqkVX/mPCD8JFomIwO8nmxajaKFFcdOuKObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O57qpWoQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bvqgozr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Dec 2024 17:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735579287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IxiIiQpyDpTJMHHbijX6hDlOU/XVJ/aDD2yDdaob6o=;
	b=O57qpWoQGF/tHf4Mb1aFUSCky/v36znsGRu7HLZyXQ2/LiGAk1qzJMIJZBJh76rMsJMcIf
	JCk7+tTMGatL1rB2/CbSg2IiX3Jmyuk7vstnpp3pY5upXKyrP2duoQ0ZPJfHuSD+Uy9+rg
	betaPZILby93JwO/wptEj+OqDPqw+cUSaLgfF55teEUqoWaBb+vFUPvM8Muray1HdgtyeX
	tDzu6kNFPSqBJYaDV9juh2uvC/SMK7ShvXT/Q4r5XCVzSu3rYTx07/FejibJhd5d5TW/g8
	9X6yRRF3OMlTKKIdYPB1+pzkLpFyNb9PiSs4SOCx+9KF/faU5MgZFBJbCUOZuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735579287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IxiIiQpyDpTJMHHbijX6hDlOU/XVJ/aDD2yDdaob6o=;
	b=1bvqgozruhARCqgP072itjSX7Dkjd/SGqzLoeDL/e1Uti85Jpxd2eHqTdoFZD1ivlzAtIl
	M+Yy/3CBMpEY/VDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpufeatures: Remove "AMD" from the comments
 to the AMD-specific leaf
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122210707.12742-1-bp@kernel.org>
References: <20241122210707.12742-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173557928679.399.11097433366651948625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     288bba2f4c8be1e1b9c8bc2e087ce677faf9918a
Gitweb:        https://git.kernel.org/tip/288bba2f4c8be1e1b9c8bc2e087ce677faf9918a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 22 Nov 2024 22:07:07 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 17:59:29 +01:00

x86/cpufeatures: Remove "AMD" from the comments to the AMD-specific leaf

0x8000001f.EAX is an AMD-specific leaf so there's no need to have "AMD"
in almost every feature's comment. Zap it and make the text more
readable this way.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241122210707.12742-1-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 17b6590..09e1e54 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -443,14 +443,14 @@
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* Speculative Store Bypass Disable */
 
 /* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
-#define X86_FEATURE_SME			(19*32+ 0) /* "sme" AMD Secure Memory Encryption */
-#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_SME			(19*32+ 0) /* "sme" Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is supported */
-#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" AMD Secure Encrypted Virtualization - Encrypted State */
-#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" AMD Secure Encrypted Virtualization - Secure Nested Paging */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
-#define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
-#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
+#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */

