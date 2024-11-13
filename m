Return-Path: <linux-tip-commits+bounces-2847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A307D9C7A28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E459B23EEE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A416FF37;
	Wed, 13 Nov 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yfSRU36U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53O8wKGR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48513B298;
	Wed, 13 Nov 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516278; cv=none; b=m1n+EcqfF8aK0+yM5w+TBomDUGocx52TNje1djPXa6C70m/SoMkDtU7SH8yNvzgyNCv/73Q0vap7Juj1T2Qb0vZHzy9RdXpGIOsvGwDX5403DFPx7YeoyB9ikKnwA1k0SJ0J6JLlVmBjrAZtKoryP9fH4Shbpmkd6x21ZhogqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516278; c=relaxed/simple;
	bh=nGatbUgIMB8d8zwTcC5BOgt89BZ0fgXw+qqR6tDEBUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p/RjtJD3qqHbczOOlygxykEvJ8N+Z0BCURyumwcD3dnDJNO6GisP1nZPMpEKEywpTJy8UuqUxw5Gnl4udmM/veMJLPWeCSWLxoXFdKo8EKdYJdqcawzFCe2vxvUWk9oF4Zijdj9THQspGVQIJHLW7NkeclyJcOr9jpGbfINOSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yfSRU36U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=53O8wKGR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 16:44:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731516275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzdBUqAndhId5aYN5fAT+azeBxxqzlfXyiH2SyfjIoQ=;
	b=yfSRU36Unv2Zvsd8M6dEHThJe3tNpxJUeBebyCt/UgzI/3J4wD5pXyKDyJ2YnMcX/jvpYE
	ayk0pdtGeoXPooSAVQ0HwVo7omwZF1OWf20jK7LmmM/sW2Pp69z+gdh9nWO9nDr7xxfhGB
	9DvWW/bvD8E0XeE9zdRFH3I0VzYlTenPF3vadt9006I0W/NwOh6picp0DQ1YU+/+6xtXsC
	dQtnO9NSBCFOymS+Ee9bfPJ4PzrF2QOxlAeRLWxG9Beg16DWFJOIE05jSNkxMsjrX3al+X
	EuLw/aDxFb+N7TarZbGz1jbOGq0wqL7WmtgXf8uxVivPjrK8fHKrDyAPU61rRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731516275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzdBUqAndhId5aYN5fAT+azeBxxqzlfXyiH2SyfjIoQ=;
	b=53O8wKGRGAWVOHLHE3ZGNFYUrPetJr8v8Cv8czBcCB0xifyFkOUs3qYWoMeIZnXKycYfx9
	rYPKOenTpwZGQhDA==
From: "tip-bot2 for David Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/proc: Use seq_put_decimal_ull_width() for
 decimal values
Cc: David Wang <00107082@163.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241108160717.9547-1-00107082@163.com>
References: <20241108160717.9547-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173151627402.32228.16251188627102840898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f9ed1f7c2e26fcd19781774e310a6236d7525c11
Gitweb:        https://git.kernel.org/tip/f9ed1f7c2e26fcd19781774e310a6236d7525c11
Author:        David Wang <00107082@163.com>
AuthorDate:    Sat, 09 Nov 2024 00:07:17 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Nov 2024 17:36:35 +01:00

genirq/proc: Use seq_put_decimal_ull_width() for decimal values

seq_printf() is more expensive than seq_put_decimal_ull_width() due to the
format string parsing costs.

Profiling on a x86 8-core system indicates seq_printf() takes ~47% samples
of show_interrupts(). Replacing it with seq_put_decimal_ull_width() yields
almost 30% performance gain.

[ tglx: Massaged changelog and fixed up coding style ]

Signed-off-by: David Wang <00107082@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241108160717.9547-1-00107082@163.com

---
 kernel/irq/proc.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index d226282..f36c33b 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -495,9 +495,12 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
 
-	seq_printf(p, "%*d: ", prec, i);
-	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
+	seq_printf(p, "%*d:", prec, i);
+	for_each_online_cpu(j) {
+		unsigned int cnt = desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0;
+
+		seq_put_decimal_ull_width(p, " ", cnt, 10);
+	}
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {

