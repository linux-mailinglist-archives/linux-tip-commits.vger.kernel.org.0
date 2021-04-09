Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E452359BF9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhDIK1o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhDIK1l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:41 -0400
Date:   Fri, 09 Apr 2021 10:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdEIUud9lZ4pLFmnef0chA/BMguCQiBj/F0RgBkA7IM=;
        b=x8xjV9HzbEobrvU++VoiXGbwb8xwqrU5tVZaOUEjyrgv08U0ZBo5wlf+j0MUQkoIssq//E
        pfx/R2C8AJ+VmrZxs0h6a7/v9sjdo1qG42sXinpj2IwjCH8FFmxHzihnAHXsO7UTO4SPXT
        auOEYJOV2JrKCy/eMmcxXiSny6hmpRl851P0yhn3/ZhuKddx2Xc1GphMiy8v+mzBmDhDYK
        vdlhfs1D/5i7Ej4pA9avqB49n0On/P8tv5QDK+B3e5uyHSYoG0kDNc9sP3KJcjC67nY+nI
        +mTS0JS7vx8kuCMyqRcJoAnKmiHaBmVHyLf4jF7L79H/6NKrvJ4zYyTXLRVOuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdEIUud9lZ4pLFmnef0chA/BMguCQiBj/F0RgBkA7IM=;
        b=Q7H8M1WHrocW/IBt/MFO7N4iDSRFR1eAYsc/sFpycnCyTQEoSfHwUQcYrC72JJYEaxy6OJ
        c8J2FfBQ0cJDOtAQ==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Don't use CMTOUT_IE
 with R-Car Gen2/3
Cc:     Phong Hoang <phong.hoang.wz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210309094448.31823-1-wsa+renesas@sang-engineering.com>
References: <20210309094448.31823-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <161796404656.29796.2438653089234156067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     68c70aae06e9660473a00fd7d68e0b53f4d7b6f4
Gitweb:        https://git.kernel.org/tip/68c70aae06e9660473a00fd7d68e0b53f4d=
7b6f4
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Tue, 09 Mar 2021 10:44:48 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:24:16 +02:00

clocksource/drivers/sh_cmt: Don't use CMTOUT_IE with R-Car Gen2/3

CMTOUT_IE is only supported for older SoCs. Newer SoCs shall not set
this bit. So, add a version check.

Reported-by: Phong Hoang <phong.hoang.wz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210309094448.31823-1-wsa+renesas@sang-engin=
eering.com
---
 drivers/clocksource/sh_cmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index c98f885..d7ed99f 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -339,8 +339,9 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 		sh_cmt_write_cmcsr(ch, SH_CMT16_CMCSR_CMIE |
 				   SH_CMT16_CMCSR_CKS512);
 	} else {
-		sh_cmt_write_cmcsr(ch, SH_CMT32_CMCSR_CMM |
-				   SH_CMT32_CMCSR_CMTOUT_IE |
+		u32 cmtout =3D ch->cmt->info->model <=3D SH_CMT_48BIT ?
+			      SH_CMT32_CMCSR_CMTOUT_IE : 0;
+		sh_cmt_write_cmcsr(ch, cmtout | SH_CMT32_CMCSR_CMM |
 				   SH_CMT32_CMCSR_CMR_IRQ |
 				   SH_CMT32_CMCSR_CKS_RCLK8);
 	}
