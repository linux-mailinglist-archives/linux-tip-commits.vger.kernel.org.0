Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F212F4DF5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAMOyc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Jan 2021 09:54:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbhAMOyb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Jan 2021 09:54:31 -0500
Date:   Wed, 13 Jan 2021 14:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610549629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPtiNcNaVIH62EFdxfvZe8gY9t35yvS5DVUbqsmry/Y=;
        b=QmiyLLzPgv2e3jRNIdf3CIedU3K/JWmA9aCAo2EdHsKHJNOOw2C+WQL6uPR9yVKHbyOy5Q
        PfMyb5HKEZZIUiDxCJTSAOpDZl8SU611kMztPcsb9X4W2YE60pakThc+4yaVWYFlEDKttY
        g/obB4NrH9PumQCTvIMK4BmHR9lcCNMHXk7eGlb4ce1xMVfefqLC2w7FCyhSXgtIJlzrQQ
        ATrR3a7UeqejrzknUugKiy+NqbRBE9O49I0X2SRjO/JfnbqpAb36bZVdAmFRlto3sDUeww
        kL4XgZZ2CDGvJA01aWGalSEML439Yffc90Uh5JUIfUbmT7zZeNJsK8DZtMSHZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610549629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPtiNcNaVIH62EFdxfvZe8gY9t35yvS5DVUbqsmry/Y=;
        b=QQJ2evuQoX7uBZa7Q6G1twLAVo602OU3ye8F7TMn60U+kqoXWlysnlnyjKV/6+EnlsA6NA
        Z2L+ANhXa2nFt1Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Export irq_check_status_bit()
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201227192049.GA195845@roeck-us.net>
References: <20201227192049.GA195845@roeck-us.net>
MIME-Version: 1.0
Message-ID: <161054962816.414.13151167154004705944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ce09ccc50208c04a1b03abfd530b5d6314258fd0
Gitweb:        https://git.kernel.org/tip/ce09ccc50208c04a1b03abfd530b5d6314258fd0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Jan 2021 15:43:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Jan 2021 15:48:05 +01:00

genirq: Export irq_check_status_bit()

One of the users can be built modular:

  ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Fixes: fdd029630434 ("genirq: Move status flag checks to core")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201227192049.GA195845@roeck-us.net
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ab8567f..dec3f73 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2859,3 +2859,4 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	rcu_read_unlock();
 	return res;
 }
+EXPORT_SYMBOL_GPL(irq_check_status_bit);
