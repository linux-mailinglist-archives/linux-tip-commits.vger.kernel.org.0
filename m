Return-Path: <linux-tip-commits+bounces-4830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E8A84737
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 17:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A82188563C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54381192D96;
	Thu, 10 Apr 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubU1X742";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Io+k2/OP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCC1581E0;
	Thu, 10 Apr 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297069; cv=none; b=M+LPM3o0s5Q3pkCSsiXj27qhYHlnlaR24Z4slX8or0ICcIbm/PEHuP0XmxjneNuov79JkazFPDQDc5NWjoKBcKZzbCXlC+jDwG+wSk4dRYPdFRF7n6EyOxV1QHE+ZVbJcjfz/604HJg86z28KUTtIfCXNSyE+Buzn9Xkaig9XXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297069; c=relaxed/simple;
	bh=3eVNknEvMc0grzW+AbgfAUrPDeZV5fj+H41d0IF3b54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a4cE2nCUMBYXRbF04qNL7pdw1TCOStPTHEhePeaiTQs3fc9osAur33ymIUNaUL0a6rvOXC2FlyO93GLQkRXZ11+oyBLrVSR+iu/cfUJ9oAbghZbMQQzUMNOBeRJOehDqgCh5KcZIgce1yQ85qY3+KwF/gv+lgnDPBughRlV5j1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubU1X742; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Io+k2/OP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 14:57:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744297064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jozy5XY4hH1Y0FEwRg8ha4gBDVFMFA7xclkeqVWkI7k=;
	b=ubU1X742VBBqO/E3dXKapkgR79kC9vg4TzYuDPVvm8aMa5YXpHLFjecaJhX3RMQwUbTm4e
	LOdegQdGxu/IwK9D35RIx55p0+V1okz81/z2YcgGekWfYTTTd/pNOnlS0gfwYvcIhQbyAm
	aZEejYrgVLdvOzyZJEMESeEdRaP6fW/6DfHaTMkBQOyCuolZxOelA3FmQ8yyvhMrltTYYh
	zzLynhNWEoVowYeaBLCp92nKziUr1JORdV0tuLHRyhz1SLOYDYXISH80jXrL+KH3DHrDXv
	j7gcpk46dtbMLN9sO+em1u7JSITqx1TdgGLCK/Rmd2G7fYUa09IyT311eaiirA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744297064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jozy5XY4hH1Y0FEwRg8ha4gBDVFMFA7xclkeqVWkI7k=;
	b=Io+k2/OPv3JqN2IF0+2YKpgFJASDb7nyzHsP/2u+JyoLaSEYJfybLIcvSXQb6KhUKmhM6/
	WvehNz2pgDqwXiCw==
From: "tip-bot2 for Cheng-Yang Chou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] genirq: Fix typo in IRQ_NOTCONNECTED comment
Cc: "Cheng-Yang Chou" <yphbchou0911@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250410105144.214849-1-yphbchou0911@gmail.com>
References: <20250410105144.214849-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174429705955.31282.9757976364935333931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1732e45b79bbb38cccc336ae1c2a5101e7c9e876
Gitweb:        https://git.kernel.org/tip/1732e45b79bbb38cccc336ae1c2a5101e7c9e876
Author:        Cheng-Yang Chou <yphbchou0911@gmail.com>
AuthorDate:    Thu, 10 Apr 2025 18:51:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Apr 2025 16:49:10 +02:00

genirq: Fix typo in IRQ_NOTCONNECTED comment

Fix a minor typo in the comment for IRQ_NOTCONNECTED:
"distingiush" is corrected to "distinguish".

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250410105144.214849-1-yphbchou0911@gmail.com

---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c782a74..51b6484 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -140,7 +140,7 @@ extern irqreturn_t no_action(int cpl, void *dev_id);
 /*
  * If a (PCI) device interrupt is not connected we set dev->irq to
  * IRQ_NOTCONNECTED. This causes request_irq() to fail with -ENOTCONN, so we
- * can distingiush that case from other error returns.
+ * can distinguish that case from other error returns.
  *
  * 0x80000000 is guaranteed to be outside the available range of interrupts
  * and easy to distinguish from other possible incorrect values.

