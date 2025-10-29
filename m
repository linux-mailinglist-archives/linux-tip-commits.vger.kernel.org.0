Return-Path: <linux-tip-commits+bounces-7096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D655AC19DD0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EFD18941B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885EF32C92A;
	Wed, 29 Oct 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbrsR4hq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gn8nvUEL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A55329C45;
	Wed, 29 Oct 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734542; cv=none; b=NZMTroX+5m0jhu4r8odsYrqPMwzdzHKdxuCQA3B402qBezJ137EnaaKpZlbqroxo6GXB6xAFz7WHf3ftesW1DibinLPJ04Ka+7OhqbRXfgqPbJVZUSl1lESRQL0I2x8cBoxEIi2WIQRWCH5dKWPb4GeAiUhggUW0fDZP0+G2WH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734542; c=relaxed/simple;
	bh=XnR5TQQWkgb2t+1BLXDg2YRkbNjw7cElBSfBQqswmLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aLLJv61YZxY4SgbX0Rl1cQnbEAtURwZmQv0YZ1t0rZRAgOg3n3EJFsh+MdDtS8FXmImCRFbjrlkE7kcVra2cB+J0IK471YGDnfsIuq+ktcaesAa3SuVEG2ljWalk/LgRV9lsGgoADezTdPivUJloiWzyFMcDU/SiPFo+08M/hLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbrsR4hq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gn8nvUEL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:42:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761734537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnw1QfnK1WTWfaygOSoWowgI7wZuToMlN+nhoyEXExY=;
	b=KbrsR4hq2IjEAOehYwO2s7/BBy1tFw/7J1Rq0xalPFcuUAnCc02j0PbL+QnImDcKMm5Tep
	xZqg6AMMAIzKrUapqTt3w/PnagAP50uxDP+34bUATMbr7DOGvWPgCFZK8XzMyIHxhqcY/c
	7Ki2I/VvdbRxnCgfYClS8+LaLXp5YkxggpAV8e1yj2cPnSePj3h+rAzny91M/s9N5IwYnF
	Rqa9qMnDDjvzpfJx3NVXonugECitgH8M6UPk3iiKK+o+quJi/wp9Cp4WC3je/hb7tVfMHH
	KmLVFtrePSo3prMwPgXeAiXUv3KCivlhEBQD0Tu85F6och1OTtdY4KdwAUmNxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761734537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnw1QfnK1WTWfaygOSoWowgI7wZuToMlN+nhoyEXExY=;
	b=gn8nvUELwxTbnBcUxKDYqmHUhg+7sR1NgIKj4SWs9q3wEbT2jLEe8IYv7UqoUkjzqWY4Os
	pYI6i/WqGtW6P/Bw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Add PMU support for WildcatLake
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zide Chen <zide.chen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
References: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173453616.2601451.13189847202857172481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b796a8feb7cb094ee998931a96cd6152a9d3022e
Gitweb:        https://git.kernel.org/tip/b796a8feb7cb094ee998931a96cd6152a9d=
3022e
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Mon, 08 Sep 2025 14:16:38 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:31:44 +01:00

perf/x86/intel: Add PMU support for WildcatLake

WildcatLake is a variant of PantherLake and shares same PMU features,
so directly reuse Pantherlake's code to enable PMU features for
WildcatLake.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://patch.msgid.link/20250908061639.938105-1-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468..fe65be0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
 		break;
=20
 	case INTEL_PANTHERLAKE_L:
+	case INTEL_WILDCATLAKE_L:
 		pr_cont("Pantherlake Hybrid events, ");
 		name =3D "pantherlake_hybrid";
 		goto lnl_common;

