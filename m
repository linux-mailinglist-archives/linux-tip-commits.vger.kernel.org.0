Return-Path: <linux-tip-commits+bounces-4370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE552A68AEF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0937884625
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E225D8FC;
	Wed, 19 Mar 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIkbc4jF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fi6zQjPL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001125D213;
	Wed, 19 Mar 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382238; cv=none; b=NvgFOnwSnhFwUyVSoUjkBPN4j/4XRfyZleztizUgmooRxpr3Of7a5mnzmZ/hkFGSJ4w09KDqm0v10GmTdteeyRoOKOO6Fajvol+5DQN/ATLx3JAmpLhMc1apqL/VDB9yNJ91LZ8qdVtLTkZav45wCHvJkWe2yyPp1kVINZwT6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382238; c=relaxed/simple;
	bh=mb7uaerLDeggVUEPwAhHEAE/aH6Cpkkbc9u5ClBE7Iw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=EmVgVCEGBtTywyETlj2Zp9rD00lexCp7/tOvNMm9vcEibkUYnGl2tsyWBeUUz7EROueYUoA8q0cmA4L6bCBK+psXFAoudZBFssbF3/dUVanIN/gZCmnOcMji/NeqbOimTwPIvhnzfWU9Ux1EMKGhTF38xAUxl9oa4XlNyViMl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIkbc4jF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fi6zQjPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XnUkTbbjiUCbEnfHCifzLKt7/3gvERIafLj2qXsFs3o=;
	b=vIkbc4jFw0kAH7gn1yhCEnCFTNlGmz+naAAdvsPkyL5FRdKsPWtgEGJeHLI0woQYwdLqc3
	bqAsLQbF8xnm5vonBjBUpYXIDjmDJaBFAlKZk8y5brYPmUQdr7VGQRzE3U9ZBFvvN5KFGq
	WDgffcLBu2xht2sxwG/coq53XH4LjZ7oaLDy2sK9epR0IIUxj4gLP4y4uI+EKZLTSdO9Jo
	pf1BhBfT7oQg366fPsWHAdgzPh0NwkktMKe9Zm4o0K2n4CLv9QGtyfm78cwmwtCifxrduy
	oGhsiGkP9mmvrEX2cy5LHqHrRNxh2qhcEKk7maFqeZkqD02CDw0I3QHQqjidOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XnUkTbbjiUCbEnfHCifzLKt7/3gvERIafLj2qXsFs3o=;
	b=Fi6zQjPLr9I7UBBITaAy1Ff7V4x9n07AffZKb1Zvxjvt1X1Rj2Yr08THkn9JA1bFnb8xLs
	bSrOnANcU9oen3BA==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mtrr: Use str_enabled_disabled() helper in
 print_mtrr_state()
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223377.14745.7305720279082979065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ad5a3a8f41aaa511b2150859ef5b1d76fff34fc9
Gitweb:        https://git.kernel.org/tip/ad5a3a8f41aaa511b2150859ef5b1d76fff34fc9
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Fri, 17 Jan 2025 15:48:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:17:56 +01:00

x86/mtrr: Use str_enabled_disabled() helper in print_mtrr_state()

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/20250117144900.171684-2-thorsten.blum%40linux.dev
---
 arch/x86/kernel/cpu/mtrr/generic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2fdfda2..6be3cad 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/cc_platform.h>
+#include <linux/string_choices.h>
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
@@ -646,10 +647,10 @@ static void __init print_mtrr_state(void)
 	pr_info("MTRR default type: %s\n",
 		mtrr_attrib_to_str(mtrr_state.def_type));
 	if (mtrr_state.have_fixed) {
-		pr_info("MTRR fixed ranges %sabled:\n",
-			((mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED) &&
-			 (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) ?
-			 "en" : "dis");
+		pr_info("MTRR fixed ranges %s:\n",
+			str_enabled_disabled(
+			 (mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED) &&
+			 (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)));
 		print_fixed(0x00000, 0x10000, mtrr_state.fixed_ranges + 0);
 		for (i = 0; i < 2; ++i)
 			print_fixed(0x80000 + i * 0x20000, 0x04000,
@@ -661,8 +662,8 @@ static void __init print_mtrr_state(void)
 		/* tail */
 		print_fixed_last();
 	}
-	pr_info("MTRR variable ranges %sabled:\n",
-		mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
+	pr_info("MTRR variable ranges %s:\n",
+		str_enabled_disabled(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED));
 	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {

