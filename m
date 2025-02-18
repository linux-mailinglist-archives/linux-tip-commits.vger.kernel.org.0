Return-Path: <linux-tip-commits+bounces-3473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693DA398ED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7060D166984
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D1B24113A;
	Tue, 18 Feb 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwxQSF0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6uJUcxI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A623498E;
	Tue, 18 Feb 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874394; cv=none; b=SyukO2YUjgfzdPaEwpbhH4/bHzt6ZM3PGuHczn9FtgpjqqdQMX7O4HkBUmPoEKmmj/Uws+pqutvqvrD0ZNB5qDW2ka60pXwTkaVDVHukVPX63hX/hbauJhl48VLAyLQxESaJi3CKKSMMyXFcTWaAQbYEdeOteAPqJG41r+PDAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874394; c=relaxed/simple;
	bh=6tgshXNW7v7bvDwQ/A/g7ZQD+J5eaQzPo/iHusk3HRQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O56d/JJHDuS2WmKR1e+f/eaKrkGAFj5SaTwHreMevoTjmoHQ9IqkwW4+dtOzeM/gQC4w1ia3YEPQ0qPTzmSedRwLN0Y5iZScQhFe4HUE+Vxk2arh2AvYJWcFRn8wDrHUq1moRjKO1JcCbPIwVgUbPqEOeNQ91CZ8rxcRAoMRYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwxQSF0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6uJUcxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6ypyH9QV/0dN5a4UctGx32dDTbI0yOvl/DviGQdvVs=;
	b=pwxQSF0XO7N3RIqjflNnpammz8Xjqrw8d37d0KfWwVKP/O8IcpFrNsWX/fXRzTiqyFej34
	b4OSIgbufS0eNOy7Wor4R+aVlyfnuIxW04Dia8lye7OLxSFPkSxLpNIxBnld7nLpsLEN81
	/7Oq+Isp+nDCxp0NGEGfBAHWTVRi6HRJa9t5DfvDAJDTXK7QkrwU6RFIJjWrLocBw6tKW5
	Sig/cn+LpAkBoA60VksQ+QYpn+/JThEuoDADk2H3D3ixpVGhyNgrgXTnmIFJw6vM/q56bd
	S4KoiqaQRqKt5JNicKD0b1G8PsVOjyx8fLuv8EhChoBG6kqybZzT5aXCAYhWug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6ypyH9QV/0dN5a4UctGx32dDTbI0yOvl/DviGQdvVs=;
	b=C6uJUcxIF55/p4g6rPc/PZSmf27NBMn4FJFiudOoe1uVnHnIM63pksF8S6tfMkLsXVXagw
	B6hBiILVUtLFyDCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/amdgpu: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Alex Deucher <alexander.deucher@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2e3664eebb00d3a8c786ee7cc1fba8096bababc9=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2e3664eebb00d3a8c786ee7cc1fba8096bababc9=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439013.10177.5813302293311242891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     690d59fee83cb0f45fae21ce3aed2b335c87c1c2
Gitweb:        https://git.kernel.org/tip/690d59fee83cb0f45fae21ce3aed2b335c87c1c2
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

drm/amdgpu: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/all/2e3664eebb00d3a8c786ee7cc1fba8096bababc9.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 0330826..7507d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -188,8 +188,8 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	amdgpu_crtc->connector = NULL;
 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
 
-	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	amdgpu_crtc->vblank_timer.function = &amdgpu_vkms_vblank_simulate;
+	hrtimer_setup(&amdgpu_crtc->vblank_timer, &amdgpu_vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	return ret;
 }

