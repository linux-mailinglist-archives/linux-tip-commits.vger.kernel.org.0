Return-Path: <linux-tip-commits+bounces-6206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B1B11C7B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054743BE61A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EC2EACE0;
	Fri, 25 Jul 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHfYLD7T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bRJAxpUe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C42EA172;
	Fri, 25 Jul 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439512; cv=none; b=c5w5zg8TDRbedqAdOIGX9SLd7v/ukG9TgSgI7OjktsW5fxVE4qBXYXaHfUMX0hqD24aZVqqgT0rxAEf32qYdd5oSfZjaxfR1xt493umVx0CfKRzyMFwXlzynv4k0FXNalWjpQp3ll2R66RKUSd+Bg0bvjz7X8ML1cbAwkY5d6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439512; c=relaxed/simple;
	bh=k6zBc9Pj7eYWeXra25M3RsP4J6Wn/qRvJsukYlX4J9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HAvu9DI48QTykGql5MbEZIprGcVLie6bymTl/hCHNd71r/QmV/T9l6Y7dqMwvOKdNNgxvb1jxbKHgmOyPwwLuirPqcMq8kp1/hNukIwIlWmR4I7o76D+arNZhMG5uZU1/qM4gHlK214Z65Dg1OXqjSypNHfTDXL0MBkifUoOdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHfYLD7T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bRJAxpUe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9Q0tyqg0XAxdO3I/2sv0O0RN7vF+41J9H1oy1z44ug=;
	b=JHfYLD7TOUeDia1sra5fPRYYPeBPMXL0wxpzUFmxfI5+qDYEG9c+R4CGK8OpTYPl3B+vNG
	TjLC2DUaB7QzpExrNwGU4yYCsInIGtPh7IGBHZSPff6yvA9bFdMDAErcUQzBYskeYxResq
	yU2xi2jMLNiPnl5/3kTvxBEoZ7bCktP043waB4s1oHebf0XjIs6eagkiVnAG3YtvjrqEq4
	+VYPdsU29osRXTMdyWIRxXzLd5LhPJwor0oaE5ejXQdt+sYd3hX2TRWJIGRm8jpbqo2Avw
	DNOTcgm1nFnkpT+3puyeRWL9tofvys8Qqu6UDP0o19adh2zVWeCOo8vciNlJpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9Q0tyqg0XAxdO3I/2sv0O0RN7vF+41J9H1oy1z44ug=;
	b=bRJAxpUekNKVIuSnhqxHGoN1Yjn9ioTKHetHhOilz4YTtrzpY9xzQmHMYwIru/v/VmyNFV
	bYdRCSVmmxyKT5BQ==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: fsl,ftm-timer: Use
 'items' for 'reg'
Cc: Frank Li <Frank.Li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Ingo Molnar <mingo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250523141437.533643-1-Frank.Li@nxp.com>
References: <20250523141437.533643-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950713.1420.12083169589037507665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     a06b35eac655563ac7f184f2be5b580bbe8ecc44
Gitweb:        https://git.kernel.org/tip/a06b35eac655563ac7f184f2be5b580bbe8=
ecc44
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Fri, 23 May 2025 10:14:37 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:03:14 +02:00

dt-bindings: timer: fsl,ftm-timer: Use 'items' for 'reg'

The original txt binding doc is:

  reg : Specifies base physical address and size of the register sets for
        the clock event device and clock source device.

And existing DTS drivers provide two 'reg' MMIO spaces. So change
this driver to use 'items' to describe the 'reg' property.

Update examples as well.

Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250523141437.533643-1-Frank.Li@nxp.com
---
 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
index 0e4a8dd..e3b61b6 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
@@ -14,7 +14,9 @@ properties:
     const: fsl,ftm-timer
=20
   reg:
-    maxItems: 1
+    items:
+      - description: clock event device
+      - description: clock source device
=20
   interrupts:
     maxItems: 1
@@ -50,7 +52,8 @@ examples:
=20
     ftm@400b8000 {
         compatible =3D "fsl,ftm-timer";
-        reg =3D <0x400b8000 0x1000>;
+        reg =3D <0x400b8000 0x1000>,
+              <0x400b9000 0x1000>;
         interrupts =3D <0 44 IRQ_TYPE_LEVEL_HIGH>;
         clock-names =3D "ftm-evt", "ftm-src", "ftm-evt-counter-en", "ftm-src=
-counter-en";
         clocks =3D <&clks VF610_CLK_FTM2>, <&clks VF610_CLK_FTM3>,

