Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964AD359C06
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhDIK1x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIK1o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40771C061765;
        Fri,  9 Apr 2021 03:27:31 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOdkg3ijftdV/dNQLgE5mhvm1MQWSKjhyGxydXL7qMA=;
        b=VVH0LBGm8DIIfYFVJLdCjyzA9mizC7O/eHL+JWr4rWCtRtctC5xlm3LZu9Dw0op0V3HhFx
        xxsQQ7OhmdVhlp8oE5A9NiIFyDYKDnfDfJUNXfnaIH4dJYPL5RMNnPWO1e/1noyRt5RIuK
        tqCJVYlJcYpzpeWKJ3ecpESKXPPse2bHlYT17cF0YgRXLqRcxZ3K06RdOEBC6w9FUUC35u
        I4wvlMTIBDJGfl8EWdTx3NplPrub2hkvXCrR4sbCUIV2ojCuyngh0RaSeIL11abIWjtKPY
        qImkXx25YAeQaBqIyiUOwSbFsyuKWqxfnPWRX+WOdC7HkuZuiuhRJD8Z47syFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOdkg3ijftdV/dNQLgE5mhvm1MQWSKjhyGxydXL7qMA=;
        b=FQIf5CVwJNvWhwVxlKhIkcIPDdE4+Q77eoRomEwL/++QPyypS2ivwn/LxPI7WkLgCbcWhr
        Q7jEQu3GRHbxu2Dg==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Add r8a779a0 CMT support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311090918.2197-1-wsa+renesas@sang-engineering.com>
References: <20210311090918.2197-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <161796404906.29796.17104382917045246922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fe8324f37cfebf72e2669e97b9d76ea9794d2972
Gitweb:        https://git.kernel.org/tip/fe8324f37cfebf72e2669e97b9d76ea9794=
d2972
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Thu, 11 Mar 2021 10:09:18 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:23 +02:00

dt-bindings: timer: renesas,cmt: Add r8a779a0 CMT support

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210311090918.2197-1-wsa+renesas@sang-engine=
ering.com
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index 428db3a..363ec28 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -79,6 +79,7 @@ properties:
               - renesas,r8a77980-cmt0     # 32-bit CMT0 on R-Car V3H
               - renesas,r8a77990-cmt0     # 32-bit CMT0 on R-Car E3
               - renesas,r8a77995-cmt0     # 32-bit CMT0 on R-Car D3
+              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
           - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ=
/G2
=20
       - items:
@@ -94,6 +95,7 @@ properties:
               - renesas,r8a77980-cmt1     # 48-bit CMT on R-Car V3H
               - renesas,r8a77990-cmt1     # 48-bit CMT on R-Car E3
               - renesas,r8a77995-cmt1     # 48-bit CMT on R-Car D3
+              - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/=
G2
=20
   reg:
