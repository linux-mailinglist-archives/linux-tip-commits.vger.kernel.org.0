Return-Path: <linux-tip-commits+bounces-6082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70BB02152
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC1F562F0D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880892F1997;
	Fri, 11 Jul 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8tIXOrf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ypwytseY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199A2F004B;
	Fri, 11 Jul 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250179; cv=none; b=IM/aTRSiWpKMmI9XvFhbvbx6IRmEvaRUJltQX5NZy6a8CWetxOxNjbPQ+JtNr/NRigrzZnU7ziBED56bXq2wF2k9t0/3z6jLlv2Pbt/87dyMjrBNL/+ruU/yXsmm7jtBhH1Na1Mj9n7S1mo3bYrE+zitbnRPpvIbBCkWaLKsrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250179; c=relaxed/simple;
	bh=lMi2PuglLoXvvJcy/bFH65gvUm5fzMxSbCto8NA11kc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t7C3ZCQR28xNYOm4K107/3LVPR7FfdKB6KCBzH8ETMA74QG84PzTZatlIcaWqkZOqAf1Kn1ZKnWolSgDzy/pvPGaARdW9HOhYMtZbV9SbC3i7VecZ/KHLqXP8GkqrT1MwCNXjlqaOJ2d5D2mDHhNyebIpUsmJhhfCWT8/BhiYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8tIXOrf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ypwytseY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjMvtmAKFJihWipRZlWOSprJ8PZBuoa9jSBaI39vNQk=;
	b=t8tIXOrfT9+c6wSyjL/J0tagVaEhrrNQoew3yfgBoHaoMUHQ0JV/l2wlPnqUo6KY11XIHB
	hJCe42vtCtXza3Lqm64D8rVRXo96s1uN5UmE1WqSrv4sgz9yxkzGvlcGWNOFmftfGFw3gY
	I/3/VeNfPg8YWMjkSF9R6yF3OjDbxox2leN4Yt+e+sJ6OjDZ9ESQuOpGkUj4if08VN/yBQ
	tdADLFFyMQw5k1MGtbUmxKoYioJIu8s+o8W/HdsN7UO7OX0y0z00PBgdPAqUYVKKJI5GL6
	cI6ZzTBVulPmA6sY9otBLrtCe3bfkXzwBv09kBuhvvgjU1aiQyxLG142xvRJKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjMvtmAKFJihWipRZlWOSprJ8PZBuoa9jSBaI39vNQk=;
	b=ypwytseY7JzHrKwKk80WiCNKnHyYynmOCYxaizgdEIei+snQDHQYmK+KDbFhQL81Q+d5cd
	URhNffW9Wv6YsLCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for BHI
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-15-david.kaplan@amd.com>
References: <20250707183316.1349127-15-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017509.406.4120630478925562585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ddcd4d3cb37c8ad60cdbaaffe93f85e15e2babb5
Gitweb:        https://git.kernel.org/tip/ddcd4d3cb37c8ad60cdbaaffe93f85e15e2babb5
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:09 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for BHI

Use attack vector controls to determine if BHI mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-15-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ff56251..2022f05 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2217,11 +2217,20 @@ early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
 {
-	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+	if (!boot_cpu_has(X86_BUG_BHI))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		bhi_mitigation = BHI_MITIGATION_ON;
+	if (bhi_mitigation != BHI_MITIGATION_AUTO)
+		return;
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST)) {
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
+			bhi_mitigation = BHI_MITIGATION_ON;
+		else
+			bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
+	} else {
+		bhi_mitigation = BHI_MITIGATION_OFF;
+	}
 }
 
 static void __init bhi_update_mitigation(void)

