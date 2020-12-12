Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF32D86CB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406181AbgLLNK5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:10:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438888AbgLLM70 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:26 -0500
Date:   Sat, 12 Dec 2020 12:58:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q869i+khhi8eYG23ysnHCr8gl3AwWd+D3vtI8rLxPxI=;
        b=o1KG9xVTZdv/2G/Rvg3QAqGosRIRi1ETgkBvGfLbYE+D5QeFmU3Vui4AfU9ysv8cM/+UPL
        1JY7B6Eqw9br3iC3NtMXcj0tqzsdSCKB9xPkyb8GBYdnQnJhjPG4wpaf6fMiOLx/Xg3pC+
        X/kTZ46xl+eBYuiUNhiptRP6l9ocYtfyXfjSUxrr+mvu0iuUjZ0zSBb7OS7iGIK7O0sjEg
        9r7DjUxgN74RIYCkRdomiSntdapxsliW2NkLdtRID0yjJDMGqZ0WosaLaSvkoIpGxcHVyt
        tFv31OkISL4Z19aYw0qlRsykRsERRiBhVxpcompdGsoyzFXVFe38X870adlyBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q869i+khhi8eYG23ysnHCr8gl3AwWd+D3vtI8rLxPxI=;
        b=j4tjj9MZRGie9kZq7uzO+aLr2S2H3J6m464hVZs3mt6hxD5iOz3dkXnZO7By4R6Q2sTHzw
        mEulDzsEcilbXwBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] xen/events: Reduce irq_info:: Spurious_cnt storage size
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194045.360198201@linutronix.de>
References: <20201210194045.360198201@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791478.3364.4880915357111134192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6e8e8d49554722ddc076a6b87dc7048ddceb2375
Gitweb:        https://git.kernel.org/tip/6e8e8d49554722ddc076a6b87dc7048ddceb2375
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:07 +01:00

xen/events: Reduce irq_info:: Spurious_cnt storage size

To prepare for interrupt spreading reduce the storage size of
irq_info::spurious_cnt to u8 so the required flag for the spreading logic
will not increase the storage size.

Protect the usage site against overruns.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194045.360198201@linutronix.de

---
 drivers/xen/events/events_base.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 679b2cb..b352440 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -95,7 +95,7 @@ struct irq_info {
 	struct list_head list;
 	struct list_head eoi_list;
 	short refcnt;
-	short spurious_cnt;
+	u8 spurious_cnt;
 	enum xen_irq_type type; /* type */
 	unsigned irq;
 	evtchn_port_t evtchn;   /* event channel */
@@ -528,8 +528,10 @@ static void xen_irq_lateeoi_locked(struct irq_info *info, bool spurious)
 		return;
 
 	if (spurious) {
-		if ((1 << info->spurious_cnt) < (HZ << 2))
-			info->spurious_cnt++;
+		if ((1 << info->spurious_cnt) < (HZ << 2)) {
+			if (info->spurious_cnt != 0xFF)
+				info->spurious_cnt++;
+		}
 		if (info->spurious_cnt > 1) {
 			delay = 1 << (info->spurious_cnt - 2);
 			if (delay > HZ)
