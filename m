Return-Path: <linux-tip-commits+bounces-3097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3379F6834
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A94D1893225
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366531A4F12;
	Wed, 18 Dec 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jG8Tb9vR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e141f3Js"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F078C76;
	Wed, 18 Dec 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531756; cv=none; b=PZT97kiuZt9301njuyc0cuBWA+DMXHAHjV3sM/eALTjfpZY8C48BDcarVgxV2Q728AYiU0PHPxu+RRL0WFXSa8gXKLF0tF4oFuxG35Eol+DGF5lEOibXhpIjRul17/4+3VRrueIdCEqWrkb/zYEHfosrv5B/M08ccJBKIYTeqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531756; c=relaxed/simple;
	bh=LvF5x/RBTfIUlgD2EXuA0U9pMjTE7i840/W7y30Go3I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=D01YJPrVweJECPvngb0883rY/eWymvyD8bhhpIbzhYBuy6GfQWwt/vMcmDKrRYGjmlT2uPTGt4sdY6G6l+t6ZgL+FEUU5pHdKoyP7/INcxukSbuwZqViAncAH+VBeiZApMa4nh0Y8WaMS1tNmZDzbtphNKoIMTQY6PuAjbzg4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jG8Tb9vR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e141f3Js; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZHPL0FXCC9mbVQ7yYyBe99HW7aHCtDapP2ONoUqokI8=;
	b=jG8Tb9vRSVIbgchPlAoqeDJl4SksL+cpaKz6CYzEeJngSpBfjzeAS0IBq9RzjLSCW7pVZu
	ypQamXztydUGeVc/3kczkqEs0V33+Zei0cSeIoiKHCz2ILaf2HMCmd/dph7e0KHFu3sM8s
	KeNNTBtzBLj9YjlWVHjGn8pM71y8tGCxPMypN3YQ0rI8g9Mdlrlo79j7RiaX2sRi5rq/14
	kYL5jd2eaRLoO0MrcxdiU3B6NmTJ2XpX8T0foJIjjmyH0+igXEMk2gMWPSY8hjIqRQXByM
	PTGtPGWiebVf9PH9O3Eysu6p0SE0mRRcgo8osE8P+YE66tbLrPC8hQivj1jl1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZHPL0FXCC9mbVQ7yYyBe99HW7aHCtDapP2ONoUqokI8=;
	b=e141f3JsxwMd6ufvhDPOy9QFe6RKE1aYYIGw+71svvWW4c9gfrik1dF4ZXKc2HV23I1k2H
	LEaVNBpY2a3FqhBQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/fpu: Remove unnecessary CPUID level check
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175223.7135.13530464498852485901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     588e148d8babeb2fd863fb152b80548e18971caf
Gitweb:        https://git.kernel.org/tip/588e148d8babeb2fd863fb152b80548e18971caf
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:38 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:45 -08:00

x86/fpu: Remove unnecessary CPUID level check

The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
if the CPUID level is too low.  This code is unreachable.  Kill it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/all/20241213205038.6E71F9A4%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/fpu/xstate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bf38b3e..edacd34 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		return;
 	}
 
-	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
-		WARN_ON_FPU(1);
-		return;
-	}
-
 	/*
 	 * Find user xstates supported by the processor.
 	 */

