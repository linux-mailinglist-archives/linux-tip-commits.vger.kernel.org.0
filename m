Return-Path: <linux-tip-commits+bounces-6194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B45B11C61
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FA93A57BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281E2E2EF2;
	Fri, 25 Jul 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zgCr5YyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTLan+YR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBC23A58E;
	Fri, 25 Jul 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439503; cv=none; b=cdb9R9sWru4zaiMK+LkLeQvxAKUDqc+0X+vk9Cm6NsTpLNtVXsFO/p+1RCWTgfoLstvv4Nlbu7KJ0+UAAG+whQRd26lYoWjqHFeKKqsI8d7AbvaRnI3GE3THvBRGTz2xxelzz7jGqFxvDzS6DpPz8abletsV+KgNTmgfUiSuAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439503; c=relaxed/simple;
	bh=KGUmzjPYKznw7eNnOJecXe13dBpbgToxszdNnVvYuII=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lsTTTUKxSLELPrLFuUmt2ig4hzi64wljbHVWekDybItT6lx1AH8iAnKjsq9Yl+julYttXG+Bqz3QajtHV2nPa2UnEedHksuZ+Pc+KwIj6tFgLutZWY85UEgvUxub+rFJNLX4yIKj8U335QV05FDLzw0M26ne0i1qMJZ+trZTgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zgCr5YyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTLan+YR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QreMV6KMhU9WmgTr4YsYsrjbQs7Q3fPsyZoHRuxaAY4=;
	b=zgCr5YyClphFvHeSLaBSOfoqZFqQUwNyWMik17Cd2RQuIiiPMq+QFNbPIyZOJtpaFDA6Mt
	8YDRWDCflWYK4nQeYdREV3fQdWvHQ7TE3Lr2cuYaKo3Pzdgpr8OD5QR45v9fhzqjZjatQx
	m6SGbNQfPh9yxVwIxd3UrZo3lBpLEHYDANvyyRjPsUD2+XN7p4PT1l8g3Zp+9T0GbdppSj
	6kbBkuF3e0825pp9+raciX/5BYv7MtyP4TTfwnhGWaMgMDKKAlOqGlrSaGKIWZzsuGU/3L
	Kl2ncgmmleIotWesL5m4++M/53yuqC+6oYd+2/75IbXWOfWB6Onx1GWBDTIcWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QreMV6KMhU9WmgTr4YsYsrjbQs7Q3fPsyZoHRuxaAY4=;
	b=TTLan+YR5s08eBT8VHcsAVuEkSerWrmC7KpBTRSwgcMOI2i5Adc2+IbF2uX3MW1JICjN6J
	UYOqxmLkOthwZXBw==
From: "tip-bot2 for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek,timer: Add
 MediaTek MT8196 compatible
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 nfraprado@collabora.com, "Rob Herring (Arm)" <robh@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>
References: <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949221.1420.16625294446050242580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     bc70fac7b4028f3fbaddb47fcf1ccfef4003c8fc
Gitweb:        https://git.kernel.org/tip/bc70fac7b4028f3fbaddb47fcf1ccfef400=
3c8fc
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
AuthorDate:    Wed, 11 Jun 2025 13:07:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:07:05 +02:00

dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Add a new compatible for the MediaTek MT8196 SoC, fully compatible
with MT6765.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250611110800.458164-2-angelogioacchino.delr=
egno@collabora.com
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Do=
cumentation/devicetree/bindings/timer/mediatek,timer.yaml
index d5b574b..e3e3806 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -45,6 +45,7 @@ properties:
               - mediatek,mt8188-timer
               - mediatek,mt8192-timer
               - mediatek,mt8195-timer
+              - mediatek,mt8196-timer
               - mediatek,mt8365-systimer
           - const: mediatek,mt6765-timer
=20

