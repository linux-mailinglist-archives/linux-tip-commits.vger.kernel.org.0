Return-Path: <linux-tip-commits+bounces-7095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B29C19DE7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993F356757F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F8328633;
	Wed, 29 Oct 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1Mjxkx8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rt24Fr3b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2A2FBE15;
	Wed, 29 Oct 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734540; cv=none; b=EJL8bYso34WIEn+OxjPY0DqlvPSYruqCjYtcLnUJITiw7Cwzo3HDWOxtRfKA3assSMptVrFXmoXGBHekgcxevHGFnppQ76T9oss3nTSCEizuaN1U2js1/exBkbyRNabAxZm7kl3MVcoNRTVdB1oaDQk3Gimthv+x6plNRhJ5waU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734540; c=relaxed/simple;
	bh=En191ZlHD3MzJ+xkuht8nvwtRAQonSDwIJ8NrAGThOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=awpKlZQxqrM7YnV4sVlp0i2VFbJOZxEdFcz8Sdacc5cMBxmcD79C55xj6eG4IKYgs2toVgxdg6ppBBgs+GkdvkcSIbGSOtFIR5cxhohoJGQnVAkjZY7PUUHXOs2a8DFCN6gVTTTu3zYRxkFh0CdaD5RWXGCiH4JQYdOXddJnDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1Mjxkx8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rt24Fr3b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:42:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761734536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICizyKXON+wU+sTV07oz1rHpUQLB5mVMaKb2cgAEgkU=;
	b=l1Mjxkx86rvk4G8RNGd+hffGG4q0MfQ25VYnG+nipfuthnWRJZe+rrsdhaKyWi/mKQ1Cf/
	4aN5MdSVoVTZulazaDDmeKdYLDGGpkT40wl0Qfy0xCLscMcFq3razY7iJHKM8ZYXB+noGi
	LgIMQYncXwMe9ly8zDBVFVGvm7FPRkiff6vNMzkSbq7JA1RHkF/ZHPm+dokmN7BjvkLx8D
	p7I2ga/HjsOY64hH77cAv66KNoR+CL07SN+jRH2v7a00lNN6+FSOWOYnG33p4xn3oBOX3W
	rI+ZMo7i3qkfnnxWUfqavvIPqrVoOxLTg9dNBiloi6IHlRn0NY+j45oYLf8LhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761734536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICizyKXON+wU+sTV07oz1rHpUQLB5mVMaKb2cgAEgkU=;
	b=rt24Fr3bXy7H/Rz19gOjUIhQuF2/Wz86flywDfZkLO2kLjjyazZD1SjvtYfs0rZEiH4c/y
	KyPEY9BF2L0DyOBQ==
From: "tip-bot2 for dongsheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Add uncore PMU support for
 Wildcat Lake
Cc: dongsheng <dongsheng.x.zhang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908061639.938105-2-dapeng1.mi@linux.intel.com>
References: <20250908061639.938105-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173453474.2601451.16883737397804706362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f4c12e5cefc8ec2eda93bc17ea734407228449ab
Gitweb:        https://git.kernel.org/tip/f4c12e5cefc8ec2eda93bc17ea734407228=
449ab
Author:        dongsheng <dongsheng.x.zhang@intel.com>
AuthorDate:    Mon, 08 Sep 2025 14:16:39 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:31:44 +01:00

perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake

WildcatLake (WCL) is a variant of PantherLake (PTL) and shares the same
uncore PMU features with PTL. Therefore, directly reuse Pantherlake's
uncore PMU enabling code for WildcatLake.

Signed-off-by: dongsheng <dongsheng.x.zhang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250908061639.938105-2-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f..d6c945c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1895,6 +1895,7 @@ static const struct x86_cpu_id intel_uncore_match[] __i=
nitconst =3D {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),

