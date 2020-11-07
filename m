Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFD2AA62B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgKGPN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgKGPN5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:13:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633FDC0613CF;
        Sat,  7 Nov 2020 07:13:57 -0800 (PST)
Date:   Sat, 07 Nov 2020 15:13:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyG+1H7UuSLP2OKmWxckpk/UPtOx0sGvxKy7oW1J+ok=;
        b=FkeAxHvK02n8VH7FOqEjqsJEpqzXHzvbCeJXZxsHzMk9Lf6y1IZsw4a8l/sWylROtuPwnd
        mGGga1lKNFpg2f91AIxx1dzaIbI0OBZ15ULQjHIGEiI0bEq+9S3Nz2ooKV8vw8Cmr346Vu
        DhnAKyngDjZ7ugiOVHlA+mIJmISA8dnrjd69nzTlPHCET02lZkAYVox+GFbGm9Spy2lxKm
        FbBrPagpyzF04APkjKvXOt9XYrH/w729PH6n5DQINtvFXp5NEYWI5Czo4Q2YCig0QRvcHj
        PLZCCreQt02Y7vE3nZRgUbEw6a4p1iFHTR2c6CKBqCYk3h7zU1e124+7IdxNXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyG+1H7UuSLP2OKmWxckpk/UPtOx0sGvxKy7oW1J+ok=;
        b=lMYku0XvaWX0Q6qK96cFURNb/JK9XSaJjZJjNHyZv8CFJSVa83S5zs44AFMqCDJ/bT/qAB
        KGAhI7p06fb3N3Aw==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Replace open coded of_node_to_fwnode()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201030165919.86234-4-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160476203458.11244.15363644462716481347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c3a877fea962d9d0fb1e3747334699978f566930
Gitweb:        https://git.kernel.org/tip/c3a877fea962d9d0fb1e3747334699978f566930
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 30 Oct 2020 18:59:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:33:45 +01:00

irqdomain: Replace open coded of_node_to_fwnode()

of_node_to_fwnode() should be used for conversion.  Replace the open coded
variant of it in of_phandle_args_to_fwspec().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20201030165919.86234-4-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374..831526f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -737,7 +737,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->fwnode = of_node_to_fwnode(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)
