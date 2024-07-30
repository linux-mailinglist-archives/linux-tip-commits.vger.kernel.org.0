Return-Path: <linux-tip-commits+bounces-1858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2B94141F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5452A1F25407
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7DA1A38FB;
	Tue, 30 Jul 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFTIg41D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9xD/TCd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE761A2C28;
	Tue, 30 Jul 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348919; cv=none; b=llSnVFnOSQlmP7F8rZ3CLogypuYfkTFnYF04A/0DacDH2ToFiF4Cd3LivZ8BnTYRNZXYP76AnBeowqkYatECVgG8wJotUu6FNPaDpk7KVB15lodNE19WS7vH6GkHm3Lt1ud0eFfQrN3Ek0CDYKggm8ukt1Q4hgac3Mmrxwfe9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348919; c=relaxed/simple;
	bh=JqoxRLWjZLZzqeWKiNJX7HPY5fK7XfQXnr5nf+CAcFA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LVhU2tJVXPj638C0jTgaRECOHYWRoMEn2+VCocWtEwByXOU8OH2H2DTl1SwsuE0fOrj1GULCbLygiwW6eO0K5AdLw58RwiXTWJ3TvoENN+anoENEdvv5Mn6rMQKp8pPa4nlx8C9DowRm9hpa6w7SPFMq3WQgD+YwpIyUpdL0Nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFTIg41D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9xD/TCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XOMjR9I7Qr0zuIge3sTQAV1GYPj3QvAUYx2AAtMLyI=;
	b=AFTIg41DASI9JJ24yS2bTQ/kv9GQDPkj0Td4UUIaVgiCxPQEy6zeosyMSIohBHSgFM8+4t
	5J1QBSuOSnvH97SRhRuZcyupBa1OA1+z1FMmvUjcOwKMCOX6KuD5A//jGI/Ll7hq1vlY/d
	ppwc+CGuFTqmCiSF1qC9V8xl9lLom8bPzJCiUnd8n+HhS0tjSNWHpFe5Mhp4nvCUSl/hoR
	vS9lwaQuyTL3BAWJf71NWA9M5T0Xv8LXxDI2qmk+zBp/9CWY4mEdfkYoeZhTs9jPVaOGxS
	PAZhqqUccrG3RH+hhF3VjCWRFVFMzD91NekKwaV3gCb80QbcimqYl+4k3bIs5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XOMjR9I7Qr0zuIge3sTQAV1GYPj3QvAUYx2AAtMLyI=;
	b=n9xD/TCdpARMpV/aH8eRsGuSPuS9gImyc2z9fictLu0YeyjO/v7Hjfzv2MRrQtgrAEQzFj
	2KSmMlPgWDRC7IBg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for TAA
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-3-leitao@debian.org>
References: <20240729164105.554296-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891457.2215.9029377920326503847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     b8da0b33d3899e5911aaf0220a317545fe2e3b37
Gitweb:        https://git.kernel.org/tip/b8da0b33d3899e5911aaf0220a317545fe2e3b37
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:50 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 10:36:16 +02:00

x86/bugs: Add a separate config for TAA

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the TAA CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-3-leitao@debian.org
---
 arch/x86/Kconfig           | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 36e871a..712a4f8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2659,6 +2659,17 @@ config MITIGATION_MDS
 	  a hardware vulnerability which allows unprivileged speculative access
 	  to data which is available in various CPU internal buffers.
 	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
+
+config MITIGATION_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dbfc7d5..ab30698 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -294,7 +294,8 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {

