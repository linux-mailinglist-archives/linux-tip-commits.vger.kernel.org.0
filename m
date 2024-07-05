Return-Path: <linux-tip-commits+bounces-1608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E07928E80
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22B81C21559
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7547176FA2;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/hQ6IzZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdXruBEF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F816F8EC;
	Fri,  5 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213608; cv=none; b=qm7k6QIn6AgRjszHRmPWXoH51ckvSnTlNxYv9wnBl31BoxztwTb3FtjWAnrS6AULSQvHlD0YcsHR5P16ud2IO56d5DKsk16olJYJ0BxHaTnzs0z4IMyZrJ5NIPiTM81wgrvynlAeN9koxYoEO8hnjSFjr5GbV1+JnG5UiI4nnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213608; c=relaxed/simple;
	bh=HORWNaInMxa31FR9APAX3sy92/mT/44Dk/tDafZyz6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BmStmLe9P2F6GJ91uKdOFW77rQ8iUsBwbXHDB+WUOopd7Dy57mYBl20U9nC/B862eE5lWcUPzjchCTsJHBKklp2QODBq/WOKU4wLt5J3hKIAuyQWLsQpMs6GtqUB9nm0stW3TotcGaZjuFoZIy8LYD9ZGBqPL5RIR9mqkvaIqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/hQ6IzZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdXruBEF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkhxBYCPER/mI+FoqSXgY9IfqxD5UYz3M6LWhIUfwq8=;
	b=X/hQ6IzZW4Q3DHJJfYkGkp2f3k4OP/69ZG7jYB5mHwmnZn75Kl+jxjfiAndHprj8qyACmE
	LKL8PctZrDPIDpA65kRH5qvSRDZGAp/hiIpo2TpyF/l/te+mXxJI0Fj3Z45qhf8M28x4fQ
	HXcNr0FxZPQV4BvfIkHXFDFwC/R02yUIcPdVFg6SVMF+otT08s1OdPe5vQV2WLC1NrC4OD
	kZNndxMr8SLBeRDnejyor+7VzFs9zfxTg4xy1texEx3HjqHIwo4Xf8n4oipwhfri9jP+qm
	8LUdCiQXnzoTNsKhr9j/jdYUde6e8BmU2qvSm3cvkAK03L0wa3oZS14HVbkjQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkhxBYCPER/mI+FoqSXgY9IfqxD5UYz3M6LWhIUfwq8=;
	b=MdXruBEFpU9uPCylm7CXc901Xz5S6hXtRL9p4pgzW6kHMWRyhNS1nAy8ozd32Rv+8XGwBH
	b05KAgdcIHYMqeCA==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240628031758.43103-2-rui.zhang@intel.com>
References: <20240628031758.43103-2-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360480.2215.2382611613265250508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2c3aedd9db6295619d21e50ad29efda614023bf1
Gitweb:        https://git.kernel.org/tip/2c3aedd9db6295619d21e50ad29efda614023bf1
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 28 Jun 2024 11:17:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:34 +02:00

perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake

For Alderlake, the spec changes after the patch submitted and PC7/PC9
are removed.

Raptorlake and Meteorlake, which copy the Alderlake cstate PMU, also
don't have PC7/PC9.

Remove PC7/PC9 support for Alderlake/Raptorlake/Meteorlake.

Fixes: d0ca946bcf84 ("perf/x86/cstate: Add Alder Lake CPU support")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240628031758.43103-2-rui.zhang@intel.com
---
 arch/x86/events/intel/cstate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e64eaa8..bf0bfd7 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -81,7 +81,7 @@
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL,RPL,MTL
+ *						KBL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
@@ -90,8 +90,7 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
@@ -636,9 +635,7 @@ static const struct cstate_model adl_cstates __initconst = {
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
 				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
-				  BIT(PERF_CSTATE_PKG_C7_RES) |
 				  BIT(PERF_CSTATE_PKG_C8_RES) |
-				  BIT(PERF_CSTATE_PKG_C9_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 

