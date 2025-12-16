Return-Path: <linux-tip-commits+bounces-7728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B6CC3576
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CECBD300D673
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5672313E3A;
	Tue, 16 Dec 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34ht44XN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJJUVpbA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866C33984E;
	Tue, 16 Dec 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892927; cv=none; b=h/3SWpYf59Kl4EYRvhpUiNPXRWZhGg+/rk3ujb/4mWRKROuwiHzo4U1p10Ww0bjI9Z22Dd18perJvH/2gRDJWKsok5JYX6kS9omiGcyFtGTD5NQpsnP3f4hxuRqUs1irYH9VFd2yFuH6t+/Lo2XWzc2TBwmhpqAmHtoqNROmIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892927; c=relaxed/simple;
	bh=0TsDZKi29SiffmXpQr3KzDV/t4/+bSUWQ62GZZeuHQU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kPyyhJZg/dKi0chsw4UpEH0Y6wccwdO6ID2rXWBRzIYvuH43TZMLBx+6gXsDktMcPqBy+IA7X2pZ3opy0qavPSkzvafEaoyJaTmyGn/I8M7rGyjaYKV87IW2JzLOdS+CEjNC9YwEj/Pu7kMh+siV2vi4Gu8iveO1OK1/8bmQb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34ht44XN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJJUVpbA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Dec 2025 13:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765892921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUuk6a8PF/YV9Xj9J1Wm2CzRRdlhzMDlY+20ebKnZQ=;
	b=34ht44XNzbaBrb4ohTA1HGoTR2bMPZJsQYxN3uA5j4tNABzx0J/EQBqzfioFVAeSYFnodZ
	XetNmqImNMlmLQfc7K+EZh9xj4ARqfmUjP4tAZ8oakdk0Y5IfjFR5nNhT65pz6oFpZMdOA
	hSmK/rYQiKer/I5bJuZmtXOWdtk4NZm+3qogjHkw44KFHFu8fnlgVQfSS0lHFgteq2jvkI
	ed5vKfCnUPJvaI3E5jQIidZuEA2ABNLXIAFYTUgiYQmbctgrjtVHWyB8OUn7tByh8NLLhB
	mJ8NznEN30FaxkFMCmF/Hli7JsOu1Ay8ADUhWxWOMEoaVmLtegwKp/VmPdcKjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765892921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sUuk6a8PF/YV9Xj9J1Wm2CzRRdlhzMDlY+20ebKnZQ=;
	b=qJJUVpbAYafZYSz/YQjOunUUOcDQPZZB2/9di24nsk/Z6WSbB9mFKmf8kUi9VUBYFprwbD
	WOywSZqVEsJrlPDA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Wildcat Lake support
Cc: Zide Chen <zide.chen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215182520.115822-1-zide.chen@intel.com>
References: <20251215182520.115822-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176589292037.510.1492747132077966710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6d4b8d052ff22742c3980fa45f26b0969a9b6163
Gitweb:        https://git.kernel.org/tip/6d4b8d052ff22742c3980fa45f26b0969a9=
b6163
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Mon, 15 Dec 2025 10:25:18 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Dec 2025 14:35:59 +01:00

perf/x86/intel/cstate: Add Wildcat Lake support

Wildcat Lake (WCL) is a low-power variant of Panther Lake.  From a
C-state profiling perspective, it supports the same residency counters:
CC1/CC6/CC7 and PC2/PC6/PC10.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251215182520.115822-1-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index fa67fda..b719b0a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL,PTL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,19 +53,19 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL,PTL
+ *						GRR,ARL,LNL,PTL,WCL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
  *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
- *						PTL
+ *						PTL,WCL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -78,7 +78,7 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL,PTL
+ *						ARL,LNL,PTL,WCL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -97,7 +97,8 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL,
+ *						WCL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -654,6 +655,7 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

