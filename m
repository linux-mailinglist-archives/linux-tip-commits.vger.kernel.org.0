Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8134D2D86BB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439060AbgLLNJQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:09:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438892AbgLLM7b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:31 -0500
Date:   Sat, 12 Dec 2020 12:58:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx5o7YFcdB1Q78ixdSbXSuPqroCOXBTtp4jErv45ZW0=;
        b=bMbbtNokTcXR1A+ZI/nw1StzMFfjoCVfQjtIjkNkoZp0JzDngK1rdQ6ggSL+9KCrsZCvmv
        V9nvwoqrp642BNFR/iypZautoMpQ/xSnUBZsNPc7dzFCbaSvKCXRFbXw7r7U5Rq2XLhAEW
        3XzX7PUJ7zUruyc3GbeLyrewFTqCp2ADX+jVTauj0sJ6zBxFwuXdA5MF2LwVecz1JfCwow
        jqItWUliUOIjxtPwQVw07GhPg9ne6RCqWZkSFsF1wT5KPLB10fkRKOF0X4VuvfpBR6NSJb
        fQ2fPDTcutGGYoijt1TvEoDhtOg3tqlmXTRwRCRIz4Fx5ClfTCgm0rBMr8+Hkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx5o7YFcdB1Q78ixdSbXSuPqroCOXBTtp4jErv45ZW0=;
        b=T0zV2D3EY8iKAJeaH0NORPRetI4If3kncNc9sic84gXE9OujI+nCLQusaJuu1etz1Yicx8
        rrDkxpJz0MuAJuBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] xen/events: Remove unused bind_evtchn_to_irq_lateeoi()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.972064156@linutronix.de>
References: <20201210194044.972064156@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791594.3364.10448489903620740755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     16b2efd9e4c60f9010f27ada31b0c7d73f23e0d3
Gitweb:        https://git.kernel.org/tip/16b2efd9e4c60f9010f27ada31b0c7d73f23e0d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

xen/events: Remove unused bind_evtchn_to_irq_lateeoi()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194044.972064156@linutronix.de

---
 drivers/xen/events/events_base.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6038c4c..d6458e4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1132,12 +1132,6 @@ int bind_evtchn_to_irq(evtchn_port_t evtchn)
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
-int bind_evtchn_to_irq_lateeoi(evtchn_port_t evtchn)
-{
-	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip);
-}
-EXPORT_SYMBOL_GPL(bind_evtchn_to_irq_lateeoi);
-
 static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
