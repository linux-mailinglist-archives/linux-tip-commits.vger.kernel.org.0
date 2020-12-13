Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC432D8DBD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 15:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395019AbgLMOGR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 09:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgLMOF7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 09:05:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C2C0613CF;
        Sun, 13 Dec 2020 06:05:19 -0800 (PST)
Date:   Sun, 13 Dec 2020 14:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0F0l8trAb1+z0OaG4QlBFlVz0bUGXjKJD0V4G3KYCmk=;
        b=cUd+3e2BtlUjESBDXwsas3p16AW/+1EAN+68B/vB85kdTzCOXjAghwx43MafIM9/hM3ORD
        g3T73q1gaHP4wJo7WiAXBbSZalinVy450scE1WpnHzvbN1lWPpyegQBsA7z/ggAuJ9in83
        T0A/tA/XeLlZYgFCBITVLo1NdzoeNIv1+C5yOqos21BTfS0/fwWWWQx13pRITI1jMS96at
        u0v3aaJ6EwvEdLheg4fzVKatnMX86sSaP5YIDdjv3QqjckOy5+yjrtKPmV6U3IL22Hg9Ja
        BOok+NsaOaDBRtprYE9zud98sE7v/QLE3XroAOB8beXK7lvZBR7wtTqizN0K4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0F0l8trAb1+z0OaG4QlBFlVz0bUGXjKJD0V4G3KYCmk=;
        b=Dchz4uJWNM6zlMrrOHfQnV1Gkyne8rfxB2ERJDezEiOvcFtTW5ugMXUd7hobAYHxRzX/oz
        CKRAF+y1OR/+1XBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: nomadik: Fix the fallout of the irqdesc change
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
MIME-Version: 1.0
Message-ID: <160786831640.3364.5703795227951528699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d11e2d4fc53d68c1f94b294b97838b78fac5763f
Gitweb:        https://git.kernel.org/tip/d11e2d4fc53d68c1f94b294b97838b78fac5763f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Dec 2020 13:49:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 13 Dec 2020 14:58:44 +01:00

pinctrl: nomadik: Fix the fallout of the irqdesc change

The previous removal of the irq descriptor access missed to update the
second dereference.

Use the cached value in nmk_chip->real_wake instead.

Fixes: 52ae486b230b ("pinctrl: nomadik: Use irq_has_action()")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 724abe1..d4ea108 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -949,6 +949,7 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	} else {
 		int irq = chip->to_irq(chip, offset);
 		const int pullidx = pull ? 1 : 0;
+		bool wake;
 		int val;
 		static const char * const pulls[] = {
 			"none        ",
@@ -970,6 +971,7 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		 */
 		if (irq > 0 && irq_has_action(irq)) {
 			char *trigger;
+			bool wake;
 
 			if (nmk_chip->edge_rising & BIT(offset))
 				trigger = "edge-rising";
@@ -978,10 +980,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 			else
 				trigger = "edge-undefined";
 
+			wake = !!(nmk_chip->real_wake & BIT(offset));
+
 			seq_printf(s, " irq-%d %s%s",
-				   irq, trigger,
-				   irqd_is_wakeup_set(&desc->irq_data)
-				   ? " wakeup" : "");
+				   irq, trigger, wake ? " wakeup" : "");
 		}
 	}
 	clk_disable(nmk_chip->clk);
