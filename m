Return-Path: <linux-tip-commits+bounces-2473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D79A1331
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF07B2345A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44292170D1;
	Wed, 16 Oct 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o0sRk7Eu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xU7FL73b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23428210C2F;
	Wed, 16 Oct 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109051; cv=none; b=ivCsRPIg3gecRhwK4mHVl2JBeQNd5aawNryvzwNl++5kgQzuon1YZSsZIHtzfqmwAPa9Bg4s84CWFEc5l4525zjzc1PUqHceUaOJvraSy4VRZU8sa1kvWfiXqnXyuNumbmbg+IkNHS8a2iyOYDrT7y993llQkA78vTAOKcaK4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109051; c=relaxed/simple;
	bh=g3M3btuMYkE/oBjSQ6krVLuO76oACCMUqtJ/qf0dfEk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pyy7zlxm1fKpIbbxSZD97UONIc7AxICAy/e74DgNDyaU+z/A7EgJQOWcqUHfhjctAlPUTD9Mzh2MICVtQf5JPnw25mYCx71lookC7kcS4n7DDN06lmQw5SM9kiFYYf6F/ThnCXu4/TzOfjvgGzRCokDugpaccRrkg2xnRngdcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o0sRk7Eu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xU7FL73b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/0VuEQ1jxsfKNXYGjc/XrZ2QOOsAAgDtpXHGUskUyE=;
	b=o0sRk7EuCfKKW6bJj/W4XQkS7LjO+5gZ1p+0jj4tSSHf7oGIkRaWk7mlpVdRvUxRNXwpMT
	RqJBFzV8T3pIwT5rCj9PDPiJ5STmE5WVYGV4SIJ/N/L8y+tYpLi/KHZj/zHAJuWtA7uFa3
	uUos9RfJxdb0v765DeZ/m5nqjblL8kkhXezHprytZhrzK1aORQdsUqLrqqr2uZ7CSKPKyc
	yE21UxXOZhjgopxxwGDOFX9Y1XKD8kOrTUDF7RxcAUdvoqHxfC0DuCh+4mdQ7H0V5/ON8/
	Ax+bR1aIC/WiL+FnZuDwyRxGa90wTUSxH252tUZldlufuKk++mQifYMDewcjOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/0VuEQ1jxsfKNXYGjc/XrZ2QOOsAAgDtpXHGUskUyE=;
	b=xU7FL73b/RytQaohl5Df3FhvWdPf669bmX3N7jPVjyek9cuXexMFgiBlUSQwAIbDTTeQdV
	Knh7bVY4tlqG9rBg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] xen/events: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-20-bvanassche@acm.org>
References: <20241015190953.1266194-20-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910904737.1442.9515827309145204947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3e48fa2ecf4de8baf8a368987f8ea8ffb64ac7af
Gitweb:        https://git.kernel.org/tip/3e48fa2ecf4de8baf8a368987f8ea8ffb64ac7af
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:50 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:59 +02:00

xen/events: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-20-bvanassche@acm.org

---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 81effbd..985e155 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -411,7 +411,7 @@ static evtchn_port_t evtchn_from_irq(unsigned int irq)
 {
 	const struct irq_info *info = NULL;
 
-	if (likely(irq < nr_irqs))
+	if (likely(irq < irq_get_nr_irqs()))
 		info = info_for_irq(irq);
 	if (!info)
 		return 0;

