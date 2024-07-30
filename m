Return-Path: <linux-tip-commits+bounces-1856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E11C94141D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2964EB266FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C911A38DB;
	Tue, 30 Jul 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECq4yVLI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+8/acpp7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8D1A2C16;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348918; cv=none; b=SqsPvjffKBiLoL+CkWmG3pP/hfFcCTd3eNMnFj1g5mYfzmMXIYu1QL5emg9yBtRxp4LYn5RW3SK3FgBBe1eNR3g6wFmtOZoWvG+Qx+1pbdAnmsWRvW6EMSKCVIhqzJG3QqNSH81Q6yZIOXCQ8GoyyDRZoQksriakm5Wbf6qLpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348918; c=relaxed/simple;
	bh=3c9YLjlgIA8ofZuvJ+KMCQBu/mqYdK1PbBEwBqfhEaM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hvAorfZDHFA9ejDnHeTZjP9lGlBpYSQ0NZsVfuUag4oMUoW8hEzem5lYcVa4ldEh3Bs7eyE/XODEp/EVQmeABp/RCUz28tJ8+xSovhRi0jULWS0I9t4bWWKl6zIC5kj7KB1tntaYl/+DUupvVzFmyI4oiofINp0gCMH2oHczyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECq4yVLI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+8/acpp7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pMPBI2iCMFlNVVBPkMchOZfa8f3iZO2b0c0oFUVpss=;
	b=ECq4yVLI7p6wmVSTaDIgOCg5IzETiymBA3bgPJ1jd19lA0L9sZUm2J4mtrX75HUtcA2C4R
	T1G3uBX/LAi/xNTXCp40FYheYruE/g1xTv1/+8QQxj5N4WUdywvgaopDns6N5ZBKCnXjhO
	IwoP3bNBblPEwZJS2ij6795wDMe7MV7VT3U1Kisf5lrWd/aPqz6Fh1tF9exoT59UNr4l1i
	PJNmdASwjAH39EtvjhyBxtTLyLUEwuNP2V0tjmft6L8+gEsbw4sjQh9bE37XoQIhiqUgvt
	VCLgHR1y6DaNvyhdipLci1FQIwRLjKUy0yBbRar1SzyaU8l2A8ismcbR7UBHjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pMPBI2iCMFlNVVBPkMchOZfa8f3iZO2b0c0oFUVpss=;
	b=+8/acpp7DV2rGHwY0gsZysN49d0nYA+yFCqigyKmcWAKULtDRIe/6IQ+DWis7WYGHQmWtT
	BX8rx0UJJMhkLCCw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for Spectre v1
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-7-leitao@debian.org>
References: <20240729164105.554296-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891314.2215.1983688628596540699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ca01c0d8d03089f81c713aec0c63d359bc0f6796
Gitweb:        https://git.kernel.org/tip/ca01c0d8d03089f81c713aec0c63d359bc0f6796
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:54 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:49:28 +02:00

x86/bugs: Add a separate config for Spectre v1

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the Spectre v1 CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-7-leitao@debian.org
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c9a9f92..e3c63e5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2705,6 +2705,16 @@ config MITIGATION_RETBLEED
 	  unprivileged attacker can use these flaws to bypass conventional
 	  memory security restrictions to gain read access to privileged memory
 	  that would otherwise be inaccessible.
+
+config MITIGATION_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 08edca8..ebb6a2f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -874,7 +874,8 @@ enum spectre_v1_mitigation {
 };
 
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
-	SPECTRE_V1_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
+		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",

