Return-Path: <linux-tip-commits+bounces-2489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7F9A135A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B11F22C25
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292A21C17D;
	Wed, 16 Oct 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrmAyZgE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3rupINp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9E21C164;
	Wed, 16 Oct 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109071; cv=none; b=sDTQaQDW9i89wzZJCq4RJliNzJ+vnfHHwffHUUr+ZlUYWs0DwLSTHVtqc/r46SyuYkL+aZHCLN8g0g12n7q5w+bTPivmHMiRayR6dq8u0SV7ObEwLe2erx0UnUPs4uzQJhDhkyspjoy8JRuIpZ0Y3B6qhXCHlLsI8iZiYiT64EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109071; c=relaxed/simple;
	bh=ttEBIz3T/l/XGDjWsBYvZ92ArxchGvidyjEhqbEt/7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RzPslw4sWw7/Y/nhQPOuV2WZN1Vd0pDMJwuOQHlbuAf+WVPrkAgH70zSIxgHC2dACtH3ozhwY+Vbv4iupj0ztGdVyCJAPgDb/DtJn2jQkEHWl3AdCzdksDPwxIIsYhhsRcrAy/q+b7vCV+vM9TJTbHQL9hhrwoRKVKuVk6LFZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrmAyZgE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3rupINp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhgldf8gZAF2DiV1KnVUZQ8J7D2sHPX3kq6tT2hdCX4=;
	b=TrmAyZgEri3C+y0cdi000VfhLu6++QIprv+4oZDoQfUreYMCOlF0ZPKSOSQJdf70W0xf0i
	pa0iQpOAeWgBQ7J5LcNQqgmDfYkhkIqB1TNrftJ6CZr2AFB1B8MEjpgsvb6kJufnC3IYVt
	PPB90pREAqDquE5JXfaryNdeilshi7GWzbDGwSBMEyfnF5CHM7i17/A8K8bB34KoQ8jVVv
	G3x7SQ+dhS4AQTTWvAXMoBztt8UW6HoOkFXKB/UeEj4E6tRglHzZ9DUjpEBvo6Lm0O1cFI
	6o0LruBEJF2Pu4eIBb5lMzLLNhRPZlwNZpiy74Asg2iqfIb46mHbb+rmh1mjxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhgldf8gZAF2DiV1KnVUZQ8J7D2sHPX3kq6tT2hdCX4=;
	b=i3rupINpj0Sq679Ar9DeOugm22aAAO1fTympHW+3t78VfwDQ36HhfYRM295ISUoiTxC7Q5
	76TPyy4+ygngvmDg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] LoongArch: Switch to irq_set_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-4-bvanassche@acm.org>
References: <20241015190953.1266194-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906757.1442.11206646689857832013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f90ff314a92f2eee5c00590a17e99f7f8bd7a32d
Gitweb:        https://git.kernel.org/tip/f90ff314a92f2eee5c00590a17e99f7f8bd7a32d
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:34 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:56 +02:00

LoongArch: Switch to irq_set_nr_irqs()

Use the irq_set_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-4-bvanassche@acm.org

---
 arch/loongarch/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index d129039..80946ca 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -92,9 +92,9 @@ int __init arch_probe_nr_irqs(void)
 	int nr_io_pics = bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
 
 	if (!cpu_has_avecint)
-		nr_irqs = (64 + NR_VECTORS * nr_io_pics);
+		irq_set_nr_irqs(64 + NR_VECTORS * nr_io_pics);
 	else
-		nr_irqs = (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+		irq_set_nr_irqs(64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
 
 	return NR_IRQS_LEGACY;
 }

