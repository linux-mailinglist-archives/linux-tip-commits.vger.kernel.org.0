Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11660359C09
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhDIK15 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhDIK1o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:44 -0400
Date:   Fri, 09 Apr 2021 10:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Hui8eVUUAjuio9SpIiuANTI/YnV8VTgVEfBanqp/vE=;
        b=Bcp5ZbAB7Mbr6rW4IvqoklRxpD4Blsof/GywcwL5gBMHshALers41bE349GxHJmG6qXDVv
        gbLn6EliPc0HXtG+2z7HYpHt01SlbJJhs7E3oEJp2/cHdasRQj0ZYdRAu2/RvOBNb3qbkC
        MIqu/sMP26wTiec/JjtCU2de+N21lzrPvi2XqWqcoKMKD3RVzTx3XN3P9CkzDdZ+hO32GC
        detjb51dUi6rCgKudkty182vpKXz02iW3kT40pLhd8ZG8AoE+lqp9mPvOxf36tipovVxgL
        +nxIhZKouAlA8UdcnWsONaBglIGz49iqvOcnlvCCoK/KX8w2HovlfspextG1/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Hui8eVUUAjuio9SpIiuANTI/YnV8VTgVEfBanqp/vE=;
        b=Cv1kH1vie0w/yEhbwiPGNQi03na5kg/OqmnTJTfqrG4MReViFBUjDR6li90BaRelr3zTW2
        QJks8USrUM1cFeCQ==
From:   tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,tmu: Document missing
 Gen3 SoCs
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211143102.350719-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210211143102.350719-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <161796405053.29796.11150931297237061814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c4d814416fe3f5eb27438209a83582d7508ba80a
Gitweb:        https://git.kernel.org/tip/c4d814416fe3f5eb27438209a83582d7508=
ba80a
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 11 Feb 2021 15:31:02 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:21 +02:00

dt-bindings: timer: renesas,tmu: Document missing Gen3 SoCs

Add missing bindings for Gen3 SoCs.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210211143102.350719-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index c541887..f0f0f12 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -28,8 +28,14 @@ properties:
           - renesas,tmu-r8a774e1 # RZ/G2H
           - renesas,tmu-r8a7778  # R-Car M1A
           - renesas,tmu-r8a7779  # R-Car H1
+          - renesas,tmu-r8a7795  # R-Car H3
+          - renesas,tmu-r8a7796  # R-Car M3-W
+          - renesas,tmu-r8a77961 # R-Car M3-W+
+          - renesas,tmu-r8a77965 # R-Car M3-N
           - renesas,tmu-r8a77970 # R-Car V3M
           - renesas,tmu-r8a77980 # R-Car V3H
+          - renesas,tmu-r8a77990 # R-Car E3
+          - renesas,tmu-r8a77995 # R-Car D3
       - const: renesas,tmu
=20
   reg:
