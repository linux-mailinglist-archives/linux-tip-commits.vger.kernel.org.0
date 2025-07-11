Return-Path: <linux-tip-commits+bounces-6080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5BB02151
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766BE1CC276B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A92EF67E;
	Fri, 11 Jul 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3m2Ul64K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ko5+EzQN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09182EF9A8;
	Fri, 11 Jul 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250177; cv=none; b=bhqLYNm8PNhSd0aQA7S8iLHGFkks7HPRgTfObVjmOs5U2B/So4Hw64uDAM1WGVXoiVAyTP+a3Pqe1bm46V6YxfD4brnzmOxMusu0vRjlwjca3tGOi/TQPUA1SAOar1RzO6fgp7D8Nvatm5/dx/QefKA5VjhuGk340frVsXLv4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250177; c=relaxed/simple;
	bh=UHMDUuvX/Zgxq4GEzRPOukhTpOjQGHAhlSTNu/YvqGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OKLkK5s9tYqdZ0RUGGTS51fMBgEJ0kihbz21NUxE93nItCwlaHXdeBy9ZeCfTTKGTvpi01Kcd9A+xoiNY+Fn+aM6LWwxMFUCR4x7PbcNS//e0l2/m7S/KdKly1fp1petxRSpFi5kFvNNCtR0p59m6gLD17y/w+v5UmIlsKSQk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3m2Ul64K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ko5+EzQN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcmL/QijISVOJjarxU4Isonm5yZshn3xmlijAJS/zEY=;
	b=3m2Ul64K3k/T8qsM1eGqVVPI78heffn5H7f2KFMzWJM2oFwzQ2bUCGvVur9h68NgpoBayn
	dSvjFMqbsBh9U3aUSK3BpJHV5CefDOGKi9EqrAdoaHCQOnwndoPFT7XO5llgOOAT+3StSZ
	AVA4r8j7PjM1jK2g6tVykJ+0Dz3KtVFUXmbFaiyXRkEpSItoKp3KpPv0lYGOgX68a3tfmm
	/h+I5IV9YiQdPFs/rVvmvfUj8Ck70bfxILJuHZ2K1AkyfFsGXvxE2Ce03xJnWT40KY1zc6
	ygZSqxjEHbeCfS730k+pebOXeLsc+D1kFkuBC3DNne8byhhlvgM3S9mVVNl/PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcmL/QijISVOJjarxU4Isonm5yZshn3xmlijAJS/zEY=;
	b=ko5+EzQNRrr2u9pemOTYSvX8Tao9ixgQmM0udpX+N/r21h/4JHjJ1A6HLu0h4VtvGLy92q
	SeTwOU8ZEDp4P4DA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for L1TF
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-17-david.kaplan@amd.com>
References: <20250707183316.1349127-17-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017305.406.13997731550461668881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2f970a526975f4437bdc9a4ba550ecc7e66d861d
Gitweb:        https://git.kernel.org/tip/2f970a526975f4437bdc9a4ba550ecc7e66d861d
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:11 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for L1TF

Use attack vector controls to determine if L1TF mitigation is required.

Disable SMT if cross-thread protection is desired.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-17-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 94c72f4..2128623 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2995,17 +2995,23 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 
 static void __init l1tf_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_mitigation = L1TF_MITIGATION_OFF;
 		return;
 	}
 
-	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
-		if (cpu_mitigations_auto_nosmt())
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-		else
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	if (l1tf_mitigation != L1TF_MITIGATION_AUTO)
+		return;
+
+	if (!should_mitigate_vuln(X86_BUG_L1TF)) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+		return;
 	}
+
+	if (smt_mitigations == SMT_MITIGATIONS_ON)
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+	else
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH;
 }
 
 static void __init l1tf_apply_mitigation(void)

