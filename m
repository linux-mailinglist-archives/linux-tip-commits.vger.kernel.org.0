Return-Path: <linux-tip-commits+bounces-3223-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916FA11D39
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D852016318E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF028EC89;
	Wed, 15 Jan 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5Y7AIA7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRKCCKk+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A2236EB6;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932641; cv=none; b=EXSnWnW9VrkxflXIusqFOnM3iZvHrmSxAonVQ7NSah2GiuE0h59nRWFGMdJ4fXAR506zLSG0A5L/Q0He18S1mHOsb9Fa+ZEhuRNFJxCVqe6dOUFbFPG6VNYcTstencxPkRvI1SeH6z+vwthqb8FE6bqOXsicTFdMXOE8wuYzXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932641; c=relaxed/simple;
	bh=Fg29oHccvIwt/seAJMZUhqKDu7n3rpJVDKInEW8TBO8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EdsKkJSkIgNOA6eMsWy165t461N1I05xn/lCE+ctQNO0hAR9aPALRCxc0yLQ5o2AODh2YXDoCWWq9xv3h9qOMYRXIfaeTdXB70SNBM6Q3x3VSVsqARF/mrGxpqeDk9HMTITQJxhdsQvEKgmyKIi5dXmdJfQiUGs46bxobQOIpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5Y7AIA7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRKCCKk+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPfxYxBXyBsaUB/x4jpozM72FCfON+H/i4RwLAlL/iM=;
	b=C5Y7AIA7uZMW9cpTa4yCUvcdDIBAPqtNhM+7OcnX/Xm4lQGvVvJ5yoR1xxEgd/Hi11wljL
	DbI1OAYbcRKPU0HaVCjVdWdjtnuvK0raQZLPiLsS5yHIKFA8h76dZ7k0gE5Xk/7/TNmwtP
	rb0hlAM076YjixY92VShjrtQoeEKL1psudaq+5JW9DeZEbFy3sm9ixNW7q+N5PHtL1JQAe
	HDUj8pq+3mJylRx4slz3Q3ERbg7zx/vs0CyRxOz4KtAH5KeDLTbHC8Fkk+S+3Kz4w3SS5j
	yJhU2yLoaLSr8hULNvzrmeCj9BpW+5LD+DDTx59fBWnb0XaWyJ1fYPNbW+6jog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPfxYxBXyBsaUB/x4jpozM72FCfON+H/i4RwLAlL/iM=;
	b=HRKCCKk+w2ZgLtq/rec7dZu6yuX44uCvlOrcyjoRSZjGM2TEngDL0PjOkF88ntukVy2TN9
	I4mWTRos/3MDHrCQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/topology: Remove x86_smt_flags and use
 cpu_smt_flags directly
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-5-kprateek.nayak@amd.com>
References: <20241223043407.1611-5-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263649.31546.9315263291780431897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     537e247879589f6bace747e3479e4abf42dbbbdc
Gitweb:        https://git.kernel.org/tip/537e247879589f6bace747e3479e4abf42dbbbdc
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:03 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:24 +01:00

x86/topology: Remove x86_smt_flags and use cpu_smt_flags directly

x86_*_flags() wrappers were introduced with commit d3d37d850d1d
("x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU") to add
x86_sched_itmt_flags() in addition to the default domain flags for SMT
and MC domain.

commit 995998ebdebd ("x86/sched: Remove SD_ASYM_PACKING from the
SMT domain flags") removed the ITMT flags for SMT domain but not the
x86_smt_flags() wrappers which directly returns cpu_smt_flags().

Remove x86_smt_flags() and directly use cpu_smt_flags() to derive the
flags for SMT domain. No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241223043407.1611-5-kprateek.nayak@amd.com
---
 arch/x86/kernel/smpboot.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f08..6e30089 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -482,12 +482,6 @@ static int x86_core_flags(void)
 	return cpu_core_flags() | x86_sched_itmt_flags();
 }
 #endif
-#ifdef CONFIG_SCHED_SMT
-static int x86_smt_flags(void)
-{
-	return cpu_smt_flags();
-}
-#endif
 #ifdef CONFIG_SCHED_CLUSTER
 static int x86_cluster_flags(void)
 {
@@ -519,7 +513,7 @@ static void __init build_sched_topology(void)
 
 #ifdef CONFIG_SCHED_SMT
 	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT)
+		cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT)
 	};
 #endif
 #ifdef CONFIG_SCHED_CLUSTER

