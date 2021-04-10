Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B535AD03
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Apr 2021 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhDJLjE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 10 Apr 2021 07:39:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJLjE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 10 Apr 2021 07:39:04 -0400
Date:   Sat, 10 Apr 2021 11:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618054728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcXVZPVdKBOJrax5a9I8AU6wSE3X7aCGEX9eVIitwZc=;
        b=qF8G422JnG7hWgJxxQcFDaNw8Kf3Do16tXYHNLaYWK2E/vRWCAHvUtvbW4bQk1Jhh4Zyco
        HkLhclC5nQAtY0eEgHq0LZhJYfGjXtduK9lo6Gm+TK3TFMQRqoEqxZx+EzvkCaaCc3nzWw
        nrVU+3mVro0TFA/a1rS12WS4TynUY8LgaVBHrYLuqvae10gVHmZPwCb3se/SnZcb5fFVmX
        AdIHrOFHqqSQAcOQ3699XfaqzfU3xRmhhWoOm2wHOzAjPYXWrXoqOgf9hGoiAZ84zLpGWP
        fMh4ovcpLQxz/kXpcnyXptuinoOO34IO43BKTdyTTelfqTVlF0jbVPktkwYzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618054728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcXVZPVdKBOJrax5a9I8AU6wSE3X7aCGEX9eVIitwZc=;
        b=Tnbf7y7TvAEw69+W9HJJcaHTFgWIY6sW2D6AZOX1G+4aiqAn33q5ucONQbVLurD6kRgNYF
        /BC1h9Vt1TSdoMDQ==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Reduce irqdebug cacheline bouncing
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210402132037.574661-1-npiggin@gmail.com>
References: <20210402132037.574661-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <161805472739.29796.12148662743360710895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7c07012eb1be8b4a95d3502fd30795849007a40e
Gitweb:        https://git.kernel.org/tip/7c07012eb1be8b4a95d3502fd3079584900=
7a40e
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Fri, 02 Apr 2021 23:20:37 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Apr 2021 13:35:54 +02:00

genirq: Reduce irqdebug cacheline bouncing

note_interrupt() increments desc->irq_count for each interrupt even for
percpu interrupt handlers, even when they are handled successfully. This
causes cacheline bouncing and limits scalability.

Instead of incrementing irq_count every time, only start incrementing it
after seeing an unhandled irq, which should avoid the cache line
bouncing in the common path.

This actually should give better consistency in handling misbehaving
irqs too, because instead of the first unhandled irq arriving at an
arbitrary point in the irq_count cycle, its arrival will begin the
irq_count cycle.

C=C3=A9dric reports the result of his IPI throughput test:

               Millions of IPIs/s
 -----------   --------------------------------------
               upstream   upstream   patched
 chips  cpus   default    noirqdebug default (irqdebug)
 -----------   -----------------------------------------
 1      0-15     4.061      4.153      4.084
        0-31     7.937      8.186      8.158
        0-47    11.018     11.392     11.233
        0-63    11.460     13.907     14.022
 2      0-79     8.376     18.105     18.084
        0-95     7.338     22.101     22.266
        0-111    6.716     25.306     25.473
        0-127    6.223     27.814     28.029

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210402132037.574661-1-npiggin@gmail.com

---
 kernel/irq/spurious.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f..c481d84 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -403,6 +403,10 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t a=
ction_ret)
 			desc->irqs_unhandled -=3D ok;
 	}
=20
+	if (likely(!desc->irqs_unhandled))
+		return;
+
+	/* Now getting into unhandled irq detection */
 	desc->irq_count++;
 	if (likely(desc->irq_count < 100000))
 		return;
