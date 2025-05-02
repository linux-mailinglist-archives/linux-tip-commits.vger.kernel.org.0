Return-Path: <linux-tip-commits+bounces-5186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC1FAA6FBC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E977A9EA2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102E243951;
	Fri,  2 May 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReCNhanz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ja0vT1p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669522DFA7;
	Fri,  2 May 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182012; cv=none; b=b1gQmS1RWWIHcmwTi17oioF6Y5kqUa3paXZUiLKDDP0grpDxqDr7NcVa9g5kWO9VwMmcf8ji9WEb10PHHIXmADLHhw5TwUd4fw88vXqpD6z4nmXxBWzRgZ4yHRz93Q2qv4H6Nded32qsNAZLHDY7lY7Hwcqg40vKN44ZoC60W9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182012; c=relaxed/simple;
	bh=6QEAhWqoxgiQrK0AHA75E1viSIpz/U5WBhTF3Z46OpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OnPIPos//84Bq+0bbWoVUS48Wc0K9PC3AtfKAIppCnqLcf0Q/C50Xr4uEj6xCWxzeobzNRPgAKARju0JcGgrg5qUUqsP57lHfJCcqjCYatGpbTdrnNMl40HoUfwNINUs2GNjFIf9c66RKlHITDCy3xkiX5wYUkp9WB94nbyk4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ReCNhanz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ja0vT1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXpZfjy/xDT3mFh5/7/N66kp5ZfHYjz21aGD1cB4k3c=;
	b=ReCNhanzg06QY/2ZYm8a3jwxX1OSfEnj3LK7JnuTcuSVvgj02tjMVWSGBgPtTESziJbGOv
	CsbmfpTWTY5Nc0EEgiRtSPWP4U4/iPVMPh0XbLPdR46DmPPI2lmYJQs3k97nU8f+B5or6n
	h7eVnCFaj43XPR8/yurNp6sEqScLflWV1Xdve5HeOLXmZm86tnnNoSRXf4Mr5jBvaJ5a9U
	rzLIsvKoyZkHGRDChKaxAT0oktaaLBj4+K+YLvxSEZLmvC6h6aYa33BMPQ6fhfnREfARxm
	WFwfQz7TpxzZxk2U8XYf2Gj1PWDbBF/eyAOnuOdEaqMkbeGEF8Rrx/J9owKFOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXpZfjy/xDT3mFh5/7/N66kp5ZfHYjz21aGD1cB4k3c=;
	b=4ja0vT1pK0FkWSktKP1eI6Hm3Ga2Nk3vkY8opeOGrotmV2xeerUU+mhK6a/eO1VSxTlAtp
	3QrxsFZqaSj07tDw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Allow retbleed=stuff only on Intel
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-10-david.kaplan@amd.com>
References: <20250418161721.1855190-10-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618200789.22196.12744430810963109755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     83d4b19331f3a5d5829d338a0a64b69c9c28b36e
Gitweb:        https://git.kernel.org/tip/83d4b19331f3a5d5829d338a0a64b69c9c28b36e
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:14 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 19:55:50 +02:00

x86/bugs: Allow retbleed=stuff only on Intel

The retbleed=stuff mitigation is only applicable for Intel CPUs affected
by retbleed.  If this option is selected for another vendor, print a
warning and fall back to the AUTO option.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-10-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1a42abb..7edf429 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1191,6 +1191,10 @@ static void __init retbleed_select_mitigation(void)
 	case RETBLEED_CMD_STUFF:
 		if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) &&
 		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+				pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
+				goto do_cmd_auto;
+			}
 			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
 		} else {

