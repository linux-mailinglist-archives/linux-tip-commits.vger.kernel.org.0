Return-Path: <linux-tip-commits+bounces-5890-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD907AE64CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 14:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D8B16904D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AABB284682;
	Tue, 24 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xwq0zz82";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8p7FkFT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F927C16A;
	Tue, 24 Jun 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767798; cv=none; b=GNkFvi4sYZ/TlN2bBhHxfr+u/kdVUEo95Dqgncd94ym89jm3n+sC59q10VTcSICx/zxJ5Ixl0tBM/a267lpYXdBe5MY/SVrXJ9lfeYMlY+9jI+Nxd0p46InEXDX6tF4ZFzITrBgvGEkhSMpijMaG/KaJFxraTrcYD+brHbRPUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767798; c=relaxed/simple;
	bh=DJLQ/wsgbW5YsyUuj/JMv+HiJkZGQWsoKjoZKL9PAF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q4dSypT+plyYAm+G9QONlZzFxKwp2KPmUhsLX172PdhgFU4C+fE7am783e1jwap35VzL0ZLb74+ozU7F/+fQtPsVVd3Di6AotxFnaUXym8PHlBV0DYZogGN4KOVsfTN2FJjKln3L8zgh8YO1Jquc6xKNT6y+M/XFmG7YVX+qCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xwq0zz82; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8p7FkFT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 12:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750767792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu6GFFcWQoMP32EqVRc/cloGCBIUDAzTjm2vKavalFc=;
	b=xwq0zz82tcOV5IlwsSNxaZ4TJq76qphov0VzsPFQSmWgzJJu1j1ExIaqidWRCESaaGLHTD
	CQGUtSA+xyIKa9dlgbr9PAKMTf1qvhcdP/AZam2dTA1xC1Mvh2amGUn4xWZDexShIMDtrG
	eIDiK7KoBsOxhb7rRsX7nI+Ro1jW8+i5KnMNquH7RbgPln61e8ywxWJjdJbKO9vMMWLsiO
	LeOpwVSRyGHK0dt0weEgPLc9ldTjnZjKsXUUIc6TVKO/xwe+7yfkmbF2n4tsCzJHKgJh43
	g66lY7q0yD7oD1EUb1JBvgDaLbSdaTV5lodDg3G/E6c/nRyUiyJfSpptOeZzuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750767792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu6GFFcWQoMP32EqVRc/cloGCBIUDAzTjm2vKavalFc=;
	b=P8p7FkFTDtTSQM3UOcWuwoZGIvhOc18X4jfpYzw533hI4E3D1FusgHNh6WSzFcrQEb0EnD
	hb4NSJkUY62vVgCQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Allow ITS stuffing in eIBRS+retpoline mode also
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-7-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-7-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175076779110.406.9820573204118095413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ab9f2388e0b99cd164ddbd74a6133d3070e2788d
Gitweb:        https://git.kernel.org/tip/ab9f2388e0b99cd164ddbd74a6133d3070e2788d
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:30:33 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Jun 2025 14:12:41 +02:00

x86/bugs: Allow ITS stuffing in eIBRS+retpoline mode also

After a recent restructuring of the ITS mitigation, RSB stuffing can no longer
be enabled in eIBRS+Retpoline mode. Before ITS, retbleed mitigation only
allowed stuffing when eIBRS was not enabled. This was perfectly fine since
eIBRS mitigates retbleed.

However, RSB stuffing mitigation for ITS is still needed with eIBRS. The
restructuring solely relies on retbleed to deploy stuffing, and does not allow
it when eIBRS is enabled. This behavior is different from what was before the
restructuring. Fix it by allowing stuffing in eIBRS+retpoline mode also.

Fixes: 61ab72c2c6bf ("x86/bugs: Restructure ITS mitigation")
Closes: https://lore.kernel.org/lkml/20250519235101.2vm6sc5txyoykb2r@desk/
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-7-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 31f3db0..bdef2c9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1126,7 +1126,8 @@ static inline bool cdt_possible(enum spectre_v2_mitigation mode)
 	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))
 		return false;
 
-	if (mode == SPECTRE_V2_RETPOLINE)
+	if (mode == SPECTRE_V2_RETPOLINE ||
+	    mode == SPECTRE_V2_EIBRS_RETPOLINE)
 		return true;
 
 	return false;
@@ -1281,7 +1282,7 @@ static void __init retbleed_update_mitigation(void)
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF &&
 	    !cdt_possible(spectre_v2_enabled)) {
-		pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+		pr_err("WARNING: retbleed=stuff depends on retpoline\n");
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}
 
@@ -1454,6 +1455,7 @@ static void __init its_update_mitigation(void)
 		its_mitigation = ITS_MITIGATION_OFF;
 		break;
 	case SPECTRE_V2_RETPOLINE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		/* Retpoline+CDT mitigates ITS */
 		if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF)
 			its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;

