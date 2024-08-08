Return-Path: <linux-tip-commits+bounces-2004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04194C0F1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3209B1F2294A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF65190489;
	Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0GRoiaU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVzcayA8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CA18F2CA;
	Thu,  8 Aug 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130505; cv=none; b=RHc5FI1VsJHdQbTaD2lR/20pIfe0cWsfojMTwsvAVjqRXBEj6xFBzGYbGb/bP6Rn+VExckXpce/LedT3Yc9Tt3CVUH3pX+YnMT1v1xD6LuVHLsBUUZfFC9BQ3HkaJfKe+7T82tJ1+bb5nzHtgXTGvXHM90KVPvBV5hLQ6Mw9Ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130505; c=relaxed/simple;
	bh=BjLsQ3L8rwBn8oLeiQjZquKDX2PcqXZcRVPTW1eFqc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tkqCgl8CrfMKzpSThZ5uaxADhWHCONOHSeWq8sm5z9AI5sEz42epPf5bKe2/Xr5kQV900vSnQ67UK7HiW7uIaZH68VFQ6ViStJeysNObULTi0GZnLEvjpOrlwRkTHKo9rYDZQ5E8K4SW5ByxlGL9AGcXO95DOYJ/+l7TpbqLS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0GRoiaU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVzcayA8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uULYZBwlNQSpLxzA0VrkJtgb8xF2tMjnj2r9LV3xpIk=;
	b=R0GRoiaUrCycu30PyXHHqmtFZB9KlrTvyWvtok6kdai5ik7zjYfqcED8qx37y1oi9H29Vf
	WcnOgMzMeKgb5XlxxapvnMLmCymSXHxqnsHIRqC0t8hOvGe1y8x3gKuKl7/04O1IgzKqJo
	GJPkrlJ4tqeXV+UOdZ8W5TIbrCzREfHq5yZgLz7jfC6Vkxo06jFJdNGRhqx5ecyyjuV7D2
	Jd2RYBrXqh0ln7FyB/gy7RTiAFs7+nTW4uzNHSXCMaCiTvRtH9xCLaWrdTRFPaWx3xNM0N
	mpdqtLiKw2Gia3Z+lL3jedxFlgsTRJmyA/yLXXeMSU8Tw6aSPpEcFFFIIZNLvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uULYZBwlNQSpLxzA0VrkJtgb8xF2tMjnj2r9LV3xpIk=;
	b=GVzcayA8pCZjDy0yKxJSbOTlxfBZwSJfJ8hyXpUvvq+JAwootk0uGep+I4CJaa/6n2aKdk
	uIRi4XMvu9fKi+BQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/irq_sim: Remove unused irq_sim_work_ctx:: Irq_base
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240808104118.430670-1-jirislaby@kernel.org>
References: <20240808104118.430670-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050140.2215.11113404153225912181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15e46124ec937bb0ab530634dce4550947f53133
Gitweb:        https://git.kernel.org/tip/15e46124ec937bb0ab530634dce4550947f53133
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Thu, 08 Aug 2024 12:41:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

genirq/irq_sim: Remove unused irq_sim_work_ctx:: Irq_base

Since commit 337cbeb2c13e ("genirq/irq_sim: Simplify the API"),
irq_sim_work_ctx::irq_base is unused. Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/all/20240808104118.430670-1-jirislaby@kernel.org

---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 3d4036d..1a3d483 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -13,7 +13,6 @@
 
 struct irq_sim_work_ctx {
 	struct irq_work		work;
-	int			irq_base;
 	unsigned int		irq_count;
 	unsigned long		*pending;
 	struct irq_domain	*domain;

