Return-Path: <linux-tip-commits+bounces-1983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1094AE0E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB19B24600
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C713E02E;
	Wed,  7 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtEFaSYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fq6243pn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E913C9CF;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047933; cv=none; b=Kfmg4g3Wo3z0EjfH9Bwyydtt/KyHTxbYigphjqyHCjtiH1Keccw9mqlhnZANWZ9MVfPNxFPV28d8k59qEupSVRZjT4PXU61TC/9XLBJ0y4V1fiyLyYDokbtB+DrSfOZYd1627ylkBUYA+dUWkK7oWzKsTN4/YXBNZa7GXOi35yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047933; c=relaxed/simple;
	bh=pr9fOaDbzWmkowfOPI5TOox1x7kj27tP+dVxeREBpho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ot4ueRTHalSJe2xztv+LHrohYvAut9BtR2ArtOk1L6ixgmpnz44Bg0ig2ISMt1G5S/NA9T+DT2pMdIFOil5mNKOtDpzGNytVx2ITwdFeuibiH7TWRJlHSAGC+9RUJhLln4DJxOsjPlw+FMHXawqmBhpfTnTSq/tOd4W6FY0fBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtEFaSYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fq6243pn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em/5ikolP+qtanF0jxFP/Y4LxUuQKNvs0DsxSo/vieQ=;
	b=AtEFaSYk9CBOvHVfCI3igf0Y174IKCQQevv+ZmFEk0D2Ar/8KeMuEKm6m0ABaOvjDzMH2x
	qnxJ8+9Ji+CwksiD+/JxCb4gptEYSXYaBgIF6n0NgmKDaANGjUegaSHIEA1F01piwNmb6B
	GfFdkDAxSeOaLwfArglKMcq+DvGgnF1zAuGlwqBy4CtDalN9RfFWdTnX5EW1fJvs7Rbuh+
	MdjY/tCwCTCB0CRB7Aaf0qAzkLEfLfMdNAxz7gPxMJ+SO5wfzDPKA2adBeqAQUeGfYjGIf
	BO7N4v5koqV5+qIkmoLz0gM6K9Qkws/lDrPBK08Yan1f6rZRIYPcALAGqLrrvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em/5ikolP+qtanF0jxFP/Y4LxUuQKNvs0DsxSo/vieQ=;
	b=Fq6243pnbTl1jDxPo9SaQohilqtsGbhEaC+4ExImuyf5mPOGvbNZAMmqwpXMpZpBB711+Y
	dTDYmu6TXN+eHqAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Mark mp_alloc_timer_irq() __init
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.339321108@linutronix.de>
References: <20240802155440.339321108@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304793008.2215.15558011168489822601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6daceb891d5fd8729f9b4453b35d3d47dab10914
Gitweb:        https://git.kernel.org/tip/6daceb891d5fd8729f9b4453b35d3d47dab10914
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:27 +02:00

x86/ioapic: Mark mp_alloc_timer_irq() __init

Only invoked from check_timer() which is __init too. Cleanup the variable
declaration while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.339321108@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d1ec1dc..30a3af2 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2122,10 +2122,10 @@ static int __init disable_timer_pin_setup(char *arg)
 }
 early_param("disable_timer_pin_1", disable_timer_pin_setup);
 
-static int mp_alloc_timer_irq(int ioapic, int pin)
+static int __init mp_alloc_timer_irq(int ioapic, int pin)
 {
-	int irq = -1;
 	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
+	int irq = -1;
 
 	if (domain) {
 		struct irq_alloc_info info;

