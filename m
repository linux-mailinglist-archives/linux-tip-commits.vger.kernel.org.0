Return-Path: <linux-tip-commits+bounces-3657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80AA45C8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261B93AC5C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2421883D;
	Wed, 26 Feb 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQAZ1/Ay";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GSRS+bZy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41A2153CF;
	Wed, 26 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567846; cv=none; b=TvKZxUL8IRievE+/rY2lZpzE3/aYEkleqXxmMDWzLGxnNS65sOrSRMjl1TBe/jnuOOuDTav8GzP7/Zh1U4bmjwB6y4wJqktY9zLMn9XDPcZkAMjCHkuMW0kb+fB9c+zW9ItlIcWtEbJP5mCB5kPqd5wTACVIT2ZvW4UyD8Z4dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567846; c=relaxed/simple;
	bh=BpoO3XKL59QdK/JmhTWcvEnPjJAPyJqasSIpVj16f9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E7dLoHXP1XyBiVon5QW0DguQ+BLmz+X8QamyMMZ+HktOEgzAyNHtBZv+7Er7hYVvk/XGbktpMCtLGlwQNa+05uioUJMw279ZAY2r61xjHPLqP/q5Xfj7pXolYucSvp+7HgeU35iJgsy3GHmmoVr5aQAYZfnWqiYyxCS4a3sjSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQAZ1/Ay; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GSRS+bZy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwZGb8ye0KvnBDhoKwKz1KCdDcjRiwvLN0V6UYtt4fE=;
	b=uQAZ1/AyEYrYeiRxzVhL6+MI0OeZA05hnFtVLZ561Pu/QVaPc0lQfkoCIWo3KyffojJTc9
	h9ihSeBbXm5HGokXi0v1nn6ApjWqcHbRRBtim29T2PaqISLMXvcPZN2rMQ+DGcfltOhG2S
	MTXL/FeaHwimBWNaA0QLeQTQ9FU2YJY4CzFasx3ZwhF0uYWLHQJdHfOsKp7lOxJFU1PjFc
	hFgnWHq/pZIjOUTp0nF2Id4+i53cdUNTesHNzFin7hRNDFHgi1p3HQOHtGlHvugNppjVPC
	v0LOIvFg+3wvVUrtdgu1pPwi5us/df/VolGd5DkhvrAzZe5hs+uW2PjR/KSgPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwZGb8ye0KvnBDhoKwKz1KCdDcjRiwvLN0V6UYtt4fE=;
	b=GSRS+bZyUg3dL08r52IwKgCDRL7Ib4shY7uGcJ2GAvpNsLcIGsRk6YGME2UyLBKII64J5a
	qqJFo0JopDp3piBA==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller:
 renesas,rzv2h-icu: Document RZ/G3E SoC
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-2-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056784278.10177.5669846418937512319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9d245214b683e9e4fe2d5c588691337b22c48841
Gitweb:        https://git.kernel.org/tip/9d245214b683e9e4fe2d5c588691337b22c48841
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:17 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:49 +01:00

dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E SoC

Document RZ/G3E (R9A09G047) ICU bindings. The ICU block on the RZ/G3E
SoC is almost identical to the one found on the RZ/V2H SoC, with the
following differences:
 - The TINT register base offset is 0x800 instead of zero.
 - The number of supported GPIO interrupts for TINT selection is 141
   instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Hence add the new compatible string "renesas,r9a09g047-icu" for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250224131253.134199-2-biju.das.jz@bp.renesas.com

---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
index d7ef4f1..3f99c86 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-icu.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/V2H(P) Interrupt Control Unit
+title: Renesas RZ/{G3E,V2H(P)} Interrupt Control Unit
 
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
@@ -20,7 +20,9 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g057-icu # RZ/V2H(P)
+    enum:
+      - renesas,r9a09g047-icu # RZ/G3E
+      - renesas,r9a09g057-icu # RZ/V2H(P)
 
   '#interrupt-cells':
     description: The first cell is the SPI number of the NMI or the

