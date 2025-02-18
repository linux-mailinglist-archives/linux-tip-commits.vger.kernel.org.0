Return-Path: <linux-tip-commits+bounces-3465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3BA398C8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3937174892
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83329235367;
	Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JYhgZxp+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8FN1pRR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBB235BF0;
	Tue, 18 Feb 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874388; cv=none; b=I1yzW0yG8KkPnMts5za9ptfbs2eapB1L0PQnY3887/5qvt9sYXrPIcHTd4a3BzlFbEOgx67+6QQ1Go0QrXWZWtlrMfM8scI8Vsi1M0keh/Ud7LGMngHY4nDm7cp1+qFWTE9PTc6xFyCrgC+2qJTbJNND5eYmUT7HvvMvxugj8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874388; c=relaxed/simple;
	bh=OC5LARbCCDId+iSQkAhShTiR6W1LrMWEu8FAoQGNRwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MAMr103CMVWEmUwBv7vlB7afwz29OfFECHCeNTetTfAQPnln4eLZ7WtBckAht4ed8X3R4+ScaJnm3IrG2zXnxV8z09chLP4NnlyDEoKNElc7V4PZzP86BTaNKCp/40Fegx3Z2Ep9OMnjdw6dea3yUvqb+gePH6DKNPX4sjpTOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JYhgZxp+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8FN1pRR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBM1N6fUQWAKL1M7v+s9jiT2uMCHy7v3DHTDpfwWDuY=;
	b=JYhgZxp+ortp32mqE8UiXjjpkhR6pQSCxUfG/j+YSs2YEtvJ29jOmD3mzGeZ/NJhOly+lg
	mY2F0TJC4r3AiD58ZxbXZI7Lp6mDW4ckrIOcPROcu+LFpMCSEuLyumDRXs5lAe1li0/DWo
	Bh32e7Kyu1a5YfV2+xJURb4KK9SHCYCcLhPIHhuI9CKWdBVJ6y7qZ8tCx0gru6HoEoikfJ
	q1fRdnpNWOQNxGL6RNuFEX/fG5FR4aqEWbqLOTXtmo+yazHG5hXhA25baTDn5WQRHLGo4g
	+2eCmf+CuPioq5Adeel/FGA7wsgGAMcGT020t8xJENQtvQ/kGsrRsvYIR5kT+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBM1N6fUQWAKL1M7v+s9jiT2uMCHy7v3DHTDpfwWDuY=;
	b=H8FN1pRREREYKx6JLQ5FtAQUEclDybtp1pL6VDY/nsGlm6LsrvTyMlC/IjzJFFhAApWlas
	fvgeYzEsroNI8SBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/vkms: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C866841803c850c38819f98fdf6bd992ee4a4d012=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C866841803c850c38819f98fdf6bd992ee4a4d012=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438487.10177.15931332081481792559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c38e753abee274318a52ba53f99446a1b912ceea
Gitweb:        https://git.kernel.org/tip/c38e753abee274318a52ba53f99446a1b912ceea
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/vkms: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/866841803c850c38819f98fdf6bd992ee4a4d012.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 28a57ae..ae4e36b 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -64,8 +64,8 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function = &vkms_vblank_simulate;
+	hrtimer_setup(&out->vblank_hrtimer, &vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
 

