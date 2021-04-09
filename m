Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5D359C0A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhDIK15 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhDIK1p (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95486C061760;
        Fri,  9 Apr 2021 03:27:32 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUch0/IYpj+ofu7bFu5kxgXz3c49U4i14apznW9QRy8=;
        b=jACugCUxE2dQyMelrTL0aET5z9O8pNsg17S5rDYnu+I9sNBfHq8FglvXVP/SRMEXU8NGoV
        a0JtO+4mlS1O3kDwMQ7uVi+Pc9V4dCBvglT1qNieUx+JpBn8sxgAeO47WKC3Vvr58YpXqm
        6OaK0vwP6fNxjlSNl94F6UeCg4u0LrhtuJW/4gm0MAZahY+5YTL7crZFeVP079ujvR7ctD
        pDluTYXJD6wiyoCAPIpnJw9Xjkrq73LBT/QYkl+HC+5hR0MK5UEyBx4VYF2lEGIkwmRl6T
        Td7lvIyhtvAMnciPYjq8mi6gwygdD+Mf1K2PvPI08JkGT9iCownxtkgvi5DZZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUch0/IYpj+ofu7bFu5kxgXz3c49U4i14apznW9QRy8=;
        b=2mMYolLUq5/tUbcxs48h+NGJIAeIcE3VUsfPv4CkBIKUdQVR1EuQWBkCyQexmXajQbRMPN
        +9YuHfKfOJiemDDQ==
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: ingenic: Add compatible
 strings for JZ4760(B)
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210308212302.10288-1-paul@crapouillou.net>
References: <20210308212302.10288-1-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <161796405018.29796.8123027624166433306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     507d8c5a418a5d413bf9751d4ff94b259e947736
Gitweb:        https://git.kernel.org/tip/507d8c5a418a5d413bf9751d4ff94b259e947736
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Mon, 08 Mar 2021 21:23:00 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:22 +02:00

dt-bindings: timer: ingenic: Add compatible strings for JZ4760(B)

Add compatible strings to support the system timer, clocksource, OST,
watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.

Newer SoCs which behave like the JZ4760 or JZ4760B now see their
compatible string require a fallback compatible string that corresponds
to one of these two SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210308212302.10288-1-paul@crapouillou.net
---
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 30 +++++--
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 024bcad..8165df4 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -20,6 +20,8 @@ select:
         enum:
           - ingenic,jz4740-tcu
           - ingenic,jz4725b-tcu
+          - ingenic,jz4760-tcu
+          - ingenic,jz4760b-tcu
           - ingenic,jz4770-tcu
           - ingenic,jz4780-tcu
           - ingenic,x1000-tcu
@@ -52,12 +54,15 @@ properties:
           - enum:
               - ingenic,jz4740-tcu
               - ingenic,jz4725b-tcu
-              - ingenic,jz4770-tcu
+              - ingenic,jz4760-tcu
               - ingenic,x1000-tcu
           - const: simple-mfd
       - items:
-          - const: ingenic,jz4780-tcu
-          - const: ingenic,jz4770-tcu
+          - enum:
+              - ingenic,jz4780-tcu
+              - ingenic,jz4770-tcu
+              - ingenic,jz4760b-tcu
+          - const: ingenic,jz4760-tcu
           - const: simple-mfd
 
   reg:
@@ -118,6 +123,8 @@ patternProperties:
           - items:
               - enum:
                   - ingenic,jz4770-watchdog
+                  - ingenic,jz4760b-watchdog
+                  - ingenic,jz4760-watchdog
                   - ingenic,jz4725b-watchdog
               - const: ingenic,jz4740-watchdog
 
@@ -147,6 +154,8 @@ patternProperties:
               - ingenic,jz4725b-pwm
           - items:
               - enum:
+                  - ingenic,jz4760-pwm
+                  - ingenic,jz4760b-pwm
                   - ingenic,jz4770-pwm
                   - ingenic,jz4780-pwm
               - const: ingenic,jz4740-pwm
@@ -183,10 +192,15 @@ patternProperties:
         oneOf:
           - enum:
               - ingenic,jz4725b-ost
-              - ingenic,jz4770-ost
+              - ingenic,jz4760b-ost
           - items:
-              - const: ingenic,jz4780-ost
-              - const: ingenic,jz4770-ost
+              - const: ingenic,jz4760-ost
+              - const: ingenic,jz4725b-ost
+          - items:
+              - enum:
+                  - ingenic,jz4780-ost
+                  - ingenic,jz4770-ost
+              - const: ingenic,jz4760b-ost
 
       reg:
         maxItems: 1
@@ -226,7 +240,7 @@ examples:
     #include <dt-bindings/clock/jz4770-cgu.h>
     #include <dt-bindings/clock/ingenic,tcu.h>
     tcu: timer@10002000 {
-      compatible = "ingenic,jz4770-tcu", "simple-mfd";
+      compatible = "ingenic,jz4770-tcu", "ingenic,jz4760-tcu", "simple-mfd";
       reg = <0x10002000 0x1000>;
       #address-cells = <1>;
       #size-cells = <1>;
@@ -272,7 +286,7 @@ examples:
       };
 
       ost: timer@e0 {
-        compatible = "ingenic,jz4770-ost";
+        compatible = "ingenic,jz4770-ost", "ingenic,jz4760b-ost";
         reg = <0xe0 0x20>;
 
         clocks = <&tcu TCU_CLK_OST>;
