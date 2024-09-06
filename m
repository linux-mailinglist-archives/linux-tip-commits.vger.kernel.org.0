Return-Path: <linux-tip-commits+bounces-2191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6B96FB8F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64621282AE6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02D213D2B8;
	Fri,  6 Sep 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtKkvVF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDDnFjHu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0D3398E;
	Fri,  6 Sep 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649016; cv=none; b=vGpuL5+tSfxr8d4K/sdXBqUzzU5tDouWAcep3hqJGEp25+ez7kGcB4EqiDt2be/85Xf8t0bHoihCXCYle2pPgmkB/gcyWoJmfONa16hayObbA1kM5ol5ivdJCpmNNxRlNrqAaC9R/ol6KMfr2ZV99DyNSGNj8vmNiRb4y2+NqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649016; c=relaxed/simple;
	bh=vei/oVqVVZecAbphzAi6pkgWjS6IRi27Up7xcKZHN88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bi8zg2HG9uwdi/QuzihWNM828sIEPrvTs5qO5Sgol3Dg9Hk4ku7MFwFt33mVBMxAPRh9zgqJ1DnQrp9a2Gx0CRs6UO7LQpl4qHeubji6Z9Y1eMf5aIwXK1/XKhPbOxIFWeVRhtaibWaRE1jomFL5GVnI2rux62sNPihZZDNrVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtKkvVF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDDnFjHu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKQ8JCwDs0Pf6xjERG9QPfWayMuOJh/fGMYr+YRhaQQ=;
	b=FtKkvVF2T/bb5t9dWZqVVL0holV32ZxOiOIwWJBN5TpS43igtKWaWif6xDzWvAmpVpPbgk
	32DeHzYLKXQJTEFXmSxC+BiieORHDzF1f7h1y29L3zgEOGq33azN2bNrdUgMv8sgAh99Zp
	Yrxz+DXFDXkzi0l81QXgl1Af8H8fZJzXIZ9ZTugUgAdfuiRXsscRY/gURIrJ0xabCJXJ9L
	wNPg9E/W2BnqX3wDANWk5O9wH7hrQuQpVYSl9iY9fOLem809ZxBd3LFiCOXmRvpxkCktTq
	7J3EadmKMeg/BFfSkWMCsth/tg53EhsWHwgbYQAbrVwFNz6cnrcWrJ9dJzbOxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKQ8JCwDs0Pf6xjERG9QPfWayMuOJh/fGMYr+YRhaQQ=;
	b=UDDnFjHuZafeB0QQ7lReUWhiaGbYc2ZA3tb9L9CT5owGgSnLxRhRU/KCNviTOeGd7U4ZrF
	dOJYMeGsSXU1f6BQ==
From: "tip-bot2 for Marek Maslanka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] platform/x86:intel/pmc: Fix comment for the
 pmc_core_acpi_pm_timer_suspend_resume function
Cc: Marek Maslanka <mmaslanka@google.com>, kernel test robot <lkp@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240904094753.1615549-1-mmaslanka@google.com>
References: <20240904094753.1615549-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901281.2215.8099034029470421233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2376d871f8552aadea19f5bc0b1370db54a3a5f2
Gitweb:        https://git.kernel.org/tip/2376d871f8552aadea19f5bc0b1370db54a3a5f2
Author:        Marek Maslanka <mmaslanka@google.com>
AuthorDate:    Wed, 04 Sep 2024 09:47:53 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:21 +02:00

platform/x86:intel/pmc: Fix comment for the pmc_core_acpi_pm_timer_suspend_resume function

Change incorrect kernel-doc comment to regular comment for the
pmc_core_acpi_pm_timer_suspend_resume function.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409031410.a9beukFc-lkp@intel.com/
Link: https://lore.kernel.org/r/20240904094753.1615549-1-mmaslanka@google.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index c91c753..e2b4c74 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1209,7 +1209,7 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
 	return val == 1;
 }
 
-/**
+/*
  * Enable or disable ACPI PM Timer
  *
  * This function is intended to be a callback for ACPI PM suspend/resume event.

