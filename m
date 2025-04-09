Return-Path: <linux-tip-commits+bounces-4815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A69A830A8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9EE446161
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55107202990;
	Wed,  9 Apr 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40nIUyFf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUiZ8eC2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E01F8743;
	Wed,  9 Apr 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227618; cv=none; b=RzVBrSH3BgzwV1eke/+P3P8e45Ql2B0VcpE0fAZEFOOjrqEL8k27Si1IMO4+8HSwQBTGm4b7/mu4XymBgxphC5sKv3Nz8EfnzHM7HOa/xqcG5i3X95vfesFvBtmgZKvonqy9qWNGcK9/TZvigjcaNzq0fueVmnl61pbdTLnZLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227618; c=relaxed/simple;
	bh=zXovE3nJkLN016htjzpUM8/SI5EDK3RGlEwENHXVY90=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLKlkmfCFEtB4sslFsgC8i42nAGk812tjFNW/DBBsskCLKzdDmoNOYaeO7ddTRVgkPfWpfE8JaIU0nNsDrv3j4Rxl5aNUFdeP0gWVgnxuBxX4t6s81quCWxFMpkEcZ9Rl+9mhxkqQqM5xYs81jeumoWJ1DPrvCw/gy7ac8Abrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40nIUyFf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUiZ8eC2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744227614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyap9BJ7VZSO+iRC5C9PQAHNdatWUNhaCmNOIOD0GUU=;
	b=40nIUyFfSV9963ugM8Mt/wr03Rw0kJs7xJl1Wiq1CM2rhppQXK+ZFYUvGQoxO6fOVuFdWm
	ZBrfOAN9M94S9HNGcMPa7g+CyRaywjgsxqBOaWjTuikKRpMCG6rFB/dndwWoFPKCeZJIFM
	QOdRh7a1BDz7rA6HaqKZkNoguYA6+6HLxJ1CbWzvHzyC3nQQz4UIu1Cm5cI2q4Ar+Ohwvd
	ySiG0eL0yeC65wEX1fVhBxemPRFILgZvs18c/P2wj6B1yzdhkb75JNeSotRVnIY6gceivn
	gFnpvWntZNwyeqMW6yVpMlF4HNjNPCn0fcbupNLtihXGcyI5hChAwAqVdf+oQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744227614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyap9BJ7VZSO+iRC5C9PQAHNdatWUNhaCmNOIOD0GUU=;
	b=EUiZ8eC2a1C/okQoCCJpDU0PkhKYvA7trgVH112oYxGiCmVpDD//nsQf6nG5zTGoeTzFAH
	WNm97qdU9gdLLIAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Properly parse CPUID(0x80000005)
 L1d/L1i associativity
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409122233.1058601-2-darwi@linutronix.de>
References: <20250409122233.1058601-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422761402.31282.13417527364559338124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d274cde0dbe0217ee2f2ddbb1a3c545dedf81a06
Gitweb:        https://git.kernel.org/tip/d274cde0dbe0217ee2f2ddbb1a3c545dedf81a06
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Wed, 09 Apr 2025 14:22:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 20:47:05 +02:00

x86/cacheinfo: Properly parse CPUID(0x80000005) L1d/L1i associativity

For the AMD CPUID(4) emulation cache info logic, the same associativity
mapping array, assocs[], is used for both CPUID(0x80000005) and
CPUID(0x80000006).

This is incorrect since per the AMD manuals, the mappings for
CPUID(0x80000005) L1d/L1i associativity is:

   n = 0x1 -> 0xfe	n
   n = 0xff		fully associative

while assocs[] maps these values to:

   n = 0x1, 0x2, 0x4	n
   n = 0x3, 0x7, 0x9	0
   n = 0x6		8
   n = 0x8		16
   n = 0xa		32
   n = 0xb		48
   n = 0xc		64
   n = 0xd		96
   n = 0xe		128
   n = 0xf		fully associative

which is only valid for CPUID(0x80000006).

Parse CPUID(0x80000005) L1d/L1i associativity values as shown in the AMD
manuals.  Since the 0xffff literal is used to denote full associativity
at the AMD CPUID(4)-emulation logic, define AMD_CPUID4_FULLY_ASSOCIATIVE
for it instead of spreading that literal in more places.

Mark the assocs[] mapping array as only valid for CPUID(0x80000006) L2/L3
cache information.

Fixes: a326e948c538 ("x86, cacheinfo: Fixup L3 cache information for AMD multi-node processors")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250409122233.1058601-2-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index cd48d34..f4817cd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -91,6 +91,8 @@ static const enum cache_type cache_type_map[] = {
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
  */
 
+#define AMD_CPUID4_FULLY_ASSOCIATIVE	0xffff
+
 union l1_cache {
 	struct {
 		unsigned line_size	:8;
@@ -122,6 +124,7 @@ union l3_cache {
 	unsigned int val;
 };
 
+/* L2/L3 associativity mapping */
 static const unsigned short assocs[] = {
 	[1]		= 1,
 	[2]		= 2,
@@ -133,7 +136,7 @@ static const unsigned short assocs[] = {
 	[0xc]		= 64,
 	[0xd]		= 96,
 	[0xe]		= 128,
-	[0xf]		= 0xffff	/* Fully associative */
+	[0xf]		= AMD_CPUID4_FULLY_ASSOCIATIVE
 };
 
 static const unsigned char levels[] = { 1, 1, 2, 3 };
@@ -163,7 +166,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		if (!l1->val)
 			return;
 
-		assoc		= assocs[l1->assoc];
+		assoc		= (l1->assoc == 0xff) ? AMD_CPUID4_FULLY_ASSOCIATIVE : l1->assoc;
 		line_size	= l1->line_size;
 		lines_per_tag	= l1->lines_per_tag;
 		size_in_kb	= l1->size_in_kb;
@@ -201,7 +204,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 	eax->split.num_threads_sharing		= 0;
 	eax->split.num_cores_on_die		= topology_num_cores_per_package();
 
-	if (assoc == 0xffff)
+	if (assoc == AMD_CPUID4_FULLY_ASSOCIATIVE)
 		eax->split.is_fully_associative = 1;
 
 	ebx->split.coherency_line_size		= line_size - 1;

