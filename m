Return-Path: <linux-tip-commits+bounces-1853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6E941417
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A651C23467
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2731A257A;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pv7wZvz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xhHUtNbr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7871A2564;
	Tue, 30 Jul 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348916; cv=none; b=GI/ESnPz68cAgerkKZs+RR5gdWvPCqZwfFbz+3ZettH3tOLRx4JZzE4wtyMUeYZhzCSm9+mpEyj1LLPrJ00u5gjrsIyumALwMcJMmASyf99FybNZpCKKtiJZAkOevZB6fbA97soGqf/BzmVyXO0Wy908neKvWPw+blyzqqAflSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348916; c=relaxed/simple;
	bh=PNKGNqvf2e1qOtnG5K1/D/LIyGaxYeiYAbPRQQI5Qhk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m/Ia6C6Yra9AzA1rwXJYozf4LPhctduJD1QHlt3uptcAtEYRJa4fen1RUXu+OBLvoLMfTCHC1UStW6DjhBs9a8MdzSgi+CSnq7XRZLskcDKInjOolYhMbp8NjlxP1Ko//0ShDBaQZtBtr+aTX/+4sGe8rrixtr4sd2attAjgByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pv7wZvz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xhHUtNbr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2o1HAwaU5Y+qn7qqiOnuT/Dqlfa0heKxk5EgZpt3huY=;
	b=0pv7wZvzOWD1TjmO0YcbBK1nTizQeICdYnaYXHc2wcOkIhbHDJ+8HTVxoKtQkExKyiFvus
	xlQnr6aR2C8bcuEz9lVRH0A6zRjOLTU1luhfEYfje17ul5Sk0GMKSYfzXGZ1I0fZJX/7PL
	bp7k75XOGqB7e4ZYwsr1i+JFVw7oT79Uz6+pY8JIL7vMslBKo7eeMild/iAMpmgcHzRMiC
	9RjTNCyzSro4ht+ayB3CYssxOu/AFAuTMGPMGlo0odxng4NSrFLZK46Yl3DyeqwvhoTR6S
	cGcCHdGBtGjgIEjGS1LoT1TMLW0n0Ab+SoS6osBZmn4JVTMvM6NFU+JtOYg+nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2o1HAwaU5Y+qn7qqiOnuT/Dqlfa0heKxk5EgZpt3huY=;
	b=xhHUtNbrQZnP56zcTecUnJHKmy1k4bvFTMojsGFW3jUwLdvEXbkqYcvlBJkoGAzCGbPHIY
	me1m/rFg95vcpWAg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for SSB
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-10-leitao@debian.org>
References: <20240729164105.554296-10-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891240.2215.9541829225956645612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     b908cdab061a5ead51d5e1731ca9c1b26699a9bb
Gitweb:        https://git.kernel.org/tip/b908cdab061a5ead51d5e1731ca9c1b26699a9bb
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:57 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:51:45 +02:00

x86/bugs: Add a separate config for SSB

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the SSB CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-10-leitao@debian.org
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33e125a..2e72a07 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2741,6 +2741,16 @@ config MITIGATION_SRBDS
 	  using MDS techniques.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
+
+config MITIGATION_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45cbc6f..a7f20ae 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2027,10 +2027,12 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
-	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	enum ssb_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
@@ -2038,7 +2040,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -2049,8 +2051,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 

