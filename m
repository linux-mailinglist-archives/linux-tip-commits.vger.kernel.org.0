Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490331C8DAA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 May 2020 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGOH0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 May 2020 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgEGOH0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 May 2020 10:07:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC13C05BD0A;
        Thu,  7 May 2020 07:07:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBK-00027H-Qy; Thu, 07 May 2020 16:07:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6FDDE1C001A;
        Thu,  7 May 2020 16:07:22 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:22 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Mark uv_min_hub_revision_id static
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-8-hch@lst.de>
References: <20200504171527.2845224-8-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044241.8414.13036679821317631665.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8263b059379c4a95fe0181db1e5a2e9c2229d929
Gitweb:        https://git.kernel.org/tip/8263b059379c4a95fe0181db1e5a2e9c2229d929
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:22 +02:00

x86/platform/uv: Mark uv_min_hub_revision_id static

This variable is only used inside x2apic_uv_x and not even declared
in a header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-8-hch@lst.de

---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index cb07a98..f1a0142 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -48,8 +48,7 @@ static struct {
 	unsigned int gnode_shift;
 } uv_cpuid;
 
-int uv_min_hub_revision_id;
-EXPORT_SYMBOL_GPL(uv_min_hub_revision_id);
+static int uv_min_hub_revision_id;
 
 unsigned int uv_apicid_hibits;
 EXPORT_SYMBOL_GPL(uv_apicid_hibits);
