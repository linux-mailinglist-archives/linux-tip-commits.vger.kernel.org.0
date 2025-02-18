Return-Path: <linux-tip-commits+bounces-3491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352AA398FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFC3188C342
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE07263893;
	Tue, 18 Feb 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jwiavnpc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBS8DiYh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D82500DC;
	Tue, 18 Feb 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874405; cv=none; b=UHWXZMC3r6s5jQxd2ZWG+AQNj7XoqaCryYgsinmznCZfJQiIrlJpfmR9Qp+9rwNXqgrTJgKnCNDLmbck7422XpCNs5S4uIldckSHtG1v78386fu3gea3QFxnZOiDYGItDeyCe7qhAa1zdHdHRE05Bgn0GmdTBb/ayH017kvsWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874405; c=relaxed/simple;
	bh=JMhkV2KjTHwcSa4kVM7/nibeZQCGakkE3y4yA1KaaSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MxoTBQw36FVcybR3sbfIDj9zBCt0v6PCozrvQeuVnrFbgIXozsaR2uh67o+E251p6jqwjqVVAkDSbzm1U77OjF3A9wnhHZNygqirorb/fPb2Hm5ITKaiBIVLn7GGN7BjGidVeOl9usWnD1dRW0h3jKiviw3kJdE64gJ8TMwlXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jwiavnpc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBS8DiYh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz71nM8KStAqPl4ffv/CanQmUQtTxSNtucivjc7KKEk=;
	b=JwiavnpcnApQ7SXGWRbyECG9RE2mtouvLBx++Jh/hFALmB1SDZxUy+BVoS7QCOd0v3+J65
	VSgN+jgaaR2VG+BlCirbwHnNZAObqZdpnjJvOH4iCDnqaIWdQ3cY5gtdt4JGSYhAb5/RnQ
	dAqZ+O6sMpaAMn4Jy44H36/sS4JuyZ2MalRU3zZngdjTIIZrSqkpYx9qdTEPfbZRol9nN6
	yFZ0FbeYjzpuIk9FQ6pZIe5dwniUFFp0s/DqqDtEvNlX9RsHyWdjo8rVZllu+qXHT/vNdg
	t+oCawyIFA+y0UYQJ9DfhAApjcr22a7mKfnCO56Wrd3Pewz3wtfpyI3+/EAOtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz71nM8KStAqPl4ffv/CanQmUQtTxSNtucivjc7KKEk=;
	b=pBS8DiYhUFGLs7zrIbXVb05xTCo3jxKcPoE9tJsxQyqeeDzUj6gZXbqeRzCLQxdIGpOcbm
	NFL3sbr5A8NAPHBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] serial: sh-sci: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc21664d013015584aebbb6bb8cedd748182cb551=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc21664d013015584aebbb6bb8cedd748182cb551=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440137.10177.1436809314131153883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4e121496960342f3f2c2c563d65a3c08821ef7d7
Gitweb:        https://git.kernel.org/tip/4e121496960342f3f2c2c563d65a3c08821ef7d7
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

serial: sh-sci: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/c21664d013015584aebbb6bb8cedd748182cb551.1738746904.git.namcao@linutronix.de

---
 drivers/tty/serial/sh-sci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b1ea48f..b72c3bc 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1702,8 +1702,7 @@ static void sci_request_dma(struct uart_port *port)
 			dma += s->buf_len_rx;
 		}
 
-		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		s->rx_timer.function = sci_dma_rx_timer_fn;
+		hrtimer_setup(&s->rx_timer, sci_dma_rx_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 		s->chan_rx_saved = s->chan_rx = chan;
 

