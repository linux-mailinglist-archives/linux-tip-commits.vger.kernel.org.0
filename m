Return-Path: <linux-tip-commits+bounces-6021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E933BAFC7C6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B341BC4690
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514326A1BB;
	Tue,  8 Jul 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HORDvcr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuYCOWGM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3012690EA;
	Tue,  8 Jul 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969040; cv=none; b=XYAbqNGJHEadHqWPWNJkCFA+KX7niQlZIarF+Au6AC5t28saNJylWV74Omb7sYvcopO+SptU0sSfcbHR39UvrAlS3fkBwq8hE6V88HKyplm2RT2hTOzSx4Dw9fzxrYimy8L3YTIjVAblgNKFzOVd4e5Be2kB8dS3swhVir4dIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969040; c=relaxed/simple;
	bh=BY68aZdEa378DJ/t3vpo6LmgSHewn8eiRqhrOu5J1AU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rB+mcyEsUOCRQnJuASuqZi+9rzQK1nwNZiQLTEO9X391QZ/ec70DL39cPe4t3xEPiT/sQ0/yaT/0tAcykK6Er2jdD1/fCnIBw2FpwuhZWf4/47MsDH4z9nCMieH7c4gBU5EARdYv/bKkYAEREsuqUi97JSJgyBk68nyGw73NMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HORDvcr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuYCOWGM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OSm5RtBEGqK2Y53in7YM1zMdgMizfQmg+dHNl9TDw0=;
	b=HORDvcr5+PjA+QQiceXEQNy2AGAnzXhgR4QnInGjr1rfbXX6HErfVEyl5COtr78Wd5n1SS
	VVSG70o5KjpTt8VTwWs1K+46BMdV7RRdgygPYg/dnM76iqD2BMBpUUqFHUNPQmgFrIAg1N
	co6e6ia9HVgp9I/hcwqmpsB0DTojv+2jZod2Kl0pu+pzPYzMB/V/4bT4htLdzpqoqojrMS
	QEgykPTY9Zc1NxMcBWLbsO66WcM8l5CsJ7o5UIvFs7M2hSQ/LHVjYdXQ/NXQTTjWhgtl8F
	6Eb9JWuDC8HkRuElSxZu2DBBUZ6QA8D6JqsUXuuFMFU0c400NC6Y6VpQy1HJ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OSm5RtBEGqK2Y53in7YM1zMdgMizfQmg+dHNl9TDw0=;
	b=LuYCOWGMG0grBm0RUj8ma0Jkymk2+HIMtM5Nw35kHxiP20/zyo0v3nIQSgjUoeSmeLIcSi
	uBYQpuh4+IwBQIBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] cpufreq/amd-pstate: Disable preferred cores on
 designs with workload classification
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-11-superm1@kernel.org>
References: <20250609200518.3616080-11-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903493.406.13263192898156163411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bfea2b3b4f2346510ec45a0c22450e1564f48f88
Gitweb:        https://git.kernel.org/tip/bfea2b3b4f2346510ec45a0c22450e1564f=
48f88
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:15 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:33:10 +02:00

cpufreq/amd-pstate: Disable preferred cores on designs with workload classifi=
cation

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-11-superm1@kernel.org
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f3477ab..bbc27ef 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -826,6 +826,13 @@ static void amd_pstate_init_prefcore(struct amd_cpudata =
*cpudata)
 	if (!amd_pstate_prefcore)
 		return;
=20
+	/* should use amd-hfi instead */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore =3D false;
+		return;
+	}
+
 	cpudata->hw_prefcore =3D true;
=20
 	/* Priorities must be initialized before ITMT support can be toggled on. */

