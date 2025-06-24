Return-Path: <linux-tip-commits+bounces-5886-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073BFAE61EF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951B51719D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9346283FC8;
	Tue, 24 Jun 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBIsdyHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYtM/7La"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94C72617;
	Tue, 24 Jun 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760140; cv=none; b=cePxBcABExyNNgRWLlu8QnR+4Tc6l13kwImNzodyoXUg6udZugxN+LPGgUp1j8WSY0uzFvT3bIgI8/HRIOGYyc3jb74iBHzoAGzOurssekejWWRE4gnn2gF0b/kCw+jfdl8iOMhydkL6zZLuC6zdI/09bQfGy1yBwRdYjrCksB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760140; c=relaxed/simple;
	bh=cxFnfUyr7392+e1h+hrdBCm/v5QTz62docpqaj+KIeg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hL6pCnQvjdrbTgdIv968ObVV6krf/WuBj1ZoDl6DZ9uzO/dTHlBaOPhBx4wDybLaIb2+XvWOreQjRHcNn7cqWxSJscyu6QHHCohUlHJLqMiWr3gd63xUkzi1Neudy27lQKV6gKLeWxSHRwnOBsFGF8nbUybWqrlL15et7d1y3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBIsdyHD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYtM/7La; arc=none smtp.client-ip=193.142.43.55
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
	bh=aAWOdsXG2Bn3qy8b6/DJnPlPliiKxw49kc7zgXQ8X+I=;
	b=aBIsdyHDsJOozck2wRwuf7o33eiBBXe857Agnwi00pCw1taTeYS697u88pl4g9fTgrR2Nn
	kTNyEIg0htIf/SjxblMW3eFlCTjtqX3YCO4QWQyL3GykMjprmdnO6xYkqQXRL//1yVsiHC
	+D3GYnn7pZXjw3SKonAK+cL3Y5lVGb61NCdv2oM6KiSYNrdvB/3VxPgI6fw42nHOSGL6D8
	9OLfw1nJztUr36Ih5FHm1rJN4CfXuV3nsLP5DM43Vyuec2Mlg8hy48LFK9LX/8Q5Ynbm4O
	jVmQsQ0ty12XJ8Azw60/gFKRfD4sUM7OXFfaTa2MR+KV/L/1V9F8BcABSrSzsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAWOdsXG2Bn3qy8b6/DJnPlPliiKxw49kc7zgXQ8X+I=;
	b=MYtM/7LadhU5kTAjaQ53CW/yJH56fCrTNGpX3dqM8bboa5sepXOT1xCs//AZNv0CXQD661
	mUKyCzJQfN6ZR1CA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Introduce cdt_possible()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-5-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-5-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075954691.406.1500626531885983184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8374a2719df2a00781e6821e373d7de71390d1b4
Gitweb:        https://git.kernel.org/tip/8374a2719df2a00781e6821e373d7de71390d1b4
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:30:03 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:26:57 +02:00

x86/bugs: Introduce cdt_possible()

In preparation to allow ITS to also enable stuffing aka Call Depth
Tracking (CDT) independently of retbleed, introduce a helper
cdt_possible().

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-5-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e861e88..387610a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1119,6 +1119,19 @@ early_param("nospectre_v1", nospectre_v1_cmdline);
 
 enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
+/* Depends on spectre_v2 mitigation selected already */
+static inline bool cdt_possible(enum spectre_v2_mitigation mode)
+{
+	if (!IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) ||
+	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))
+		return false;
+
+	if (mode == SPECTRE_V2_RETPOLINE)
+		return true;
+
+	return false;
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "RETBleed: " fmt
 
@@ -1267,7 +1280,7 @@ static void __init retbleed_update_mitigation(void)
 		retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF &&
-	    spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
+	    !cdt_possible(spectre_v2_enabled)) {
 		pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}

