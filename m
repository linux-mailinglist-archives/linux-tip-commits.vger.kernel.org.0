Return-Path: <linux-tip-commits+bounces-5496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B7AB0178
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46562188ECAB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25F28750E;
	Thu,  8 May 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwrKRFF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUKz3d07"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CD2868BD;
	Thu,  8 May 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725237; cv=none; b=XJH7jhGNERstY0BKI41G24weV3G4tTRWUjMkAu3G3pJFgrSYAP3D1r5XUKIpC4nXrqvNBFcK+tgzXzgRzrg5IA0fwzR/c9Wm8vXXXaKZF6J437Jv2FF4/kPZ1cDdQAPLa7IQB55m0REKvZOx2EGpWdXxZiqI1n9mVjgcijzTcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725237; c=relaxed/simple;
	bh=TUjYufyEWAdhKNy6b5AnC63HGaQKiq+g1O16VYOpcLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pqrOlymbwb7XC8eHItjLoAhkYeSl6fgqUIEY0tBBhKGcLvZKpaKWhSvn/YzEjbgadCXizKswDOrTJrPVMO6ubQoLEZLkFhvgWHJcx2uH9SYMZ/Ck//Ee0210h/8AMWUx5PSSucwnjv4ezgaUjNEFIcOCKGq+ktCy+OA2D/0OxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwrKRFF6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUKz3d07; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKAGGt1lCm2MoAITZlPlJwdFQyhFqCx8JhU7gXHohj0=;
	b=NwrKRFF6Ml0bs7GylkJSTd/Zx/FfproHqFBvJu6JDXjGUrTcLkj6R/MA2vnjRjDtG6V579
	QSKNdb1t01pJrLOW/51ot7d3hEdsj/xDfiEf2qFi6iwXs/dc8aITAIZxIi8nI7X0n93fQs
	X8q64ETVmKwvuRjpJLpJM7u5GAR5cwDTl83VfMicOtszurAiSjmnU2puTmaFWnTU5C9tNE
	H5Jb3r6JbUyapFnJzHu7AY9wuCJ1ipFy+xSWtsSwttvt3RhkPL0P3i0wSMpxnYt1Js0l7u
	i4hVXfuhnn+6+HHOLpvR8GAh6JbOpNB0/HTxFqK5bt6OtBX4A6TGXgjpmtlLBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKAGGt1lCm2MoAITZlPlJwdFQyhFqCx8JhU7gXHohj0=;
	b=uUKz3d07uVE9CPsR2SEcVfPbfzV0mpe2oEK6uMZaHGZuH5kapYUYQM1u4VN+LJVXUAkuqQ
	m6FrXMklwZx0ftCA==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Add msi_remove_device_irq_domain() in
 platform_device_msi_free_irqs_all()
Cc: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414-ep-msi-v18-1-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-1-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672523272.406.13475096235281643458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9a958e1fd40d6fae8c66385687a00ebd9575a7d2
Gitweb:        https://git.kernel.org/tip/9a958e1fd40d6fae8c66385687a00ebd9575a7d2
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Mon, 14 Apr 2025 14:30:55 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:49:00 +02:00

platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()

platform_device_msi_init_and_alloc_irqs() performs two tasks: allocating
the MSI domain for a platform device, and allocate a number of MSIs in that
domain.

platform_device_msi_free_irqs_all() only frees the MSIs, and leaves the MSI
domain alive.

Given that platform_device_msi_init_and_alloc_irqs() is the sole tool a
platform device has to allocate platform MSIs, it makes sense for
platform_device_msi_free_irqs_all() to teardown the MSI domain at the same
time as the MSIs.

This avoids warnings and unexpected behaviours when a driver repeatedly
allocates and frees MSIs.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250414-ep-msi-v18-1-f69b49917464@nxp.com
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0e60dd6..70db08f 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,5 +95,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);

