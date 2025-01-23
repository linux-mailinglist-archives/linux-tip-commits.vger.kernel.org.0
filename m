Return-Path: <linux-tip-commits+bounces-3283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C5A1A28C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 12:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256341880955
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C620E009;
	Thu, 23 Jan 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlGsiPrN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SkHnJWkg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200D20C46B;
	Thu, 23 Jan 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630397; cv=none; b=pxycYmSR7CKzX1f0G388oHQwPeA1PTbSHOnaE1vj6lGAPGXFbSvGYXXhipQVc0zhFWqScMVNvmRfa7lUo/1mwc66qhKAeickni33wjLRxOaSNy2wYvTyBxGfL13ysoblBzTCTBx37GkccF1BNrUbQ3AroW6q7eAXq3pZWDrMeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630397; c=relaxed/simple;
	bh=dr4nd0mGZilnl5mWIGO3QPDYs6SEFdU0GN2cZ7N2+Eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bje62eJ57GDNmaqyba03ppl6iUpSPfxMJjN0pSbDBDHPyAO1WxFtBzg61OPvvPP8380+t0fsanbHTzE9bGFIcBVIs6MdqUsqOecHPAuKgvJyRZvmISfHvgCgfIMzk2H+YZjd4cmq8hsu/CkZZ7ZCHMvBZ0cxHpSEzDWG9TbvH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlGsiPrN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SkHnJWkg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 11:06:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737630394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qObs5Rz7Wx6vatz8aijoL61lCYmGjolnH455ol3V3Jk=;
	b=IlGsiPrNpeAabzatXogqthbrMYrhNpVPuhJwrFZpZxZ8DgoqIqa+Ayxyl9pnk7cO1dckUp
	Ux6w2YgcmOUFH8SdDvl4HV53lwSnoNwZmhFCH1FQ6OsfbDr5uZryW1jCFhpA7b5pImm9ln
	laISSD6dbQiRhHRXT4hidvmDdpf07aGUWrbdJilHUlqQP7q832shkgWIqcm1tndziNyId+
	u+FQuCH53AwXEqPPz8nvEHmD4onJodDI0MzP0esvS8q0bnZph4IwNYM+WR17RBBKB0QGF+
	U54qMlEU6a93EmzpifVFMhcDXt+82XNG1laTmgec8vFMPWi9wRh/aZGi/U53mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737630394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qObs5Rz7Wx6vatz8aijoL61lCYmGjolnH455ol3V3Jk=;
	b=SkHnJWkgMPEhQguILHZrZIL73YQHhRLBFEcj5Jze0Z+lNV4NPlcQbI1qftKh9FZpZjQvcM
	jSKFdBAA71TJkVCA==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] dt-bindings: interrupt-controller:
 microchip,lan966x-oic: Clarify endpoint use
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C247b1185c93610100f3f8c9e0ab2c1506e53e1f4=2E17373?=
 =?utf-8?q?83314=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C247b1185c93610100f3f8c9e0ab2c1506e53e1f4=2E173738?=
 =?utf-8?q?3314=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173763039398.31546.12682905928030556986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3fafa6a02be219ddd05d6201911534a34135cb82
Gitweb:        https://git.kernel.org/tip/3fafa6a02be219ddd05d6201911534a34135cb82
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 20 Jan 2025 15:35:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jan 2025 11:59:10 +01:00

dt-bindings: interrupt-controller: microchip,lan966x-oic: Clarify endpoint use

Reword the description, to make it clear that the LAN966x Outbound
Interrupt Controller is used only in PCI endpoint mode.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/all/247b1185c93610100f3f8c9e0ab2c1506e53e1f4.1737383314.git.geert+renesas@glider.be

---
 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
index b2adc71..dca16e2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
@@ -14,9 +14,8 @@ allOf:
 
 description: |
   The Microchip LAN966x outband interrupt controller (OIC) maps the internal
-  interrupt sources of the LAN966x device to an external interrupt.
-  When the LAN966x device is used as a PCI device, the external interrupt is
-  routed to the PCI interrupt.
+  interrupt sources of the LAN966x device to a PCI interrupt when the LAN966x
+  device is used as a PCI device.
 
 properties:
   compatible:

