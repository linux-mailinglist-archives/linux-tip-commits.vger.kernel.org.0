Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA33359BF7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhDIK1n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIK1i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:38 -0400
Date:   Fri, 09 Apr 2021 10:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tk9NDwe5+9JyTHshYCdyXa3LvjuyDwlrqrS8tUFvprc=;
        b=hqisi3Y/YX97U77eWHCPUjxWsB19bjEOK6cOZJYyj9wLiJ5tmH93MGLVwFxy4cDwXt+pYa
        mSmEEy4wx/HNEUOyKwEScRwCaA45j+sG8rHtHAm1h9pep4fuaezzWhui5YK++GLXdo4037
        kT308g9bbJjjOh9TNjq4lcCgkc4omqt37EOkn0cbBvzJY0qAQ7ai/2Q2Y/EY76NR6kTysE
        TQvd0hjuHenJnYoD+zwhHGD4jZryrXb66mZ1Fwh4DXnbI1dNdpG68JFS2cAGpMxVOWuROW
        /Pz32EEyadBrnJn4HziZUN2jX0LUZ3iEaBFRO9lji7AsGLBa44wgqDbXFUvLTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tk9NDwe5+9JyTHshYCdyXa3LvjuyDwlrqrS8tUFvprc=;
        b=K1WB25YE49HOzEr3oGlvt7JfMZEABScII/M6JJe3rNCBjJmSYRKKDkK9prFdDa71MmbN5A
        vIkmPQtd2XOfI2BQ==
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: nuvoton,npcm7xx: Add wpcm450-timer
Cc:     j.neuschaefer@gmx.net, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210320181610.680870-6-j.neuschaefer@gmx.net>
References: <20210320181610.680870-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <161796404405.29796.2440065988250066812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8120891105ba32b45bc35f7dc07e6d87a8314556
Gitweb:        https://git.kernel.org/tip/8120891105ba32b45bc35f7dc07e6d87a83=
14556
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Sat, 20 Mar 2021 19:16:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 16:41:20 +02:00

dt-bindings: timer: nuvoton,npcm7xx: Add wpcm450-timer

Add a compatible string for WPCM450, which has essentially the same
timer controller.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210320181610.680870-6-j.neuschaefer@gmx.net
---
 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.tx=
t b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
index 97258f1..ac3a5e8 100644
--- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -4,7 +4,8 @@ Nuvoton NPCM7xx have three timer modules, each timer module p=
rovides five 24-bit
 timer counters.
=20
 Required properties:
-- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
+- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750, or
+                    "nuvoton,wpcm450-timer" for Hermon WPCM450.
 - reg             : Offset and length of the register set for the device.
 - interrupts      : Contain the timer interrupt of timer 0.
 - clocks          : phandle of timer reference clock (usually a 25 MHz clock=
).
