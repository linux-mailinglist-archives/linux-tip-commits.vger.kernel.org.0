Return-Path: <linux-tip-commits+bounces-2311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04898AB3A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Sep 2024 19:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF871F21FF7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Sep 2024 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE9192580;
	Mon, 30 Sep 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YOPDBfPa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLAKOlMu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173C18EAB;
	Mon, 30 Sep 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717915; cv=none; b=hNGadAW4FP4moXlI5y8FwDQ7FsDlohLwocWqll7cCHwRNQBF+IGWHMuzTqfY1UKJF1N/O9UcNo/RD4EdWgQdMwZ4dRYnlt2sthpVTQbX/murQoyufz+r5Sj4LlcJLIbaus5R/gX8RGJBFYMlWKaPi623Fi12g6VfZz1fNl7eulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717915; c=relaxed/simple;
	bh=CwR/jaJJf5gRiS2tIxZMwYJTi9ewZBM0JWaufMRqG50=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cOmxj5liemq58k/0j6pUt0HyI9N1ZUTezX32KYlG5j0InkNKP15b+EB87HcZP7vLCiUgAJPJyqk0RoEeonQpT24sdI5RTY1aL6pPRlb+d4Kwm1ttIHM9hroirtYcMfOKaiUoVIV9AVlFnyI0XFwpGA6V3cDHsmBZihxdCCzpiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YOPDBfPa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLAKOlMu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Sep 2024 17:38:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727717911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qp5nwg96y87OpSLZA/vVu33PD/rs5eKJFKqagbVKAw0=;
	b=YOPDBfPa4txdaG/FchV1pfamwQ/AUbUAeL4+JKdJ6vV0gfoOf7hOIO9PtW7DxZPoPeGpFW
	tAMIOztUFgf1156aDypF9kE4W4xC2xvTA5ZdJYOxFAvGPdHhUb09aJTlysnl79D7wC2CQ7
	QlKvEQgizbpXzjjLw+Jklp5g9UBU6I65hHOKSWBZUayrkH8u6PDCzP4zT1DWxOJpDBlEkq
	imCrrhvEC8IhxZ7U0YTikiIhAvJt+Hkmj6ALeIPs80K8h8J330GL93DxYWpXj3MDbl7JVq
	F/cILImBCYvJA+eF/vIyJ1P5LKsN3VzDebtwR4eOhiBOhOSo8ZXxjyfIQBHTMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727717911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qp5nwg96y87OpSLZA/vVu33PD/rs5eKJFKqagbVKAw0=;
	b=zLAKOlMuwI/8W1zaYhVMwXrRAd19gl6cIc+2Bo6R+/1Ij+2JQxJAYemK+4R5ItwK3ZtySU
	7fJYn1ykWS5wd8AQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/bugs: Correct RSB terminology in Kconfig
Cc: Breno Leitao <leitao@debian.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172771790961.1365.12944524838461131424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     86e39b94cd71a4987f9b98dd2a7d6c826e1c5c98
Gitweb:        https://git.kernel.org/tip/86e39b94cd71a4987f9b98dd2a7d6c826e1c5c98
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Fri, 13 Sep 2024 05:27:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 30 Sep 2024 10:30:54 -07:00

x86/bugs: Correct RSB terminology in Kconfig

RSB stands for "Return Stack Buffer" in industry literature[1]. Update
the kernel Kconfig to use this standard term instead of the current
"Return-Speculation-Buffer".

This change aligns kernel documentation with widely accepted terminology.

The line length reduction triggers text reformatting, but no functional
text is altered.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/return-stack-buffer-underflow.html

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240913122754.249306-1-leitao%40debian.org
---
 arch/x86/Kconfig | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd..2cea5f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2551,15 +2551,14 @@ config MITIGATION_CALL_DEPTH_TRACKING
 	default y
 	help
 	  Compile the kernel with call depth tracking to mitigate the Intel
-	  SKL Return-Speculation-Buffer (RSB) underflow issue. The
-	  mitigation is off by default and needs to be enabled on the
-	  kernel command line via the retbleed=stuff option. For
-	  non-affected systems the overhead of this option is marginal as
-	  the call depth tracking is using run-time generated call thunks
-	  in a compiler generated padding area and call patching. This
-	  increases text size by ~5%. For non affected systems this space
-	  is unused. On affected SKL systems this results in a significant
-	  performance gain over the IBRS mitigation.
+	  SKL Return-Stack-Buffer (RSB) underflow issue. The mitigation is off
+	  by default and needs to be enabled on the kernel command line via the
+	  retbleed=stuff option. For non-affected systems the overhead of this
+	  option is marginal as the call depth tracking is using run-time
+	  generated call thunks in a compiler generated padding area and call
+	  patching. This increases text size by ~5%. For non affected systems
+	  this space is unused. On affected SKL systems this results in a
+	  significant performance gain over the IBRS mitigation.
 
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"

