Return-Path: <linux-tip-commits+bounces-5461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67813AAF65A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC40E1BC6A77
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7423E325;
	Thu,  8 May 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jjjs+pEh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFVRN/i8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729720409A;
	Thu,  8 May 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695352; cv=none; b=Csk03JSCA5w5Qq7Fg5i5UmYIgBOZS9IEyUofT3kyY6vr9Sir6BVMrNqAZJ3Rm59vptd4bsrugI0ohk0rK59YN83w0rWlVn1+0BLgs3zHIxaZ2Si2i1a7kZdOPgmFfjuILPd/b2bTaxGogPf9NP8rCxeQeqsowIzu5l0z0BxZR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695352; c=relaxed/simple;
	bh=t+HiNP9OQuZN3c0EzA7EgzHkStGHipfmj78gNgzjdME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fd9WqtcN5kyPASfWOVfzSGHNe3Z7+1GjSIEqI2/G0HMokPBi38u0nmnMzRAftbmL4TdRb5MRTIFy4lFFoZt7UU4eev3VKHa+X/Ft/ZNgDwWGQvC+mNtuU6LSi+VytVFGbVTCPbgAmH4jQu/wyw6bd3SPnjKhheNP5b9OwovQSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jjjs+pEh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFVRN/i8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 09:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746695342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqcdgsDFS76Ypx5VsTKgCynupNwSh+fIF0+FgZOOS9A=;
	b=Jjjs+pEhB8dDsBYdKH+m9Ud8lbvtKpOZBdj/58IJeUy47bqO3sz/CyTSrB4njycfRZQHF9
	cgE2UJR0GA3EVk08VRiMUA+WxKnOSi1KlQXJrBRdGZeZt+j3X6Qj/SF3UOxiIwBaFmPrVH
	mWKaZBekf0b1GA1URSBeYmq6b9epPjCAufZIG8INaYw1gxNIuFeObNNPYvUyHqqrW2TTWd
	WbA5YrtXS4gne4fghTqHvoB0WEpRTzUIxJipEFxiXxokNXkGJdvJCn9oBQUy2A8TEa3IVr
	ez8d8Hn8Zgowrvoig7feIHP/NBsYlIaerllpj8N92cO0KKfbHUV7PfShPIzynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746695342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqcdgsDFS76Ypx5VsTKgCynupNwSh+fIF0+FgZOOS9A=;
	b=cFVRN/i8zIWZHwy1lQPa/Gh499L9NXe/yy5OqQ+bJkHI6xPHGBhcWyfrnzwcmuwC9cWQ/G
	4Zu4RC/OQ/7LjiBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] accel/habanalabs: Don't build the driver on UML
Cc: Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202505080003.0t7ewxGp-lkp@intel.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174669534192.406.16180090316398658392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     9cf78722003178b09c409df9aafe9d79e5b9a74e
Gitweb:        https://git.kernel.org/tip/9cf78722003178b09c409df9aafe9d79e5b9a74e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 20:25:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 08 May 2025 11:02:46 +02:00

accel/habanalabs: Don't build the driver on UML

The following commit:

  288a4ff0ad29 ("x86/msr: Move rdtsc{,_ordered}() to <asm/tsc.h>")

removed the <asm/msr.h> include from the accel/habanalabs driver, which broke
the build on UML:

   drivers/accel/habanalabs/common/habanalabs_ioctl.c:326:23: error: call to undeclared function 'rdtsc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Make the driver depend on 'X86 && X86_64', instead of just 'X86_64',
thus it won't be built on UML.

Suggested-by: Johannes Berg <johannes.berg@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Oded Gabbay <ogabbay@kernel.org>
Link: https://lore.kernel.org/r/202505080003.0t7ewxGp-lkp@intel.com
---
 drivers/accel/habanalabs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/Kconfig b/drivers/accel/habanalabs/Kconfig
index be85336..1919fbb 100644
--- a/drivers/accel/habanalabs/Kconfig
+++ b/drivers/accel/habanalabs/Kconfig
@@ -6,7 +6,7 @@
 config DRM_ACCEL_HABANALABS
 	tristate "HabanaLabs AI accelerators"
 	depends on DRM_ACCEL
-	depends on X86_64
+	depends on X86 && X86_64
 	depends on PCI && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select HWMON

