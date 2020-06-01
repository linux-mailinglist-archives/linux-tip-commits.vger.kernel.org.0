Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779F41EA48C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jun 2020 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFANMp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Jun 2020 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgFANLx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F713C08C5C9;
        Mon,  1 Jun 2020 06:11:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEJ-00077E-2s; Mon, 01 Jun 2020 15:11:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B4D721C0244;
        Mon,  1 Jun 2020 15:11:45 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:45 -0000
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/rda: drop redundant Kconfig dependency
Cc:     Johan Hovold <johan@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200513122548.16974-1-johan@kernel.org>
References: <20200513122548.16974-1-johan@kernel.org>
MIME-Version: 1.0
Message-ID: <159101710552.17951.6306013470249214753.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     83cba9536905e4f82b726a98fe404400f0c9eb76
Gitweb:        https://git.kernel.org/tip/83cba9536905e4f82b726a98fe404400f0c9eb76
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Wed, 13 May 2020 14:25:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 22 May 2020 23:58:56 +02:00

clocksource/drivers/rda: drop redundant Kconfig dependency

Since commit 2f8a26c166eb ("clocksource: Improve GENERIC_CLOCKEVENTS
dependency") all clocksource drivers depend on GENERIC_CLOCKEVENTS so
drop the redundant attribute from the RDA-timer entry which was added
later.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200513122548.16974-1-johan@kernel.org
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9c2d72b..c824002 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -120,7 +120,6 @@ config OWL_TIMER
 
 config RDA_TIMER
 	bool "RDA timer driver" if COMPILE_TEST
-	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
