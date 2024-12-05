Return-Path: <linux-tip-commits+bounces-2978-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D09E5574
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AFF1883A0A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DC218AAD;
	Thu,  5 Dec 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPvquHUx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdLiPEiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCC2185BC;
	Thu,  5 Dec 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401695; cv=none; b=hKjUW4Svdy/r0mRT4nxm/CKb6EgZtH4yg+5BhHpR0MnCk2j2WHTOk0OyR3adVRvi05YqMzYmSKdrY7JrISRdaZsDTert5vfdFp9yP/sAd4Gm0kvLV+MGOSv9e4AdcG6elEIXuMC/NJowjQYNGUZNER1Leok0dr/7EHNrK35sBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401695; c=relaxed/simple;
	bh=eZo26FOZzncdZhhJ7NZIXczEpZwfZRO0EKemGJBqQr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lO2EloXUG1kN6ZljWV1agCox4WicMPVZbzG1X8SFDlcb6QqRPNzoQH+MvfQCCWxY3HwoWt9A7mNIxqCyE0JGGvkyaQus/WYgyW4XgvVhPfZ1u9VwEtHV2wdJQwWFbw+SOyH0vYw35DX6K+oeLnMs+UNHSn04Uw8HqJ7Ka7Uua/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPvquHUx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wdLiPEiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLxbDYfVDUO2okigdhQyyZJXSYsBK8DGZ3ctVstKP3w=;
	b=VPvquHUxDvV+orPjaLyE4EFyA2DMAnnFEEti+1fMNo8IQV3/APgiRdUri4e31VMb4aXPrH
	zdPvfBZNmdtpmajlOTpJa9PKDow1W+0yej+xYJH9IhfxPX+5d7hKMrZq3r+GX6IcQpZFfM
	x/oQxuYCYV2MuJkr9FgSXJQ7SYz7VY3N8Lv/ukBDOuw0K8BlNdi7a5dJqkijzkKlOpO6kN
	trjW9PAYAxq+x8l4jpmndh1pU1oCA/5bTcLJj/6FLXttSCHoZANHlCVwaWvKTux92/+TDh
	wfKplSvIqtktKLEYy8poXjVSZs8RDiuKugvyHPIA3Jtxy6BFf6AC4tpLqijkKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLxbDYfVDUO2okigdhQyyZJXSYsBK8DGZ3ctVstKP3w=;
	b=wdLiPEiXZJIH7tfz71Ti3pqFXTSqxJUUkO6Pd/0ME6HxgZ81nwhoXMwFxT6bhg15iV49Ye
	dTUtUnLyubNi5dAg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Disable UBSAN in early boot code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-13-ardb+git@google.com>
References: <20241205112804.3416920-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340169141.412.4232110300188141837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     3b6f99a94b04b389292590840d96342b7dd08941
Gitweb:        https://git.kernel.org/tip/3b6f99a94b04b389292590840d96342b7dd08941
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:54 +01:00

x86/boot: Disable UBSAN in early boot code

The early boot code runs from a 1:1 mapping of memory, and may execute
before the kernel virtual mapping is even up. This means absolute symbol
references cannot be permitted in this code.

UBSAN injects references to global data structures into the code, and
without -fPIC, those references are emitted as absolute references to
kernel virtual addresses. Accessing those will fault before the kernel
virtual mapping is up, so UBSAN needs to be disabled in early boot code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-13-ardb+git@google.com
---
 arch/x86/coco/sev/shared.c  | 7 ++++---
 arch/x86/include/asm/init.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index afb7ffc..96023bd 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -498,7 +498,7 @@ static const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 	u64 xfeatures_found = 0;
@@ -576,8 +576,9 @@ static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpui
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+		      struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 14d7272..0e82ebc 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head	__section(".head.text")
+#define __head	__section(".head.text") __no_sanitize_undefined
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */

