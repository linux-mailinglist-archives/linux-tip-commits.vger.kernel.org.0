Return-Path: <linux-tip-commits+bounces-1610-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99A928E82
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60EFB27F48
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8C177999;
	Fri,  5 Jul 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kddaUiB/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9UkWZbyT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA716F901;
	Fri,  5 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213609; cv=none; b=aDIsA2xNslacCkhkL8BbuprFUcdFeiluURmlMmIEx534Es1PIaV23/6K85s5w9jofuxnrEGh2pJ3x4hkCdc9LMxCHlP0+lW2EwvGiPYeeIVgPnWSDfmjJiy8fMuZtJLilnNGcqal85SoQ1Or1s+BOU5iX+LRzDRTKokOc8c8rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213609; c=relaxed/simple;
	bh=W/k7YvfAEqpxOgjBTJg1foWAM+ZtdDB7q8NHRZB4prE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=szH7OGUya+LM1DRfThEA/OGePv4FAOLDxMAmBwAoVPNeQ/bOMUGMUGnHkFmpsDipw5HNgv1xIMgZvzxizJ0IMgslHjEbKMQ7o38U6nD2ChTSAGAkRlchSsyG/Y7zYX9qPA2fMeCfeJQtA2WP8vSzyeP060YiPtNRoQXxODtH+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kddaUiB/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9UkWZbyT; arc=none smtp.client-ip=193.142.43.55
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
	bh=khPPS1hfz8u+wQnFlyrkCXiFH23eaZ0VvMkKd0mrG/o=;
	b=kddaUiB/uj5f95ZH7tkgxPDmMdk76LNy7d/QN9NTXRigfHWtpPiUh58C8KKUbKuuqNTTWP
	5qTfHZ45EcUScjq3U8BlrAebDHeShPO/8JyzVGpy8+HiLg/CSL8lq0apsK5Xw7qtj11YA6
	ABz2xOYqMOd4Y1J/dN6W53g+pALp3TzX43a0rhNWkfTrwM3Cq9refd55UbJ6RaFHWKlLBK
	nHNY0DR46KTKkXNXjGygiLjQ1GxilOUs2NNNMoqfmi9xsXNbOzAS9QnycwmKEesuQWyzNl
	PBJUWup4EmYizVV+IuhlK057eAP6r5AnndxnOH2xapEWjt1Hsj7mZ5riKrORhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khPPS1hfz8u+wQnFlyrkCXiFH23eaZ0VvMkKd0mrG/o=;
	b=9UkWZbyTXueUTljSlIzhZQpFSHiEIPXFxtgSyIM9kF9QVQ3/McJ0TS6MQU3iF22u35XAvq
	yO1mKlKSWOqM7fBw==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Arrowlake support
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240628031758.43103-3-rui.zhang@intel.com>
References: <20240628031758.43103-3-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360441.2215.7045968313476220032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a31000753d41305d2fb7faa8cc80a8edaeb7b56b
Gitweb:        https://git.kernel.org/tip/a31000753d41305d2fb7faa8cc80a8edaeb7b56b
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 28 Jun 2024 11:17:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:34 +02:00

perf/x86/intel/cstate: Add Arrowlake support

Like Alderlake, Arrowlake supports CC1/CC6/CC7 and PC2/PC3/PC6/PC8/PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240628031758.43103-3-rui.zhang@intel.com
---
 arch/x86/events/intel/cstate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index bf0bfd7..9adfdf0 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR
+ *					  MTL,SRF,GRR,ARL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,30 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR
+ *						GRR,ARL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL
+ *						RPL,SPR,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
+ *						ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -86,7 +87,7 @@
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
@@ -95,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL
+ *						TNT,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -759,6 +760,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&adl_cstates),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

