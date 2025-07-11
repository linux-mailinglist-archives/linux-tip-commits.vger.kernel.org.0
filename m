Return-Path: <linux-tip-commits+bounces-6086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A06B02159
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0425E5C524F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9FB2EF2A8;
	Fri, 11 Jul 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhYoz142";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xba/qEdn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A22F2342;
	Fri, 11 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250184; cv=none; b=kUnlzpXQfwcoQz9U+IvoWLCmrDkNZStEHGidqVkFdxfoxQzRlyAo4OGIGvj4GY5U6u2XoNs1Gk5COsE7H7r7KeZ9ZYCfy3DWkXX+f2zcJOCWtPl5VjdVVClXIY/x1n57W76mzUdNqWtIt0X7IWcjtrkHiMVIv0e93o4bOLhwko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250184; c=relaxed/simple;
	bh=UYpDUVhPh5f9jjjVl4qszt5ml+cX8CrdvymCeHlLyyY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QjXj+zCy60ZyxdKHuUVjyP4PIj1koPHLKq3haJyxaSnl/nJp4AHzL7pKWqBacwSpRaxz7sQhh7yH8yk1b/OT24VNnYMewSC8wLrmGE4Om3LAixSQ9mN/3K34l3B/ah4fjEA97vlOeOUfKnPG18u0U5zw03wEMZZ2VI4BWLXze/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhYoz142; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xba/qEdn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qyamqq5pJmDG/dfJpc6VvKB0aplAWJBMi76lPGv89sE=;
	b=BhYoz142PvSh7ipSOIAmEur+NYaS47e33+yzIQImxub8ztcajF8tagOhTDF8cQuydEbpLY
	S0pnNnrFNfGW74IXr1e5zQ6WACEgtNj/Ss8f7HUyPwvg5QsahBfIq2gNdlkXQYBFrzyVZ2
	EIh+/fRqb6A4yjALakopFIMbtZ9JLATuIWzb2WQoXFDEyq1LSD+/Ba+rhDOqmrTAiGQrIG
	sQCaNTreQgrR6WaBYcqc2jBWQqBiWxI9fA0FI9bHL2vo5i3a+M4V9CgOApTy2lTD+kxjtz
	hyStWHTt4w+IVpc9XNA4ME3yHYNLDSIPfRFb6h/kfAtNUYiBcG9pTnNoqj2fWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qyamqq5pJmDG/dfJpc6VvKB0aplAWJBMi76lPGv89sE=;
	b=Xba/qEdnLADCWyzSifkpFYpnlxiaw6PdVUUYRtzgWOJQnVZwdAa0DsB50w2hWwmCGOGlnB
	JMo0hH3qANwzWXAw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for GDS
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-11-david.kaplan@amd.com>
References: <20250707183316.1349127-11-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017889.406.13837449048056339085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8c7261abcb7ad1df493773fd52ff3ddce37a25e6
Gitweb:        https://git.kernel.org/tip/8c7261abcb7ad1df493773fd52ff3ddce37a25e6
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for GDS

Use attack vector controls to determine if GDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-11-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de0b5ef..e9227e4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1030,12 +1030,15 @@ static void __init gds_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
-		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
-
-	if (gds_mitigation == GDS_MITIGATION_AUTO)
-		gds_mitigation = GDS_MITIGATION_FULL;
+	if (gds_mitigation == GDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_GDS))
+			gds_mitigation = GDS_MITIGATION_FULL;
+		else {
+			gds_mitigation = GDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/* No microcode */
 	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {

