Return-Path: <linux-tip-commits+bounces-5018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F169A90C19
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 21:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375094609E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732A224AE8;
	Wed, 16 Apr 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/AjE96S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+x9Q+O1Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB982040B4;
	Wed, 16 Apr 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831000; cv=none; b=XeCAHhDdbcSxC2dwlNYeKtkf27moaHFwyd+1H/dQ6MOE0t/72I7UFCOD31MhNgfAk+DRqzc+p6IycPIsR+vwqcDGLv3g2/bFn1iSM4zKc9PL3B8PjxQb2EWaWQ4ox3uM8h7Md7bc+giqrGXaUv22rhg0ERhUAGNqVigwPEaDxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831000; c=relaxed/simple;
	bh=Ne2K42cedbErzkuOPKDKqQfg7DPSI9Q6asi3M4+Lia8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KMl1HJ6rfS/Gzkn7Nqq/LU3LmbxCOgkBtdeTtbEE2x7EMOEbHO4Sded+6YQZTJDtCXtKu6zMdaKN+5GLCGW/fxp8GrjCYxxQAaIxwP5SZDxGtt3sq9vEGb0Y8kjczRpQqV+RMJ8xb7DfrVQomG/BE2XX+ByBTrI85oc2VDT2qUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/AjE96S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+x9Q+O1Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 19:16:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744830997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy14Oh6mzfQR/r9jF9cADxD+hdKqheBQkqRWvx2RCBU=;
	b=C/AjE96Sonl0DnUHL31ved977dMCARlLffdqfWtvfMrgR59NJlsyrmD09BdUobSJxeZkIU
	lP/207VUqyQTRx+CgpG5IjfsxDsV35H2N9H3zHYtK/6TdKSON1l2TgmAyik+wSiN5dby0S
	ci4xsLBlrSoSPkexqv+F2Lx1Ol59BX3zDGs5MAPfQGbss9y4+5vESnybAQzK7/UTcwVIAq
	ezgOfD5+gpZXpVsRevvoZQIf7dyJSBHcIbMKGpYcCdvrsp5c+ouYB/ieCC27U83AstIxhN
	0GFlxEfwxNmvtbCi77JJyc4PxeANW7epKSiEjWTfXQGhxmzcGz2EBb2RF+REIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744830997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy14Oh6mzfQR/r9jF9cADxD+hdKqheBQkqRWvx2RCBU=;
	b=+x9Q+O1ZNa1Rj1775mSN3OGVVSX10DcNGbtzKzzIuqs6+mkKoFTidl66oG3LCUYiS4TFFP
	AhdVwyb1uJO6vIBA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq/amd-pstate: Update asym_prefer_cpu when
 core rankings change
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250409053446.23367-4-kprateek.nayak@amd.com>
References: <20250409053446.23367-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174483099634.31282.16693779004724554985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8157fbc907452aa5674df2de23c1c7305c907006
Gitweb:        https://git.kernel.org/tip/8157fbc907452aa5674df2de23c1c7305c907006
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Wed, 09 Apr 2025 05:34:45 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Apr 2025 21:09:11 +02:00

cpufreq/amd-pstate: Update asym_prefer_cpu when core rankings change

A subset of AMD systems supporting Preferred Core rankings can have
their rankings changed dynamically at runtime. Update the
"sg->asym_prefer_cpu" across the local hierarchy of CPU when the
preferred core ranking changes.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20250409053446.23367-4-kprateek.nayak@amd.com
---
 drivers/cpufreq/amd-pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6789eed..8796217 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -844,8 +844,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (highest_perf_changed) {
 		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
 
-		if (cur_high < CPPC_MAX_PERF)
+		if (cur_high < CPPC_MAX_PERF) {
 			sched_set_itmt_core_prio((int)cur_high, cpu);
+			sched_update_asym_prefer_cpu(cpu, prev_high, cur_high);
+		}
 	}
 }
 

