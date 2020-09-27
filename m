Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3127A02D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgI0J1g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgI0J1Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E714C0613D3;
        Sun, 27 Sep 2020 02:27:25 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyqNt1b3ngpjcJbFVpjO3KBvIeAuVZdhQRxiA0WhRgY=;
        b=tEv0xEu+w7XbAskJvXAjqgC3qH0CLMGLU2hzRp72tZVkP5pqKBSeP/6DCgX56KVvUA6Ufb
        WTh8Ta07nPUpDOMjHnYWmNXcx+aNBYaFfnvO1wmZ8S7zawT5O88WrAdVfUTAvlwioGv7DB
        YverC7maHLF+pe2JdEZ7Kj5JS62jLXdux5u54oYnL8rbW00X2Cxuh2j4HWMg/6CvrTOpy/
        cWUg3r23C/A6YW8ATDpsIV6We33WbTOCpFX+9lnLKwUAlFSduYCbtwRnrtK9aMxCr6yoZj
        85csjLjCEMiCa5fEEyvUv0qlDRhBMzY9eWQafcROeMIp+XG5KaokSP3k5Ldb5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyqNt1b3ngpjcJbFVpjO3KBvIeAuVZdhQRxiA0WhRgY=;
        b=mnv7qCxvac02rSejkqmUZocaW1eRmx56v/CbWxkwQqZxZXow3NwyXMwAhEmIDdCqzanqYX
        0V8KRw0JCfiGPwDQ==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Document r8a774e1
 CMT support
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1594811350-14066-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594811350-14066-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <160119884301.7002.9082861042611982447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     51b705af287d08192140d6caf16d64e32a7abfe4
Gitweb:        https://git.kernel.org/tip/51b705af287d08192140d6caf16d64e32a7abfe4
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 15 Jul 2020 12:08:55 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

dt-bindings: timer: renesas,cmt: Document r8a774e1 CMT support

Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1594811350-14066-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 762b650..428db3a 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -71,6 +71,7 @@ properties:
               - renesas,r8a774a1-cmt0     # 32-bit CMT0 on RZ/G2M
               - renesas,r8a774b1-cmt0     # 32-bit CMT0 on RZ/G2N
               - renesas,r8a774c0-cmt0     # 32-bit CMT0 on RZ/G2E
+              - renesas,r8a774e1-cmt0     # 32-bit CMT0 on RZ/G2H
               - renesas,r8a7795-cmt0      # 32-bit CMT0 on R-Car H3
               - renesas,r8a7796-cmt0      # 32-bit CMT0 on R-Car M3-W
               - renesas,r8a77965-cmt0     # 32-bit CMT0 on R-Car M3-N
@@ -85,6 +86,7 @@ properties:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
               - renesas,r8a774b1-cmt1     # 48-bit CMT on RZ/G2N
               - renesas,r8a774c0-cmt1     # 48-bit CMT on RZ/G2E
+              - renesas,r8a774e1-cmt1     # 48-bit CMT on RZ/G2H
               - renesas,r8a7795-cmt1      # 48-bit CMT on R-Car H3
               - renesas,r8a7796-cmt1      # 48-bit CMT on R-Car M3-W
               - renesas,r8a77965-cmt1     # 48-bit CMT on R-Car M3-N
