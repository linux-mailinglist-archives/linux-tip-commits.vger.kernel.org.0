Return-Path: <linux-tip-commits+bounces-6091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62642B02165
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CDA5C55F0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D52F4322;
	Fri, 11 Jul 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJ0L4fme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9ilzP+S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853D2F3648;
	Fri, 11 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250188; cv=none; b=uC5Z+lNNDfeCbenn3UamgKY3zBl1T5XKnYZ9gF7G5J8TvPyikqlkKSm2fqz6InrNrWQtK1KmRtRwaAMsExEgPuA6Qi6jsYVch7MzpzVUer7+nWG+c4Lxgi5MuLZG3eym7oE40uxSImVcRkvc7CMOYAjFnJ7jfyNxJFuzFsNX1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250188; c=relaxed/simple;
	bh=eE92MlYCjOhWHXiDKiNKkl1Bko8slyuNq9ldCKbgfUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9Egp6RrvG8pE46lEchkCIsEpNqMnE0pyllG0CFelZjHmQ8puNA/eP/P4sLJCpORqJp3z1r172lqzN1pp93zRmNsEp8lvbKpaeXZBpvDPQR1PsHFc+HuwFzyMeWGjp8DmW564ZitOQTxUCi2jXVzFs2ty0k9K39xqbpJaf6q9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJ0L4fme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9ilzP+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ/XyvNCLaQmUQQGG1Yw/3jdYjvnKJFqFzUJT8eMM/4=;
	b=vJ0L4fmeJ5aeq+0cH+LfajSVU3BBS+L6vPl1a50suMdtwSgA+JSpiCvrHsxg0dmbs/sVKb
	vQo0Tr9sxk4Z1XgfPCXfIqvnYkr0WBwHvCSKHgkl2Iotuj+crH3ddCYiNIybxl2LawyxGB
	2h32D5Eey2Md+fsQHaAun1kKdYp37b9xE6WOmWc/Nxx2W7Gv/j20RzD+xB5jSzjEMVQPxO
	0X3qL9h2Mi3jrQXXvRs2qcgvqAo2cIFCcsClicig9dJZuFTFnJGZKUU3pc+zlHmH3ZIlRL
	m1SQAfXUOJGo3uFpfvWdsEXooXXd2WnOgcJdUWTI2lpJNXr/CoVcNr3+sOecJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ/XyvNCLaQmUQQGG1Yw/3jdYjvnKJFqFzUJT8eMM/4=;
	b=Q9ilzP+SmRpqyhm0LKo5405oAIaS7BQnIFwpuINRd3+O00RbhvCLBZigivrC370A42XTwV
	kCBazx5UuWXvAFCg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for MDS
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-6-david.kaplan@amd.com>
References: <20250707183316.1349127-6-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018305.406.13111141914791060768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e3a88d4c068242c00a1d6ddfd3c711fc22983f75
Gitweb:        https://git.kernel.org/tip/e3a88d4c068242c00a1d6ddfd3c711fc22983f75
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:00 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:40 +02:00

x86/bugs: Add attack vector controls for MDS

Use attack vector controls to determine if MDS mitigation is required.
The global mitigations=off command now simply disables all attack vectors
so explicit checking of mitigations=off is no longer needed.

If cross-thread attack mitigations are required, disable SMT.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-6-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b083e7e..31e0cf8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -441,13 +441,17 @@ static bool verw_clear_cpu_buf_mitigation_selected __ro_after_init;
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (mds_mitigation == MDS_MITIGATION_AUTO)
-		mds_mitigation = MDS_MITIGATION_FULL;
+	if (mds_mitigation == MDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MDS))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_OFF;
+	}
 
 	if (mds_mitigation == MDS_MITIGATION_OFF)
 		return;
@@ -457,7 +461,7 @@ static void __init mds_select_mitigation(void)
 
 static void __init mds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		return;
 
 	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
@@ -478,7 +482,7 @@ static void __init mds_apply_mitigation(void)
 	    mds_mitigation == MDS_MITIGATION_VMWERV) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 			cpu_smt_disable(false);
 	}
 }

