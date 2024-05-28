Return-Path: <linux-tip-commits+bounces-1299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF828D22F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2341F25078
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5B47A53;
	Tue, 28 May 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m6xLMamH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWoAJoRi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF745038;
	Tue, 28 May 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919510; cv=none; b=KPeRxVs7vD+230d4q9L87o8zEh1Sim+SDWRe3ts259eH38WJuqb6pvfT21ApUKOCR+YhZ5jXcglexLyCxXQleOGkys4IXJehZleSQ4Z98r6lmS0rkWt92t3fvA4cqcinH5dLE+Bj8Ocx+OVJlOk26U91kvE1MGzQA4LgBrb+9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919510; c=relaxed/simple;
	bh=tvClPbnGzZCLqeGMkY3JPQ7fd1z89EWU6gPhRLeJ+2A=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=I/Ab22NMNQmigMIXKoYu6SbwHlcvHfENIAPUTQnuIltIbm7GQCzac2Z+L+4BSiYm44PK2MJYIYQiALePbRBmtzdRC+3mpklPAtOy15bjq2gLH4w5oeRGNMNG/Thff6HT8c6W2wnek2iBpi/hGOg/fRrObfryw1f0y/SE0TPOyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m6xLMamH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWoAJoRi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LIXDy75mTdzgsMSPtQK+N43o5jHFXQ79FOaPCMU584U=;
	b=m6xLMamH6pS88euOHpW974+wWHWsC15DgCxuiTNDKvbiEFPlfFTTp+kbthwkseCoNhiMEZ
	/MsqqkPPFLCq85Q2/tZ8IGUZKaTRoDeR+g4DdaEy0wtTpaZeQMHyiBswFe+QHVK2Ab9PvT
	ku5+1jEF23ogHrm+KB7N9Jvb7ZLcCjcDQtwxDu4zFfOcUzk1ItjyLrlUbG6j042X7iA10n
	QJrPI1qsO8+f5hqxo3At4CJU4pGaa1ddpmpk18bpapSzkpOgWqS3T8I4KHlM+Yf8W7Bcfp
	Jsxaczzctq/7JEzre6HWBhKazVy4WqErCL9P4CKQvPXsocJc4UrY/35nw7oc4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LIXDy75mTdzgsMSPtQK+N43o5jHFXQ79FOaPCMU584U=;
	b=NWoAJoRi2or6Hsv08Sny7/pyjn9h31nJP6oTrpovxjuR7i7XXvG9jeWl31/+DLoNGKQdbW
	wn8ZNwsV95Cq5LAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/boot: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950683.10875.4843444684563640261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6fd5e8855e60a94f6f4b78a1314afac56fce7427
Gitweb:        https://git.kernel.org/tip/6fd5e8855e60a94f6f4b78a1314afac56fce7427
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:46:05 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:03 -07:00

x86/boot: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model but
boot code doesn't have all the infrastructure to use them. Hard
code the one CPU model number used here.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240520224620.9480-35-tony.luck%40intel.com
---
 arch/x86/boot/cpucheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index fed8d13..0aae4d4 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -203,7 +203,7 @@ int check_knl_erratum(void)
 	 */
 	if (!is_intel() ||
 	    cpu.family != 6 ||
-	    cpu.model != INTEL_FAM6_XEON_PHI_KNL)
+	    cpu.model != 0x57 /*INTEL_XEON_PHI_KNL*/)
 		return 0;
 
 	/*

