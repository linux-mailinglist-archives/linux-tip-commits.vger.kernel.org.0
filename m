Return-Path: <linux-tip-commits+bounces-1283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D818CBE77
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 11:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79811C20F56
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C086026A;
	Wed, 22 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwXL67JA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qv7C0+Wj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8481722;
	Wed, 22 May 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371228; cv=none; b=rZvkpowDPAcFSRVxiaLmJpJVjDKJalNcJvyIyQaXikaD107vhLIUfQeJ8EdrgdaFOyCRNf9I1h6yE/+RP2CIjRU3Lf//JUQTtG/DaYHtGjZRrq6IZ2q6raQ3x4iWRHXZEiRxxMUqCQlOmQ/2iN4HmunT0XjYz8j9n3pSZq/kNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371228; c=relaxed/simple;
	bh=GbH3ZjuIogxSDiRqCT4Y8LqcpzEVznEj2b457At/qkk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1RfrG4dR/X8/9+kx7k+Rq6jxRnP94cOM5U8NwnXYzquPYa261CaE6P9J0NEzt8mA+smlBCz66JMrTZtLsGKwan8oN+HK8a+X1Z3PKD6lgBWz0jkxtfV8rLEPs/vUp4HNQLdKbZ0QkG7/YOjtJ6Ng1SixH/c0stacjL3MFSGJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rwXL67JA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qv7C0+Wj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 May 2024 09:47:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716371225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbci3/Q4QiVdr3IVwLhtaqvHRvmSpRWKwJzp81lpGZk=;
	b=rwXL67JAo1CG/iB6g+MzvoqMuZaGGCxK0hv94nJMqODPglPdRORKnKON6OqrZMpOcuV35V
	nGwAScoxINlWlws8iH71/AHPWAOuW9uyghG+XxLlbFXzT6/noKrS+rk/5/vJ2ePZS1d6vh
	H9c8kNzhbiPSlyb1dCH8JYIMqDe21cXgSHBBf2PEfYX/uK6hnLgsEg3RKsN8R0+KSiPM9O
	ts38Cba7g6j32fPeXJa66a9Ww+5ex51WuvPiuw3qtk1f6SuqbbtkjHAARRvk0zZgNRqb7Q
	AEXqW5VHbssYB0Z0FHaRtKh83DGn1sC9U3XkcgK3cSDvjW9TZxUC3DP9Dl6v4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716371225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbci3/Q4QiVdr3IVwLhtaqvHRvmSpRWKwJzp81lpGZk=;
	b=Qv7C0+WjYk9osFw5DYP4N3u23PObAjUJci7+2y572QeVIiKG4Ks3zaro9UDv0VwaIE9pAN
	Kk5jP3bRFeHADAAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] crypto: x86/aes-xts - switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Eric Biggers <ebiggers@google.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240520224620.9480-2-tony.luck@intel.com>
References: <20240520224620.9480-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171637122512.10875.8916941284453923650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6d85a058cf4941b5b2713b879ef41430e6aa74f3
Gitweb:        https://git.kernel.org/tip/6d85a058cf4941b5b2713b879ef41430e6aa74f3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:45:32 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 22 May 2024 11:10:48 +02:00

crypto: x86/aes-xts - switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/20240520224620.9480-2-tony.luck@intel.com
---
 arch/x86/crypto/aesni-intel_glue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 5b25d2a..ef03165 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1223,14 +1223,14 @@ DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
  * implementation with ymm registers (256-bit vectors) will be used instead.
  */
 static const struct x86_cpu_id zmm_exclusion_list[] = {
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_SKYLAKE_X },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_X },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_D },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_L },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_NNPI },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE_L },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE },
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	0),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	0),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		0),
 	/* Allow Rocket Lake and later, and Sapphire Rapids and later. */
 	/* Also allow AMD CPUs (starting with Zen 4, the first with AVX-512). */
 	{},

