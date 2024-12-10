Return-Path: <linux-tip-commits+bounces-3049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0E69EB8FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8BB283378
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B34204698;
	Tue, 10 Dec 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wf2F4bsU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsHd7z5R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55841BCA05;
	Tue, 10 Dec 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853919; cv=none; b=I1yHeQ4PPIgldRdzrtSvL+tX0s0gOv8tWx8P97KjD/XFhBDbEyxIaXjKQ7PS50SQHI8FVoWM3F9KHIpUoGzcNqEy26Qt+LdUrdXLUwUIQqhaUp4bJ8KgSEpeGD4IYnuRSCEUEEBrJ4Yr0VDIFSrQmSJWcIpgttFjrugvokuOlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853919; c=relaxed/simple;
	bh=3zQcmcVc01UWFmkGFcfmpbw0T4ifsUkvUzkvVACm6RQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nRHHFwgqVUllaBNH7uTs/lmoLN6z0LVfAJSt/yYwsOzU6cs1XV2Yq70lQdQ7O5XW3oE7KpsxbNM+9/46ocAG9nIX+lvXmT3YonHnIzX5Btxr5A3Zk1MMKcqLBpW+UelzmDwCWqsyuxInMLqq3SEcha/B4Ma3K4WQILmNj/hfJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wf2F4bsU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsHd7z5R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 18:05:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733853915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UMiOndftgcdO/E8qu01KhH2mvQDeQZ8KN2FLxyOEIA=;
	b=wf2F4bsUAfqQajYMQTt3G0BX2LMNvf9XtDO5DYGJ4WSiOBPQV15iMzgul6MX4i2hghCVfg
	QAdRCnhnKyBXnEJfhhA2jIVfzY5r89N1Tu1F1qFb6E2cjwvmlsDsqvl9fTMr54vLdlNf0K
	6ZftjwvcTpa2djtAISjGRXgbGvv5c9+Ntl3t+WI+RJafUl8RYS95UBGskshht2fqCM0OHm
	9QYyvMxR4y+heZIoEbYEXFgFe2yO1idxniz7aDqAQJNsGZ8emxYfU6U28+0L99lgC74p9x
	RNU9d4z6Y2nAG7sluYi0+YYWX/W5y0tjcOuGzt6ZNj9hbly5lSTw1lIuPSrczQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733853915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UMiOndftgcdO/E8qu01KhH2mvQDeQZ8KN2FLxyOEIA=;
	b=qsHd7z5RbclM4psXyNNqN3WmPTHEqpeRea5xuZMFfqnsrCvIfXek4qwEBZyuR7DQxn2ZJf
	weNtZEpM6cEeUZBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apic: Remove "disablelapic" cmdline option
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202190011.11979-2-bp@kernel.org>
References: <20241202190011.11979-2-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173385391464.412.17889576345902752664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     13148e22c151e871c1c00bab519f39cc6f6ea37a
Gitweb:        https://git.kernel.org/tip/13148e22c151e871c1c00bab519f39cc6f6ea37a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 02 Dec 2024 20:00:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 18:55:08 +01:00

x86/apic: Remove "disablelapic" cmdline option

The convention is "no<something>" and there already is "nolapic". Drop
the disable one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20241202190011.11979-2-bp@kernel.org
---
 arch/x86/kernel/apic/apic.c    |  9 +--------
 arch/x86/kernel/cpu/topology.c |  2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c5fb28e..1267b26 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2582,19 +2582,12 @@ int apic_is_clustered_box(void)
 /*
  * APIC command line parameters
  */
-static int __init setup_disableapic(char *arg)
+static int __init setup_nolapic(char *arg)
 {
 	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 	return 0;
 }
-early_param("disableapic", setup_disableapic);
-
-/* same as disableapic, for compatibility */
-static int __init setup_nolapic(char *arg)
-{
-	return setup_disableapic(arg);
-}
 early_param("nolapic", setup_nolapic);
 
 static int __init parse_lapic_timer_c2_ok(char *arg)
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151..6ebed85 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,7 +428,7 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'noapic' */
 	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
 		possible = 1;
 

