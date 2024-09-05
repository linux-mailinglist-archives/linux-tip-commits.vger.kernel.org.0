Return-Path: <linux-tip-commits+bounces-2171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3C96D300
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E992811B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3F1957E2;
	Thu,  5 Sep 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18BcqTiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Gy+dBdt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA70192B94;
	Thu,  5 Sep 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528093; cv=none; b=aWsat0syxpS8nI8eRqesHZQ1nSksJQOy8Mjox6ldwjJi8CNnOxbSNTp8g/Kul7r8F8d8rTsMN0vZC9UVO16sDVxh7583dAZ/DnEZQMZLVltta2uHRhzM0wPOGx7gqlQopstJJn1DV7hobztaDBj1kzoY69bfZYzY+bnID93OfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528093; c=relaxed/simple;
	bh=23asEOBJFutD+0iU+yyRxYxcnhJZmndq46UBMt/w0+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XLEyw/oFnhREJ4uAwsQIQWrJ4kq6H7l1+bL/P8NaBpccrxjmM6jTNU1wgz8Jj/K1PmtDZqB5rqtHBzAHREy2iNhO4xsKHLk+ArN9flr6w80cjDMXc+Tv+fuLhU405P2291xr+Um6At3DfnpXzrecbiBXnhDuAYAQRRlR+ETBhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18BcqTiA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Gy+dBdt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 09:21:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725528089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFR8188rD1MJi8R2IyqT+ui4bTFFmBwMcKVEK2Mux0U=;
	b=18BcqTiA9KOcXBqxpI6TZYtWgAb+DrXr5Src0td3iFXQzCfUCvAtsjGqFV39cMMcyLF4Jw
	53OYHWzTjGSrperMlBjbFSnf88b1CJXe2kYG/OXMX9NrIbrX+i3mhdN7Fj0M1g0yt/pVHB
	r1mBFcdqReM0PMdweazTkUw7od3ha1weq7/WVZ+rtGbNPL+Sq1bt2DOmSQHDwRMZtM4oj4
	ZDZxHJrznedXu/DCMWmm6gZKmLeJ/BqihU+C8++CAARQf7RN0pOjFYIpyTHP2oc0ZDGW5K
	1SMuw8pnO9FwWlNFT28fDRHyEi0JsbzwUdyY92ftgRm78MlktX4OLDw915A+Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725528089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFR8188rD1MJi8R2IyqT+ui4bTFFmBwMcKVEK2Mux0U=;
	b=7Gy+dBdtejG4tG1PERa66vLXKlE8NLvqwwE3ncnH6AJzeN2ItNE1pyB0OmpmJWRtiOg42M
	9HZDtTrr7sGR93Cg==
From: "tip-bot2 for Daniel Sneddon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add missing NO_SSB flag
Cc: "Shanavas.K.S" <shanavasks@gmail.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240829192437.4074196-1-daniel.sneddon@linux.intel.com>
References: <20240829192437.4074196-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172552808875.2215.5444492199463668370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     23e12b54acf621f4f03381dca91cc5f1334f21fd
Gitweb:        https://git.kernel.org/tip/23e12b54acf621f4f03381dca91cc5f1334f21fd
Author:        Daniel Sneddon <daniel.sneddon@linux.intel.com>
AuthorDate:    Thu, 29 Aug 2024 12:24:37 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 05 Sep 2024 10:29:31 +02:00

x86/bugs: Add missing NO_SSB flag

The Moorefield and Lightning Mountain Atom processors are
missing the NO_SSB flag in the vulnerabilities whitelist.
This will cause unaffected parts to incorrectly be reported
as vulnerable. Add the missing flag.

These parts are currently out of service and were verified
internally with archived documentation that they need the
NO_SSB flag.

Closes: https://lore.kernel.org/lkml/CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com/
Reported-by: Shanavas.K.S <shanavasks@gmail.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240829192437.4074196-1-daniel.sneddon@linux.intel.com
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d..be307c9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1165,8 +1165,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),

