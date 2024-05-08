Return-Path: <linux-tip-commits+bounces-1247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187768BFEB3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494CF1C22597
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6178C7F;
	Wed,  8 May 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzY6gdMP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGwkKn+u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DD26AFF;
	Wed,  8 May 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174761; cv=none; b=fZf7akGT1vDKzvThBUyANnJQUIvuMT8orq4TNJEsrRMP96VquWSZkCLlvz9Kx2ZWE0Jy0f/ylmKRpsdQJo2BgwgoH81y01JUNqEwDLek9YXnv0DeI4puzOCT8pjKr5l0M3x5zIQgfZRzsUnZ6lD9HxPbtsUss6vo6qcmNKUx3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174761; c=relaxed/simple;
	bh=JcTv18sDO3NgTJrLL5P7Kt3KYTRCy3pnv0msXUafur0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nP8CcsjkTlFtT655Le1De8vKSFBVCRPcj99Xmhw6A0v+CPjND8ehaoNK5LSclac8aLAUrJ2GWvYsffPmbYH6sjBSuiSs2fLczI4eo83P7SXW79h5Q6XLIRLuZT5TK4z+Byg4QqNZY1dJkW+Fvz0J+sP3awWk8IPsayM+CRmI+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzY6gdMP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGwkKn+u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 08 May 2024 13:25:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715174757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIzTXlk0BbMU/gkh1XIZNmB1y05fF1wLb5M1xoUXdBQ=;
	b=pzY6gdMPMKjsv9nH6jmWmGU1aAneZLyw98wm6tseUgxLhTXOk+FNDfn27OFpQzIQCEb85r
	f/Fn4NOZclap5O9zfhM6H1QGAOaDXINY61gW8y+F2aYWEXgZz7u1+XEIKGhywm2+v4adZs
	sTC7jI2n0jreZs9u08QpJ+BsH25gi48Swjvn/aRuYyX0C7FXAq+81q0eICiIzo/M7z1aMW
	El8+EwOK72XAhE+YBgi6qlJQ+EYAR2xB7Sp+CZy+GzuEYQChNVAVq0X/5jQTWUG4M3V6xQ
	tLp0F0TcXIAwLeZIGxaSrx881Nv1qrqeZ4D0ecThfBeG6G106zeJyXBR0FNB+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715174757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIzTXlk0BbMU/gkh1XIZNmB1y05fF1wLb5M1xoUXdBQ=;
	b=tGwkKn+un1vTqh3tF6H7pKJxpA1Ue9F7+bliVHcoIhjLdBF4WcsVt+DrrGceBr66f7CreO
	yZm/NQZT1HbywpCg==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Use existing helper for pending vector check
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Imran Khan <imran.f.khan@oracle.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240506175612.1141095-1-jacob.jun.pan@linux.intel.com>
References: <20240506175612.1141095-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171517475718.10875.16618789278156468301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     6ecc2e7932fe8f132d3b671685f9995785f19e9a
Gitweb:        https://git.kernel.org/tip/6ecc2e7932fe8f132d3b671685f9995785f19e9a
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Mon, 06 May 2024 10:56:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 08 May 2024 15:15:15 +02:00

x86/irq: Use existing helper for pending vector check

lapic_vector_set_in_irr() is already available, use it for checking
pending vectors at the local APIC. No functional change.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Imran Khan <imran.f.khan@oracle.com>
Link: https://lore.kernel.org/r/20240506175612.1141095-1-jacob.jun.pan@linux.intel.com

---
 arch/x86/include/asm/apic.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5644c39..467532b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -503,13 +503,7 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
 
 static inline bool is_vector_pending(unsigned int vector)
 {
-	unsigned int irr;
-
-	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-	if (irr  & (1 << (vector % 32)))
-		return true;
-
-	return pi_pending_this_cpu(vector);
+	return lapic_vector_set_in_irr(vector) || pi_pending_this_cpu(vector);
 }
 
 /*

