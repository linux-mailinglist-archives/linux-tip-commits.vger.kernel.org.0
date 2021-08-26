Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005303F8C11
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbhHZQ0F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbhHZQ0E (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:04 -0400
Date:   Thu, 26 Aug 2021 16:25:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SWK40kIKp6fcpk0GSErqvJtf7SQk8W67he+7muxkMw=;
        b=tTu/iyIYhQfkKv317dTStltvayySwWL6ifA9SOpLu9K282Bs6keBjpnbh81wBzw+bZl6Ww
        ggT6f1X3AlnGNdTECViWmBtQpLr6FfnMEam8oF7AoKsTir8lHksOfRrxmKL9mR1JsCyUUL
        8nulDwdUASdmJ8bmHs24YtqBsTH5fIY0hSnPVjVVNkmskIb6FWU67ddhkWUzBj32cmqQqi
        3TYe/3ymqw21tO7BNU+yi8FTN6wxANJdFidXfKMIXMxddmNtTMMjhujSi7Ihv19Xxa9uwb
        o3u5h4UbYR+rCNnfm02PiL6dQcs5CQMYTHE7MrBDa6un+IBV6jlmyuUjlJ7j4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SWK40kIKp6fcpk0GSErqvJtf7SQk8W67he+7muxkMw=;
        b=ZezTXTpsjaUBZgcCYMRonalpmsaxVVXckbTtyPRBHOtJ3J8k5JdIs8KVrwlcJC4FUvtX6P
        8+lYDqE86OBNL+Ag==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add ABIs for new Ingenic SoCs
Cc:     zhouyanjie@wanyeetech.com, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <162999511453.25758.7971723443425767533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f196ae282070d798c9144771db65577910d58566
Gitweb:        https://git.kernel.org/tip/f196ae282070d798c9144771db65577910d=
58566
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Fri, 16 Jul 2021 01:36:45 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 21 Aug 2021 09:58:17 +02:00

dt-bindings: timer: Add ABIs for new Ingenic SoCs

1.Add OST_CLK_EVENT_TIMER for new XBurst=C2=AE1 SoCs.
2.Add OST_CLK_EVENT_TIMER0 to OST_CLK_EVENT_TIMER15 for new XBurst=C2=AE2 SoC=
s.

Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1626370605-120775-1-git-send-email-zhouyanjie=
@wanyeetech.com
---
 include/dt-bindings/clock/ingenic,sysost.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings=
/clock/ingenic,sysost.h
index 063791b..d7aa42c 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -13,4 +13,23 @@
 #define OST_CLK_PERCPU_TIMER2	3
 #define OST_CLK_PERCPU_TIMER3	4
=20
+#define OST_CLK_EVENT_TIMER		1
+
+#define OST_CLK_EVENT_TIMER0	0
+#define OST_CLK_EVENT_TIMER1	1
+#define OST_CLK_EVENT_TIMER2	2
+#define OST_CLK_EVENT_TIMER3	3
+#define OST_CLK_EVENT_TIMER4	4
+#define OST_CLK_EVENT_TIMER5	5
+#define OST_CLK_EVENT_TIMER6	6
+#define OST_CLK_EVENT_TIMER7	7
+#define OST_CLK_EVENT_TIMER8	8
+#define OST_CLK_EVENT_TIMER9	9
+#define OST_CLK_EVENT_TIMER10	10
+#define OST_CLK_EVENT_TIMER11	11
+#define OST_CLK_EVENT_TIMER12	12
+#define OST_CLK_EVENT_TIMER13	13
+#define OST_CLK_EVENT_TIMER14	14
+#define OST_CLK_EVENT_TIMER15	15
+
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
