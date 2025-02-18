Return-Path: <linux-tip-commits+bounces-3468-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21291A398FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AA93B6F8B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50723C384;
	Tue, 18 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVSpnLqG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2AGYarRJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05523956E;
	Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874390; cv=none; b=ZhlYA1t+HRqbw1V/v3v3GQegGmCgt/nYyxrdZ/4gII74VbU7UqkMHXyfghxCpkh7pGHCyE15njxi2nNy6ty/tzj2SeqL/kGDA17dkTJS6DPpqIWPeYWryZRzDvp+pb5zB8dYS54iafJvLOYQQsxLeDTlCrxErUzq3TG07E6egv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874390; c=relaxed/simple;
	bh=H6+dzF8GizOFdAzQMr4AsHTPitm8HGgQirftS0KtADQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fXEw5t7PXLYb5n/m9+PSoArxTKSODYXqC1fcdDuzhUDThL6kNPz+SB7YV0i+BtGrkQAmOsvHodnxtzbMLx5VpEKouhzdEDaCedVzJDskFlaUzGN+5oPWQOgoyPwM93g7UTGTU3W9z415WrCxwjVgdZYmX7BF4qKGWJFWgCzufTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVSpnLqG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2AGYarRJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W3LZ+KIPzVxIEqZLBG0G1KrXm2Zo4l1emtJWdLJwGg=;
	b=ZVSpnLqGo8ZxcW16vLJPuD5Km7EpmY2BVCVmssrKBlb4HqPpEgnWqQeOZ51K5NwjRd7Hm4
	pD0hDmwJ5eDqbG6SLhV6ytf5PrfbMPn9X7VvStwbHEc5oVe1pP8XGNvdQkzHK1nhgT6ECf
	hbavlpIo3iJCwvHkdl6zncyBa99e/kJsaESPEqPgSxqKprivMmX2zpYq0pMC1bue4Mj6me
	8c6pysRcWEZ29NLHTCOKQY4osTqHqc/DDRqfC34z4lWo1ttiTIO63lneMaRwt8KEW/fOL9
	be7Q4xAguBrvInyPEA/cOCwoTVhlpVySw7rQN+hOH6sZervMW5XREDlyz0S39w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W3LZ+KIPzVxIEqZLBG0G1KrXm2Zo4l1emtJWdLJwGg=;
	b=2AGYarRJlYKnk3bDLct+7E5cNMZBE9flQuPNQVfa86aKs2k2Yk6kQ0jBu6vfWauorQsh19
	Mi+0bA5pqgpcZ+DQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/i915/uncore: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1d0ad9ab31040d9c3478b77626cdb0a04c0a7bad=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C1d0ad9ab31040d9c3478b77626cdb0a04c0a7bad=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438664.10177.5973868873322305800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f97e1d787f9f57fc78227bad348d092c1d7a1ee9
Gitweb:        https://git.kernel.org/tip/f97e1d787f9f57fc78227bad348d092c1d7a1ee9
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/i915/uncore: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/1d0ad9ab31040d9c3478b77626cdb0a04c0a7bad.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/intel_uncore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index eed4937..bdcfcae 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -2103,8 +2103,7 @@ static int __fw_domain_init(struct intel_uncore *uncore,
 
 	d->mask = BIT(domain_id);
 
-	hrtimer_init(&d->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	d->timer.function = intel_uncore_fw_release_timer;
+	hrtimer_setup(&d->timer, intel_uncore_fw_release_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	uncore->fw_domains |= BIT(domain_id);
 

