Return-Path: <linux-tip-commits+bounces-1967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9494A69A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED22DB235D1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BB1E4F1E;
	Wed,  7 Aug 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i46JZarx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9EL01Qj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA21CCB37;
	Wed,  7 Aug 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027909; cv=none; b=S7qS+J5SrQNHONXhCLn+9zyO+r8y8qQMuajEGroyq1xE16AbixBDlCiy+Ys1SMEpQLmQAFPLz6zHirjNW31OjuBIlnzZHV1Lp2jRCS6BxVubAvLG8DHy8H75x3TFlkx1LasDhz+PIX0LBiL92uJyCfGCSJxVQ4YTYu/33DB7vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027909; c=relaxed/simple;
	bh=L8uwwRF0RTqyvo+Y8Fxp2MyWp2Y5bPKrlH5XQ7SmKP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JQGrTOBG1VWEXma5TMxtuShf7w881t2Cag+eKVHSJd7h7inqGGV6+XqOr94vQvBwWoxsmrFBdXm+8r3Pxp3um/fJTvE9c0DFsI0hI8YPy3IlJpMoDVvsgWGDc35xQ3gJu/CV9Myb1fL7v6mKWQT4IEFCMwZFdkQiqoRqLaKWSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i46JZarx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9EL01Qj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EkPo/vp8dHN1xWUh7kk9/RI85olrzg5Q2pGqZdUZNk=;
	b=i46JZarxaMrGM/xI5tL/tTLqEqsVvdb7ZSOxnL0u1VIYzj/flgudI2jI0XIG9qaAFYr4VA
	LK1FBnUXGigcrXmDl4wh9bMswGa5ikLRNgrVT7xpJmvg1DM/xuEyZ5TN8Xs8dSrqjSAE7d
	eCXnrF3kqjdtBxFOUltj0H0vsC/eTXS0Kxmym0zEtNi1Gc/mV353htchqjR0rv/w+9vpHo
	3KwR99g9fsQlcg5IKuA+DvupGlfXV2bumXJ+kHr8pnUIwhrKDSh6weF/Jsh0nPuPEIRv7U
	856Ei02GRZML2KmxiJZaNj1St/WJpQTpHyfzLAmo7als0Kcql9u8nKm4uk8BmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EkPo/vp8dHN1xWUh7kk9/RI85olrzg5Q2pGqZdUZNk=;
	b=j9EL01QjTb8NRyEm/0W7zC1GgEpF3P85oJ11qac1RKrlHFb1JtULy5sODwCFeAReQOj/QM
	uyzkfoxUilCQd3Aw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Arrow Lake support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731141353.759643-1-kan.liang@linux.intel.com>
References: <20240731141353.759643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789892.2215.15294168514575102834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e0f49f15f6344ef3eeb0a04a8b5dedde2a454136
Gitweb:        https://git.kernel.org/tip/e0f49f15f6344ef3eeb0a04a8b5dedde2a454136
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 31 Jul 2024 07:13:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:45 +02:00

perf/x86/intel/uncore: Add Arrow Lake support

>From the perspective of the uncore PMU, the Arrow Lake is the same as
the previous Meteor Lake. The only difference is the event list, which
will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240731141353.759643-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 64ca862..42968ad 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1893,6 +1893,9 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),

