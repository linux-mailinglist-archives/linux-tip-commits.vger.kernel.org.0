Return-Path: <linux-tip-commits+bounces-3074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF69F2072
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B3A168179
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11381B219C;
	Sat, 14 Dec 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ham1+gDL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXXsgfvG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67121AE003;
	Sat, 14 Dec 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202076; cv=none; b=Dnt4OdvGFgMMiwbIyiwNTDS1cvNCBPQgtEFWsnx14ChDl/e/aA+PAvcZ9m74ZCvuQx3taz7MdgHEl+HPWpkYqR4xB4Cq2zPJbrM2Fd/m0jOXlLEzpbM+L03TE6Ev9H/qbon+fSvxFu2jfO2ezcaMBKqb3cRbZZNT5V0WQ1nP7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202076; c=relaxed/simple;
	bh=MDE08mrKGQZklNTkiSBoaW8gLDizUxk/G7MfBkaYA+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JMS5Q61jhuNBxkYAcd5hwZdvwDctRfUgrqeq9fOlCoziRkhr8ULCezY4p4i1YBTZlcuWBuAn/QKN1YnqfZYGgY+hIKqw8atMZcuyb7PDTLLWwDtyeoQWBiTqVOI4byDYjGh70iPKfN933PdCku4DF+9gZd4NWNG6A+0D/cpoSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ham1+gDL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXXsgfvG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4np/bGLJEbmaIeUmFPxr9EPBB+s6BrLJ2Pv6sgsG4tE=;
	b=Ham1+gDLGL7yFXh08ToZmLYW8tqMUygN35XLaj3IjdpQNpw4Y+xwglrnMZ78HQbr4MwkDU
	0PsNijcxtPE4ZclgU9K1utALVNuFqkI59h5LnTlNnvDT353QNF4G5Gh8237DFKFWCtPbYI
	+2Xr8ZEJRttumJbzDhMy+bDoG3Hzqx+w5D3D/CidAUS4ljjnmh088P8sr5D0CBxcOqJdAL
	QaJzOuTnODMNuZgmldmnJ/hiTnr8E4Z74lTR7oBnlJlFPR+v7onQrm3dBtP/089ULZkwV3
	sfJta170EMSJrCbll0A5h7hG4hrZujZt5k8pDeualMlSE2LKU8BjvJxv8Ym7cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4np/bGLJEbmaIeUmFPxr9EPBB+s6BrLJ2Pv6sgsG4tE=;
	b=zXXsgfvGfCdpWFlSh6wzQDK7zleuIrpl5gg1/H5BWkMWcMrhyel/WMFDj+2Z6LxJxoNNU2
	BloUU2c7C/IoyOCg==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Require the RMPREAD instruction after Zen4
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5be0093e091778a151266ea853352f62f838eb99=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C5be0093e091778a151266ea853352f62f838eb99=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420207235.412.17427087437652580992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     4972808d6f4a2b4c10eb3035d769f2e1a003da2f
Gitweb:        https://git.kernel.org/tip/4972808d6f4a2b4c10eb3035d769f2e1a003da2f
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:48 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 10:55:28 +01:00

x86/sev: Require the RMPREAD instruction after Zen4

Limit usage of the non-architectural RMP format to Zen3/Zen4 processors.
The RMPREAD instruction, with architectural defined output, is available
and should be used for RMP access beyond Zen4.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Link: https://lore.kernel.org/r/5be0093e091778a151266ea853352f62f838eb99.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/cpu/amd.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79d2e17..b9592c6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -355,10 +355,15 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		/*
 		 * RMP table entry format is not architectural and is defined by the
 		 * per-processor PPR. Restrict SNP support on the known CPU models
-		 * for which the RMP table entry format is currently defined for.
+		 * for which the RMP table entry format is currently defined or for
+		 * processors which support the architecturally defined RMPREAD
+		 * instruction.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+		     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
+		     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);

