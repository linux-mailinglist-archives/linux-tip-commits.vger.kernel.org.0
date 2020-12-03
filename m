Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0182CE2F6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgLCXsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbgLCXsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81475C061A53;
        Thu,  3 Dec 2020 15:47:52 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMtnaZjU9BONytZKvj/OPgvI1/wnaA4Yx0oL68Vq+eE=;
        b=nUMjUR17hzcp92PoV2gcYV9OJZ1U1pXqkVMxjTGJrynC7JQewoiNQJUYMi1xk73LErJ3T2
        cxDVdR0BiFKWG7P5WXpOTl+/CDGRtr+3IG3SQxzHS1FusUjWg/LMtiH2/PvwpWCQlFN9uK
        H/u4D5JhnM/YmY5ieFC2wS6aDeXCD6u9kVw55tRTAVwYkVLG0CUd5KA7rC1t1w9BXKT287
        kuESoVGa7lNa3wKQ9Wf949MA9lzL7ySPy7bSwaTNr9E5J8UWnWN/PVnjWUNHnpA2fPVU5k
        gnTQO+BZWevxHT06W6QJi46h/C+T4k7gmWja3QO2zo/vx5Fw4zJ/q87YhBhmqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMtnaZjU9BONytZKvj/OPgvI1/wnaA4Yx0oL68Vq+eE=;
        b=JOlz2E99E5FqEh5L717IvB5dEKGuuXdkQeI3NOJoxUmjfqOYRHIB7aUCn6vrxGbcH07q9z
        wwiOu+mQh6AfHLBA==
From:   "tip-bot2 for Marian-Cristian Rotariu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas: tmu: Document
 r8a774e1 bindings
Cc:     "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110162014.3290109-2-geert+renesas@glider.be>
References: <20201110162014.3290109-2-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160703927036.3364.107118630100426091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     db08e6c0e2513d1341369ec6a4f1774ee20b290b
Gitweb:        https://git.kernel.org/tip/db08e6c0e2513d1341369ec6a4f1774ee20=
b290b
Author:        Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas=
.com>
AuthorDate:    Tue, 10 Nov 2020 17:20:13 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings

Document RZ/G2H (R8A774E1) SoC in the Renesas TMU bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas=
.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201110162014.3290109-2-geert+renesas@glider=
.be
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Docume=
ntation/devicetree/bindings/timer/renesas,tmu.txt
index 29159f4..a36cd61 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,tmu-r8a774a1" for the r8a774A1 TMU
     - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
     - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
+    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu-r8a77970" for the r8a77970 TMU
