Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA52CE2E9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgLCXsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgLCXsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F3C061A51;
        Thu,  3 Dec 2020 15:47:52 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itsyXZdM2nEnIsJh0sX7synjjNKHkpZ+E3EabHl0Jyw=;
        b=dZ7iP7wycKAIBt/RZUWv3OmlSA7aPAPTJ4VMNYT90ljtc4P0yKF+E7XqtVTKamk4HEUJ9x
        w+DO6AOAquJFRFY5xY+Qv7a7UVU81QnCfrv6W6/zbNWkbBRPX8W5BJNq75ftXm6G2tpCdV
        bsAJP+fUd62s2+7+CH5aLCPl//6RSzM5U2yFACzm9vP2dOep1/anXJDODQtQLkRT2TWQjm
        ZrxWX83ydKwLjkIEfPj1RyV4114it2IWsOEhEmHF4aRbU4ODXKLX62Rv7o2ltSma3XAqI0
        xANG4ukW7gJ3IBNM/hTD81AeVhD28LabnLqQqphUTe3o6vJQMLRtnnF2N9jF7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itsyXZdM2nEnIsJh0sX7synjjNKHkpZ+E3EabHl0Jyw=;
        b=Ge93S1dTVEYrD1K+DT3RrkcKrQ8JHXRb/MuTg5biLYO1dRkzgi7lX+UcDv7co0T7NmSAW7
        /n2fWkkGX1vWWgAQ==
From:   "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Fix section mismatch
Cc:     kernel test robot <lkp@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        zhouyanjie@wanyeetech.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125102346.1816310-1-daniel.lezcano@linaro.org>
References: <20201125102346.1816310-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160703926877.3364.2896296134554460342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5bd7cb29eceb52e4b108917786fdbf2a2c2048ef
Gitweb:        https://git.kernel.org/tip/5bd7cb29eceb52e4b108917786fdbf2a2c2=
048ef
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 25 Nov 2020 11:23:45 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

clocksource/drivers/ingenic: Fix section mismatch

The function ingenic_tcu_get_clock() is annotated for the __init
section but it is actually called from the online cpu callback.

That will lead to a crash if a CPU is hotplugged after boot time.

Remove the __init annotation for the ingenic_tcu_get_clock()
function.

Fixes: f19d838d08fc (clocksource/drivers/ingenic: Add high resolution timer s=
upport for SMP/SMT)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.c=
om>
Link: https://lore.kernel.org/r/20201125102346.1816310-1-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/ingenic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingeni=
c-timer.c
index 58fd918..905fd6b 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -127,7 +127,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev=
_id)
 	return IRQ_HANDLED;
 }
=20
-static struct clk * __init ingenic_tcu_get_clock(struct device_node *np, int=
 id)
+static struct clk *ingenic_tcu_get_clock(struct device_node *np, int id)
 {
 	struct of_phandle_args args;
=20
