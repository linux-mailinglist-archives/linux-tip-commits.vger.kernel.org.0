Return-Path: <linux-tip-commits+bounces-6988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73765C0564D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 185BB4E7035
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF630BF7E;
	Fri, 24 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEqtNiAg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuyNgfMw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90430BF64;
	Fri, 24 Oct 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299094; cv=none; b=To6IdyLQtlQBJ+udnIBpnByr2Yfg5VFFbMZ2LmjbHgh34L+paS901G72srdJIlh+GuLIEFQvPH/75L9uaZkqoh38KcZHen6RiayPWKKBPsD4Ar7vpuJFggChT2d/NDscaQdYuMSkaBAehuRrUSynKlYxmGroxTphueP9jvghu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299094; c=relaxed/simple;
	bh=/2HRTFh2VM5YW/xSRMuiW0yfeOgMt3QGvQ6iF68F4+M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pWslEUGzzPQcj8WUstJLRw8opEjacmCaBI6d8tiaz6Mjj21mUooLDVE3FCyc93JkFsjtxDiycFP1c0VZ570PV6bK1o4RFdaBrkBzw6+/kbJN3EUchlgzVdnfpbEvsyBW8VaoFYX8CHzRvJZnNRBzqTr64JPWR+gjgSWUTWcWtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XEqtNiAg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuyNgfMw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 09:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761299091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJdS0dDLofa3GlcxsYCcaSbp/BJwXVNV7qhRt12qEBc=;
	b=XEqtNiAgY7jVkByuhnL2VwJYUllkqfRy5EluhiCIKXIinx6Cqw0iniN2ZAdckkgNL1P0+L
	o0jtLquUzH3ft5hKnjRE4g7Sg5vPvi/LLG/Uc7xs8KjQ2wD6dJTj6Byd1mgysysF2eIl4k
	ImXrhKPrUjUtqH8ECQcgCjOImy17InKfJG7BGsADHGXLZpktSw01f5Rj/GZt3YgIYUPDh4
	KSiIbJvsHIF6GkoTVz1lO+dN/JH4VzMPYHMblc5dFedtWZ6k7w0BqnDTLgkznVEaYAy5Eg
	ni1MkpWrLIxRlpZx1I0McE6R+xLV5fIUE0g9C3nj974MXBsoJKamJELRPCgLuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761299091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJdS0dDLofa3GlcxsYCcaSbp/BJwXVNV7qhRt12qEBc=;
	b=SuyNgfMwYEonPxH9QKVk2Hpw5YXD0rcY/Lxa7R+bwR1l3VbccVqY6to+yEzkw19Kse25Gw
	53eNJWwKLqBMYCBA==
From: "tip-bot2 for Charles Keepax" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/manage: Add buslock back in to
 __disable_irq_nosync()
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251023154901.1333755-3-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-3-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176129909038.2601451.751277171615788851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     56363e25f79fe83e63039c5595b8cd9814173d37
Gitweb:        https://git.kernel.org/tip/56363e25f79fe83e63039c5595b8cd98141=
73d37
Author:        Charles Keepax <ckeepax@opensource.cirrus.com>
AuthorDate:    Thu, 23 Oct 2025 16:49:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 11:38:39 +02:00

genirq/manage: Add buslock back in to __disable_irq_nosync()

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: 1b7444446724 ("genirq/manage: Rework __disable_irq_nosync()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251023154901.1333755-3-ckeepax@opensource.ci=
rrus.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c948373..7d68fb5 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -659,7 +659,7 @@ void __disable_irq(struct irq_desc *desc)
=20
 static int __disable_irq_nosync(unsigned int irq)
 {
-	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		__disable_irq(scoped_irqdesc);
 		return 0;
 	}

