Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E151E8F30
	for <lists+linux-tip-commits@lfdr.de>; Sat, 30 May 2020 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgE3Hqz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 30 May 2020 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgE3Hqs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 30 May 2020 03:46:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428AC08C5C9;
        Sat, 30 May 2020 00:46:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCZ-0001ue-5T; Sat, 30 May 2020 09:46:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 55A5D1C0481;
        Sat, 30 May 2020 09:46:40 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:40 -0000
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] platform-msi: Fix typos in comment
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1589770859-19340-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1589770859-19340-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <159082480021.17951.11777500685293897400.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ae0bb9fda405c881848f7f6e94d912b35f6e31d2
Gitweb:        https://git.kernel.org/tip/ae0bb9fda405c881848f7f6e94d912b35f6e31d2
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Mon, 18 May 2020 11:00:59 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 18 May 2020 10:28:30 +01:00

platform-msi: Fix typos in comment

Fix up one typos @nev -> @nr_irqs.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1589770859-19340-1-git-send-email-zhangshaokun@hisilicon.com
---
 drivers/base/platform-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8da314b..c4a17e5 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -387,7 +387,7 @@ void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
  *
  * @domain:	The platform-msi domain
  * @virq:	The base irq from which to perform the allocate operation
- * @nvec:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to free from @virq
  *
  * Return 0 on success, or an error code on failure. Must be called
  * with irq_domain_mutex held (which can only be done as part of a
