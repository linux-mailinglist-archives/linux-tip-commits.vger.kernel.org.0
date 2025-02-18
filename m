Return-Path: <linux-tip-commits+bounces-3397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99241A39664
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475A17A1D77
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E3231CB9;
	Tue, 18 Feb 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNR5OH87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntt86Lsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822622D4E9;
	Tue, 18 Feb 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869438; cv=none; b=J5Dvi2qPDrQs0MzUhSzzaxqGZ+60Wx7BxFUoIu/r0QvdIvjsXDBoh39NYtLHmZIC19YcXKyDdoYhDYW+mBhVmU+mWR+5pwlAeSMGAgWmjqgCwXJCxfIz9cvi2XB55PpdanOJvdKGqAElAhilil5+RV8umSh8Vpky1plrbuPmdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869438; c=relaxed/simple;
	bh=OhGgopD8UcgrRAAlKfX8UsrmN+XEITghrcnpLsrIWUc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HepUx/WPNG48eWbUstJ5uZSevwq949aSWlyL8oDZlt9b3+EdTHHIVcUYmxx3OQfgv0rzJ9OjvxXUvq19CSNVdLxMelP1nFQl6etZ+bcl87q5RfZ3DhGEaxe/DSejbzpDsXtMMMcYCFsKQqMnLkRIoyAZsky5RxVIMKPdiKihb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNR5OH87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntt86Lsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:03:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odqM1eje+C7yJYPWAZCGNApFzPHDP7os21AL9LuILW0=;
	b=YNR5OH87oPh0QZxukMXpTzIAS0xbU2hznaZlmOd/dYzDjT71QdQUzX+pg9A0yxL36YGH0H
	BrpX2tC+jInFDmwi9jD670t6mFmwUVbeciPIpEu9Oi5aaFjFxKttAemudkm+qWJLNRI0Bi
	oqt/b++HT6mI3mzuIKw2jfEOUH4Vr3bBWGignwV493jAKel6N5PtZIIWdJECUSnxT2iJIv
	iXfphcuY+MBtoABI5RezPxNQt4jZ+UjmDVXK3j/NxpKtx/Bdlbf6pjVC9wFkU+QK9St+1y
	oiNV6xWqXwjFTweYINn+kGpVn/qmfKO15CeZZWI8xQxdLOU/baD5k+NMsgJk3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odqM1eje+C7yJYPWAZCGNApFzPHDP7os21AL9LuILW0=;
	b=ntt86Lsn84fJ7PsmbzSK6ECDOtgz51jW7OgwNXX63euetay8ZIqMjmqpvJcUM+ru4UJE8X
	F5QCm7FKYh4FFuBQ==
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
Message-ID: <173986943482.10177.16197758003555178082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     213ea5f92da586fe137dfa55004ed0f7706cfae5
Gitweb:        https://git.kernel.org/tip/213ea5f92da586fe137dfa55004ed0f7706cfae5
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:52 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:51:01 +01:00

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

