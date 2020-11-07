Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D812AA48C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKGLPN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 06:15:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKGLPM (ORCPT
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
        bh=WlyNepKjGqlinQjurAmFsYJP0g+gGEOCd0KEkSbjcyM=;
        b=RuqxEWEeXF4YE2KFA2e7JkFpuL4Yzj24svNq0kfcXT/icr8YN80oL5u9omOZFcwi3A/d8t
        Y0NvNF0Ga+KunsQR6myN6YWTTUvkQwrIRvib1aSf1Cwc2yLsOCNQfknx6V7tKQ3g2MSB+l
        FjMjsaVwW3w29MW38xaBMkZkfSN2AjUel38wc8YfUNc7s4vPTn37zZKxPPCO9DdfGGxipl
        GgRrQ8stHY1elMm79lhRlUtPfiJ6gmu8Jlewj1WxwMpgKHBUs60tYHoW8BOyTSXJthmXZR
        WAJNk2ssmtc+Pj9goqfklMwLRax4VT053IjDdy8PR3yG8MJYSFRL84XqxLhK0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604747710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlyNepKjGqlinQjurAmFsYJP0g+gGEOCd0KEkSbjcyM=;
        b=7dXMLbsq28gEjnSBiAIW0VEmPBJ7A6vlokhr/P52Q4fENBNOJcEMYSnmTGuUr2g1GdZi9G
        RVi+1FzrHjHu2GCA==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Remove unused of_device_id forward declaration
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
In-Reply-To: <20201030165919.86234-2-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160474770997.10260.13324386175243740203.tip-bot2@tip-bot2>
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
