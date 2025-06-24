Return-Path: <linux-tip-commits+bounces-5889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918AFAE61F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172A23A94D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B38288C18;
	Tue, 24 Jun 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iK+z7s2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xUjeLyA8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD428469C;
	Tue, 24 Jun 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760142; cv=none; b=WJJxII6njLcyvuzDUh12n9a2XStaEXnRFpzYNSYb2mFB0zT1MzP0IeJNxBgjdpvpE54A8Um71iWGRvylnQtQsX7v1a3mQYZcuIew8bTog1g3rGqN7hM8wYafkn4xe6tXFiHef62na4zs4mYfSX5Sstx/xYa18L2pkdpRmV+uQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760142; c=relaxed/simple;
	bh=1SODcScY7dgr76pnJHiFTfa5Ghmj+Q7HnnFxPxlr2zI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YgTtXW+Yp/lU7W/9fntMdh+fZkzYtVPov/byRjdPT/r48h0/ODuVRSLywq9WR7UsW3NsxthOPDi0Vp7Ysae+KuKfNGSkhenxHV1Kuo92Z4D7OhaWHGK9eQ1YFupVZRIREUa0xIqkbCGaao7IShjjo2Rg76I5wSKXOYtAAKBDMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iK+z7s2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xUjeLyA8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 10:05:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIUgE4AxtMAwv/yWvjYUmD8OQAMhYwbDqiEFmt4Qr6g=;
	b=iK+z7s2vTU8Hit5LvuNuFe1XVCYUi7Z5NPCM7VUBzMLUI2NZEuH3hw0UDDULCSudXXzUso
	4iIDr7lC0hGqkw3IkSxoWAgRTVTWGdCJTy+shmUqrlnXmZh85050eBrnTcuaRIVYM/Rvbc
	NkdR6e5qGszt9pHlCMu/0ORhwzyvRURpEXwCT4sGkWSm5sQGsBmKggPCeshJrLnD/KLxw2
	GG+SSmhwvfOJ/SagTEVOBqOiIXY3PKeJoQbLziJZEmlOzllQzlxBxLL9kSSUGrHQnwv5Vk
	u7gX0vRXrytIBuLgRufPVQVSspbSyQJz9OMScygIwtOpPQSKqgwQyC6/hH0Btw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIUgE4AxtMAwv/yWvjYUmD8OQAMhYwbDqiEFmt4Qr6g=;
	b=xUjeLyA8IsB13D6eXuOH8yVIHoQN+fDrJb2i+avWLE7Y1e+TA73JXdQPhjqxDrR/sbkGXU
	6HTaG8QJ0C3UE2Cg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove its=stuff dependency on retbleed
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-6-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-6-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075954607.406.7576046067785357125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e2a9c03192f54bb53a5422bf5106bdc4d04a7426
Gitweb:        https://git.kernel.org/tip/e2a9c03192f54bb53a5422bf5106bdc4d04a7426
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:30:18 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:29:04 +02:00

x86/bugs: Remove its=stuff dependency on retbleed

Allow ITS to enable stuffing independent of retbleed. The dependency is only
on retpoline. It is a valid case for retbleed to be mitigated by eIBRS while
ITS deploys stuffing at the same time.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-6-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 387610a..31f3db0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1467,13 +1467,8 @@ static void __init its_update_mitigation(void)
 		break;
 	}
 
-	/*
-	 * retbleed_update_mitigation() will try to do stuffing if its=stuff.
-	 * If it can't, such as if spectre_v2!=retpoline, then fall back to
-	 * aligned thunks.
-	 */
 	if (its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF &&
-	    retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+	    !cdt_possible(spectre_v2_enabled))
 		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 
 	pr_info("%s\n", its_strings[its_mitigation]);
@@ -1485,8 +1480,6 @@ static void __init its_apply_mitigation(void)
 	case ITS_MITIGATION_OFF:
 	case ITS_MITIGATION_AUTO:
 	case ITS_MITIGATION_VMEXIT_ONLY:
-	/* its=stuff forces retbleed stuffing and is enabled there. */
-	case ITS_MITIGATION_RETPOLINE_STUFF:
 		break;
 	case ITS_MITIGATION_ALIGNED_THUNKS:
 		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
@@ -1495,6 +1488,11 @@ static void __init its_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		set_return_thunk(its_return_thunk);
 		break;
+	case ITS_MITIGATION_RETPOLINE_STUFF:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
+		set_return_thunk(call_depth_return_thunk);
+		break;
 	}
 }
 

