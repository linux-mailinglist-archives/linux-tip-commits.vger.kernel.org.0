Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AAE80AEAE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB81C20B96
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA857889;
	Fri,  8 Dec 2023 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/XFm9E0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="My/rc/L7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF46BA;
	Fri,  8 Dec 2023 13:14:45 -0800 (PST)
Date: Fri, 08 Dec 2023 21:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702070084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htEkvLlrJuTJNOJpdgf6DdbIhnF78QDdoh9RBqL2+Jk=;
	b=w/XFm9E0Qjo+8P8ojiJsmE/uWOqb8RfRLTDnfqKhKt/R+oBr8xJbjUsEApUSEdYeAZZgVa
	RadY8xKih/0IjuPGklsNOr6a+Wd9pDkTGZ9P43vi1ZlthL5f6BXlmGsnTZpUL95pXayAJL
	bwkOqx5+8Qt1Q0K78a/UAWeIQIKgopTOQeolFlrOboIoQEt0F4ZHEBDEx9L2GQy1MvBMCp
	XfK1r1Ir+LgNHYQ5gJSWnxVGNJPAXp12EAZxNfNZfZDg4gKVv//IcRjH0Z2Vw+lWGucsQX
	6SQViuE3xqYgti/ZVXswbfFlQtbOnW9VzI4aHK3E+WMA1qhQwCQC1FEBzsE2+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702070084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htEkvLlrJuTJNOJpdgf6DdbIhnF78QDdoh9RBqL2+Jk=;
	b=My/rc/L7Puzd80zHisdlbKff9AdNA/YqEz7hHxRnO7fmUJd4G/4EdSRjoDkBdYSgDaAp2R
	u2/Zlh/pRlsn4wBA==
From: "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Use tabs instead of spaces
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170207008390.398.1954973112060051009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     663b1d8debac386b5cbcc1d65b92bbef6b9c9cc0
Gitweb:        https://git.kernel.org/tip/663b1d8debac386b5cbcc1d65b92bbef6b9c9cc0
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00

irqchip/renesas-rzg2l: Use tabs instead of spaces

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros to align with coding style
requirements described in Documentation/process/coding-style.rst,
"Indentation" chapter.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516..cc42cbd 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -53,8 +53,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;

