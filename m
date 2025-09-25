Return-Path: <linux-tip-commits+bounces-6764-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD4BA19C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BB01C24B81
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9132F486;
	Thu, 25 Sep 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpqP+904";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qPEEXj2T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77A32ED5D;
	Thu, 25 Sep 2025 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836032; cv=none; b=U9usBg7fRjLF40/lrr4N05XKKxSxLEikdRoNRzGPCU7NqTadTEpTJaL3IyDaOtwP4n4xdBXSCsqruRIyMerty6hn0ho66uHm+35pdn3cBIf3MLT8V71EavoEhat1ubpGgIhekZ4KPd3OgnKKWASYJ73dOUqV+a+7MeXO2xiWqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836032; c=relaxed/simple;
	bh=RmNDZ+JVhAb4njrt3xy3m7ZPBpu3qGC9wtCF0/ZrUqA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=S1Z+DKhv69u01LVwymGhemtQSZAWRVzgA9TsvWLRv3NkMhBPToAVYNM5VnO947x3+knX5BITBQFkVqT2iTx/vwY/QMAupPz76xISv6sBiFVsjFHgXZhiPA5WJDgv3YuINHILnT3uuShdyg+T1dtlVEa7/j8Uh6wK0sajaIP3Us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpqP+904; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qPEEXj2T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RnF97kFBqmz4qizA/N7yZFhXP1YDr25rsr2b/F4yUW0=;
	b=IpqP+904FJG/Xw9k6T/PwgaJb0BxXuEJq4veXg6kqD0jCXOWzLBCshhlorc1WtPX3IaWYB
	VRk1EfU2eepUIAENmouZxUwaVUQa1qKEUK5hFSONd+0R3GsnHxmEqXFUZ+ySrAqDvYqECg
	5JwqJSkSMDqXAXSpMd35bJ+hLw4F9b1sDAyL1EF4kMzo+U9yRS9pPpaOJCEpurAZMCsFiZ
	eExHcVj0FSxKWwYDaCQmtCOp9eqr8z58tEZGOsXU+6qYfo4WvGOr0GkdoMvbOd4RvAcZM3
	L1oAlJaWIb8rMUELJX7wnwe29DLKlHJkV/86Ta/eiw3o8eA0cXQ/ckIhMmL7jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RnF97kFBqmz4qizA/N7yZFhXP1YDr25rsr2b/F4yUW0=;
	b=qPEEXj2TyCasO0g58HFhuzvaXMsTgiL5doEsDkXAVz6kZUV28drHhA+xGJ7xgCGEFhjw+X
	NdBBaZNhBU20sUBQ==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] of/irq: Export of_irq_count for modules
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602773.709179.11309414470993255585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     be26ec8b1479a0bb1888ed93d7bb5ce4d8eaee1e
Gitweb:        https://git.kernel.org/tip/be26ec8b1479a0bb1888ed93d7bb5ce4d8e=
aee1e
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:04 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:53:53 +02:00

of/irq: Export of_irq_count for modules

Need to export `of_irq_count` in preparation for modularizing the Exynos
MCT driver which uses this API for setting up the timer IRQs.

Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane=
.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250620181719.1399856-2-willmcvicker@google.=
com
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 74aaea6..d2b6908 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -519,6 +519,7 @@ int of_irq_count(struct device_node *dev)
=20
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
=20
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info

