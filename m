Return-Path: <linux-tip-commits+bounces-1349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFA8FD372
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F245C289134
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FD192B71;
	Wed,  5 Jun 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWkTqIZq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8vuKAK6J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4EA192B83;
	Wed,  5 Jun 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606781; cv=none; b=HFBgXzTH+7pXqKEVi4Kvj3VFGb3vD5EKWbjU2XwzfoqsmVyQIPUf6LrSRiND6euG2mT5N9wtAI3EVHmK+g86CR3S9BMsWVJNw/F8NUUDjWxCIBFYOY8r38JYzVKg/OL9oCFL5xCrw7uds6NhU0BGr3lTwSDtk6P8Ulhri0cmVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606781; c=relaxed/simple;
	bh=eQXyZD9pmqMvGRBpSI6MNY1HqWLS/4h1EVScywOXKA0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=avlLGLmGOD1gMotOgIMGo7PjueXa5EzZHszZxdRwA0uxhO0NLitNBlvvQZNup1a6bkn9KzhszMhgbgenUUVPTVMRJbpMNn+VTov33gmS9ar15MBOwNwUK6Hb6d3wUmaqmrfeUtrm0Ov/E0iBUvtvKUJbW+5qCaVFiY86tLMkOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWkTqIZq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8vuKAK6J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 16:59:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717606778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV19RTCPMPJpWOa3r269jrwlwDwRM929PFXsDZWfVDk=;
	b=pWkTqIZqILOUM3rJsWH71NASOPQiIvOSqu/axGzX4RoGgX2i16SPXr20VDKcsdlSVioppe
	0oGP1KN3WnsWMUERmHadXFWjxPr7Fv/vXlItFYTMRbqy9MPTFFu2dcPJBgzx/vUvUEdfXZ
	ZYrUzXxPN6oVIgMdNgUwVRAKHavOaQixfWsn32FlzeyWO9q1naFj9g9ZEh1oX1fSBNu8dH
	EL53AJh7dLE13gs/DPJxwxj9JmcdxzRCUeo677r5Bz9Xjuz4Q/Gqq/A+x9rH8hQEypaviQ
	kBnJ5GY89ici4JkfDubtH1QrFa0AC4+NWTp8puxRcpNpTYdaMOklnwIjS6Qt/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717606778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV19RTCPMPJpWOa3r269jrwlwDwRM929PFXsDZWfVDk=;
	b=8vuKAK6JVZUySAvEOvQKnPbCU43kXRaH9kFMh008nrRxaeVufePgvwT176wnfN2JaZs1fk
	kP1KvITlYFh0CJAQ==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240604173710.534132-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240604173710.534132-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171760677786.10875.15852018813600963983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     372487b295557b6c0c7ba3583fb34a65c574ff9f
Gitweb:        https://git.kernel.org/tip/372487b295557b6c0c7ba3583fb34a65c574ff9f
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Tue, 04 Jun 2024 18:37:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 Jun 2024 18:56:53 +02:00

dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five SoC

Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on the RZ/Five
SoC is almost identical to the one found on the RZ/G2L SoC, with the only
difference being that it has additional mask control registers for
NMI/IRQ/TINT.

Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240604173710.534132-2-prabhakar.mahadev-lad.rj@bp.renesas.com

---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index daef4ee..44b6ae5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -21,13 +21,16 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043u-irqc   # RZ/G2UL
-          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
-          - renesas,r9a07g054-irqc    # RZ/V2L
-          - renesas,r9a08g045-irqc    # RZ/G3S
-      - const: renesas,rzg2l-irqc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043u-irqc    # RZ/G2UL
+              - renesas,r9a07g044-irqc     # RZ/G2{L,LC}
+              - renesas,r9a07g054-irqc     # RZ/V2L
+              - renesas,r9a08g045-irqc     # RZ/G3S
+          - const: renesas,rzg2l-irqc
+
+      - const: renesas,r9a07g043f-irqc     # RZ/Five
 
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the

