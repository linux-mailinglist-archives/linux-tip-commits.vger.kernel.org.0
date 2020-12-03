Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DD2CE305
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgLCXtO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgLCXtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A3C061A56;
        Thu,  3 Dec 2020 15:47:53 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6HuaTzI63Adcs8d/TYLyU/59/p1gb87Pl8qF+YncMs=;
        b=ebubQpqpqOxCNcYSXB0wpdcHFMxo3XDffrBaeUWmnMm/kyOolcw0MmxEshtEioPJ0Ywq0U
        BfPqpEjUk0BJ32F5pK88MQGSJhVjWifS+K2GVgnrUkUy+uVh4ITb6naLMnow03wP9GeJlW
        sMRETsGxa6/7e8PpcU0v0TDJlmCOEGqltGX3n2xbarqG1i5P9zK6g5Xb/HzSDhU2A6pK8p
        QHr6il6PehVFSb1PKLgTQMv12SpxHdTTkcemqzmxGYhLkqXJrJlZMsItiFc8We+FOfhVZx
        56k69yq0m7BEVbxZR5IE0KP8aIFE/jRPn8RqfTuF5tNJ16BbEitAMgk3ivJvXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6HuaTzI63Adcs8d/TYLyU/59/p1gb87Pl8qF+YncMs=;
        b=yacwht1gDi5M/ErySgGgOum9/dEuV0vfhGwwNdo8+1gukcPG5hG2+VsJwrZ6FXClHfE8SS
        26tDv35EzwGZVCCA==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add new OST support for the
 upcoming new driver.
Cc:     sernia.zhou@foxmail.com, zhouyanjie@wanyeetech.com,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201026155842.10196-2-zhouyanjie@wanyeetech.com>
References: <20201026155842.10196-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <160703927157.3364.4500387551340496666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0fce2e02a29ca5420472f03d3f2858eedded3fe7
Gitweb:        https://git.kernel.org/tip/0fce2e02a29ca5420472f03d3f2858eedde=
d3fe7
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Mon, 26 Oct 2020 23:58:42 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:18 +01:00

dt-bindings: timer: Add new OST support for the upcoming new driver.

The new OST has one global timer and two or four percpu timers, so there
will be three combinations in the upcoming new OST driver: the original
GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
combinations, the clock can be registered (by calling clk_hw_register())
from index 0.

Before this patch, OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER are only
used in two places, one is when using "assigned-clocks" to configure the
clocks in the DTS file; the other is when registering the clocks in the
sysost driver. When the values of these two ABIs are exchanged, the ABI
value used by sysost driver when registering the clock, and the ABI value
used by DTS when configuring the clock using "assigned-clocks" will also
change accordingly. Therefore, there is no situation that causes the wrong
clock to the configured. Therefore, exchanging ABI values will not cause
errors in the existing codes when registering and configuring the clocks.

Currently, in the mainline, only X1000 and X1830 are using sysost driver,
and the upcoming X2000 will also use sysost driver. This patch has been
tested on all three SoCs and all works fine.

Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201026155842.10196-2-zhouyanjie@wanyeetech.=
com
---
 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings=
/clock/ingenic,sysost.h
index 9ac88e9..063791b 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -1,12 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This header provides clock numbers for the ingenic,tcu DT binding.
+ * This header provides clock numbers for the Ingenic OST DT binding.
  */
=20
 #ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
 #define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
=20
-#define OST_CLK_PERCPU_TIMER	0
-#define OST_CLK_GLOBAL_TIMER	1
+#define OST_CLK_PERCPU_TIMER	1
+#define OST_CLK_GLOBAL_TIMER	0
+#define OST_CLK_PERCPU_TIMER0	1
+#define OST_CLK_PERCPU_TIMER1	2
+#define OST_CLK_PERCPU_TIMER2	3
+#define OST_CLK_PERCPU_TIMER3	4
=20
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
