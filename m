Return-Path: <linux-tip-commits+bounces-1688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A69304F6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6CF282887
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B246F066;
	Sat, 13 Jul 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fG4zjjph";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hI0gWDve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDA49635;
	Sat, 13 Jul 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865823; cv=none; b=YjL+SMEhr5kEFahIJDrxfcsMb7Ral20GGKD4srzMDBrbYdyhGcZLRvZOl/Su4aBCqOvaJK0yzIW+uvkRz0CZmlzGcQV8DTGjO0A4w/liqmpAqZ34h+QTdGKOSs+GoCpVWfxIz4mEPz1dhK3oE+Xbet6ZKaluT7u2GG4Fvn+b5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865823; c=relaxed/simple;
	bh=ikg6+k7evUXjX6R9vFf3uf93xUe7mNjBRtJvixHWHzE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=emlhVDnnjqzax6Ej4zC8q+CsqSt+/Up7m9W3N7ki9jIPrFG/ZY54I6UkaO6FthfpjpdTU7AMBsbcPFsnSgza8zs5RmtmGyy3fOzlMZ+GEkHc8Rcu1xdqdm+eMto3qRJIjId+9lt0mNp5B9/nbxNWkZlxo4s9ju0bjhcOVZJlaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fG4zjjph; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hI0gWDve; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwBe6AZ+wDB9fPQZPIHLPRuCwS6397DCx5rUB7F4UMg=;
	b=fG4zjjphztWTDSlxT/xx4uUrim7hRfS/szFqe/Ivcg1kUqsUDSw/v6wr75eWol10ae3GJK
	jIkFeX1dX9OkAIDBrB0jJ2MRj+taU/MDHpEVMGbtYPGpPDy2y2XHhlZKNcbp6eyWhMPGaC
	sIPJ60FbcAXFxLdziCuVK910Rp9UiOG8Kil5f/VdxC5sh/cR4fvRHuq6zyxf03JW5+zkf6
	GRX+4/JbmQrSuLNixdgsQIFKpJPMkXxZU52u3l20pUiKhm+R9bLDqtLbOE7STwBihvNLO1
	hBmIepxGnMBjXS+Yjfs6I+1/nrG42wEaxbKfuHe/8HDGm5P6wIPVeInzDp33RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwBe6AZ+wDB9fPQZPIHLPRuCwS6397DCx5rUB7F4UMg=;
	b=hI0gWDvem6MT9581NvhSwm1HzPnZLkKLOiLyAl34BUjbauuRFAV6PBxl3g6/RxLkwUiQPh
	cIBTkGYpvX9WtIAQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: renesas,tmu: Add R-Car Gen2 support
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 niklas.soderlund+renesas@ragnatech.se,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cde215e00e180c266527b7bd7cff5f75df918da98=2E17169?=
 =?utf-8?q?85096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cde215e00e180c266527b7bd7cff5f75df918da98=2E171698?=
 =?utf-8?q?5096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581461.2215.11568471605049116141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f124a52ab88986dc21c88bfbbcefbfb262ce47f9
Gitweb:        https://git.kernel.org/tip/f124a52ab88986dc21c88bfbbcefbfb262c=
e47f9
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 29 May 2024 14:22:06 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:06 +02:00

dt-bindings: timer: renesas,tmu: Add R-Car Gen2 support

Document support for the Timer Unit (TMU) on R-Car Gen2 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/de215e00e180c266527b7bd7cff5f75df918da98.1716=
985096.git.geert+renesas@glider.be
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index cc228ed..b6dd98d 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -34,6 +34,11 @@ properties:
           - renesas,tmu-r8a774e1 # RZ/G2H
           - renesas,tmu-r8a7778  # R-Car M1A
           - renesas,tmu-r8a7779  # R-Car H1
+          - renesas,tmu-r8a7790  # R-Car H2
+          - renesas,tmu-r8a7791  # R-Car M2-W
+          - renesas,tmu-r8a7792  # R-Car V2H
+          - renesas,tmu-r8a7793  # R-Car M2-N
+          - renesas,tmu-r8a7794  # R-Car E2
           - renesas,tmu-r8a7795  # R-Car H3
           - renesas,tmu-r8a7796  # R-Car M3-W
           - renesas,tmu-r8a77961 # R-Car M3-W+

