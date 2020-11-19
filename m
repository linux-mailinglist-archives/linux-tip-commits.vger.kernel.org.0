Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819972B9BB8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKSTvT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 14:51:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKSTvT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 14:51:19 -0500
Date:   Thu, 19 Nov 2020 19:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605815476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e/pC9tS0I7XU9S3D/OLvhwm2F+qD6KVc4sckpDDb8u0=;
        b=cYG4FNxmKPSQZd8G9Gya1o2IEzOLiS4+ChnKNs7KIJqXZaxrL2vjQVm1DypdtUHl7IASIY
        3/F9fCbkk07FwF/4ycMmldl23mOBg5fh+g/HUAmp+ALigCey4dgJ7P5k73i7m7MqHdV7Zc
        tx4liksYPTu2f/d6NeXt924bLHAUnNQFdh/UmQn7nQzm6K6Yo0j3tH9UefNh66QOr7e6I2
        XxQSkunv4hIOq759RzlabZb5MSFwTiW4D2ieEpjSv7Nx2hohM799zR+HYw/HVR8apQC3cA
        k95FU00uCDH9gN4l8RK8WIyaWAVPyhaQuO1GD6Bk3Gk8NMxoQz/5BJnclWy8iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605815476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e/pC9tS0I7XU9S3D/OLvhwm2F+qD6KVc4sckpDDb8u0=;
        b=lKeGVYIXdsWobyG/0WsNbKzhkFOvP5ix+MynwTHtO4jr4OOAo80VZXHJ0qJbDMBQKqAVBZ
        auLC4lsTKv+Gd9DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] microblaze/mm/highmem: Add dropped #ifdef back
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <monstr@monstr.eu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160581547501.11244.627337755797620780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     a0e169978303ee5873142599c8c9660b2d296243
Gitweb:        https://git.kernel.org/tip/a0e169978303ee5873142599c8c9660b2d296243
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 19 Nov 2020 20:45:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 20:49:44 +01:00

microblaze/mm/highmem: Add dropped #ifdef back

The conversion to generic kmap atomic broke microblaze by removing the
build fail.

Add it back.

Fixes: 7ac1b26b0a72 ("microblaze/mm/highmem: Switch to generic kmap atomic")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 1f4b5b3..a444778 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -49,6 +49,7 @@ unsigned long lowmem_size;
 EXPORT_SYMBOL(min_low_pfn);
 EXPORT_SYMBOL(max_low_pfn);
 
+#ifdef CONFIG_HIGHMEM
 static void __init highmem_init(void)
 {
 	pr_debug("%x\n", (u32)PKMAP_BASE);
