Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFE636CE8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Nov 2022 23:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKWWMJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Nov 2022 17:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKWWLp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Nov 2022 17:11:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E411E72E;
        Wed, 23 Nov 2022 14:11:27 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:11:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669241486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsfjykesDNFV6OD+g3hFK1x5GkNwmVVz7PjwxF26TMs=;
        b=nPv5NIiExKHu9S0HrNSuJqc0PBHbi6NvpHV6CgR4FHZSOJXCrbQRzI4tv7UlcqlQ+TilD/
        Vdqf83IKHzEzpRjWRja5l7Mrym+eBOn6QgjAlLtQl4APK7s2M36IDcCLps39mEnMI0qIdM
        rrxf1Udx4uE7/1i1afR5Ubk02SuEnWtp/5Hg3aKoj/R4vaX6ttKMK7sN7vA4kodKwqa3z2
        NO7e05xKwL2pM7+DL5tCZf//hAFdan9h71aHzhiN4OTN6xptPdfWF9crjJXxVLrnYQV1vo
        fk1l8faiTFDi4Dn7SVHzk6lPNYOVK97MbMpmRB9A3LW0UbA3PynGCc2awSzx9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669241486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsfjykesDNFV6OD+g3hFK1x5GkNwmVVz7PjwxF26TMs=;
        b=IXyGy51D0+/Xbd1aYLQBgHPu/+humJ5dvH7rjC4S8uUq1To3SAiLnYfkaWP+dmVaR/dey7
        2HyGuIcgUH0cMzAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] soc: fsl: dpio: Remove linux/msi.h include
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221113202428.760225831@linutronix.de>
References: <20221113202428.760225831@linutronix.de>
MIME-Version: 1.0
Message-ID: <166924148463.4906.7277315892884690614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     20e2e09c0998ef0c325edeb00560a8ff67b35913
Gitweb:        https://git.kernel.org/tip/20e2e09c0998ef0c325edeb00560a8ff67b35913
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Nov 2022 21:34:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Nov 2022 23:07:37 +01:00

soc: fsl: dpio: Remove linux/msi.h include

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221113202428.760225831@linutronix.de

---
 drivers/soc/fsl/dpio/dpio-driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 5a2edc4..74eace3 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>
