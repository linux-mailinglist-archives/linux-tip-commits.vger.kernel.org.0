Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DE359C02
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhDIK1v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhDIK1n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:43 -0400
Date:   Fri, 09 Apr 2021 10:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c8PHgNKwX4khUwwzzNTD5M829upyKBWhtNoG7sk/Ie4=;
        b=Msxd0qkzXzA0nrAJjWBcTQo9eyGFXlOKUq6L9BDTGH8N5QwJsFyAcUVwpLNr9bdrw8KXlA
        FkDPV45xjDjyEWByJosvnn8lf8E+fPfvIZNH18LpHWXoYu1kbHH5R+ebt7MHSgBUHlE9YQ
        A+/YtuwWRGhEqFSQUIQ/79ZPp+cJdrGUvBky6y1J/1+GNkcDEJr1yNQ7Hx9Vfrl55Ij18R
        SgzqMroQ35Wq7fQCfwAEp9tz6cs+MEd0sISf8UPbsSD1Y4QN6gidQncGuyS8rDZYhvTv7h
        iTIZBaty3Eu7D5z0FQ2J4XZ/jFcVl338eKDEmwKo9+8Pd0GD44UPHoU4kccXyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c8PHgNKwX4khUwwzzNTD5M829upyKBWhtNoG7sk/Ie4=;
        b=2d8lABefp9YcqP4gHVOPaanHcxTSZKqacsbIaBY7ZYsHOvsHUfOYDm5LC2rNxIqEctTqrG
        ebpaik4GflkdQhAg==
From:   tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Document R8A77961
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211143344.352588-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210211143344.352588-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <161796404867.29796.16542355512964948478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     446e1a943554e07a4e6431fff6dd06c0f130895a
Gitweb:        https://git.kernel.org/tip/446e1a943554e07a4e6431fff6dd06c0f13=
0895a
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 11 Feb 2021 15:33:44 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:24 +02:00

dt-bindings: timer: renesas,cmt: Document R8A77961

Add missing bindings for M3-W+.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210211143344.352588-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index 363ec28..53dd6d9 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -74,6 +74,7 @@ properties:
               - renesas,r8a774e1-cmt0     # 32-bit CMT0 on RZ/G2H
               - renesas,r8a7795-cmt0      # 32-bit CMT0 on R-Car H3
               - renesas,r8a7796-cmt0      # 32-bit CMT0 on R-Car M3-W
+              - renesas,r8a77961-cmt0     # 32-bit CMT0 on R-Car M3-W+
               - renesas,r8a77965-cmt0     # 32-bit CMT0 on R-Car M3-N
               - renesas,r8a77970-cmt0     # 32-bit CMT0 on R-Car V3M
               - renesas,r8a77980-cmt0     # 32-bit CMT0 on R-Car V3H
@@ -90,6 +91,7 @@ properties:
               - renesas,r8a774e1-cmt1     # 48-bit CMT on RZ/G2H
               - renesas,r8a7795-cmt1      # 48-bit CMT on R-Car H3
               - renesas,r8a7796-cmt1      # 48-bit CMT on R-Car M3-W
+              - renesas,r8a77961-cmt1     # 48-bit CMT on R-Car M3-W+
               - renesas,r8a77965-cmt1     # 48-bit CMT on R-Car M3-N
               - renesas,r8a77970-cmt1     # 48-bit CMT on R-Car V3M
               - renesas,r8a77980-cmt1     # 48-bit CMT on R-Car V3H
