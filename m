Return-Path: <linux-tip-commits+bounces-3696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD8A479DB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6358D172BE5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACB22A4F3;
	Thu, 27 Feb 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgGVkTmD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JBf/UJOG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB261227EAE;
	Thu, 27 Feb 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651128; cv=none; b=Zb5FCLPhQvC+22+ARbu4hi6VjLzFcg3SA0K9vBQIeBOlHHAQd1FYcYm6AdW5WL2dflTxXPnUpRL6ZKZXGjxNxV0bDviuOr8mVPqcLon4UiIgV6PwxlzlbAU2WDIh4Qj0daPTZPngo5OwTV3+eqcUIEV4J8ClftupbeYok0DJh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651128; c=relaxed/simple;
	bh=3SB+uH8AbEKJJt5JsoiuiAItiqIqpen4K6t3TvtOkiA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gu9Vfz12ogT7Dh4CT672vywHSRChrQEr+d989eKGrj2tTHfbT49cJcQ9DUPGJld8v29tTgJfqnVwCGVsCrsbIV1HwR7QALHJaqwHOogmVOkKioB5qq2FwGXFvfCpB32vkX7Di0K0a7mV/JhgfK6OXVjBS1TynxPzpjaGPX1757A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgGVkTmD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JBf/UJOG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF0ixAmiLtO24KcMi2Dtz13A9/5S9b9nuSnk4g7HYjs=;
	b=JgGVkTmDg+TNIEk+YZFyv5avXnUuU2N2KwOAaVUkbvIGWm4Dm1qBg0l6CYTdLVd3+Q/3+H
	0WwCOeSkDGNqjcSWCtmasuPixA+lQEyIwWMsyznQzcH+HhOTyN7AbD/FdtbO7fYrxHHM44
	VbH65wv9FbiUrUkvNYQWYCaLMDI3V5DUWjZosAn3j3E+b3ZzXzICOCWlU/Gs16VQAXaPYU
	W61hBm4Jmrz4ZBb65XwIeYs/G/CyWSn4tRAvTgXm1T+iuK+pcW6j7KVbqlv49DIAO1A2hR
	7WJ4MnMDrmTVmC+0m7F0KZd0bMNiRoC+E9B20bWsgytYNbRj/QlRCJ5ExupQgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF0ixAmiLtO24KcMi2Dtz13A9/5S9b9nuSnk4g7HYjs=;
	b=JBf/UJOGkym0DHXWe0XgOdMklI5puSG5WKh2nlK2t7HVHyo3HaVXhjmxZKsL97dzZPkcNI
	pwrnPK7kSFPJCcAw==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove the X86_FEATURE_USE_IBPB check in
 ib_prctl_set()
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-4-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-4-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112356.10177.673205901241431963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     bd9a8542ceccce1b1d5d5fd5e47be57fe42f9bb9
Gitweb:        https://git.kernel.org/tip/bd9a8542ceccce1b1d5d5fd5e47be57fe42f9bb9
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:09 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:20 +01:00

x86/bugs: Remove the X86_FEATURE_USE_IBPB check in ib_prctl_set()

If X86_FEATURE_USE_IBPB is not set, then both spectre_v2_user_ibpb and
spectre_v2_user_stibp are set to SPECTRE_V2_USER_NONE in
spectre_v2_user_select_mitigation(). Since ib_prctl_set() already checks
for this before performing the IBPB, the X86_FEATURE_USE_IBPB check is
redundant. Remove it.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250227012712.3193063-4-yosry.ahmed@linux.dev
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 754150f..1d7afc4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2272,7 +2272,7 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
 		task_update_spec_tif(task);
-		if (task == current && cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		if (task == current)
 			indirect_branch_prediction_barrier();
 		break;
 	default:

