Return-Path: <linux-tip-commits+bounces-3945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE7BA4EA50
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294C78C79C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82A209F42;
	Tue,  4 Mar 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ph1NqR2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6sVbLbX"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB3259C89
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107838; cv=pass; b=oDV84WsI82ru1GiQUKDyWh4T8QSTYf+flqexP4//ueLGGMb3Vd4g42JAwINI3WjHE0Mn7uNzEhsDJK9AQePPNNYymH1WhNZ1afA+UKJpzCCSG69M9nTCs0k+jtFp+hpIeHird+y1DeGOdEcu/s8mNRdkDaTD9sD5oVZHsOrxJDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107838; c=relaxed/simple;
	bh=Hq8O1gGb+P40tEcirF5xOUQzXZ4h6pVNVOlur8zSbzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kvhORgDdi1Iy0iwgAkDi3q1768XR8oOn8vs9bUthZe+IztcQS2hhug4vr3XgbpmN9HGyu6JcK/m115FeiG/vpGqlb4o4mhJ+H0qZ7WIEKWQhjF3lK4MAMAvaj5ue98jrdw5YADU2/g6WpIve9w/PF690irEmSj1NDVsX7dJMMCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph1NqR2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6sVbLbX; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 6440940CF138
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:03:55 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ph1NqR2e;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=G6sVbLbX
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dLq6mKQzFwhT
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:27:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 540C742724; Tue,  4 Mar 2025 17:27:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph1NqR2e;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6sVbLbX
X-Envelope-From: <linux-kernel+bounces-541661-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph1NqR2e;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6sVbLbX
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1410142545
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:01:26 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id B84632DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:01:25 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA2169BF6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758B20E03E;
	Mon,  3 Mar 2025 12:01:15 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA17192B84;
	Mon,  3 Mar 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003272; cv=none; b=aUISRxakeFYQj9DYKXP5qvw2rrCL63DcPVoDwaQTtjn1l2/6yM0aWUjEvUKN4qcKTf0FgoKUpLdWa5yHL5q1r+l3va4p0RSJ15Gs2Wt+Y8eH/8l/II6kqMXy2Qkxe3KfqW5EZxgLnyVZjUo805Yu0KBswRhl+3TA+JfjZlHSKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003272; c=relaxed/simple;
	bh=Hq8O1gGb+P40tEcirF5xOUQzXZ4h6pVNVOlur8zSbzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NWTbY17pGCzSeAaFQk8/MkaIgZNvdxupdmUVmp3TViHsuS7USqxSkARdrj2l2z5Fa301OLHbJ8insFitSLxCFZt/4p746II+ilabPhT3mY4UkhxO+00uHHeUMGzlHCFt7AfNy3BlXLE5RgRybhiVukuPKnKwH+NI3b4X/mpZFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph1NqR2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6sVbLbX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 12:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741003269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy/72BhdRmeKN0WCcoRdfRHpn4eagc5lEBQIp1+DUmo=;
	b=ph1NqR2eyvPFKSXpl3NJIfcpuBqOXcJz3iOPk3D+GLEtevMyK7swaY95U95AWPLfdbkZx5
	J8k7oOsyBzmZvl74vCs4k+FAr8dLKvXK2JLfzT+iAExgf9nKUzfcODVoivIqFFe6vNpWfg
	ZJ/uFCQLLaKnii5oZCxuXpuKZqr1RI2KlmHFnt8LETBzOgS6hZB3skW7y7YBlnnIFtbyTm
	A+akmD3uvChg8RpOqXpVaSaJuzZlHR6sR+AVfvsCYR+6C/RbVQfSKzdou+lFic/zFi52Ye
	dquBLC/7pFTja6wbh7OcZHAw0f66LhggTZW6CNJY8opZAis6o3ddQ0WWnXHmZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741003269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy/72BhdRmeKN0WCcoRdfRHpn4eagc5lEBQIp1+DUmo=;
	b=G6sVbLbXJ3hI64XzPvV/O9CnLihB2s2fUPadh9Liu+XWL8tr2XOgAD1TZduwYiKX6svSKt
	aKLfujem8ZyuuiCw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Use the cpu_smt_possible() helper instead
 of open-coded code
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241031-x86_bugs_last_v2-v2-1-b7ff1dab840e@debian.org>
References: <20241031-x86_bugs_last_v2-v2-1-b7ff1dab840e@debian.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100326694.10177.17515354436837072065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dLq6mKQzFwhT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712514.31542@vfWa0ykoYVYWqIcYZjNing
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2a08b832712980b9eb0e913d64a42c74fc56319b
Gitweb:        https://git.kernel.org/tip/2a08b832712980b9eb0e913d64a42c74fc56319b
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Thu, 31 Oct 2024 04:06:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 12:48:17 +01:00

x86/bugs: Use the cpu_smt_possible() helper instead of open-coded code

There is a helper function to check if SMT is available. Use this helper
instead of performing the check manually.

The helper function cpu_smt_possible() does exactly the same thing as
was being done manually inside spectre_v2_user_select_mitigation().
Specifically, it returns false if CONFIG_SMP is disabled, otherwise
it checks the cpu_smt_control global variable.

This change improves code consistency and reduces duplication.

No change in functionality intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <David.Kaplan@amd.com>
Link: https://lore.kernel.org/r/20241031-x86_bugs_last_v2-v2-1-b7ff1dab840e@debian.org
---
 arch/x86/kernel/cpu/bugs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 93c437f..346bebf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1346,16 +1346,11 @@ static void __init
 spectre_v2_user_select_mitigation(void)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
-	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		smt_possible = false;
-
 	cmd = spectre_v2_parse_user_cmdline();
 	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
@@ -1416,7 +1411,7 @@ spectre_v2_user_select_mitigation(void)
 	 * so allow for STIBP to be selected in those cases.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
-	    !smt_possible ||
+	    !cpu_smt_possible() ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
 		return;


