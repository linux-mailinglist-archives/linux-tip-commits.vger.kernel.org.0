Return-Path: <linux-tip-commits+bounces-5919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79423AE99AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A93A49D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E74296161;
	Thu, 26 Jun 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVOXDOoZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsiOhG/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBB26B76D;
	Thu, 26 Jun 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929004; cv=none; b=La8gd4YT+qPpUPvaj17fg2LEISfTn6R37YhlfNOJmb7JFX7Po8+7Hp9StSXMNCLykK5OEqDcP14CkYXRtpoZbK2eFr8ZxmEJRMLR4uT39QiOm8tTqq028aHidB/3GwuYZpyT902Afhucig85bjGIjhGaokrUTOvqRv7EEjuTdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929004; c=relaxed/simple;
	bh=Ajynqem2ioOKzb1RG7SUqhKZOJKIsxfiL6AdqHeyrHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rz8rxzAMCrUiQE7YMU1b5eg8ijqnVBHQ95Fu+dXcAoFaZ5hO7aeb9vqEgrzseCtF8vR6TsMFeGNmw5MyIdj4aGkbU7zh1YhrSIErWhmGw02DrzVwq7elinOcq95xQEE3HHQyG+np4EsD07CB+Zpe1VqAVyc3yrgh+NwYAlWUK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVOXDOoZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsiOhG/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 09:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750929001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLyGErgkP7aeo4xKyl4kAAV+J4OKXallBd0v3+MhuK8=;
	b=CVOXDOoZNdEB9QBksGFxwQP89nrAWyOnQFn+rpsaOLr3qb7tyNqdm/KJuYDFg6AdOY/oYY
	LSJSLRDQ5xopRwcSgBVntUNnSWdChPiSngSRsdgZoIXLnKPbgNax3mdTgF7fs1dx+u79pI
	JFTHAUJbxOl8jkrnnpOFcq+3l45rXb4hJ5aMaBGjNQEvZwZ+j8y+2WLGmAYJCjw/5wOCf/
	Enw49wqshhCuGhu+TLi1FROHJj97oBTMIkdbrWNvD4mmrT696dLGvkhYs9cq/WEka7wWrg
	wYtaQ9yeLjOWlCFx8qGMoilXIlRik4vwix+4l/MqUDV9Bgj/BUeldFZgWb4qtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750929001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLyGErgkP7aeo4xKyl4kAAV+J4OKXallBd0v3+MhuK8=;
	b=VsiOhG/1mh7EosZuO1VFoEfzzsAiVN6g7Qoz3Z168rTX/XOLrgbJJey8r6jftPOMRZ28iO
	+e5Sfv+sBpKk33DA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add SRSO_MITIGATION_NOSMT
Cc: David Kaplan <david.kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250625155805.600376-2-david.kaplan@amd.com>
References: <20250625155805.600376-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175092900020.406.6486511755076508456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     1fd5eb02867ac7db9144bd44c8edfad0189c8e57
Gitweb:        https://git.kernel.org/tip/1fd5eb02867ac7db9144bd44c8edfad0189c8e57
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 25 Jun 2025 10:58:03 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jun 2025 10:56:39 +02:00

x86/bugs: Add SRSO_MITIGATION_NOSMT

AMD Zen1 and Zen2 CPUs with SMT disabled are not vulnerable to SRSO.

Instead of overloading the X86_FEATURE_SRSO_NO bit to indicate this,
define a separate mitigation to make the code cleaner.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250625155805.600376-2-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bdef2c9..6c991af 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2851,6 +2851,7 @@ enum srso_mitigation {
 	SRSO_MITIGATION_UCODE_NEEDED,
 	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
+	SRSO_MITIGATION_NOSMT,
 	SRSO_MITIGATION_SAFE_RET,
 	SRSO_MITIGATION_IBPB,
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
@@ -2862,6 +2863,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
 	[SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED]	= "Vulnerable: Safe RET, no microcode",
 	[SRSO_MITIGATION_MICROCODE]		= "Vulnerable: Microcode, no safe RET",
+	[SRSO_MITIGATION_NOSMT]			= "Mitigation: SMT disabled",
 	[SRSO_MITIGATION_SAFE_RET]		= "Mitigation: Safe RET",
 	[SRSO_MITIGATION_IBPB]			= "Mitigation: IBPB",
 	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only",
@@ -2914,8 +2916,7 @@ static void __init srso_select_mitigation(void)
 		 * IBPB microcode has been applied.
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
-			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			srso_mitigation = SRSO_MITIGATION_NONE;
+			srso_mitigation = SRSO_MITIGATION_NOSMT;
 			return;
 		}
 	} else {
@@ -2968,8 +2969,7 @@ static void __init srso_update_mitigation(void)
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
 	if (boot_cpu_has_bug(X86_BUG_SRSO) &&
-	    !cpu_mitigations_off() &&
-	    !boot_cpu_has(X86_FEATURE_SRSO_NO))
+	    !cpu_mitigations_off())
 		pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
@@ -3265,9 +3265,6 @@ static ssize_t retbleed_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
-	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
-
 	return sysfs_emit(buf, "%s\n", srso_strings[srso_mitigation]);
 }
 

