Return-Path: <linux-tip-commits+bounces-1657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6C92D661
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA5A1C20FED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F4198E9A;
	Wed, 10 Jul 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBp3J+9t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWpIFGTJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA4198A29;
	Wed, 10 Jul 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628755; cv=none; b=lgzKq0puhatitLhxevEqYApwGbE0FsxdJ5dA08OBj0KX9VfYsvIIBk+6pOKLe+gGQgnBZ03dk+vdfLYCZCH1MUe9ocf8EppOBcMLQR10BkpAXtz1Amgmo6pULzaKr35RUTRsfLrWQ14FngcHnrJZsD2AgYqc2KsGg4I/zJ0T+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628755; c=relaxed/simple;
	bh=412zqoXaZRGt9imTb61YH76Yujv48NDtC+GPZOQBXEE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LQHv6JWyOwmrMHYpoIRwLSoBD59M19VT/oBb3Byf63ToR1SrgOJwRwnonZl8LZfor2+k6kUzLSQTi7E77kZoxpK0AxKnknclGEqKdnx7Vi0ds7s66Z6e88Y+kPWuk6v8jj6EmFDaPybpiM1rCjCtF7yZnfgDJI1dFIKBlcXLeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBp3J+9t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWpIFGTJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp8tWW8Zs+QVr2Au65yb5YwLCuszX1RwVGt/+5ceMUE=;
	b=GBp3J+9tm3LbeH+8gnXdMIZxkevGkGGgI6WIQjRMYlt2T0137cSLapz4END0qe8paADZ/h
	YKtwVm1CePGsDjMqCMOakBZFeM/FQkjNNs6FiuFEDkufiTuSZ06h08A0jpEj9aKTpGjZ/h
	kAprOYdCfD6VU21dL7KdZtqrPIxDkYBp7U8+crozeUtmxUUqcZERrP1Q0tVKsjbJEq60Op
	eqVPV69edThH5UOXJR092aWSKegINXfVms2RxFvPx43F7zfWRHAJ8yFdY5c5XNQMrUFAIL
	JkuX5VpFVgUvQIEjCzuTpmyo/D1cbAHdRQfGtNihDDxMy18NOqLKJR3+WfZ4Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp8tWW8Zs+QVr2Au65yb5YwLCuszX1RwVGt/+5ceMUE=;
	b=CWpIFGTJFfH2xbBE2YgBTrC0ZZm57vVUL780c8m9bTQOjxHHCFCCX67qFiQgBvQlMrPEQa
	0QwcY5i384VNK+CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/msi: Remove platform_msi_create_device_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.395577449@linutronix.de>
References: <20240623142235.395577449@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875147.2215.12875205380569454030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     808d004f0784dd5706bf725cadd7193cc1e4a442
Gitweb:        https://git.kernel.org/tip/808d004f0784dd5706bf725cadd7193cc1e4a442
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

genirq/msi: Remove platform_msi_create_device_domain()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.395577449@linutronix.de



---
 include/linux/msi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 04f33e7..4ae036d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -660,8 +660,6 @@ __platform_msi_create_device_domain(struct device *dev,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
 
-#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
-	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 

