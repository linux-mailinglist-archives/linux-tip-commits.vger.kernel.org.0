Return-Path: <linux-tip-commits+bounces-6765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A832EBA19CD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F241C82043
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377832F754;
	Thu, 25 Sep 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYDRC0qN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbMJmrlA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00E32F74B;
	Thu, 25 Sep 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836036; cv=none; b=L+ch3EDZCfTfJdHgFTelrSITXz/x1fCukqH7d34iyVuL+6jqwfTUcEprvhsBn18yadEd0AcqsOs7L133CqKvRECt/TLxZeR7UTsv6GbOkiYXyDRhOUKN5+6VpYTRqIikTedR7+pCwFTY9cZx3ZqsSj3eCJoVyY/cJrc4ThsYHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836036; c=relaxed/simple;
	bh=JsFolB0RBlSSutqG9pGXAU9PojaMi53YFvEIatii/yM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SnyDu/8oDLUT8vde/qPhB/fNi7Xn6J562M/jk0YzRPHg72enpUi8kpJ2jof5GbfsLg4ptt6CPP/2nwc1JPI45C5dGfVhE3+mpM3nZRRvS6lmoE5NSskefKNdV3X/o281eCGT1QmwPI2JAbR5C+3+bPRR+tYqaX4HfeUrAA6kfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYDRC0qN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbMJmrlA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2DNWShEhMuXEjRj8KcFoSy3RnZCe/IEpyWmTv4TcOvc=;
	b=UYDRC0qNBiO/FJrcS6DouM0yTd8q/RcPmnttSxrJWJfNPpozajbW22xUp1tXsmd4/hKzP2
	/MzHwNi4TPiw9boZEaGr5SNlYGSDegtIizRv3CQGums2oHx6DhfxZot66y2r7SutSxMFet
	L+gQuvCcLeN6uRXzQhP4R91ES2KM/Mkjhc0VW3ErhIcXz4pThsjGkVi1aqJn5T56YpqPcE
	/z2/rmbOd3TC7nWQYwVFvc2T+Dq1jAhTPhf/N1Zef932OP0an+CGEv3S9KtHh3xgWAIS4g
	d1khK4ueSs3ZCc4au0rqDmM5HyMCCYB17QdadB/iqIZr5NoEmLaMXAFN3l4o0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2DNWShEhMuXEjRj8KcFoSy3RnZCe/IEpyWmTv4TcOvc=;
	b=tbMJmrlA1Hx1yGfoFdSyCQ/t/x4F/6pxXMB6h2UShkXjrQTYid7PESDtGz7Utg502VYKjc
	r6sED85RxMLRazBw==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: fsl,ftm-timer: use
 items for reg
Cc: Frank Li <Frank.Li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602895.709179.18337909220379754741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     c1ff9e919addb8cf0414b08bd996f11a4a2e7297
Gitweb:        https://git.kernel.org/tip/c1ff9e919addb8cf0414b08bd996f11a4a2=
e7297
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Fri, 23 May 2025 10:14:37 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:53:37 +02:00

dt-bindings: timer: fsl,ftm-timer: use items for reg

The original txt binding doc is:
  reg : Specifies base physical address and size of the register sets for
        the clock event device and clock source device.

And existed dts provide two reg MMIO spaces. So change to use items to
descript reg property.

Update examples.

Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250523141437.533643-1-Frank.Li@nxp.com
---
 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
index 0e4a8dd..e3b61b6 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
@@ -14,7 +14,9 @@ properties:
     const: fsl,ftm-timer
=20
   reg:
-    maxItems: 1
+    items:
+      - description: clock event device
+      - description: clock source device
=20
   interrupts:
     maxItems: 1
@@ -50,7 +52,8 @@ examples:
=20
     ftm@400b8000 {
         compatible =3D "fsl,ftm-timer";
-        reg =3D <0x400b8000 0x1000>;
+        reg =3D <0x400b8000 0x1000>,
+              <0x400b9000 0x1000>;
         interrupts =3D <0 44 IRQ_TYPE_LEVEL_HIGH>;
         clock-names =3D "ftm-evt", "ftm-src", "ftm-evt-counter-en", "ftm-src=
-counter-en";
         clocks =3D <&clks VF610_CLK_FTM2>, <&clks VF610_CLK_FTM3>,

