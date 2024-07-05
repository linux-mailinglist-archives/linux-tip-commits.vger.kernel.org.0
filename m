Return-Path: <linux-tip-commits+bounces-1609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0C928E81
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A9F284A04
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C4176FC9;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVKmlVM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KykAlHZQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709116F909;
	Fri,  5 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213608; cv=none; b=rRm7hCDsgrR7dMGH+HmaNxEGAYjQklFwXYagz3dAGD7UcI4k9f+oXt1x59aGo6d+rnkQ1K0hgzEzqJYlys1YwsfCZO7qfAq/LO28BXDXShF5izmWVkiEOPkUzqK/y5+Q2BI7pU0GtlturSL/LOmEakkmL0Qfaj0w2wT3l3Xr2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213608; c=relaxed/simple;
	bh=jTWyWDQfYO0Uh1gGcrr2tXX3bOGwYp+hGxc++10HdmI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SkbrZXxMuu873xBii2THmkadkgEcWfKYyawHxmrStDAFo2wXE6t1EmQ+vswYwEZO4pZ2wEtRxGpYBji5dHEBQKs4rCrigM3577qYXlhKrMxFc5axbncqXRk6ZFyDzWDzhFAnngVHK+6QiC9cT5WAti7z2Rvk1+XVAjMEeHQNcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVKmlVM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KykAlHZQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnv34jp5wWWwuZjAqqdr9QxEK7pPTVxlmYXP00PKpc4=;
	b=ZVKmlVM0o61xUquR/hjwWTNgU43+0w7gmqE5WBy7fHfrrrh5BDyz8WsefmrQu/zZr25D1+
	i9KB3cFvFLk95ChXdjiiggOUxyvriOZboQCgJ/r7ool5P83F9LAMO8nUOjrq2WO0dKAhSV
	L0t2ogNkXy0bj73QSE4CUey94HJaB29HuyMz+H0FvCkcX+g8nleVXny9oEgiKvDlVUbFAm
	uzbUcKRKCzuFrJa8HAUIBhAVm1IS/gxylRcpVB6n3LXnixaBk8+mz9Uqhct/4I/YmUNOTo
	M+O+xNBnCJ4PieY1DEne9Y8UycUqfsiJ3tqjFzPx5W3CHxmNZ8z6aDIqoy9jxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnv34jp5wWWwuZjAqqdr9QxEK7pPTVxlmYXP00PKpc4=;
	b=KykAlHZQ6DkZKSWfEv3LBZXIvhyVeNfP1S2AAAXkV3eEmzcPJ7DR+GGzb+8BZB7s6gXReP
	TTF07+5/vfbdPJDg==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Lunarlake support
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240628031758.43103-4-rui.zhang@intel.com>
References: <20240628031758.43103-4-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360405.2215.11274214034624879815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     26579860fbd5129e18de9d6fa0751a48420b26b7
Gitweb:        https://git.kernel.org/tip/26579860fbd5129e18de9d6fa0751a48420b26b7
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 28 Jun 2024 11:17:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:35 +02:00

perf/x86/intel/cstate: Add Lunarlake support

Compared with previous client platforms, PC8 is removed from Lunarlake.
It supports CC1/CC6/CC7 and PC2/PC3/PC6/PC10 residency counters.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240628031758.43103-4-rui.zhang@intel.com
---
 arch/x86/events/intel/cstate.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9adfdf0..c729f7e 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL
+ *					  MTL,SRF,GRR,ARL,LNL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,31 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL
+ *						GRR,ARL,LNL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL
+ *						RPL,SPR,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL
+ *						ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL
+ *						ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -96,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -640,6 +640,17 @@ static const struct cstate_model adl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model lnl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -763,6 +774,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

