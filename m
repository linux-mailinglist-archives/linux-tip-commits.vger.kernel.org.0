Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666A23ACFB1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhFRQFz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFRQFw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:52 -0400
Date:   Fri, 18 Jun 2021 16:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbGW+Y7W47+cfpkIZZJFy9dX6g9AtN+YqA/g1Kf47ik=;
        b=VnooZu3e/oC6ZDtFPamG4W6Hkf0OdsUOE0/hovC/BQb4LmeD2h1Rfi8KbFgKpneEDRfQli
        fJiR+xXwIPUnc7usnIzjNkmBsHzw84CcwjN+Lghv7JFTWHKKP0lfl0laVVPmtmncBjU7To
        nAmU56pnQDeGwov+XVaJjn5Zl9wuq4059iF9qFRF7rLlme+YG5OUG5E8Rey3Q14D/1rqDN
        6JA5MSXgzYV0x23JV2enFxA8d29GRmS76Gru2D4phdEjETYX/izKyRFVEtUK/qUcbRj134
        0I8UJRNnhHt8LzWC7rE+0vhipJzVBsdOrdTooYkXIRxWw3MzrS8mv2A1iVNy+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbGW+Y7W47+cfpkIZZJFy9dX6g9AtN+YqA/g1Kf47ik=;
        b=uMuDYqlnpDuoTmShveOzwBrZ8UZID+/aNqFk8D9MYttleNKS+F2Pein2DM5V2tN/2pdDBB
        WG2A1KRvRiOdl1DQ==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/samsung_pwm: Constify source IO memory
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506202729.157260-4-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162403222155.19906.7758421303806023527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b4318ce203db8f8b7004e7ab82a957f894660c88
Gitweb:        https://git.kernel.org/tip/b4318ce203db8f8b7004e7ab82a957f894660c88
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Thu, 06 May 2021 16:27:28 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Jun 2021 10:12:13 +02:00

clocksource/drivers/samsung_pwm: Constify source IO memory

The 'source_reg' IO memory is only read, so the pointer can point to
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506202729.157260-4-krzysztof.kozlowski@canonical.com
---
 drivers/clocksource/samsung_pwm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 55e2f9f..6e46781 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL(samsung_pwm_lock);
 
 struct samsung_pwm_clocksource {
 	void __iomem *base;
-	void __iomem *source_reg;
+	const void __iomem *source_reg;
 	unsigned int irq[SAMSUNG_PWM_NUM];
 	struct samsung_pwm_variant variant;
 
