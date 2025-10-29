Return-Path: <linux-tip-commits+bounces-7050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C3C1968B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9324F40797A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549533374D;
	Wed, 29 Oct 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhrGaGog";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKzMsSJA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF92332EDC;
	Wed, 29 Oct 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730590; cv=none; b=G3+hsdqUNfRYSLtQkjECtukt8z6jnAs6lZqjuIVN9rwMfKmsD3iOspfFO2W9ldIHqj6iqkW6LT7nq9pa2mksi3wcpKbtx8VDLivXo5Ncg2lmEkXPi2pQ4dmkRln3QaT7fZnJSQGNO+g3xDJ8irUwAYb7zJohU5k44p87cEPj764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730590; c=relaxed/simple;
	bh=eOOfMjpkywRLz8Rj4hNNE/tIjDdNfiBcelLxEachPE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VGfooelGfx3NksWTyd66vXlKsC7DJfmW0vuIeR0iE1MIZmSQnXcTaHz8I320AS+YjhmbkCyFidEbYbZhu16U5rsoeUlfVID1bzbZhS313jT9Bhn+cpTlGrWDYkwR5NBFo26Eh562Ij7S3MEzOS3dCcSTecmJVKlotH0ULSzWbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhrGaGog; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKzMsSJA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3i1Lv6AOpLvPTiEXpKMIoEOadRlNIGZXmsQLxkb8Rs=;
	b=PhrGaGogokrhFBdM6EGqqhRC7B52tYCR80LemxPS31AEdTzf4ppM63TwWcpdTwNKHFpWsv
	r3iWzxRl/6+MTIaH67DIR13G7LI836ew5hhqlRIm7wC2ezMSfuwJAO2R3vop69PfeJx1rA
	sDISAUFmEZ4tT6MOsnS+MN9iEMaz3/O0ONoilHi0dPKeX/hANatOAnkvgZy/X8avj0klPH
	uULhOzllnpvZejii5Mvs75peC0DUwcDf45ssWWCQyAK8/kk9fOVzO2tqqpa5f01jJAhvrH
	fjwPH1CGks6awrJsYNeaRBr3kzvQF+C9uDifkL3K+IKrrzUglzXEjGaAKqJjDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3i1Lv6AOpLvPTiEXpKMIoEOadRlNIGZXmsQLxkb8Rs=;
	b=iKzMsSJA8iWJkVHFp6QSoPukPTGfdMCuBw90Z4iMHg2opYdWxDc1znUFMriz7zkIQ7HtCq
	e/9CallkZKHjdBCw==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/cstate: Remove PC3 support from LunarLake
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251023223754.1743928-3-zide.chen@intel.com>
References: <20251023223754.1743928-3-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058530.2601451.5637563787341998949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4ba45f041abe60337fdeeb68553b9ee1217d544e
Gitweb:        https://git.kernel.org/tip/4ba45f041abe60337fdeeb68553b9ee1217=
d544e
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Thu, 23 Oct 2025 15:37:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:54 +01:00

perf/x86/intel/cstate: Remove PC3 support from LunarLake

LunarLake doesn't support Package C3. Remove the PC3 residency counter
support from LunarLake.

Fixes: 26579860fbd5 ("perf/x86/intel/cstate: Add Lunarlake support")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251023223754.1743928-3-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index a5f2e0b..2bfd011 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -70,7 +70,7 @@
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL,LNL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
@@ -522,7 +522,6 @@ static const struct cstate_model lnl_cstates __initconst =
=3D {
 				  BIT(PERF_CSTATE_CORE_C7_RES),
=20
 	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C2_RES) |
-				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };

