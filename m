Return-Path: <linux-tip-commits+bounces-6766-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F2BA19CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ADF321AA7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385232F75A;
	Thu, 25 Sep 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCrx8jsU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2eXBFCU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2632F74D;
	Thu, 25 Sep 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836036; cv=none; b=D2yB5qI6Da71BM+OJUF/zNPRHRD56hdTHxFC+MlYSlWB89V76TumycO4esYG0V7eoTiE4I/Pw79tQh7PAEKaYvsyWP5iSPB7qQnBRvWOyGixPZdkyRg7PnNva0hf1+Fs+rCetLIWJY3rBsRXT5Gh5GsdKQ34VqDZVvCfnFh70/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836036; c=relaxed/simple;
	bh=i9z0WDBdHKM8UtsdlTO6/KNiiqMeKTtY0RmnajcQMzk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=W3BeEDQUw9HkjLB+JTZQj5DaLkz5KyTxUAGIEoRjD/PHsWbp4FDxwWoXWsoVemMOc82EY90RUNljyQNc6xtqASsj+5Fkcd2Rm7dxNSi2ZGuOy3SUqD1vzNL8gak3ZwO/UlxRTn7korRvVoO2LOFHoSlE8SbTv8ZGw3XqKdz/ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCrx8jsU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2eXBFCU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j94eD1hCZ1NqXrSo4TRVzQjlqjYCJGC3rB7/aBmR+Ms=;
	b=ZCrx8jsUCiCfYYMhcb1x8lIMOIYNpNyhagDkjjK5IiIkLPvIohk0XTecBzFeBSSEno6CE3
	4oB5K9feXq48mdjpl9Nqm/JC2N61vv46sn7SmKnup8H0Kna7STGdpNe0rkHpTduIKUen0F
	2kLcjaSil394TU/YZ8F+NgoG4UjlesKRv00pPHTpCTTX7OQnh+18nzXKLPNkytce4emCs/
	PsCuQO48QXSF1ogjtJJTNcdHWgn7EEOccJIPJdzOxE847ej5i4Ib0AgQsNZM2x2Yn5+SoF
	FbGeNACsEA0hBxdoMEs8N+l9g899Hw6UspNIiW1cBVV1HPYH/4UjFu7ohsOLBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j94eD1hCZ1NqXrSo4TRVzQjlqjYCJGC3rB7/aBmR+Ms=;
	b=P2eXBFCU2QaiLY4/bet+a2FQ2GNRJ27eXuzJt6uzo6uw9T69U+1vtlgBSAJptR9xXhOJmH
	lf2MYz8P5NjLW7Bg==
From: "tip-bot2 for Max Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek: add MT6572
Cc: Max Shevchenko <wctrl@proton.me>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603018.709179.7090133995379721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     bb7bf8b44de1b13b8b7b10ca166b545ff22edac9
Gitweb:        https://git.kernel.org/tip/bb7bf8b44de1b13b8b7b10ca166b545ff22=
edac9
Author:        Max Shevchenko <wctrl@proton.me>
AuthorDate:    Wed, 02 Jul 2025 13:50:40 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:53:12 +02:00

dt-bindings: timer: mediatek: add MT6572

Add a compatible string for timer on the MT6572 SoC.

Signed-off-by: Max Shevchenko <wctrl@proton.me>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.=
com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250702-mt6572-v4-3-bde75b7ed445@proton.me
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

