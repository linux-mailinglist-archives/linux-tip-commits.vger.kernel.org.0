Return-Path: <linux-tip-commits+bounces-10-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7B80EF15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3932C1F21287
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B1745D5;
	Tue, 12 Dec 2023 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjRRWEgV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0Nzwpbd"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ECBD3;
	Tue, 12 Dec 2023 06:44:23 -0800 (PST)
Date: Tue, 12 Dec 2023 14:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702392262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5Ool1NqEEsQrRX9RqbS/irMaVoOSwObS5yc/0NcmtA=;
	b=mjRRWEgVbW7Lx71G4NckMFWo1ERhQKlVkzEaxbqXIehn5B7Cz8db/7BD7y64gRLVVwoqGn
	BIIhBOWd42g9pIm88PHkUbIO4pC0R7TdrZl7Uy964JGTzT/wCJSM13N+2sJpO/zQZr/E7F
	QBrVrVgjYklycOYocU+hGk78wVr9WR7TLTjPwr7rS+SUitpEcGqqTjVdOp5iQYlRMuQh6E
	W9FG3GMGBfTXULtylXIsICEhKh49wvJ0nmpIMnNpnhJmyV9FVDw4aVSqJxgcx5SyErB3rY
	ItHcgF4Rc1j2HAHjquhjs0IauSk81+8YUKdklogiiJs9Sdr+eAfEghut/mlqqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702392262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5Ool1NqEEsQrRX9RqbS/irMaVoOSwObS5yc/0NcmtA=;
	b=c0NzwpbdGFqrST4YSCravcJ70QbljOFWOMG8ldkuzUsv8+wpJojTMot8L/ludHHyWn8+rY
	B0WfqyQxhLITdzBQ==
From: "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G3S
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170239226133.398.10244440044393387460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1cf0697a24ef60b3ce8be47090a6e8e79329d962
Gitweb:        https://git.kernel.org/tip/1cf0697a24ef60b3ce8be47090a6e8e79329d962
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:42 +01:00

dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S

Document the RZ/G3S (R9108G045) interrupt controller. This has few extra
functionalities compared with RZ/G2UL but the already existing driver
can still be used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com

---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 2ef3081..d3b5aec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
+          - renesas,r9a08g045-irqc    # RZ/G3S
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
@@ -167,7 +168,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g043u-irqc
+            enum:
+              - renesas,r9a07g043u-irqc
+              - renesas,r9a08g045-irqc
     then:
       properties:
         interrupts:

