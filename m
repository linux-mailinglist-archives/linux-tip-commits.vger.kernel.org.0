Return-Path: <linux-tip-commits+bounces-5888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A55AAE61F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6703A7283
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AD288536;
	Tue, 24 Jun 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcoWbD93";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dcl9zf2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805628469D;
	Tue, 24 Jun 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760142; cv=none; b=oeKx2RNa4B3iAGJN9lUqBRzT+g3TmI8M2Cb8XodP0ejAQvTjPYvMBDwiZxc6HxQaPIc8XWfrWsnqblF56Sjf2xj7p5cnXhboG5dyrfc7YDOiKmY5VR3kT7l8XE0AkoVDcgIoAsKaE8UswtMdJ9PzthStEJycpoBGCLoNNDhwo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760142; c=relaxed/simple;
	bh=wg9dNoZAsJALHHuPXe0Y7MEBvzy2wvqw5YklrzFgBp0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=njDnzI/9p7OpOOLysRRkJVQAHGiaGdR99upKZOLwmRr6dNhPG0XdNuIpdnEmbKfgo381EzWouwrFKBkrSJ5ZZcbvjR4p+UTiwG45L8N+aYbyGXFSIJYg/Q/TKpMpkgYOlTwwrJ8E7dwrDAvlO2wwHR6pXPIyHQ9xwfN5BCrPub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcoWbD93; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dcl9zf2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 10:05:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrqZ5eFy/+cN/Jve95P3eYmRL/JJkHErtglqvSkGoLA=;
	b=hcoWbD93BL/ZJ7dIXkseH3uWSPnilsV8zoahvoZEX8Ex16WHqf387ZebWbxSNvwpHYVLqp
	IATRT2U1V4gaTNinAXL1HxmGbGJuVyWoVe5vmzVmaZCuWWlo/OY9lmZSqlxgPJi+omwIOr
	WX1waMNgUxVkq4LGSysM28sJMsZsKA8PTMH2ef75gAg4qtOkSTFHiFdr6l47oP4fg8ZlIc
	FIyjrLWt9qf2l4C4Z2oHIvPFc0C0ldIJQJKcuyRay6mUNpNIiDmMYJXZDgBPQxGVPZpu3d
	aGiNRvmGS3Zvo5CyNCgUHoC+rwbySAAxhdDJU57Ou7Q2sit7NIkzLQFaeB7wdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrqZ5eFy/+cN/Jve95P3eYmRL/JJkHErtglqvSkGoLA=;
	b=Dcl9zf2/vaUTruIcdhlOGy8DAlOdyQ4BGZw/0gLn2xSEi27SQWJ324beUPn+TBIcFv2eG2
	djqakcCCQlJmivCw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Simplify the retbleed=stuff checks
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-2-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-2-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075954943.406.17585422913122991240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     530e80648bff083e1d19ad7248c0540812a9a35f
Gitweb:        https://git.kernel.org/tip/530e80648bff083e1d19ad7248c0540812a9a35f
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:29:15 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:16:30 +02:00

x86/bugs: Simplify the retbleed=stuff checks

Simplify the nested checks, remove redundant print and comment.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-2-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 53649df..94d0de3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1263,24 +1263,16 @@ static void __init retbleed_update_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
 		return;
 
-	/*
-	 * retbleed=stuff is only allowed on Intel.  If stuffing can't be used
-	 * then a different mitigation will be selected below.
-	 *
-	 * its=stuff will also attempt to enable stuffing.
-	 */
-	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF ||
-	    its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF) {
-		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
-			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
-			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
-		} else {
-			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
-				pr_info("Retbleed mitigation updated to stuffing\n");
+	 /* ITS can also enable stuffing */
+	if (its_mitigation == ITS_MITIGATION_RETPOLINE_STUFF)
+		retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
-			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
-		}
+	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF &&
+	    spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
+		pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}
+
 	/*
 	 * Let IBRS trump all on Intel without affecting the effects of the
 	 * retbleed= cmdline option except for call depth based stuffing

