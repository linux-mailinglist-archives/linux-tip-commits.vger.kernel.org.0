Return-Path: <linux-tip-commits+bounces-5704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F32ABFA71
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6DEA2547B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582121B18B;
	Wed, 21 May 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leDGeRuo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cqNtKUkD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E981C701C;
	Wed, 21 May 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842566; cv=none; b=q25wABfXTmgj2HXIH+rKXGD/AVABLAXyRq8g0TNgCdAUp3DYvjA7gndwjcU08BdpdPFrp1ZGAl2ZjZ75fUkxGA24Gky5ZhFrFfqIG+4evEVDH82lvLORhU0eN0RaqC/8DBDXLycapfgr+1chqqJEqoF6AWv8q22asLF9OuDYISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842566; c=relaxed/simple;
	bh=in1Bkaae9VGPfN9DVS2akLpCUrFyFhDmUWMBvqCW6A8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqXknjnC58Hs7b39hKWDAyzZibpCUviakGW7QgMSo6582+QiaMQVKikYJSoMmuOeer8Nl7Y1+Y9wK1W4+vr9CLHqVLVDlCYkY+LifuR5QnXG27dZp3QRVJtIaFEfzgX8cdslUrDBzVbbGkTqktTgWzMatkt64txYtmfgMc3Etco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leDGeRuo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cqNtKUkD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joo9HVHuyeEYihGathY8EWaEAYa+rowtfjsiuS1T5bw=;
	b=leDGeRuoTdjtQDhRM4PLbrMthh6G82FoyTDe1e3BUMVVg3htoTLvhL4CzsSBhNU/4r9pv0
	ruet9P27/DAw4BokXVCgtwlLpiCnIojht/JxDJcSKqZpgEaS+4GqoarGzJcgmMm9coCQQs
	dqeo4sXZ48bRsqGUyHgc4Ufmu5j1Wx6WmoxpXo2TenIAxiT0WlbUb4dFIXLJJ9iKvYOIaL
	QqOFxNss0ywi//EmXMrlyBkQFiT8pHPo1nj3VR8Hp9oIxNMZ7fNmTEvOK5LRH8yjhvno/+
	bMj1FYW+lXW5fG6yhKw/FCOpASFvCKbjF3BSlGqHz3x5i+f2gQmDh9GPOfcjpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joo9HVHuyeEYihGathY8EWaEAYa+rowtfjsiuS1T5bw=;
	b=cqNtKUkDnKeAfCfRxy1MaSVYTu+XPnr9Da3lZdJYjEQiUwO0gVM9buxVXITKG6W7pOxtaU
	PR3jIldUb8W2NLBw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: renesas,ostm: Document
 RZ/V2N (R9A09G056) support
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515182207.329176-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250515182207.329176-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256249.406.6800203121411935396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     f0e0c374379cc0b99698d3786d78d936c6c4bf38
Gitweb:        https://git.kernel.org/tip/f0e0c374379cc0b99698d3786d78d936c6c4bf38
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 15 May 2025 19:22:06 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 13:33:11 +02:00

dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support

Document support for the Renesas OS Timer (OSTM) found on the Renesas
RZ/V2N (R9A09G056) SoC. The OSTM IP on RZ/V2N is identical to that on
other RZ families, so no driver changes are required as `renesas,ostm`
will be used as fallback compatible.

Also update the bindings to require the "resets" property for RZ/V2N
by inverting the logic: all SoCs except RZ/A1 and RZ/A2 now require
the "resets" property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250515182207.329176-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 12 +++----
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 9ba858f..0983c1e 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
+          - renesas,r9a09g056-ostm # RZ/V2N
           - renesas,r9a09g057-ostm # RZ/V2H(P)
       - const: renesas,ostm        # Generic
 
@@ -54,12 +55,11 @@ required:
 if:
   properties:
     compatible:
-      contains:
-        enum:
-          - renesas,r9a07g043-ostm
-          - renesas,r9a07g044-ostm
-          - renesas,r9a07g054-ostm
-          - renesas,r9a09g057-ostm
+      not:
+        contains:
+          enum:
+            - renesas,r7s72100-ostm
+            - renesas,r7s9210-ostm
 then:
   required:
     - resets

