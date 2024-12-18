Return-Path: <linux-tip-commits+bounces-3105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8269F684A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7125616F985
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9C1F2C52;
	Wed, 18 Dec 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZYFp1Kg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wzl4z3rr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61831E9B24;
	Wed, 18 Dec 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531762; cv=none; b=a7qm/Gyw8GASLy/24rA/ATXx+cSKgYeRmQ6xhiSZNAvVYfRt1CgsKwFVz6DU4iIxW7wXLYVBzjzdLJf+S/0GmCmaEYH2Tqb95rNpwR7mzxtE7buBaYkpeujhfakq7rr2OkG/hfktEKlz3ZdF4NDDRaVCbxoSE+kGj96PenPr844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531762; c=relaxed/simple;
	bh=nGXLvMHOtDFuJmKPtFUxAW0ugorPJMTgKEyuVDy1WWk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=p31Y4M/LpABvfThOn0oJyfkJUxJ2fQUxHIPMw5cLdW+x1sbOwnkhSeRbpFwKHwhH0abdtrNL/Uy5gz6xLeviv1Az0kwBB+210aOyxjDPb/kqA55pxR6a2MGGww14SvER0f57zMT/oBmZsRoM9TBnnjULTf8jejuW7/djpVRvTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZYFp1Kg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wzl4z3rr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=idE4Zrz1csVxvgqNQzaRqF/ekiSr6dLve7iC3pX54Yk=;
	b=eZYFp1KgPe9Gw1Q7YE+9/INF0uzarR08jRFQpyArjXDSVaLnXFfdg/miK1uadZyuIw7HEO
	ciyFZd/CPg8c1OTdtQG6y/u3IcVrAi5x0kLoPTYiOyzA/kHO8Q2ytbTEgOfw0VEMwsZH0Q
	Tc7L7Wfvpjiq710dOabQ8/6IdYPQeYTSf+sAypX8afhWJqvaoHNESffyp4g9aEjWAbn/Sj
	FB4W7YhLLBoUronnqniRZyHq8rR/P6L3MlMmDPiMnkIqTcE34olZFkN4iJQuv3/HQdIZBB
	r9Cayoh0HkB+Go0YvxicfpKJE2MawOkJyeTc7v/URCdKhGPmQOA4ZDWGpFOtZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=idE4Zrz1csVxvgqNQzaRqF/ekiSr6dLve7iC3pX54Yk=;
	b=Wzl4z3rrb7GmlarTdVRFbjzghcRqvMBId7cHHrawd69Bt343g8sCjHaHYI+k3ni3buNdnm
	wF7ShMMmOP/165Aw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use MWAIT leaf definition
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175844.7135.10496581441774788357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8bd6821c9cf3b81d3c07a94fa4e3f97a3cc7b724
Gitweb:        https://git.kernel.org/tip/8bd6821c9cf3b81d3c07a94fa4e3f97a3cc7b724
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:28 -08:00

x86/cpu: Use MWAIT leaf definition

The leaf-to-feature dependency array uses hard-coded leaf numbers.
Use the new common header definition for the MWAIT leaf.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205029.5B055D6E%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d21b352..853e373 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -29,6 +29,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
@@ -636,7 +637,7 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		0x00000005 },
+	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		0x00000009 },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }

