Return-Path: <linux-tip-commits+bounces-5884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B0BAE61E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A066A3A4599
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8157280035;
	Tue, 24 Jun 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8AJyegL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hF6qn0i5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F91F5617;
	Tue, 24 Jun 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760139; cv=none; b=kDhqZQBx3ctgxAm20Mr9kbfE6kyYKpss1vpBJNT7dZpziAcsXQCmo4y4hCB0JJTn5Lq8t1Y0uWSMJMkrznKubaFfKJVfL8RdTSCUOQ5KR8lLlMmOGuvg3oQqIdrovspUJY2PsjHb9w51AyiaLohH9b9pOUKlyILOmNx7qCCWMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760139; c=relaxed/simple;
	bh=DeLoam85p8JWzZhhRxwqxzZCgYEqKHebIJm5/VJzQ+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lR0tQ5TVitkU5I1n6+bgfjaNVaeQd7GOA3jYx6F4IuiwQtufAQCIWWLILq9dDlll0CVb5OpQzfQlYViC57U675ZAm6jR8bjGmgKVYgPkGWs7zDRyfUga0iqQZr4iCQsilghrkrLx7lVt4DwIe2jPZD6671W7d+l2aPqJeucQkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8AJyegL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hF6qn0i5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 10:05:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/47q+U2EDYKcMVQQHdah7LamsadCgwZWGnEscz/LxCo=;
	b=t8AJyegLeyVH/i/um46wV5XG/LrHIxqDgLNZ2D3cgf9dCJva56HWnwoms04OKc7UHGlTrA
	phvjjAELk6QDi2O8joMc87rMJ7CoChT0HHAPglGxCE5/2xvKBskq97+U0bDzzWnQjLXDxZ
	jLHpgEsVCw+PF9k4Xyj93ao9BH8Vj0Ay4ddqNFQ8vu4m9LMP04iBOvYn9Nzj6z2CKK6j68
	F+i0Xa/IIbhKL2LvYoMB1ndjRti0RQvJ3YG1q4RFp23PjZEYBY0RJ56wCebnBvM1zPhTyh
	KHdJ9ul+gc9kFvvaauZa7W7doMw/u8sroxRGhk+ogiHkvCLAUwwjD3g6FLesOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/47q+U2EDYKcMVQQHdah7LamsadCgwZWGnEscz/LxCo=;
	b=hF6qn0i5jLJA0Kh3HAmZSgt4gdy2LkU9N/269kLp2HyR3RB5bvq93kYM+CCQIDC8xZl49C
	3S+tvREVf5eDKVBg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Use switch/case in its_apply_mitigation()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-4-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-4-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075954773.406.6201068420364124322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     7e44909e0ea8346ba08b244ecc275fc3394e2b8e
Gitweb:        https://git.kernel.org/tip/7e44909e0ea8346ba08b244ecc275fc3394e2b8e
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:29:47 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:22:44 +02:00

x86/bugs: Use switch/case in its_apply_mitigation()

Prepare to apply stuffing mitigation in its_apply_mitigation(). This is
currently only done via retbleed mitigation. Also using switch/case
makes it evident that mitigation mode like VMEXIT_ONLY doesn't need any
special handling.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-4-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 20696ab..e861e88 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1468,15 +1468,21 @@ static void __init its_update_mitigation(void)
 
 static void __init its_apply_mitigation(void)
 {
+	switch (its_mitigation) {
+	case ITS_MITIGATION_OFF:
+	case ITS_MITIGATION_AUTO:
+	case ITS_MITIGATION_VMEXIT_ONLY:
 	/* its=stuff forces retbleed stuffing and is enabled there. */
-	if (its_mitigation != ITS_MITIGATION_ALIGNED_THUNKS)
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
-		setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
+	case ITS_MITIGATION_RETPOLINE_STUFF:
+		break;
+	case ITS_MITIGATION_ALIGNED_THUNKS:
+		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
+			setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
 
-	setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-	set_return_thunk(its_return_thunk);
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		set_return_thunk(its_return_thunk);
+		break;
+	}
 }
 
 #undef pr_fmt

