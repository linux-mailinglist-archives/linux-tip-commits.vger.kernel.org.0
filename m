Return-Path: <linux-tip-commits+bounces-1854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66607941418
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96D285136
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3CF1A257F;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzWDvqGF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xlng5ZWp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8481A2566;
	Tue, 30 Jul 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348916; cv=none; b=FgytTZPA4HQH0dG0fZsiQfQiUwhPEK5puzYxllI3r25Z9mk2Z2/X6C/EdiSY1xMrppXMc2wBH56G4pMWtbiz/8xLraKLtHsKYOaE+j5XkyPBpXHZKJdzpPuwoaNLh/RosD+0rTnim0S87jYT44ZJp9b58QkhX7Ck6Lk8CW4FZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348916; c=relaxed/simple;
	bh=NKuOKSmTb9wNa9VZ/YLNEGBeyN+j0IngzB5714qkS8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EbWOgG01jGEoKwKdnvzsoibq6q2sRTbdK5jLpPC05qeU8FEsAzqABxWTKa0kyG/S27SkQCEPNaDf/zfJ6643ffECjWC4WnRhd3CIQjDSwkwNq+dNbMsrcCCIL841iKXzeQvlQpBN61W7/lewbJ337NXczll7Tvk6Ku/Z3Ukv5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzWDvqGF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xlng5ZWp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mkO5ik1q2L2V4/Yvtg4LvN++ZcNa0QdyzfbqtO30YY=;
	b=VzWDvqGF9VqbIU66LYMsXXUmVfJTlpXgcr3PQnC3AJ7D91GxUKHY7Coz+DfLY7CL7TWePG
	C9shEacEsCtapBs+nxWEu73NXGnwsUAzdOKznY0O6Eqe0LyK6kvIQF24sH41SWAF5eWeLd
	WnpVM5IW+sCWl0T3yLCgSFpOudt69LSlixTJgxe1YMNzUnCxm2F1wdRy/sPx+PBIEa88P2
	dk6YjWo5rWflOJgqOB46QtJXaWFf3NMVW7Br8CsXsXVZFnBWZLPEdNDrQAK3yyShKMeEPC
	Drb1eWk087k4ux0Zi70Avp17n1dD0TiMC9tatjAMv2Ng+RmZWbUxkATD5+s1yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mkO5ik1q2L2V4/Yvtg4LvN++ZcNa0QdyzfbqtO30YY=;
	b=Xlng5ZWpz4CShB24RQfl9dqzPNcYCZ+vfk9LH81y+SRQtIPDZtCpPV2BqBpL15TvuIMXJs
	OfNUptAjfIy3uTDA==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for SRBDS
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-8-leitao@debian.org>
References: <20240729164105.554296-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891290.2215.3511382738375523693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a0b02e3fe3661ea20df4d13adfc94b6affdcc466
Gitweb:        https://git.kernel.org/tip/a0b02e3fe3661ea20df4d13adfc94b6affdcc466
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:55 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:49:53 +02:00

x86/bugs: Add a separate config for SRBDS

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the SRBDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-8-leitao@debian.org
---
 arch/x86/Kconfig           | 14 ++++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e3c63e5..22d3245 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2715,6 +2715,20 @@ config MITIGATION_SPECTRE_V1
 	  execution that bypasses conditional branch instructions used for
 	  memory access bounds check.
 	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config MITIGATION_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ebb6a2f..8292a96 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -608,7 +608,8 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",

