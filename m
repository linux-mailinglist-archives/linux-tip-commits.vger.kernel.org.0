Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AB31634B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhBJKJk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBJKHL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:11 -0500
Date:   Wed, 10 Feb 2021 10:06:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGleL9WFhsHfGxO3weQnztnAsJi9ZaTXeJ1LJ3iX/NU=;
        b=k7wRyJgOqVBQs9kz/sfSjbqdNwukb93kMvOkNPHbF0ACHMM5TDz+durBjastuM0wndlnsx
        ztjYXxz0IaGMJh0aUEqgaU7rEHZluJozpY39sjbB6b9nRhVBE43X92pjP7dz873h2jyKe9
        ke72atuNEc/VDXXlEvawcAyQa8f9fsW3HdcAs/ngWu7m8UuOaUOsdxjtiz13dDGIZ8RpAx
        tUh8/F3kkbZFx2KBuh2d+vCDwr7meOHggtDAWv8YpPByy57XiBosvpCf7I5TNHb731zI9P
        p+pRBqcrKCkA/Ksqpnb+/amna+7lask0vDusRfUykvN6pQK3PVIs576myw0Mfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGleL9WFhsHfGxO3weQnztnAsJi9ZaTXeJ1LJ3iX/NU=;
        b=2I4i6IwC3RrpUGszY/GhSFIRdDKvHRj18T+/yGQrBqkADCdiacBtnBKEGvgZ8g61cUBrnJ
        0Z3xvGVJtE77pNBg==
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: nuvoton: Clarify that
 interrupt of timer 0 should be specified
Cc:     j.neuschaefer@gmx.net, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108163004.492649-1-j.neuschaefer@gmx.net>
References: <20210108163004.492649-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <161295158501.23325.10218203131842401803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e1922b5da0e6869f1850c4447bed0b9cb1cf5034
Gitweb:        https://git.kernel.org/tip/e1922b5da0e6869f1850c4447bed0b9cb1c=
f5034
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Fri, 08 Jan 2021 17:30:04 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 16:33:51 +01:00

dt-bindings: timer: nuvoton: Clarify that interrupt of timer 0 should be spec=
ified

The NPCM750 Timer/Watchdog Controller has multiple interrupt lines,
connected to multiple timers. The driver uses timer 0 for timer
interrupts, so the interrupt line corresponding to timer 0 should be
specified in DT.

I removed the mention of "flags for falling edge", because the timer
controller uses high-level interrupts rather than falling-edge
interrupts, and whether flags should be specified is up the interrupt
controller's DT binding.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210108163004.492649-1-j.neuschaefer@gmx.net
---
 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.tx=
t b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
index ea22dfe..97258f1 100644
--- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -6,8 +6,7 @@ timer counters.
 Required properties:
 - compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
 - reg             : Offset and length of the register set for the device.
-- interrupts      : Contain the timer interrupt with flags for
-                    falling edge.
+- interrupts      : Contain the timer interrupt of timer 0.
 - clocks          : phandle of timer reference clock (usually a 25 MHz clock=
).
=20
 Example:
