Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35AC2DEB81
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Dec 2020 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgLRWWA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Dec 2020 17:22:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRWV7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Dec 2020 17:21:59 -0500
Date:   Fri, 18 Dec 2020 22:21:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608330077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEZEfMo/QnqMJDSLzJsvgqEVvfDy14YXGTHtWxGOpfs=;
        b=Nk/PnCPliTWy67eWov5MPLAJdYFjXSdBIdgHdzFT/TOtjLpLJzKIfj4vUa4VhlEZujkgck
        QmQ3LdFG54CBnqDJ2B9od03xO4PXMpPEMTOojIImdmCvDDiDRA49bZfCXyVpORA9k4ViQl
        5FbOZ4hC8Uqkj0rVoGO81MJA/dh7ybPFnPMTeFfyh/OWZ6hoI8o6i3KDplHcqqnC3gDgBT
        O8+NEW2H6x0U15nrf+ZMfvh8+1GudZ0FMP/+yEZs4rumVW3IZpCBjHefgE4u5u/R1a3ior
        m2I2WQCi0y8OLL4RUsI9Wmo6xpbCcI+ppHPTi0BduSr57y5f3urOObIbp0IPZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608330077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEZEfMo/QnqMJDSLzJsvgqEVvfDy14YXGTHtWxGOpfs=;
        b=Tsgh4wQmSNnLq7AAwhW7s2AJSb/6aGAw9c6m7hHPMM9V17+gwIqnriM0xUWDFejxKn3xxg
        4IXqZV48ePfjVlCQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix spelling mistake in Kconfig
 "fullfill" -> "fulfill"
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201217171705.57586-1-colin.king@canonical.com>
References: <20201217171705.57586-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <160833007629.22759.14606653946447957178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f6f5cd840ae782680c5e94048c72420e4e6857f9
Gitweb:        https://git.kernel.org/tip/f6f5cd840ae782680c5e94048c72420e4e6857f9
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 17 Dec 2020 17:17:05 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Dec 2020 23:15:00 +01:00

timekeeping: Fix spelling mistake in Kconfig "fullfill" -> "fulfill"

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20201217171705.57586-1-colin.king@canonical.com

---
 kernel/time/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a09b1d6..64051f4 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -141,7 +141,7 @@ config CONTEXT_TRACKING_FORCE
 	  dynticks working.
 
 	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
+	  context tracking backend but doesn't yet fulfill all the
 	  requirements to make the full dynticks feature working.
 	  Without the full dynticks, there is no way to test the support
 	  for context tracking and the subsystems that rely on it: RCU
