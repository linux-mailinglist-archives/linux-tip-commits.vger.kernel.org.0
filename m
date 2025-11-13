Return-Path: <linux-tip-commits+bounces-7331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C022AC57B03
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 14:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E57E426F55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B063538A8;
	Thu, 13 Nov 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwQ9N+k9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmooY8Ec"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419235292E;
	Thu, 13 Nov 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039262; cv=none; b=sDBqjr3VV2Ej6w4Jai3H/Q/fBxaU15DOzm3pjw4Lthk6imvxvH1faaKg2sGmIsLFoZKwEfk1E2axQ/SaVn0vbEupN4Nvhje9rLOjKHwTDnOhK/vY86Zku8w4A8oc+tAL7UB4uZMQmzjnAA92slO5XqJe/UsF+fq30QWEPVj+0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039262; c=relaxed/simple;
	bh=MEgOBDHXKxGuchqhBruo6cG7qjR6WWbwKOAoKUrdvOE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CrWlgcHHH5qklt+qmAHylNrjycL4CQPSmAWXqSUDi665DV3DB5LGIbkAWe/buSNLW3qEMaJxxCV3LOCNJSnEmXk3nstVsPNrV+uM+YndBjJZiM+WfHum34IhbZ+A3sX8wRZ+ZTWVAHIpWPguTD1pQfFZGx8Xx4z0v1PAcfZPqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwQ9N+k9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmooY8Ec; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 13:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763039259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2xWavukJftNMA/gD26QJ49HGxPwF54XcJYDFoTRMgI=;
	b=mwQ9N+k9iqg2rxgsyZt4l8WCuXAdHH8tPyKtn8O12dT+hOTJEv2RW3sI7r9fZqm3+NTfgD
	/uUCHsNS+K+SF8WgCPXrbBwW0KqMZB2Q0Q6kchuHhYJxe3ZjvsL89x1zjXE6vrJV0N6gbC
	QrzGN5RrhC/5o+SVHjgjGArqkqJ9W72xREIHJMMBP0ly/iMl9dQR4NfWGjoIQDDocWHrZd
	//n/rF+ph69doFLb06k3znSCDt2Fh3rOpIlLKxGuGTuYRhq3bniN4JaTxm4Q/C08rgNDIW
	u2oSKbOjSSyGg7dtTsfrm6tYjOQTsGrkSVPcqMigIqhWFh5DT42H3lvNakP0/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763039259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2xWavukJftNMA/gD26QJ49HGxPwF54XcJYDFoTRMgI=;
	b=tmooY8EcpDH0TlV7zSoCo/Emt4knZAXG9UH1i1YTd0gnffsXF0WCb2lP5dvjz6f/YSXPl7
	9x9P+QJEPx4l1vCQ==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add support for
 Amlogic S6 S7 and S7D SoCs
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176303925801.498.900309447678439153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e4ca1520081bc67b2a1a01a5ad4013a82300e06e
Gitweb:        https://git.kernel.org/tip/e4ca1520081bc67b2a1a01a5ad4013a8230=
0e06e
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Wed, 05 Nov 2025 17:45:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 14:04:16 +01:00

dt-bindings: interrupt-controller: Add support for Amlogic S6 S7 and S7D SoCs

Update the device tree binding document for GPIO interrupt controller of
Amlogic S6 S7 and S7D SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe478=
1c1@amlogic.com
---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-in=
tc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,m=
eson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
amlogic,meson-gpio-intc.yaml
index 3d60d9e..d0fad93 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
@@ -39,6 +39,9 @@ properties:
               - amlogic,a4-gpio-ao-intc
               - amlogic,a5-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,s6-gpio-intc
+              - amlogic,s7-gpio-intc
+              - amlogic,s7d-gpio-intc
               - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
=20

