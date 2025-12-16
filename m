Return-Path: <linux-tip-commits+bounces-7727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A972CC364E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D007E3062ED6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71933D4F8;
	Tue, 16 Dec 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQEGYqR7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3w9v9ht"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996D17B506;
	Tue, 16 Dec 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892925; cv=none; b=gPYb90MiHkewoFU7AHRyTL5VpLdKZa616Ws5Ev98ZokI07uRM6DeQZ/x2Xw6qHCuzPGRjg8sTIyyahMeamoG86XPXiiHe1TTIfcJZhYttDAZ1Ac1NNDz/h45a+XjV3/qIPsaLDtJyh0fGuQGRaCosKNsR4P3oPjmDb/IlZ1sSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892925; c=relaxed/simple;
	bh=muXxkoNmDGQdHS8vKTe5A5AAdFYrZTVQ1cRIxRwNDp4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OLfNjSeg5iEN3707E1dt869wkMye1ntZ+/JLdZZGbn0hznDj5/rjGNqXNim+TsgHD5BEu7Id+T5h4PrqKfMgQSzWQmoh2KNvUh3MyxrlhQMi2Aul7/15n9qMQaA0/AEP6WhKMq7asMmMWZwBpXKlnAO1svcjyOxenvnmeFYkEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQEGYqR7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3w9v9ht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Dec 2025 13:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765892920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+bAoWA/AK+8GCoWQtzOHDYV5tGgF8MVyDmefu7qxSQ=;
	b=bQEGYqR7zS3MIIKTnNyqhHGyCymqFGgcBzbp5YWYRs06lBdjQ2yQI5CP0gYtzl18UHv115
	5VwltjaLF3jZ0l5ycO2nBooUcpWz2re0B49vMbupqIK3DNlCgCkR9Q2QoLQixhqgAV0olp
	QAsmrtcVH6CZBAz1lCoth5q6eaCEUtkCb8XLZmPIYno1krrDaZOgHaxQg727KAYxn7wLB3
	ZJObUsNYQfE2J7I/iQ40om8+TqwrUiNRWCbHStoFE4pZjP39qCf2gKHAo4Crvcd8MxMh6C
	l01HUGxNQHcGShkUcY+lyJ3Pnpe1toNKQo/n2vKiDQTk5Hsd+OaW36DTmNRzyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765892920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+bAoWA/AK+8GCoWQtzOHDYV5tGgF8MVyDmefu7qxSQ=;
	b=y3w9v9htqnN923eqgG95QVTYUmLRMHy3hOGlqlsp9ugoWUXKL4BdKtBKBphzwSJRHvpOwg
	yOhqg1wzPBeSkvBA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Nova Lake support
Cc: Zide Chen <zide.chen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215182520.115822-2-zide.chen@intel.com>
References: <20251215182520.115822-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176589291930.510.12746865233410858714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7e760ac4617b63628edd55a96be2fc85b7eaa435
Gitweb:        https://git.kernel.org/tip/7e760ac4617b63628edd55a96be2fc85b7e=
aa435
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Mon, 15 Dec 2025 10:25:19 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Dec 2025 14:35:59 +01:00

perf/x86/intel/cstate: Add Nova Lake support

Similar to Lunar Lake and Panther Lake, Nova Lake supports CC1/CC6/CC7
and PC2/PC6/PC10 residency counters; it also adds support for MC6.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251215182520.115822-2-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index b719b0a..008f8ea 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL,NVL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,19 +53,20 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL,PTL,WCL
+ *						GRR,ARL,LNL,PTL,WCL,NVL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
  *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
- *						PTL,WCL
+ *						PTL,WCL,NVL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL,
+ *						NVL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -78,7 +79,7 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL,PTL,WCL
+ *						ARL,LNL,PTL,WCL,NVL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -98,11 +99,11 @@
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
  *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL,
- *						WCL
+ *						WCL,NVL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SRF,GRR
+ *			       Available model: SRF,GRR,NVL
  *			       Scope: A cluster of cores shared L2 cache
  *
  */
@@ -528,6 +529,18 @@ static const struct cstate_model lnl_cstates __initconst=
 =3D {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
=20
+static const struct cstate_model nvl_cstates __initconst =3D {
+	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.module_events		=3D BIT(PERF_CSTATE_MODULE_C6_RES),
+
+	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst =3D {
 	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -656,6 +669,8 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_NOVALAKE,		&nvl_cstates),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&nvl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

