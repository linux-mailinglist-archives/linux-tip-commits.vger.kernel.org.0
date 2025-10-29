Return-Path: <linux-tip-commits+bounces-7049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC811C19724
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE8566FDC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE6333425;
	Wed, 29 Oct 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNpgC2TJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="96sP1rd5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F73321D9;
	Wed, 29 Oct 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730588; cv=none; b=TiRUsQI2aarwjAxdPBwMLeHKS1IhwGRm2bTxDU4IGXDvLZz3iAqa50Tn8cSo0+Ap/k5gzb0ZscdsDF1fK5kE/Srsn1eCyp71+Tp3K/0ryl7kKrHbCtIV/MWJ6dBDqcDD+fRrNyjdbOhRLLHenLkb9GQFgkA6jIoPNwX810WBZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730588; c=relaxed/simple;
	bh=SuUYK/8otYORJiuvZsWOB0KMT3wOa5IZjqQ2PUrq3C0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V5/LGQFs8MCDNLeTgAMkdDzylxugjKwSmuNNu//BxhmUNfTt5HI7dD4Ubw+CPRIkFSAadIxSEb+3jwrDlIrL8esfkjSbccp8hxicM4u4wTn2btx8jy5hooq/f0cT0z2CnBp9uRROGGdZ/a7ZfZdIUvHTeQO+LViWa/4tNXs9xAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNpgC2TJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=96sP1rd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueBTrPJcIklOL9FOg2IAIdst/VpZ8QVXsfplxqJhhqc=;
	b=MNpgC2TJxOJzB9eG/EN5/H1P/2B6rukwMTSK+AfMc+GbNmLHWIaikOFyVtu3WfQ5cTs4rp
	Igm1aSrE/fNHlhK/+uXtr+vK7EA680JJ0VeSBjgiFOk9yJ2ZRqKSp3aUkOZUBaJpC6FG6Q
	QEI5pGsHyO4OqRlegUuuESwf6ZDdDZKI7Xn2IeXpIfOjXZSx3BWno0+TNy9kPGfVk+LA1V
	d34ArD28xavDTIXCKOfN+yvXTO9X8fNxQovPI9B35X6r+uC5BSDDoCI1YwTwdFW6ix5vEr
	ps4C7Np6A2orz06wWEDDomXeHPeKgjq6SZxU+P8tkh+3SgEGpiz+fodAOF/Kyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueBTrPJcIklOL9FOg2IAIdst/VpZ8QVXsfplxqJhhqc=;
	b=96sP1rd5auuUCaavsQ7l5dV8eQ8oLItpSPyJ0vG+e75g9uwnIdgMIMO9u3zYJuwm9zG0ah
	P59h4zmmXstPmqCA==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Pantherlake support
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251023223754.1743928-4-zide.chen@intel.com>
References: <20251023223754.1743928-4-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058398.2601451.16733260783417618599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     34976eaf5f83d2bda76eeb54c5bbcafe87245e82
Gitweb:        https://git.kernel.org/tip/34976eaf5f83d2bda76eeb54c5bbcafe872=
45e82
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Thu, 23 Oct 2025 15:37:53 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:54 +01:00

perf/x86/intel/cstate: Add Pantherlake support

Like Lunarlake, Pantherlake supports CC1/CC6/CC7 and PC2/PC6/PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251023223754.1743928-4-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 2bfd011..fa67fda 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL,LNL
+ *					  MTL,SRF,GRR,ARL,LNL,PTL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,18 +53,19 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL,LNL
+ *						GRR,ARL,LNL,PTL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
+ *						PTL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL,SRF
+ *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -77,7 +78,7 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL,LNL
+ *						ARL,LNL,PTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -96,7 +97,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -652,6 +653,7 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

