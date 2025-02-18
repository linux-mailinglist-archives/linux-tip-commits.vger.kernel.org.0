Return-Path: <linux-tip-commits+bounces-3386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973AA394CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11127173073
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427522B8B0;
	Tue, 18 Feb 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOui4oPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzxTzOAj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0F22A80D;
	Tue, 18 Feb 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866427; cv=none; b=W1p6VKzPwSjIANGQuWHbFBTw6B0qIREh0joFNkWUK52Ec6vWwz4WCTkJwJkMflPQoxMhtxxTvOhsa4ArWfRMWvpS/n3idNaWXfL3TAACJElcHtAbxXUgsDAN9ewKsdiHrm9cjZ7W832uJlhwKhErPWLY/dw2Rw24dq1bHl5gN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866427; c=relaxed/simple;
	bh=XX59XHNMZANEAMnIXAPPgxWnmxZyjLh6EQoi6Ps5DmM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TyHD7ftCE+eLgTa9o+pY5VfXec4uGoATxsYPhUOiES3CZ138sBd5aS9CgPhEDRAfvYV/gqe/hC7E9tuq/sHmkUxdHbU3B0WblXf55PeOTuWh9wkhXrshJNkKBpWkHluPOsFOgNSIkKrMtSB057Y4XL7jAiWYS11IIm3BgHq6L74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOui4oPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzxTzOAj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVyQHqcPHfDSI31GoGIRcnN6SKVk8UHe/OJ45mh+J2g=;
	b=iOui4oPPrhE/1b0TdPkZIpGTmMNvagrBz5y3ST2Hm9hkWzQDYx5BXwVKYqExS+ZAsG+rSC
	L9Fly29xNkzHu6AyGOC3eCA5qMyvZ3cek7r+0p34bOF1oVA8eZ27X+zkU0zcvcawIA2hoc
	y3JMoHWvBLu92CvxFyzMwaMx+1DMT/OjYz/KU7QkH48d11MJdHlYguVciMJNWw36qnDTao
	BSlvxRWkY6zI0owJbZIcqbbI4s5B3f6I42asBcz9PYmhgWrjSi2kyORLCQcbjskxtGgY2L
	AvIepfiy3Os85KAzekuYDMwY+bAO6mE3YzU4UI86fiHmTo46sYn63Hvo5VyxUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVyQHqcPHfDSI31GoGIRcnN6SKVk8UHe/OJ45mh+J2g=;
	b=bzxTzOAjdyXlcRXOleDl7aM2miKC8axF3KPB02jAqrhSmD5J0SrGXdgSr6AKndAqH87gsn
	Rb+SrL43/5ATj/Dg==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Simplify checks in
 rzg2l_irqc_common_init()
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-7-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-7-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642107.10177.18133877504141715477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     0699e578e27910224ee09a55b824e5d494ce280f
Gitweb:        https://git.kernel.org/tip/0699e578e27910224ee09a55b824e5d494ce280f
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:34 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:52 +01:00

irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()

Both devm_pm_runtime_enable() and pm_runtime_resume_and_get()
return 0 or a negative error code.

Simplify the checks done with their respective return values
accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250212182034.366167-7-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 8714e7f..6a2e41f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -565,11 +565,11 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	}
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", ret);
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);

