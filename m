Return-Path: <linux-tip-commits+bounces-2172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032F96D40B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7012844B9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294B19885E;
	Thu,  5 Sep 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ecjbbmdf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inonchWK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000C47796;
	Thu,  5 Sep 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529663; cv=none; b=eAkkqCExeorieNbh1Qqy3jcd4lBUGGcZUh3hZWuSleWe1JaziGbec3KvEDm83M956FC6nLlkvdar6PZNJxpAyVu803DuyEMx5BvnBtnkJpFZdRj4SAjZJObJCyNJ0TVYjFGfiARk/OxDg/VqN+tVXJ289av2x6W1e1qkw0jE9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529663; c=relaxed/simple;
	bh=xMzNaWyGUWpvjW9EV6HlXMME3B51Ls+X/dfJ8kjXxhM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZZIZcQ3DfHqcE+srft45i9kPEDfoSkvR7dLBhtUa5RgbH7a+GL9JJR8TrBmtxkI2phzNSBYmmsdMTjZ8WyCQvLJfIMJtZtN6+fnMaTj/kYawjw/dsMM2v6sAiDrs5dLJJioCidflPemYQVDh+oG9iBBQLQR7Ye8SACyUD/lhPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ecjbbmdf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inonchWK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 09:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725529659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyRCT1hnfWSq9RQNa238X5cw7dy/AXs7k5VYwEFO0dQ=;
	b=ecjbbmdfUVhrmoGly/ygbBLj4eDovbLp6MJLh2abiwD+VnsNS9fF7iwO/bClio1HseVV75
	KeemMpdt8+vjGhxxIgwgVfD4T/GeHb9xzDZEZ5Q4ApFaxvvvMmMKwzIKUMwXlTgIC1P5J8
	yC8H6KnJYI3LoEn5LqI42RNCAwph3Bv+1JtMjqr0iqDm4Yjd3CKLdpddDFE+vIhr79i8uW
	/i3dNT56QOWnIk7BeK06XkTUbSUeeYUtGbUUM7sDiDAuf1foWuuc3Rk2nqRH3rPQpTmC4u
	deY5ML8aMBr3IuM3cr8S1xGUPs8LTeekC0GsM+i7bvQg0zR2j4IU2wVIHX9YRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725529659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyRCT1hnfWSq9RQNa238X5cw7dy/AXs7k5VYwEFO0dQ=;
	b=inonchWKC2gIIC6R+7UAYlSgma4up7VX+bFwEKI+LBnaCSpHfS5UsLhLz0dMaeptf+BoxP
	30SiGJPrwpPXuOCg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Fix handling when SRSO mitigation is disabled
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904150711.193022-1-david.kaplan@amd.com>
References: <20240904150711.193022-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172552965872.2215.17085347492363546574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d
Gitweb:        https://git.kernel.org/tip/1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 04 Sep 2024 10:07:11 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 05 Sep 2024 11:20:50 +02:00

x86/bugs: Fix handling when SRSO mitigation is disabled

When the SRSO mitigation is disabled, either via mitigations=off or
spec_rstack_overflow=off, the warning about the lack of IBPB-enhancing
microcode is printed anyway.

This is unnecessary since the user has turned off the mitigation.

  [ bp: Massage, drop SBPB rationale as it doesn't matter because when
    mitigations are disabled x86_pred_cmd is not being used anyway. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240904150711.193022-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 189840d..d191542 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2557,10 +2557,9 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	    cpu_mitigations_off() ||
+	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
@@ -2591,11 +2590,6 @@ static void __init srso_select_mitigation(void)
 	}
 
 	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
-
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
 			srso_mitigation = SRSO_MITIGATION_MICROCODE;
@@ -2649,6 +2643,8 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
+	default:
+		break;
 	}
 
 out:

