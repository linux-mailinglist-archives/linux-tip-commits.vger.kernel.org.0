Return-Path: <linux-tip-commits+bounces-3314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537ACA259CA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AB13A788A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2C205AAB;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcva94JX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cey1W3Vp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE6204F9B;
	Mon,  3 Feb 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=uaEoK0pDKMolmRQ6yqiKD99UWcAPdSqSNJCHe3vEkDjt7h4sJ+SeKSF5W9Yj4ZaCOw2bz3y/xkgn0XPKZeJqYsrreAA/zP6kFby0/FPDFLqi8G21h/ff1OkFb07U1Lmz5kygSpBJ3QGPE/+uFAs11SHnsuQDVeOE1EODCf/ha7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=EsOdw/KGZZKGasHOEkSPwAuGgQin8TCmYh4P/jdHTvM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TaoG0eEhcS1qAmTkZM6xctq7Rpxto8Ij0aFComh0sg4+U4muGrGEJTdl8qKh4/Zdf+7Cu/tJzUAUdEVL6zhK8a7RjGhKe+hLEx7eiiZE7+UtGpAr6J8EAd0+TlQk8bOyIy9Q+vV0tujimReaLaBP/MB7cWfV+dGCD4bxMlxUr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcva94JX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cey1W3Vp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vySdLVLJsEUo5lq66U7n2sqt1XWf6269xNs2dQqekOA=;
	b=dcva94JXNLbKR022GAXEpKFCUqUrw7fEuKOgA5tQjiEpYpcuT9diRty8HpVxhw9uhGszMJ
	Unbpt7ACQOVoT7OVK1pg5A3KJvx+F7UxKzU7BUUva/57scAcXXUscCl5Gmo/Pq1uWKQnKC
	4eIOg6+dZyCdPQY5fes8cU6pakftd5BujM/WTdQLp4ArcJzCDm50P2LaREUv5zUVUFILjV
	CPuMhoUpvTExbxLKJHTPONqcsAJKSxc0N++4G9IzxD4z8YczagbcZ7RJRjeBGYuFjgXGeb
	nwSSH7HE51HkxPGTT6kG1c3DU1a58wi4aRfsYMT3xrVW0WByWsPCJsebiQVKgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vySdLVLJsEUo5lq66U7n2sqt1XWf6269xNs2dQqekOA=;
	b=cey1W3VpoIDZe/Q48Ee3WuL7Vh5mq2jb0Oh1rrXnR9CcdSDyuf3uV0msaUI2YstJ76tvtx
	ew7aaGO1awtX6uCA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-2-ravi.bangoria@amd.com>
References: <20250115054438.1021-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858690094.10177.4993434304735211612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     003c0414318a1829a1a5b195ad81e8a7960c3f5d
Gitweb:        https://git.kernel.org/tip/003c0414318a1829a1a5b195ad81e8a7960c3f5d
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:30 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:04 +01:00

perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros

Definition of these macros are very simple and they are used at only one
place. Get rid of unnecessary redirection.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-2-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b87..4ca8006 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,9 +28,6 @@ static u32 ibs_caps;
 #include <asm/nmi.h>
 #include <asm/amd-ibs.h>
 
-#define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
-#define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
-
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
@@ -688,7 +685,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.read		= perf_ibs_read,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
-	.config_mask		= IBS_FETCH_CONFIG_MASK,
+	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
@@ -711,7 +708,7 @@ static struct perf_ibs perf_ibs_op = {
 		.read		= perf_ibs_read,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
-	.config_mask		= IBS_OP_CONFIG_MASK,
+	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,

