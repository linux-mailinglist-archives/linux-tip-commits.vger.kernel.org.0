Return-Path: <linux-tip-commits+bounces-6739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5FBA1924
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541FF189F400
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41E327A06;
	Thu, 25 Sep 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zrZmS7aV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ulEeNBn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF34CA6F;
	Thu, 25 Sep 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836001; cv=none; b=sAdA93c5R0UT5I3gdOR2d+GXw0mGmEhz68WyN1Jzw+VVr+gsI6Odq9BYn7EuAYOFa9ZPLASXhjrf3baZRgoB5ZS6l5NEGQ3EpH9QywAfSghajCFhWR7qEdvVC2o7QHONzymTXyohYRk62awZg80+vB3e6b/UrJULB6//w3qVxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836001; c=relaxed/simple;
	bh=fPJiFw+jQ05xZZRZiBbIIcEvDTlPZ3gEknBG3IlaIa0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pL2wj2omqLJJjuQCwo4XGWWF8ElJuGOy3BQRxt+XZuuImtdH0sVQ0jXqr5bJgZBafSK+Q/S4OjNxkncJ2v2oLgRRp7X+kWWQobMvtmNJN3olrGdeusturuuEG0OlyIz0amYqaXEYEPX0JtSgDJmTRyngWAcZSeDV05tWPk3/Xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zrZmS7aV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ulEeNBn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YoX57L2lndbhlSMq1VfYzNcTsY1hYkpSfMQqGoKBpL0=;
	b=zrZmS7aVC54blVQ83WFlCBr09PBnROUQnmyuMmga2cSPkgXZmyMLrhbTzhWui4f/e0Zsmx
	yb06/FyDqmSDnzKIRLzK4jBjx7j+XqsPsdzgnduEzanF6xkQW37b4YQ18B1BLC+VGG+qnp
	wm928uvEREYp+WXkkLeAuUCQw4NrF6uTto1rCFTjk7Zz6SRekuKBJREpGEGa5rs+hH3Xbk
	vLU3FgZjFSEtKc46Hg2dq3GCGtQm8fxurgnnv70VZkrjD+dIRsZWZ2wu6C/cYtnTS5hm1z
	Yxz/t0BaWbmIX+R1pjq85PCtvZDafZAl5ier2HRpC12P85eRayATj3krzDcNaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YoX57L2lndbhlSMq1VfYzNcTsY1hYkpSfMQqGoKBpL0=;
	b=3ulEeNBnz4E9APtI0hwKu0rR57tCFWXaW/swDFyT9qYbdqJUm1cpM/+3oWwlD5HYfELFlp
	YPZycbopuPjIXxDg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt: bindings: fsl,vf610-pit: Add compatible
 for s32g2 and s32g3
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599712.709179.684941176373319735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     adaf5b248ff38f98ea1b3696b9a793db270f8c3e
Gitweb:        https://git.kernel.org/tip/adaf5b248ff38f98ea1b3696b9a793db270=
f8c3e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:30:11 +02:00

dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3

The Vybrid Family is a NXP (formerly Freescale) platform having a
Programmable Interrupt Timer (PIT). This timer is an IP found also on
the NXP Automotive platform S32G2 and S32G3.

Add the compatible for those platforms to describe the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-20-daniel.lezcano@lina=
ro.org
---
 Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml |  9 +++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Doc=
umentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
index bee2c35..42e1306 100644
--- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
@@ -15,8 +15,13 @@ description:
=20
 properties:
   compatible:
-    enum:
-      - fsl,vf610-pit
+    oneOf:
+      - enum:
+          - fsl,vf610-pit
+          - nxp,s32g2-pit
+      - items:
+          - const: nxp,s32g3-pit
+          - const: nxp,s32g2-pit
=20
   reg:
     maxItems: 1

