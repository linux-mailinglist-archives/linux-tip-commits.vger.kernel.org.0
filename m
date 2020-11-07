Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2082AA48B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgKGLPM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 06:15:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKGLPM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 06:15:12 -0500
Date:   Sat, 07 Nov 2020 11:15:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604747710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoG63zVlXg7WAwjuBr+ErUXdE0cONYf9E5uQ8VwCCZU=;
        b=V+uWee9kmezpuOkYrX46AUR1IJrAKQGAFfPey5BP0kkwzjwU4X1Vnh1GkQ/EbNDdSneQlT
        5TssSUTVuYHqn1nIt8l+SopGRLnKDnshw9HeG+QCXcauN/j6aE2Kuq3GkJaTXZU7cyzAin
        vVgYvLPwkXtMeBy9MaTyZMaGkj/Z0Sfk3RGfAs80fpzAqiEDK1r1owoHeVNQwm9e2QDlNl
        BaSts/+SPfLEQwoXA+0dm3a9vY9nSFjMlsCoCdHzW26r0DrspIn3ErJ9MxTcloKVTK/ktz
        L0rzmw7oa4M11Gjdgrhr+wfrOYoY1bw0dTA3gk+XJ2cPIDeAZgl8SGxQQPUFSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604747710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoG63zVlXg7WAwjuBr+ErUXdE0cONYf9E5uQ8VwCCZU=;
        b=ZfEQGs/ykCsnHVGvJMYgUYgLzUg4tn8dQnGYUFs6F7bu1rFC1sP29mCyuXDejjvz0CQmoV
        lqO8yLFF7wulHBDg==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add forward declaration of fwnode_handle
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
In-Reply-To: <20201030165919.86234-3-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160474770947.10260.14857321797698517835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     08219fb1efae451c83281cb6ba4bb6c35ac88fab
Gitweb:        https://git.kernel.org/tip/08219fb1efae451c83281cb6ba4bb6c35ac88fab
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 30 Oct 2020 18:59:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:33:45 +01:00

irqdomain: Add forward declaration of fwnode_handle

irqdomain.h is a user of struct fwnode_handle. Add forward declaration of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20201030165919.86234-3-andriy.shevchenko@linux.intel.com

---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5664218..d21f75d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -37,6 +37,7 @@
 #include <linux/radix-tree.h>
 
 struct device_node;
+struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
