Return-Path: <linux-tip-commits+bounces-6177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615BB0EBB9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB858AA2BA2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D3275B10;
	Wed, 23 Jul 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZRzjzzI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WytcSK/B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C476275847;
	Wed, 23 Jul 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255057; cv=none; b=hboYyLTGgGY1cpmAwgGrP3E0qqi2FzRAHAktuB47EZU03o64HQAYekf9D4rKacHv0mVw3O3xGzkWDzfGGh9MrzUN8mXsbWmPyMpz9MJ+bNMVcAY/g0feTFFt5o7KZ6DViiuLol4PomGUt0PuBX3oRmf51XIxGGWVyP3tHua/2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255057; c=relaxed/simple;
	bh=y7IkeUbWODgpB5ea+FsFBFcNB8jwBot+v7o03wC6MHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J6HMDBuJh+OhRa7XboZpoQhgsyKNSlKZjzkQuBYJyVYsXLF8kHnqx6IGHJjuuaG51nWuAddBCRALzYvgIWy6E4/SKoK2SbpkmqZp0FeGVKrlGHndO+y0aU+3R4WAJuBA9bEFzPBTHu9WxoHasqctsrHfmCllgx8DvyTzOe1WAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZRzjzzI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WytcSK/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtXT5srm5uBSIBfQunil7THSjiGvbwr2Y37kXmZEhLY=;
	b=SZRzjzzIIh07d2dGf6hfMZT163EFJJbEpizui6TUXNB7nXwd7F0kpG1rIeIOU48d8Ywfd0
	yUqGkX8eCJ2QzZybM2xLg9xEXW6RsomSy9WgW4weeI3Go/HosynuTa17D9WaDbMD5IPi8L
	4K/Ljz49OSMT/83sfCn3PjXtM48m5JydZpcMheJ7haws6XdaSjm2JRjGkTYHAhi4HE1t0m
	8Hq+8N2Sz/cnWn8jE8XoBtLLUPHejO6q7j3LR0rTMiIxJp9rK22+NIouiQ70I3PbtOBG70
	g2Bz7O+h7VZZr7njM+w9mLEY9EOYtQTkIbbnutwCIoaLw0nShaxxjebwjtH47w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtXT5srm5uBSIBfQunil7THSjiGvbwr2Y37kXmZEhLY=;
	b=WytcSK/B5WdZIwwil1KO9gBMZSpo6OTaqeQLUgZAikGia4nOHGqcmJE2DyoRuX1+n8LirF
	ql0IYumSGyyaPiBQ==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: fsl,ftm-timer: use
 items for reg
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250523141437.533643-1-Frank.Li@nxp.com>
References: <20250523141437.533643-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505307.1420.3943140957454469329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     4532c1172869819d5b7e63d7ad12cf3f3e5f3946
Gitweb:        https://git.kernel.org/tip/4532c1172869819d5b7e63d7ad12cf3f3e5=
f3946
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Fri, 23 May 2025 10:14:37 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jul 2025 18:14:42 +02:00

dt-bindings: timer: fsl,ftm-timer: use items for reg

The original txt binding doc is:
  reg : Specifies base physical address and size of the register sets for
        the clock event device and clock source device.

And existed dts provide two reg MMIO spaces. So change to use items to
descript reg property.

Update examples.

Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250523141437.533643-1-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

