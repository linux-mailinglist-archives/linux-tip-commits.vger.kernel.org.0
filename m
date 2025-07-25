Return-Path: <linux-tip-commits+bounces-6195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD2B11C65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7593B55BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71142E54A1;
	Fri, 25 Jul 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/390IGi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJAfOaoa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AA2E11CA;
	Fri, 25 Jul 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439505; cv=none; b=M0yg6acqeu4tLStgMwLypaOk54lRhpEOvx+/loIfDg6jch5iMUJg5RsdqBlk4I7JDa05zj6pGBlc2ei3Ab21nSYgWpL964hooTQyifSW8hBJSojQABHPNax6HVskqcUnlTT3AW3RT9XQdwukyWF2n2e+iniQdi4sZSSUT1HcWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439505; c=relaxed/simple;
	bh=BaUk8859Y0PI20VU5J2vrvPOlEtrJ6rbJogagbH+JQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tZ/Rlzb49tuqRzJIQWzBqNo9fdE/EJnfscOtm52Knp+Lr+YzYWJODOz7JRiYkXEwTNoAN4F5A4l5snQQBIPOGn7uxya47ZBgbM3VMnez+qsEveHjMTu2wDTCpHtFch9ahpUgjPY1xeI0k+4XcoHv7xZU6LwAK0vlttvKLEOmb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/390IGi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJAfOaoa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+KAMbHWtag5us9vcmQ/xbMVHHeL5ROV+hyE9I1+1Go=;
	b=w/390IGi8Z7cEv4ECAIMcsdGZu+1gwzQBL0eaN0VLalZEoegciR08Ambc9Y3N/qnpF6hMh
	3FtSoKmeAqLYfTrZwAh64AoAb8UPhLmDfptKNfIOXUdwRWeDU0TnPX+IsUj8/QZDW0x2Qg
	ciilz/PMJLD8Uedd1QybaErx9KHzCojpFXgh7pC2BF77HiOY7VU9CGVghR9h8JdHuUXrxw
	4XaksPvfUVeJoXh68Zy01XynEMxxjWU8+sk3jgp9BnDfBOjMnFmkpH4QqoGAQyu6VuaNYY
	P3E7wMjvQ388HXCXddMshdYWpdv1OukVWvp1Dme0KAF9o+vDxLYoWmus1tktXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+KAMbHWtag5us9vcmQ/xbMVHHeL5ROV+hyE9I1+1Go=;
	b=NJAfOaoa6YKQX+VsX5E8iUXmh9omeltCd8xourQI25cDgXeS73AcOvdlGU7ZPNIaJnWU/T
	cCeEeueIR5/yEEAg==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add fsl,timrot.yaml
Cc: Frank Li <Frank.Li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250528165351.691848-1-Frank.Li@nxp.com>
References: <20250528165351.691848-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949440.1420.6560224114089077370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     f74c5f0b940f2ff45e0099544ed3be88125eaebb
Gitweb:        https://git.kernel.org/tip/f74c5f0b940f2ff45e0099544ed3be88125=
eaebb
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Wed, 28 May 2025 12:53:50 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:06:56 +02:00

dt-bindings: timer: Add fsl,timrot.yaml

Add fsl,timrot.yaml for i.MX23/i.MX28 timer.

Also add a generic fallback compatible string "fsl,timrot" for legacy
devices, which have existed for over 15 years.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250528165351.691848-1-Frank.Li@nxp.com
---
 Documentation/devicetree/bindings/timer/fsl,timrot.yaml | 48 ++++++++-
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml

diff --git a/Documentation/devicetree/bindings/timer/fsl,timrot.yaml b/Docume=
ntation/devicetree/bindings/timer/fsl,timrot.yaml
new file mode 100644
index 0000000..d181f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,timrot.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,timrot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Timer
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx23-timrot
+          - fsl,imx28-timrot
+      - const: fsl,timrot
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: irq for timer0
+      - description: irq for timer1
+      - description: irq for timer2
+      - description: irq for timer3
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer: timer@80068000 {
+        compatible =3D "fsl,imx28-timrot", "fsl,timrot";
+        reg =3D <0x80068000 0x2000>;
+        interrupts =3D <48>, <49>, <50>, <51>;
+        clocks =3D <&clks 26>;
+    };

