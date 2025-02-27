Return-Path: <linux-tip-commits+bounces-3718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E192A48884
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A516DE28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976126D5B7;
	Thu, 27 Feb 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xyQQXQkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmmGfZkG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCF21858D;
	Thu, 27 Feb 2025 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683082; cv=none; b=TIz8XXnMR9Hdrt3IPXRKQFANjV7Pve66VXeAFtNOID7Pmc8AtmQRnv0dpPt2kKAu2X7+1U8Yi3jFRuncOOJC3euEwVLc38BzLccJjear/0kzR6wVA0fKum7573DimDGdKOnmCYZgeAwsnQvVpyvqL7FF4UGAC4tKh37k4qceqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683082; c=relaxed/simple;
	bh=M1BO0EK+5h0CV0zOAebi3D/RM921eo6aP5NxkmQrLe0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HhqyOYOrxBUe2Ls18DP4lJ+Iv7lL2JpgtU4K1VJmKH9NOklaAegD32p5Xiy+TNid0Ov3yyDbwb/KHByYrUs9TpgC0obJWW6jQTCE11AgZcFjnbaC0RfYAUpzVtYgJnEqnccf8fboljfeYS/pyWkpNDTyxJiKWns7ZxDL//NigRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xyQQXQkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmmGfZkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 19:04:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740683079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8u47tp5FLSY4NEXzdoQdbIe/BTejFAXpRcfhsP73Kc=;
	b=xyQQXQkTtr1bWc+gDAg5VarQ03SM5r50cIe4lHZjD9CPkv5MJR66wmOmIUkAYbJ0qrk5RT
	7v/H4m5pktBJ7Vm/w/mA5GQKHAdE+7RoD13dXahREvMJkxRlM6FYPF/Ztv6/fICF8Ez4EQ
	D1aG/6aQOZT2+mo2nbxLAZOFQBL9ALETjtBejLnd3Q1cWdamK0ykDjU6Q9D8Jwhc8M2vaz
	wyj7Ek3zeEvQnSkMeiw3LS8O1PqJbDy0hwBZyawozotH3Rf5Ky7f1vw5aKaHg1UZfXmMNG
	W9ghwuRLICm7QTJHajfsmj8VD/X995c2LJR6e6O+c2TVUdv66JN4ofgjR9TyOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740683079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8u47tp5FLSY4NEXzdoQdbIe/BTejFAXpRcfhsP73Kc=;
	b=hmmGfZkGoq4PT6+s7+sWbHLXVRBV7kQyjBYqUWgEcgHOvK0bXM7+vHEw5METIPlsf84eMZ
	vjSGYqI6ysEX8oDg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Simplify print_xstate_features()
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227184502.10288-2-chang.seok.bae@intel.com>
References: <20250227184502.10288-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068307835.10177.5760172564992178850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     69a2fdf446049ae31be4a14a0cf16f2f18f09b6c
Gitweb:        https://git.kernel.org/tip/69a2fdf446049ae31be4a14a0cf16f2f18f09b6c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 27 Feb 2025 10:44:46 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 19:54:41 +01:00

x86/fpu/xstate: Simplify print_xstate_features()

print_xstate_features() currently invokes print_xstate_feature() multiple
times on separate lines, which can be simplified in a loop.

print_xstate_feature() already checks the feature's enabled status and is
only called within print_xstate_features(). Inline print_xstate_feature()
and iterate over features in a loop to streamline the enabling message.

No functional changes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250227184502.10288-2-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 27417b6..6a41d16 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -259,32 +259,20 @@ static void __init setup_xstate_cache(void)
 	}
 }
 
-static void __init print_xstate_feature(u64 xstate_mask)
-{
-	const char *feature_name;
-
-	if (cpu_has_xfeatures(xstate_mask, &feature_name))
-		pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", xstate_mask, feature_name);
-}
-
 /*
  * Print out all the supported xstate features:
  */
 static void __init print_xstate_features(void)
 {
-	print_xstate_feature(XFEATURE_MASK_FP);
-	print_xstate_feature(XFEATURE_MASK_SSE);
-	print_xstate_feature(XFEATURE_MASK_YMM);
-	print_xstate_feature(XFEATURE_MASK_BNDREGS);
-	print_xstate_feature(XFEATURE_MASK_BNDCSR);
-	print_xstate_feature(XFEATURE_MASK_OPMASK);
-	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
-	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
-	print_xstate_feature(XFEATURE_MASK_PKRU);
-	print_xstate_feature(XFEATURE_MASK_PASID);
-	print_xstate_feature(XFEATURE_MASK_CET_USER);
-	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
-	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
+	int i;
+
+	for (i = 0; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
+		const char *name;
+
+		if (cpu_has_xfeatures(mask, &name))
+			pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", mask, name);
+	}
 }
 
 /*

