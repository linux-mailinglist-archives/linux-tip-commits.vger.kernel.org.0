Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C822AA626
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgKGPN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgKGPN6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:13:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676EC0613CF;
        Sat,  7 Nov 2020 07:13:58 -0800 (PST)
Date:   Sat, 07 Nov 2020 15:13:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlyNepKjGqlinQjurAmFsYJP0g+gGEOCd0KEkSbjcyM=;
        b=vK3fYNlTP5+PtTHNhlvvHCSRTuI/BYTZdDlOjzwGbWU5oszorRtM/4RLQ2MG5/OYjBowsg
        L5ucsHSsqgSdI9AHn1uOopNHdjO0tmd9RCDdTLbritJ6BLlPWEZpJ7OXRoZmAJ45tOxwte
        DXXQDrZ+dcfnFnT/+pKyXUzme7C63G0vU9zsbbzB+dqmSNrZNnM0X6twiCgcRrMvrdv2G9
        UAmq6iPTBhDCb9JfHGEHu/mqIu+2Dmy72vfHGp2W86Jy/XIAgjopALkEk8vSIyAg+FTvVL
        jbjcmRduLw9NbjFj6BXv29GGguKSHLe3dz1yrgT6kR2r/jY6EyYK50jyEnyj0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlyNepKjGqlinQjurAmFsYJP0g+gGEOCd0KEkSbjcyM=;
        b=cyKjdbGFjVePfCdzqhjTYAMmmkTL2YgMn/VPwXbDb+iLvFPccO9rI227/pJou3raqmA/uu
        B/CbJp2uEfS0nXDQ==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Remove unused of_device_id forward declaration
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201030165919.86234-2-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160476203571.11244.5978779116215604898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     eda2845ae5e0ae466c1aca715d642b4977311747
Gitweb:        https://git.kernel.org/tip/eda2845ae5e0ae466c1aca715d642b4977311747
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 30 Oct 2020 18:59:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:33:45 +01:00

irqdomain: Remove unused of_device_id forward declaration

There is no users of of_device_id in irqdomain.h. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20201030165919.86234-2-andriy.shevchenko@linux.intel.com

---
 include/linux/irqdomain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e8..5664218 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -38,7 +38,6 @@
 
 struct device_node;
 struct irq_domain;
-struct of_device_id;
 struct irq_chip;
 struct irq_data;
 struct cpumask;
