Return-Path: <linux-tip-commits+bounces-6179-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E5B0EBAF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051227B494E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28E277020;
	Wed, 23 Jul 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/EnGtu9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgLmiy21"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BE27603C;
	Wed, 23 Jul 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255059; cv=none; b=qo+FjWxpAqNQLS9vAFH8Rg+1bPVZKdOYD8gpHTp+o8mfOh72H/tFVRB6KIhGyd/eN9Fr9iCOU0I+Tq9L/r2xoemk6M4nCpVXMcfhc4dQjyZD5tQI9WFDqBTmOZutNtgQiOtfP9V2PELbqVn7GJhx+jHkdeRRQOKIIxKnuCYLXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255059; c=relaxed/simple;
	bh=9Dcgdn5Xvs9uZP/FqZJWA0RwMY8heB2YZeMwkCKJVe8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nBKp6sQ97xYQGHAo7uJdtPNR6DhmMGDWb6JqfmVAMq3ZLpsiJMTm1J0Vjj7U4XGIPanB0S17lQLhrYhHtVT5tD0Lt6/JL4I0dnEZyhXa8RTLaGJtLdTb+6nzp7HH0klp7oqY203YKgOrviev6O000wdyhbM7+yFXaeQH3sKIBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/EnGtu9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgLmiy21; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySFRAO44/RWUAwVK9pFbxEYdEIE9mgpu+dAVgi9Y2NQ=;
	b=y/EnGtu9k4WpQl5tQdgMjfZzhwG2+SLoxGLX34G1ACP9T030fA+J3a/rBrmwdz46dB1pkz
	7aSsC3PtJhXMcVfCiPq7sjwY8cbiYQFduiiy+L/+2dYuTT5BCWKt3dMTCcbldIlsIonwKs
	NQdcbIdJjOX2bPx0LVbKYAYajaRK+DCJt3w29GbQN87Mds5wSv1HjqyPVdZ0MNx83oLXU4
	RgeE37gqdLwunLca0E/PPdVXb1wizufZCMuHdSejPFxMYDKyXEHyo7+cG/Dc800WOYR7H6
	F86UezgWowifzatT5tKhNaoiOlu7Lgq+Mg5GK99D7oi4WSdDQ98+GRZydD7uPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySFRAO44/RWUAwVK9pFbxEYdEIE9mgpu+dAVgi9Y2NQ=;
	b=FgLmiy21sMw+SYFVTTtn6f+cBvwgiZMsXNxaZwgHfDtDRQUuCA/5kZvdPqRX0Zmz+DPsOv
	X2JMZN+wmYvVVmCw==
From: "tip-bot2 for Max Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek: add MT6572
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, Max Shevchenko <wctrl@proton.me>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702-mt6572-v4-3-bde75b7ed445@proton.me>
References: <20250702-mt6572-v4-3-bde75b7ed445@proton.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505415.1420.3676669507204677304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     791a2ba9e66894b04c289176a84613ce57c72fd7
Gitweb:        https://git.kernel.org/tip/791a2ba9e66894b04c289176a84613ce57c=
72fd7
Author:        Max Shevchenko <wctrl@proton.me>
AuthorDate:    Wed, 02 Jul 2025 13:50:40 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:30 +02:00

dt-bindings: timer: mediatek: add MT6572

Add a compatible string for timer on the MT6572 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.=
com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Max Shevchenko <wctrl@proton.me>
Link: https://lore.kernel.org/r/20250702-mt6572-v4-3-bde75b7ed445@proton.me
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Do=
cumentation/devicetree/bindings/timer/mediatek,timer.yaml
index f68fc70..d5b574b 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-timer
+              - mediatek,mt6572-timer
               - mediatek,mt6580-timer
               - mediatek,mt6582-timer
               - mediatek,mt6589-timer

