Return-Path: <linux-tip-commits+bounces-5185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C79AA6FBB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62A09A1A7C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545C242D87;
	Fri,  2 May 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NkWWlBU5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsqk9TnU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36750241679;
	Fri,  2 May 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182012; cv=none; b=e+ig2WdEriKBI23Ipv1Eg16Yz727cqgAj49QZPLvnu9lUAB8NM1tubjt5Ia0yIKds6MDx2rnWk5DZXLy1BAUVBaV3SH4k6bx1aGvkWU6uGCJRViqYPhxAhQ9zDHoRQhMchTwRMfEe4js47GGbeWm+LaY1JDGO2ixJERv3ttlrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182012; c=relaxed/simple;
	bh=HYyp6acYVQf4l3VSI4sPO1n+jLG9h9HrGYCdIcv+2yY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pg10Ik4/NPrlRMayWfPRJdsReG47Q5fRt/FvpDDYnDuFGLJlKehVB67+tWb0RPM7FPgBwlT+/Ew8DjBqsldRABxH9WPuEeUdz9uDWCaJP6jyVg88+KxgY3CepYYMYAnKd6AEwgwTokp+UW8hxpvFlK9FwHn1CElNHxG1L+H6iEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NkWWlBU5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsqk9TnU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lgkWiUSh79XuRB2GaMNEO/QtytBpnCKathJImh0WE4=;
	b=NkWWlBU5QfbiEb34IgEFzztikD2yJ6pA2YQBmkzcB/yd6gNt5ll7X9JwfHN0DbR1BCTSmU
	DC6U1l8o0TY7P0UtVNWXmy5m1rUD5Q5LaEG3Z2NjlsKE1uLf8w/oW8QyQMt1Iz2R2Lf7y2
	gNbjdcK8xt9ByFQROxElyzhnl5O3D8Z7QkwAa9ss1YoVaxmdFU2DoF0AxScjemQi6aIoZ7
	FjdezCOviwlTWC1puBdZ9H0RoCh7RJhKu3usvxPkCMzpciCpw19LMZT0dMjgDj+BOqmwAN
	UW+J+TklMUMZBPqMdfFLFB83t3si9t+SUxcrPGm/74LcwFe5S//kst1O4hLISQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lgkWiUSh79XuRB2GaMNEO/QtytBpnCKathJImh0WE4=;
	b=hsqk9TnUUQYu/feXWpcsm3/jx2OHnjaA8M2uOw49y0N1yt4t6Yeargrv+CSbh+CcGZVifA
	er+dnhyElFkujyDA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure spectre_v1 mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-9-david.kaplan@amd.com>
References: <20250418161721.1855190-9-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200862.22196.5827453089232021676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     46d5925b8eb8c7a8d634147c23db24669cfc2f76
Gitweb:        https://git.kernel.org/tip/46d5925b8eb8c7a8d634147c23db24669cfc2f76
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:13 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 19:40:10 +02:00

x86/bugs: Restructure spectre_v1 mitigation

Restructure spectre_v1 to use select/apply functions to create
consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-9-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b070ad7..1a42abb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,6 +54,7 @@
  */
 
 static void __init spectre_v1_select_mitigation(void);
+static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
@@ -223,6 +224,7 @@ void __init cpu_select_mitigations(void)
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
+	spectre_v1_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1021,10 +1023,14 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+}
+
+static void __init spectre_v1_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		return;
-	}
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
 		/*

