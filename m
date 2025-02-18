Return-Path: <linux-tip-commits+bounces-3463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45CA398F4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE5C3B5ADD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233B236A61;
	Tue, 18 Feb 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY6k/wXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYaAoVqn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2101234977;
	Tue, 18 Feb 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874387; cv=none; b=V1G04bEk5mFnv1vOjBS1+B+vWo3oc/grFWXS85Coz2w/v5d0bsUVXoNRhAldfRszYJ3FnCe9T+63bCIA5j8il1BEAv1GnNGZj8PIdw5pTkGgBx9RFvTHxjqbr09H/GRkxGoRzmXdup9aUkr/oNmrhew5ftHu1nja1IOSUWSoI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874387; c=relaxed/simple;
	bh=URZ/IgHvW3YBMCfOP0fLu2D9jqF/8UEJ+qtHFxAYdI4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rCTnNCoC1+iUEM8M0kpjMBgGglC3vA1zN+/KgxI0p260auRH6WTMWU9E/tc3Wk6gP25lEHc/eCAekH+RkAShXcigZYPSh9TTwla+Sse1t4WIm/shYmtH6MyuafAKodQ/i3Ie8QS6cif/8WNtRMC6E0xMRqbOIyM8UKnpSF7UX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY6k/wXs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYaAoVqn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Na9vHdHviHpnrxDKJy2WDMeKuN0CP9E+X6XrPgOx8/g=;
	b=WY6k/wXsFQ9iwXfhGH1bve65lClS8Z3GO12D/wH869oByoFa99aDExycL04ZcFXnOfkPmw
	o9LB+Gh1RAmjkjWHQPV/swV4AvzhKxmmjYJ8TOMq4K26tEIpKgjZQnpT79BLC1+l9GSHrA
	wTzJlzTS1OQ0YCC9uZEVUGcPA2NH7/mc/Di3lJRDrQmaL//6Bhv8WnWYWksNBcsRT/Cd7k
	akYXKlSzku0n2MVzSsnduzvdf1DKu4FzAV+QcdKNP31IZo2iAR+iRRjPBWK5yKMdIR4oGl
	aColeiUqy+SPmgO7U0Q17COMbBteJutJ2J6ymspEqxUjNTZuRnmTlIUv76W7tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Na9vHdHviHpnrxDKJy2WDMeKuN0CP9E+X6XrPgOx8/g=;
	b=hYaAoVqnCGEewuVeAWY320cLyXRW5Xn8LP0S9naXF31lQycNiPY1IFCtoyzKym8OKbMVy2
	IK//j9KLuSsSjiBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/vmwgfx: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6f6664cf2fea2f782e37f64a77fc9f8699794f58=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C6f6664cf2fea2f782e37f64a77fc9f8699794f58=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438351.10177.1430402561997908703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     ff533f73d5c038e9be359fbc587dc229a8299e13
Gitweb:        https://git.kernel.org/tip/ff533f73d5c038e9be359fbc587dc229a8299e13
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:07 +01:00

drm/vmwgfx: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/6f6664cf2fea2f782e37f64a77fc9f8699794f58.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 8651b78..aec774f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -290,8 +290,8 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	hrtimer_init(&du->vkms.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	du->vkms.timer.function = &vmw_vkms_vblank_simulate;
+	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	du->vkms.period_ns = ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&du->vkms.timer, du->vkms.period_ns, HRTIMER_MODE_REL);
 

