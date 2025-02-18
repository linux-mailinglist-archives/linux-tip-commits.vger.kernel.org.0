Return-Path: <linux-tip-commits+bounces-3460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1828AA398C2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B1F166A57
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A23496A;
	Tue, 18 Feb 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNX+ndEE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpgOcVfh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC91233157;
	Tue, 18 Feb 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874385; cv=none; b=dPbGn9u398BJOLFfMRTPDbDrO8d/rqLN7+OJfj8a/YISPE0QC8Mkd8lTwNY2z/Tp+L2E/7sggO10Iqhcs6cBlvXIZvFJ0e5lKNN0k6+QTUqKtYC6rjg4Q7O7On3IrWFt44Dhhdz74oN50d4fpmFxhDby/lMY8oGWXROnhuBlIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874385; c=relaxed/simple;
	bh=+v1JweYBEY/CGYBZscyihz69jZg3It72vOCsafolEbM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M6sMT0vuqs9ydWNXgQUlpigWoVl4aZJGtcRAhoZ1USKjCoZ6dC6F4MvUzJv4LwOZVIFh9Xy0aT1qOSO1IGWTA0Og1UiCfTEoWTmAeUtGkTgDZ3aFkKYYrGb2gqMWVrofhvSgSl5HCibInTI/mTbfidv6d0/daeRmcEauBMTJCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNX+ndEE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpgOcVfh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQTlyW637reWM+qXLPrAQPnDHpvfIWgxTVbfl6LA1M=;
	b=yNX+ndEEmFlnHWgZOLlMZ98fss4dzs8pqC/iSo5OD+CqL/sLidURUeHy4fOxflsMIeLKHx
	D9gXqj5rHssvd2rXip3cIJ+oPMm60AJEMQ/D1rIIQKUsDkshSVa7wEiC6sxLl8FG+T1kYI
	ACASVWZDVMtvnMiOmU4GnOKCEF3Nhg0AoM16T43g0T1n8U/0MSKBcdbOSffspGwxDiV2La
	1b6x/10F6r4gc0WWv7S0BcFopLM4owRlWR5B2e7iocMzz1DCe8qKc0Od1GjEpU9n3ybJy1
	7UvyzRG+TGVqXdt7xja6QZsQIWX5khtekyX4hC++MppEjpVTK83Um7betzKahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQTlyW637reWM+qXLPrAQPnDHpvfIWgxTVbfl6LA1M=;
	b=PpgOcVfh0W5d0+/PlV1QYtfduBy6fMTPRbpahvpZ7EFSq4EO9B+n4/5esGIB4qSvKYQR1z
	mLuGYKvJhuix83Ag==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] ASoC: fsl: imx-pcm-fiq: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ced4be9ec380a688291e3fc9b24f8c38a3f07a143=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ced4be9ec380a688291e3fc9b24f8c38a3f07a143=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438118.10177.16763578756324505419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     ce68de08a2cc95dc2cb6018a22673beed52f25c3
Gitweb:        https://git.kernel.org/tip/ce68de08a2cc95dc2cb6018a22673beed52f25c3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:07 +01:00

ASoC: fsl: imx-pcm-fiq: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/ed4be9ec380a688291e3fc9b24f8c38a3f07a143.1738746904.git.namcao@linutronix.de

---
 sound/soc/fsl/imx-pcm-fiq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 3391430..83de3ae 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -185,8 +185,7 @@ static int snd_imx_open(struct snd_soc_component *component,
 
 	atomic_set(&iprtd->playing, 0);
 	atomic_set(&iprtd->capturing, 0);
-	hrtimer_init(&iprtd->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	iprtd->hrt.function = snd_hrtimer_callback;
+	hrtimer_setup(&iprtd->hrt, snd_hrtimer_callback, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);

