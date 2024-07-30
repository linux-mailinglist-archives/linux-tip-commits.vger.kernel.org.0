Return-Path: <linux-tip-commits+bounces-1861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14E941427
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7ECBB23FD0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1A1A3BD3;
	Tue, 30 Jul 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJxArdLP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nG3GQZu9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0E1A2C14;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348920; cv=none; b=CTzEuSGCVapKG7j671C0ZA3bfnZp9LqWMdfj2+TW4RmsnKFTZ2aECTeFZhs+vi38qUHsNPVVsZpwijeI+OMgdA1bvjTkoPbcmHPzuwhVKx9PDBRrSvEF+ErTZhEuwk2pzwG4xhYLGSq8AC0YbCwStQAqm4kdxip5/dI+RwnCyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348920; c=relaxed/simple;
	bh=c2XNAnSXZpGw9A8HZERzXtcLv6s4iGMlWqLGuprTuxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rghMXeCw3i5P5Xj2VyH25W3EzYtQyfgwHX3AGPn0dO1VyOUHVVm9LKoTyViRfGsHQGFco+FIDTowjO9qXScl86VlNH6VjCNzC+NbQZmv0GLPnph5K6ivYUm757PftnTUe1VD+Kw6YbKMpIOXKTUdFTVskE1r5F3KSb/kQNrxF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJxArdLP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nG3GQZu9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSFDFtt6A3AEcr5h4aMQYreBVvptXBzEYM/aHGJh92k=;
	b=mJxArdLPkjTcxWV5fjM5RUoFLJxFmjqE5Dr3lgv7ZZWfCUSj8FlNMzzSKMBVwL8s4MaqJ9
	CeW6BuN291wve/GbtyVIOD9hnXnOFB96OrKLFRZZb/nvOw/2fHyODE9TVDGLJ36mdHmClk
	gMktIVH6l6xfFSS+4JSUeHFdT/sBeb3VshsWAwbSuv8xIkQlVG2sDqTOuF1ojq/HfCM2bJ
	9WDr62xqOYIJqkweB42Q/fSMmCAMxBPaP8rQLGTpMgNiZyA7I5YC+pH3dIL+gG6s1RZWOd
	iRSMTrVWLDZTmDo72XuPhFJEC7qwVxVEjY4X0b2AxtfJVY5iZOkqKNmp6gnzgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSFDFtt6A3AEcr5h4aMQYreBVvptXBzEYM/aHGJh92k=;
	b=nG3GQZu9E3QhRHrAPaopU/MtdRENph+iDCv5Cy6SNSM0IT5yW5EZ6+zRS6oF36gTvFi0PT
	4xx+g6xe2lPygVCA==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for RETBLEED
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-6-leitao@debian.org>
References: <20240729164105.554296-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891341.2215.2864530336004870664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     894e28857c112c5a31517b3837b507f1dcbe9da5
Gitweb:        https://git.kernel.org/tip/894e28857c112c5a31517b3837b507f1dcbe9da5
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:53 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:48:54 +02:00

x86/bugs: Add a separate config for RETBLEED

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the RETBLEED CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-6-leitao@debian.org
---
 arch/x86/Kconfig           | 13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 290f086..c9a9f92 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2692,6 +2692,19 @@ config MITIGATION_L1TF
 	  hardware vulnerability which allows unprivileged speculative access to data
 	  available in the Level 1 Data Cache.
 	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
+
+config MITIGATION_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	depends on (CPU_SUP_INTEL && MITIGATION_SPECTRE_V2) || MITIGATION_UNRET_ENTRY || MITIGATION_IBPB_ENTRY
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4fde9bd..08edca8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -989,7 +989,7 @@ static const char * const retbleed_strings[] = {
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	RETBLEED_CMD_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
 
 static int __ro_after_init retbleed_nosmt = false;
 

