Return-Path: <linux-tip-commits+bounces-3108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130A9F684F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8669518975A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A701F667C;
	Wed, 18 Dec 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CnHZmtFS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Es3lnNgw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF51F4E52;
	Wed, 18 Dec 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531764; cv=none; b=PuvnmXTsW207sQJiPWygopVoBZfSQvwkUuMTxgk+OjQ6jeTXB5hnerQKcpdbdS+C30SaRC9ofPPKzJI73qohuw6nuQhkBP7lcAl1pHAjjfKvM+i9ODpwVhFKE8XQ56T1ZNv32SawE6jfgGij3hFRQ7dt2pLIcH3cD54gpHrWAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531764; c=relaxed/simple;
	bh=0OI9iBopZuUUgK/0UZLEVFZvjB2n02aEWgAuoVRyMO8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=g4FMkjzrop3RHwoUhh2Cm/7u6CGozAz9D8xNmNf6nupH7+FAN1Okse/aTIqNwOsp87/Z2rH+61HLkmTGiUMVVd0KtAaHjeKQ828FmAy/7BCnX32tgbmyeFlbNX2ko2+/oBIsiOx4jxAe00Vl4ZbJFKREnD/YCwjnRBBQEW4kgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CnHZmtFS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Es3lnNgw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5lPCoFzBsfaB0yC0n+G7tKm2mwP4ozH7y3XI39XkYdM=;
	b=CnHZmtFS+GVDw9b6Fzprca9mJbUzjGijYKxe5Jt6EyGG8nl4GBLU8nsXB+Ubw4kcQj82fG
	/k24eG8hteNqLCCuoQ24XD2ZAvCovw0GF5HyFTPyh71JALBajw+jjYV9sfdDwwq0QgC3Q+
	7nZ19c/HMTqUnopWjdUyX47Ih9BBu+TavR1Bp5eUKkAlZsDxOEUtTIM9HaaGApqpekbkrH
	FzXEmxFSsYJjratlNKlmVR7JzNup8Fr7AenJN2Czk1cdKhhS7domJR3kyPEHcvX0uh7hGR
	A0NZCE9/S7WCwww45SBr4QctST+6XTW91Q67w6pQ4V8S+atTkCfcTx+RdnAwRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5lPCoFzBsfaB0yC0n+G7tKm2mwP4ozH7y3XI39XkYdM=;
	b=Es3lnNgwpzJgei9+Sy9MdxMuIrCpKZzh0Bv/PznDAeWatjdJxgMedYteHc3GASZGF6izO6
	5cP840QGYdXyY1Cw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453176104.7135.7779608773767251804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f3f3251526739bb975b97f840c56b3054dba8638
Gitweb:        https://git.kernel.org/tip/f3f3251526739bb975b97f840c56b3054dba8638
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 10:51:32 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:09:04 -08:00

x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'

The AMD erratum 1386 detection code uses and old style 'x86_cpu_desc'
table. Replace it with 'x86_cpu_id' so the old style can be removed.

I did not create a new helper macro here. The new table is certainly
more noisy than the old and it can be improved on. But I was hesitant
to create a new macro just for a single site that is only two ugly
lines in the end.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213185132.07555E1D%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/cpu/amd.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d8408aa..7bb5b1a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -795,10 +795,9 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
 
-static const struct x86_cpu_desc erratum_1386_microcode[] = {
-	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
-	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
-	{},
+static const struct x86_cpu_id erratum_1386_microcode[] = {
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x2, 0x0800126e),
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x0, 0x08301052),
 };
 
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
@@ -814,7 +813,7 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 	 * Clear the feature flag only on microcode revisions which
 	 * don't have the fix.
 	 */
-	if (x86_cpu_has_min_microcode_rev(erratum_1386_microcode))
+	if (x86_match_min_microcode_rev(erratum_1386_microcode))
 		return;
 
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);

