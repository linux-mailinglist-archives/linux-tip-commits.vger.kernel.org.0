Return-Path: <linux-tip-commits+bounces-1908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9119A9458BA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F591C239B5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE81BF306;
	Fri,  2 Aug 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAxYc/nd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99lYFX+Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85701BE871;
	Fri,  2 Aug 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583728; cv=none; b=G4jfR5oZJWs3pZUd9uAw9/q1D5adP8chQzjGpO1qoJbf0/R6SO8Yoo+YICQIchr/OwxChMgQK8eTQtY5wvX2G8zzKWSIRYJXCZuWSGjm/QRWQe8bR8si5AryeSCcHjyK3jr2lXkw04JGwH0MamCoGDGPVlB7Ntau5eOmNayXrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583728; c=relaxed/simple;
	bh=MSZtsnC9+DrdVztFbzbJHV439uYN67UJwHw8HfPzveo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pl7T+WeTWFYa/z0t6wb8a+v0q/C5X3zpUVQljha5+Vdsjnjjj1caVupVo/+8kiqaJ4+Sg34kg5A55RAJURvE9LdZKJCsNsOvFL3PHKJsXCi/Bp/RGBd5UuxzrVn5e2nbk4uATFe+bKoQlyxPQ0bTM/RFDbSv+omlZC4GwaNthKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aAxYc/nd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99lYFX+Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH31syhgdm0P5RBj7isSvZf24bvFG+f9Bbfgzi0wNNY=;
	b=aAxYc/nddDg7Jbr039NOAOypEbxBF7X5G9ZNpGxVzhD3dksanengEMhwS1hBm76ltPN+As
	Exrzx/WQMWrw3Id4bQHLnl4Tdqb6Nml8CHffn1EFl7t4eWp3pDwq75nxCWkVtvRgJq8HHN
	sPjrLhbJpRVXN4LTYUo+Lvvc0gPqo84uoO1jKimOruKPE7L+SLUJm2DjGzahAck7Nl/1bA
	a1mI9NXtcBhsNoF/ltCPUoQTVcES+i/WczTwJKY1v2qmKw+unAdd3sDZoRAINz7GHcW6il
	FoJziimo5A883R7C98SrWnNL9Zsqdo4SnvlopnxY9M2oEWoqneP/dolnnt1yLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YH31syhgdm0P5RBj7isSvZf24bvFG+f9Bbfgzi0wNNY=;
	b=99lYFX+QMPXHbHlR9MrjwcvnqqiGuugVeVY6qrkdHL/hlcVk9bmLDO8L95uV2q+IYzEdc7
	Ngz+kfDDwvwkBqBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Recognize all leaves with subleaves
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-7-darwi@linutronix.de>
References: <20240718134755.378115-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372493.2215.15603553489756330967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b0a59d14966dbfe0d544b2595dcb29728d41daf3
Gitweb:        https://git.kernel.org/tip/b0a59d14966dbfe0d544b2595dcb29728d41daf3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

tools/x86/kcpuid: Recognize all leaves with subleaves

cpuid.csv will be extended in further commits with all-publicly-known
CPUID leaves and bitfields.  Thus, modify has_subleafs() to identify all
known leaves with subleaves.

Remove the redundant "is_amd" check since all x86 vendors already report
the maxium supported extended leaf at leaf 0x80000000 EAX register.

The extra mentioned leaves are:

  - Leaf 0x12, Intel Software Guard Extensions (SGX) enumeration
  - Leaf 0x14, Intel process trace (PT) enumeration
  - Leaf 0x17, Intel SoC vendor attributes enumeration
  - Leaf 0x1b, Intel PCONFIG (Platform configuration) enumeration
  - Leaf 0x1d, Intel AMX (Advanced Matrix Extensions) tile information
  - Leaf 0x1f, Intel v2 extended topology enumeration
  - Leaf 0x23, Intel ArchPerfmonExt (Architectural PMU ext) enumeration
  - Leaf 0x80000020, AMD Platform QoS extended features enumeration
  - Leaf 0x80000026, AMD v2 extended topology enumeration

Set the 'max_subleaf' variable for all the newly marked leaves with extra
subleaves.  Ideally, this should be fetched from the CSV file instead,
but the current kcpuid code architecture has two runs: one run to
serially invoke the cpuid instructions and save all the output in-memory,
and one run to parse this in-memory output through the CSV specification.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-7-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 39 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index c4f0ace..725a7a2 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -98,27 +98,17 @@ static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
 
 static inline bool has_subleafs(u32 f)
 {
-	if (f == 0x7 || f == 0xd)
-		return true;
-
-	if (is_amd) {
-		if (f == 0x8000001d)
+	u32 with_subleaves[] = {
+		0x4,  0x7,  0xb,  0xd,  0xf,  0x10, 0x12,
+		0x14, 0x17, 0x18, 0x1b, 0x1d, 0x1f, 0x23,
+		0x8000001d, 0x80000020, 0x80000026,
+	};
+
+	for (unsigned i = 0; i < ARRAY_SIZE(with_subleaves); i++)
+		if (f == with_subleaves[i])
 			return true;
-		return false;
-	}
 
-	switch (f) {
-	case 0x4:
-	case 0xb:
-	case 0xf:
-	case 0x10:
-	case 0x14:
-	case 0x18:
-	case 0x1f:
-		return true;
-	default:
-		return false;
-	}
+	return false;
 }
 
 static void leaf_print_raw(struct subleaf *leaf)
@@ -253,11 +243,18 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * Some can provide the exact number of subleafs,
 		 * others have to be tried (0xf)
 		 */
-		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18)
+		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18 || f == 0x1d)
 			max_subleaf = min((eax & 0xff) + 1, max_subleaf);
-
 		if (f == 0xb)
 			max_subleaf = 2;
+		if (f == 0x1f)
+			max_subleaf = 6;
+		if (f == 0x23)
+			max_subleaf = 4;
+		if (f == 0x80000020)
+			max_subleaf = 4;
+		if (f == 0x80000026)
+			max_subleaf = 5;
 
 		for (subleaf = 1; subleaf < max_subleaf; subleaf++) {
 			eax = f;

