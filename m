Return-Path: <linux-tip-commits+bounces-6047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30911AFE869
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81AE1C80A39
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD52D8782;
	Wed,  9 Jul 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hudoIVoh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kFPuwLH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A62957CE;
	Wed,  9 Jul 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062098; cv=none; b=O7M8fP3GGku7gEeczp85nKkZvbIJwNS+1rbqVMa8Xo+lnLj4vMH2tKabA3h0LJYyEc7SDBZW72/qPjhmuNgE9Hx37GN+X8hj5U2QypuFAVGFP0hc5TVtg1oXqdeNHXXxWVJkAMcFH7KCNMd0g6UYqJUfG/ENBzixtvw337NhVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062098; c=relaxed/simple;
	bh=P71INcA+GTg0aY+EMLISQGkFnO8N9et4+xTxhaT+w7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y7SGJWAhSY0decx+UGP/bKuopgaKm162XLZmTqenLdUPcdFldV/uMaQdMygWjDH2i1waJuyHqevWoFx/zXxbqomet71Bb+UMbx/OVgAVdYYLO2my62uqvGQ4+9I5cSmsC7HkzfDIdKmOEt3eL0xr0/jv27N12Cs+RkyHKjS8oM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hudoIVoh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kFPuwLH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 11:54:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752062094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b1qlYEcAjiqasQSHghR1zvS/YqVapEUaZaZ+PbgCmU=;
	b=hudoIVohW53tX4shI5lJfPZYGBSawd6tEYzHOZqgSCXuwX5K42rCplLB+oQy5QbZTLAXdC
	Mw8wZddiWyDze+/KqTEsXgS1axoITwD10MzqLmF5/8h6kyBwa5pxPAgmV/brtpwqywzJ4z
	wFOr40+fWcbGNzY8bd+t7LK2b5Co/TDN7FCyWxs0LIFkmMyS+ffBv69jBJus9EIqU2E1qQ
	Mza9kV1+JTrScNoVJBb80lLS+XxCdlcO0Dwb0n0wi5ic3rYGGCKlh+THgg0iydwsgR8GlX
	uTpd6BfLBEZ0Gtz4DFcWh9KiIsJcmMfH+ZdMgIsAp1stU4RniBNph1g2v3UDjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752062094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b1qlYEcAjiqasQSHghR1zvS/YqVapEUaZaZ+PbgCmU=;
	b=4kFPuwLHPZqV9GdjbYOXus5bYJtvnh7Ol+cqdhZo9VAvpe9+/7rcuVjMHUZqHtMkpttjX1
	w/nsYUNAtJOmOaCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707201750.616527-5-kan.liang@linux.intel.com>
References: <20250707201750.616527-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175206209316.406.4737369497841047668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     829f5a6308ce11c3edaa31498a825f8c41b9e9aa
Gitweb:        https://git.kernel.org/tip/829f5a6308ce11c3edaa31498a825f8c41b9e9aa
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 07 Jul 2025 13:17:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:20 +02:00

perf/x86/intel/uncore: Add iMC freerunning for Panther Lake

PTL uncore imc freerunning counters are the same as the previous HW.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250707201750.616527-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2afd4bb..807e582 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1906,9 +1906,17 @@ static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] = 
 	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
 };
 
+#define UNCORE_PTL_MMIO_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *ptl_mmio_extra_uncores[UNCORE_PTL_MMIO_EXTRA_UNCORES] = {
+	&adl_uncore_imc_free_running,
+};
+
 void ptl_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						 UNCORE_PTL_MMIO_EXTRA_UNCORES,
+						 ptl_mmio_extra_uncores,
 						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
 						 ptl_uncores);
 }

