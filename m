Return-Path: <linux-tip-commits+bounces-2166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61296C6B2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 20:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5731C21A55
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DA1E411E;
	Wed,  4 Sep 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGPS8Vch";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2NRu04o1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435321E202D;
	Wed,  4 Sep 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475698; cv=none; b=pa3WkHHYPEw/I1avwQr7whG2+kPkC1IOeYNf+ObI8TGVYB/AbWEDSflpfGlcxhcRrxoA+/hHxtjohLiWAa6ebQ/Oc/acq7Z+5DW/PwXAs59+skj4THzSJms6I0Wfu3XVr/+KFl1y7QvKUzZ+J6bHFbbv7pH9s6oAkGPjJA+xc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475698; c=relaxed/simple;
	bh=kg+vrKwWpKR3raZxzqWgRH1hEoceF9aADlqsAG1e8Gw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UJSOJwCE61fXrmu+K4oNMQ7Sb2AQHd5xVL0xM9Drpuabf85WIr29DQ5GrV0Kfgk77PnC5nrvawl1yrA6A7VvkEnbHVyM9LRMPgq78/fNad2gIa/ZaZVmp4bAWsJl29PR6Eu456CL7OZYH2IuCSxBscgM77ppJTwMwkBuOqOQpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGPS8Vch; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2NRu04o1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 18:48:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725475695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+GUNEu/gOIcHce7+VIrmC/cV5rCVdCk4wDX/Ft8Fe4=;
	b=IGPS8Vch/RuqGJwHKtA8tWUD9csDKLloCr8+9mqTl3zGs4i+KzBCxG99agCfPQ1c/ucVOW
	PIral2MmAxKXiCsP44LXTvKqAauFkSM18ylN6n1+ke0fUztbRA32jmRZXB8jEqd7CJJ+ur
	uw0jBUVQ+JMCvSgvpwOa0BF+65HtATpeMfnjAwxhEQAzvRVZYxk+o8W162NB2gp6Kohc1j
	7PxAoMLx/rNF5QjBn8yxUy9LLtqhOJRfkRbwlNCKySPSnWwLttCpCMYOIHwcjrLN1lNMS2
	J1DWvLKkpzXKz9iUTx8+6YsYVJlcnDrOn3f+TgRX6n7LETOCuFB1FslWw6vnqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725475695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+GUNEu/gOIcHce7+VIrmC/cV5rCVdCk4wDX/Ft8Fe4=;
	b=2NRu04o1QgqOByAur0rip0ntuOAxnXY5ved8VzCCy1Jf4OuIwGvpEitrpghMTmU8YmasYy
	ZuKfmaVwyvzFhPAw==
From: "tip-bot2 for Nick Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: apple,aic: Document A7-A11 compatibles
Cc: Nick Chan <towinchenmi@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sven Peter <sven@svenpeter.dev>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240901034143.12731-2-towinchenmi@gmail.com>
References: <20240901034143.12731-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172547569522.2215.8269715074163000493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9e65863194ad253f1de48bb9000a586e6caa5eed
Gitweb:        https://git.kernel.org/tip/9e65863194ad253f1de48bb9000a586e6caa5eed
Author:        Nick Chan <towinchenmi@gmail.com>
AuthorDate:    Sun, 01 Sep 2024 11:40:04 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 20:43:29 +02:00

dt-bindings: apple,aic: Document A7-A11 compatibles

Document and describe the compatibles for Apple A7-A11 SoCs.
There are three feature levels:

 - apple,aic: No fast IPI, for A7-A10
 - apple,t8015-aic: fast IPI, global only, for A11
 - apple,t8103-aic: fast IPI with local and global support, for M1

Each feature level is an extension of the previous, for example, M1 will
also work with the A7 feature level.

All of A7-M1 gets its own SoC-specific compatible, and the "apple,aic"
compatible as a fallback.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/20240901034143.12731-2-towinchenmi@gmail.com

---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e..4be9b59 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -31,13 +31,25 @@ description: |
   This device also represents the FIQ interrupt sources on platforms using AIC,
   which do not go through a discrete interrupt controller.
 
+  IPIs may be performed via MMIO registers on all variants of AIC. Starting
+  from A11, system registers may also be used for "fast" IPIs. Starting from
+  M1, even faster IPIs within the same cluster may be achieved by writing to
+  a "local" fast IPI register as opposed to using the "global" fast IPI
+  register.
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,t7000-aic
+          - apple,s8000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
 
   interrupt-controller: true

