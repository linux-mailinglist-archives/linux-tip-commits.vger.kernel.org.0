Return-Path: <linux-tip-commits+bounces-1788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4364593F295
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD3F1F223F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13C2145336;
	Mon, 29 Jul 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7nWnVbG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TiB5xsZR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533C1448C8;
	Mon, 29 Jul 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248693; cv=none; b=bqdF/SFcJAkmLEtK8aUQ7jYnqCJq/9hokHb1ovjoqu0OSDRBeCWYpSocs/YwJpGnff71g8bKxjwIjaE8x6C8WlKINdsq6j6EQNZFykmL86niH/w75e1U/fD9Bdhjw+QAqn2Q4B3rQNo2DMf5A+DI0sZpKHsG7/yrPJrEyJB1g8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248693; c=relaxed/simple;
	bh=tLAPy3f58OoVOqSXKhNhOpeZ9cOV0ls8Nl/LSknMI+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ujBoSWLDeonfh6tgUpZZM81xxD+XJYRIK435KRuu62EXGtfbwcZO/nDeNZkfUzdzVKnkdgdaeBeyNgjzDJ1GI/zApY+tLBYJiR+vyLsBxpTRmqR6NCgQEDe8xQgatULcMJXWkTzO4LF13g4a2NZmTXB+hc6UTkcAOFubeP17vNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7nWnVbG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TiB5xsZR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CpPChjpJG8n/hB06rBoS+ADx5Vp67nvwNi09une7g=;
	b=G7nWnVbG9idPZz2ABV3XKxkmcXg26yPExx+azFg4Si+6M6aH24rI9ZvWOuYjBrxdXBQaEC
	kFgAM2fGGNPF4qGkSAq00jlmzkZmoSd3OduFx/HkHs9SBdQHMUX+vk4G5lG0BirT5CRicC
	tP8J5gDjPtV5JrofF6tnYs3MJZQYVJhQkzCNAxHSJM4SGJq/bfKUynqL698m6YcwTjjQ6t
	Qb1abUGPYASvcSuDeZxpA/f+7fJCZzye2yNL/f9EGjB3NJfwaE2Im2XuPhEbo1tYJ68AML
	9NT2CaobErAS+6bmmjqAwNj5DKj2Blbnj1kds4QgW8AiKrlk8moMqcbp2QCCeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9CpPChjpJG8n/hB06rBoS+ADx5Vp67nvwNi09une7g=;
	b=TiB5xsZRIAT71UhogohHw5nwhp2jsiJXCCknY/3uUi+n2tyn6nKhaN05hbLBSTaRoU02H5
	/nCrLbnEk2ILBzBA==
From: "tip-bot2 for Zhenyu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add pkg C2 residency counter
 for Sierra Forest
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Wendy Wang <wendy.wang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240717031609.74513-1-zhenyuw@linux.intel.com>
References: <20240717031609.74513-1-zhenyuw@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224868941.2215.15632178560218109190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1d0e15c8725d21a73c22c099418a63940261041
Gitweb:        https://git.kernel.org/tip/b1d0e15c8725d21a73c22c099418a63940261041
Author:        Zhenyu Wang <zhenyuw@linux.intel.com>
AuthorDate:    Wed, 17 Jul 2024 11:16:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:16:22 +02:00

perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest

Package C2 residency counter is also available on Sierra Forest.
So add it support in srf_cstates.

Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Link: https://lore.kernel.org/r/20240717031609.74513-1-zhenyuw@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index be58cfb..9f116df 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -64,7 +64,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL
+ *						RPL,SPR,MTL,ARL,LNL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -693,7 +693,8 @@ static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
 
-	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
 
 	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
 };

