Return-Path: <linux-tip-commits+bounces-6305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F47B2F8BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 14:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E207BAFF5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD63112D7;
	Thu, 21 Aug 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uS4YbnOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2nbp3qR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178131A079;
	Thu, 21 Aug 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780400; cv=none; b=KQIvNi34Ewt4HQn8VPyMCo66hr3PksXCBAg9zgrTBbzQC4wRnF98MdYHiMFMujo68p8B3IObD94aZJM4IMSg2hl6FTzPQURhb5D1thR7BYT5L4u2H7WevcvmzfyPeU77zWcpxWfvvD3RnEq8L6ssJtnYaPqgc0TxdkT9eLTF28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780400; c=relaxed/simple;
	bh=JHUbwupkBB4e8j72louEqTZysm+vZuo/Ao9YiEuygeY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n11jRfzCYdyNSNZ9i0sESjz4h+ivxoo8rqd8j4qCITaT7QdRvhGkZ2/S4p+Tf/pwYw+tVZdk2efbLlTrUpdG1A/pnQ9O13XH1dk/jnQljx4s6xZwwvox84N9SpSGGtYGmtAv7CAnupT0UMC2LuHIziZvlcwOKf3dGU+LSz8ao3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uS4YbnOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2nbp3qR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Aug 2025 12:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755780396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjn2gTJ6q0ehI5pMNErg7W74xKdq1TiDGfyfDw+sylE=;
	b=uS4YbnOGXNXKJmDC09IP4RiA4Nfl4YowaKbGsZCGPvELDFsbT8pdyFuYWFxA3KTwkwu8pB
	BKwH3q1WCym0F16+KDffxzoMSjWnuNCTg7CIoB9rmbTyUJ9+SUksRIMq/JCihM8jNIVATp
	VH9mqZvscl1qOWwAAC51F+a80VqZgM/dwmSA9SVPkMfiCtJVP0T2WGxf4taiCkQ4v2OJ7v
	e7OTUWPotSHlkdickaCmnaJcxpQJxKptj9isTRepQRveJD4JxePtGg36RA6vsqt1UKmR8k
	zFEvsJqzTSMjqgBDQ4082UXFjEfRsdSg5BQBtRwD9Sdu4uu7j07WmDtf848bUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755780396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjn2gTJ6q0ehI5pMNErg7W74xKdq1TiDGfyfDw+sylE=;
	b=P2nbp3qRszrCrkiMXZtB3s3KlyEJiYp8t9czRKM/XvwH9qMeLfTVpY4ERnLDJnMqR+STdh
	/Q+c4D7qgCFg57Aw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kconfig: Remove CONFIG_AS_AVX512
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250819085855.333380-4-ubizjak@gmail.com>
References: <20250819085855.333380-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175578039523.1420.15391075810271564548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ae7c0996c0e0f7d3bd3665020e1fbb4d99b7373e
Gitweb:        https://git.kernel.org/tip/ae7c0996c0e0f7d3bd3665020e1fbb4d99b=
7373e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Aug 2025 10:57:52 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 21 Aug 2025 14:35:01 +02:00

x86/kconfig: Remove CONFIG_AS_AVX512

Commit

  5f5305dea066 ("raid6: skip avx512 checks")

and commit

  bc23fe6dc172 ("crypto: x86 - Remove CONFIG_AS_AVX512 handling")

removed all uses of CONFIG_AS_AVX512.

Remove check for assembler support of AVX-512 instructions.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250819085855.333380-4-ubizjak@gmail.com
---
 arch/x86/Kconfig.assembler | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index ea0e9df..b1c59fb 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserv=
ed.
=20
-config AS_AVX512
-	def_bool $(as-instr,vpmovm2b %k1$(comma)%zmm5)
-	help
-	  Supported by binutils >=3D 2.25 and LLVM integrated assembler
-
 config AS_WRUSS
 	def_bool $(as-instr64,wrussq %rax$(comma)(%rbx))
 	help

