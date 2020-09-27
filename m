Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581927A032
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI0J1g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgI0J10 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:26 -0400
Date:   Sun, 27 Sep 2020 09:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28e3sMibb5ZcFhKlLBNkX0aA/BSHMoc1u6cplRYUsSA=;
        b=OXeH2mNazeN3VxdHzDK4jHLrbnw1o8LieKGOUSkVnqdSQp6U1s0mvoaxOtuAkfvh0UUjGq
        Snt908kYQ7rKsSzskatwxJD2zO1DAWIFvC3nRr4C/W7RwLUfmRKO8BtoLQonCSvjBTwm45
        a3pjAf+NxA20BFbpQLxSOjX5JHpu5z5Tcyn181jSZ98IRmccst6GoIWhTY0Jx+RDdpBgnZ
        R7l1OLkWCxH5V/ywiwu7weV2fubtZEae+PtYQDxBK3uXKn+Jab+6Rnt/8U7h791jlKC2YC
        Bw6UcdBq8FRWu3eUpus7+dp6QMH47mcRTP73qbJJ2ZShPatD8OteUlXHNDz4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28e3sMibb5ZcFhKlLBNkX0aA/BSHMoc1u6cplRYUsSA=;
        b=MLw/U1BBnoszKlsrtxyfom9I+LoMf6XxfnRDzbf3+jMT2GR/Y1dtETsUCDla8mT6OtbAVB
        h9fuSLtunMURR7DA==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Document r8a7742
 CMT support
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902091927.32211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200902091927.32211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <160119884348.7002.8487339526351500380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e2cb498074a9cc826828a374cc1e66e532e4762d
Gitweb:        https://git.kernel.org/tip/e2cb498074a9cc826828a374cc1e66e532e4762d
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 02 Sep 2020 10:19:27 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

dt-bindings: timer: renesas,cmt: Document r8a7742 CMT support

Document SoC specific compatible strings for r8a7742. No driver change
is needed as the fallback strings will activate the right code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200902091927.32211-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 7e4dc56..762b650 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -39,6 +39,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt0      # 32-bit CMT0 on R-Mobile APE6
+              - renesas,r8a7742-cmt0      # 32-bit CMT0 on RZ/G1H
               - renesas,r8a7743-cmt0      # 32-bit CMT0 on RZ/G1M
               - renesas,r8a7744-cmt0      # 32-bit CMT0 on RZ/G1N
               - renesas,r8a7745-cmt0      # 32-bit CMT0 on RZ/G1E
@@ -53,6 +54,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt1      # 48-bit CMT1 on R-Mobile APE6
+              - renesas,r8a7742-cmt1      # 48-bit CMT1 on RZ/G1H
               - renesas,r8a7743-cmt1      # 48-bit CMT1 on RZ/G1M
               - renesas,r8a7744-cmt1      # 48-bit CMT1 on RZ/G1N
               - renesas,r8a7745-cmt1      # 48-bit CMT1 on RZ/G1E
