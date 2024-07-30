Return-Path: <linux-tip-commits+bounces-1852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B29941413
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008F128507A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D91A2542;
	Tue, 30 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ojb5CZwE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzOjDZH2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069A1A2559;
	Tue, 30 Jul 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348915; cv=none; b=PVZNGm9k9bRrGsUtGOsRTagmbLvBTT5jTJI0gF9YJbQmwF+FWH4lLD+WFuvlknckG310QMJTVBTy1hb8YXQKmcA5tCCpqgV0o7dfIpprY6wMh+/ed5zEg4h/lROUiEElvwMuct/itaMmC0bFGFWQEQQbV+wKsgKm3qkO1vIIsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348915; c=relaxed/simple;
	bh=CyI0W+gam+s8v4NH1j6xckwpohLx6wbxsuEAKIvEdZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rrmalupJaFVDkG731oEpGC9RRc/95A1P1N430AVcLMIU5P4G/LNQ2P48TtPAj6yPPtBCxbC7sXkPm3YGdgsVDXEvXHFQarRvMugdCPwN54+gAleknbZgS4gbEvz1RGMrp0QMqVzeKCDtxScC2q+U4YoF5ndeMe6erEu1iVDJHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ojb5CZwE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzOjDZH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnQCkWHn+Eq2THMNEphNglb8whFUJtCwFgbrCt5v97k=;
	b=ojb5CZwElaqdKs2Mp5skK0QsfYEUDwK5rDco1EL9WgtY1RTlxp+KpMe+JK39s/h+dA4PRK
	YFaiFw+57gdAnBC/QsLuWjPGU41HGDJLVc2UOUym0qbgg7Ty83NzbRw4SgqsDvXJWHm2vt
	UE3b17pAoVrUYNNtDHkte5X/KTr8LbxHeX+90drDOUuKZU700BKjO3Tf2uLSE87BgEnYqN
	4Z5iWHYrJwlsK0eXAo9rwpr73fczG4x06X7cOXn6SPU6sqCgFpI9yq1yyQQcNheuLJJiIw
	K/2rBQMIORJA+xEhU+Fz/rcj2gy80ojtorRit0d2bxkvSYk5czYedMeogmRU4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnQCkWHn+Eq2THMNEphNglb8whFUJtCwFgbrCt5v97k=;
	b=mzOjDZH2zpiFYdLJ+PlKPjekrS5dtGnUwZLCzXTdX6cLsZL/eJQt0vIbOFrq5VYBBTupXA
	NndtOClBWad98lBQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for GDS
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-12-leitao@debian.org>
References: <20240729164105.554296-12-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891142.2215.16307852253027242186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     225f2bd064c32397acfe3d9dfd9a2b3bc6d64fd7
Gitweb:        https://git.kernel.org/tip/225f2bd064c32397acfe3d9dfd9a2b3bc6d64fd7
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:59 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:54:15 +02:00

x86/bugs: Add a separate config for GDS

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated, where some
mitigations have entries in Kconfig, and they could be modified, while others
mitigations do not have Kconfig entries, and could not be controlled at build
time.

Create a new kernel config that allows GDS to be completely disabled,
similarly to the "gather_data_sampling=off" or "mitigations=off" kernel
command-line.

Now, there are two options for GDS mitigation:

* CONFIG_MITIGATION_GDS=n -> Mitigation disabled (New)
* CONFIG_MITIGATION_GDS=y -> Mitigation enabled (GDS_MITIGATION_FULL)

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-12-leitao@debian.org
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab5b210..475bc53 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2610,6 +2610,16 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATION_GDS
+	bool "Mitigate Gather Data Sampling"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
+	  vulnerability which allows unprivileged speculative access to data
+	  which was previously stored in vector registers. The attacker uses gather
+	  instructions to infer the stale vector register data.
+
 config MITIGATION_RFDS
 	bool "RFDS Mitigation"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b2e752e..189840d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -735,7 +735,8 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
+static enum gds_mitigations gds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",

