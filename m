Return-Path: <linux-tip-commits+bounces-6436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7DB4249B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C0C189D3FC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96831A56C;
	Wed,  3 Sep 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRbpyb/0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Wreew29"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A431354F;
	Wed,  3 Sep 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912354; cv=none; b=MVjETHx+MwQWP4RZCl7tb0hW9dH9Qzsx7d8KqEvIPpEXBls8gHK1XjreHXIrLcPLUQ214Jvh6aRBO9tgSgJ17InCx4SzftjtL3skPSE+MLAIiQ//y/1z9bRUfuH+2/0CRpulEwpyW1c1yQGgQA6RsIlaYrW6rrG4UpEwRwnKd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912354; c=relaxed/simple;
	bh=GPHmmVLF8BvpIW10xeMP7KYKiBdEEXnW3U/+BjM6P4A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FPpDPAmNEV08lKYjL9H/SorFI0RNlh0DjLJiZRKGXwZyxIxE7tFiV7QyQiy4+uIv/1GXYebtYaHHLgvRcLCBRIp30LAKLGRAYu/rQkcrbDe+I7BfVY/6uWGj9hWwWF2veIBuiNWdRGOGYeebqVt3CTawevEu0hVcZqj4CVjLIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRbpyb/0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Wreew29; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYzDQNR1K0GCN9DPuBc+1Qc78qFuo/FtGbaOwsbpdn0=;
	b=VRbpyb/0nRA1cVp3tWE/yBG/1+8HgNmmjd9MCZ2QXJCEHjlpklLE0vLpQ1Bh8uDK4F8QeH
	tzDn4J5DjRPXA2Qd8pYmwSxopTidiG0hIIZJeOPXSKQykqpuI8zpiDqfVMW/NVMsoayaNM
	Nzqn2dkAcVp0uSmgsVRdoYW/3zvZVSl3SeDZjg95oEfAqCej7JUkY2axOgeeKFGLf0N5Dy
	61Pr9l9IrVCEdQNKdlCjy3UJfrzHuciMBbP9ZyhNnUOtIP+WoSGgYOKw9ObftjJUWo4+LG
	3TXhxw5Svwn36A0S+wwEqS0uyHIVaDwmQAzOQ/w+dkfNuDqOVWf2bGKKcFG7KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYzDQNR1K0GCN9DPuBc+1Qc78qFuo/FtGbaOwsbpdn0=;
	b=/Wreew29GHFimw0spt3PjQRBxjIJnrQ3Vnnd06O5k06Lbpk0YJPv/HMZLrXR/JpE9f4mjB
	XyulmPrXxfRa6PCg==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Depend on SPARSE_IRQ
Cc: Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-5-briannorris@chromium.org>
References: <20250822190140.2154646-5-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691234916.1920.4451339008631967133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0c888bc86d672e551ce5c58b891c8b44f8967643
Gitweb:        https://git.kernel.org/tip/0c888bc86d672e551ce5c58b891c8b44f89=
67643
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Depend on SPARSE_IRQ

Some architectures have a static interrupt layout, with a limited number of
interrupts. Without SPARSE_IRQ, the test may not be able to allocate any
fake interrupts, and the test will fail. (This occurs on ARCH=3Dm68k, for
example.)

Additionally, managed-affinity is only supported with CONFIG_SPARSE_IRQ=3Dy,
so irq_shutdown_depth_test() and irq_cpuhotplug_test() would fail without
it.

Add a 'SPARSE_IRQ' dependency to avoid these problems.

Many architectures 'select SPARSE_IRQ', so this is easy to miss.

Notably, this also excludes ARCH=3Dum from running any of these tests, even
though some of them might work.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-5-briannorris@chromi=
um.org

---
 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 8bc4de3..1b4254d 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -143,6 +143,7 @@ config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=3Dy
+	depends on SPARSE_IRQ
 	default KUNIT_ALL_TESTS
 	select IRQ_DOMAIN
 	imply SMP

