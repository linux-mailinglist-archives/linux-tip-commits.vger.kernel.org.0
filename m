Return-Path: <linux-tip-commits+bounces-3532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D0A3DCE1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7293AD4D0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9A1FCFD2;
	Thu, 20 Feb 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="So2IFaWG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9yUSSGeo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4E1FBE8F;
	Thu, 20 Feb 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061602; cv=none; b=kVPYlav2FT2pVo3hjqoMbSsWYSM1XX8/B0N4YIFmFzsL7AKpic5A4NOys6rREQU9LqFqY/omLwE9zRtMObeAQdIW4SanTXznWpVdfK/IzI45g9oe2KwPQPsz8GLsuSK5758rRdbYMrLtuClfhaKSWZDw/BMm1BP1WnI4lYZBz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061602; c=relaxed/simple;
	bh=xSR7wOJKQ7t7L3DxqWhdb72WWYMi+5BaOnOEpBLV2U0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MbqFJ+P7g1R9IrLikJSSjWqwuRZZHq5lECo2U55r0p6Zw+UIDCni1RJ6muq57xc25//7QwPTizFomnKxeLtgzpEFG/eelXZxxCyU4o4QkR29afcQMCeRDHBQpxuhjGHFmK9lQTeB3TUmtBpDNNZDrDe7Wy9NEmrwAKoyK7mQ/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=So2IFaWG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9yUSSGeo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 14:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/Yxf30aTNWQGszfGit1HFnuQ+z9cfsFEACEryZIT5k=;
	b=So2IFaWGSHgqB24NlfJxkJNCor4AJ7TXlFtLAyEx1T/wxrSkkcNw+jOmQjV2f9WTw8loFA
	MkE5tJtv1FLxUydIjYVeek5gce/H/xeaSMbvTU6JhHXYJqJBgPI03sS779iHySdjA21y7V
	uPSojR/sjz2JgaeSpc2GhdUbympLvdtN1DjHVViuZOzE4ltd6NumuIHUh+TB10QxFzu676
	YYjmUdOUBbP4RpY0SSx2SuVDU7u8BIYkPemPN3Vqvt2AbEyxCwsxGmtsmjMswcsOBXsqNz
	tuyjkS1sHIL+tvzHYIhT0/J45SYQ1kGZkfufayCUNHgxhx/dxRuBUsmkp7+2mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/Yxf30aTNWQGszfGit1HFnuQ+z9cfsFEACEryZIT5k=;
	b=9yUSSGeoXoBK2W4Fdj5zsA7raEvSJitNxdADeuSjGv1+J0wPEII5RxDl7z4BnE9XcmdN+2
	l1PMPntTQAZa8tAA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] RISC-V: Select CONFIG_GENERIC_PENDING_IRQ
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-7-apatel@ventanamicro.com>
References: <20250217085657.789309-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174006159898.10177.17952950927506614084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     58d868b67a9ac0db477f714939f21849db5f5178
Gitweb:        https://git.kernel.org/tip/58d868b67a9ac0db477f714939f21849db5f5178
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:52 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2025 15:19:26 +01:00

RISC-V: Select CONFIG_GENERIC_PENDING_IRQ

Enable CONFIG_GENERIC_PENDING_IRQ for RISC-V so that RISC-V interrupt chips
can support delayed interrupt mirgration in interrupt context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-7-apatel@ventanamicro.com

---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52..a32f397 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,6 +111,7 @@ config RISCV
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK

