Return-Path: <linux-tip-commits+bounces-2832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842929C3C83
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7471F21E64
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074D17ADE9;
	Mon, 11 Nov 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQEiY+Rm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qdqy/mwE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF815B554;
	Mon, 11 Nov 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322687; cv=none; b=VvcbDl5KvVTXrgd9o/GE9GpveFdiPqEXvZg+DXpFX1YWZVClzciLwbQ7AshaR62d2ERkOLw5+f12O3UAy554MgRJdkSwUwA5wfr5/2QdxshxOMwV6jOHZOrziVLe8XNcgRwtHsD4vPfp3AeUeWvV9M1esdv/derW5B1+BQH9PLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322687; c=relaxed/simple;
	bh=YQJZRFo52/HQ/muQvuNf4IrKqg4TTHcArziP5maS8/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ekw2GqG6tM8UP4Nh318u1wP7gDuK816n9gJramHxmTF99hwt9ApedFq04fPso4hEtRtoLsEJOqVmFL8tJkhXNWyWbnuOSJPevSc0RAwITOLqERXD0/00+7hihm/U+igMTjmEBDjUUCPnF53+b6ytDE6WUXihfPlLGrspDobadGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQEiY+Rm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qdqy/mwE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:58:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jx3/zF4Rh7ajUfWVXZeaK+oRaRQklRF04heoVHN+TKc=;
	b=CQEiY+Rm8E63bDJGI7btR7ArWe7rJjlRndFpbMFvnAy+fp1DZKCYBMUhskz27TBiivqPm6
	yqM+04SvJZ0N2cpKsfDxj4vAyu/+fJIpssxBkIXB5/dKd6JJKnwB1BcfM0OQ8TfVTrWqcC
	AfHRsYKgut9jVIEmndaTYJ02o77zjW4liEVVEe/H5RC0cosOpoavQPBWjrnZC9xgVfMPT9
	YFnAhMSBt9EDCZYqQT7iFCla1fyw0Nh0iNkVD2wrILq8/3ilhWErsd47CS50E4I6KukwAz
	ZXECG9sOUs/I1i0Xts9duO1SWGQ7qy6zMXKoTvYfIR/BBdGoyL7gza69MKIafg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jx3/zF4Rh7ajUfWVXZeaK+oRaRQklRF04heoVHN+TKc=;
	b=Qdqy/mwEtJlcxRpxfd7aB4jFku8g4vx9HEpBWNur66c7Z65/lZtWdyjM1hMWWC5styZpmV
	lVIKpQhMeFJ/f4AQ==
From: "tip-bot2 for Stephen Rothwell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] iio: magnetometer: fix if () scoped_guard() formatting
Cc: kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
References: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132268163.32228.9504803007436629008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9a884bdb6e9560c6da44052d5248e89d78c983a6
Gitweb:        https://git.kernel.org/tip/9a884bdb6e9560c6da44052d5248e89d78c983a6
Author:        Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate:    Fri, 08 Nov 2024 16:41:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:47 +01:00

iio: magnetometer: fix if () scoped_guard() formatting

Add mising braces after an if condition that contains scoped_guard().

This style is both preferred and necessary here, to fix warning after
scoped_guard() change in commit fcc22ac5baf0 ("cleanup: Adjust
scoped_guard() macros to avoid potential warning") to have if-else inside
of the macro. Current (no braces) use in af8133j_set_scale() yields
the following warnings:
af8133j.c:315:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
af8133j.c:316:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]

Fixes: fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
Closes: https://lore.kernel.org/oe-kbuild-all/202409270848.tTpyEAR7-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20241108154258.21411-1-przemyslaw.kitszel@intel.com
---
 drivers/iio/magnetometer/af8133j.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index d81d89a..acd291f 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
 	 * When suspended, just store the new range to data->range to be
 	 * applied later during power up.
 	 */
-	if (!pm_runtime_status_suspended(dev))
+	if (!pm_runtime_status_suspended(dev)) {
 		scoped_guard(mutex, &data->mutex)
 			ret = regmap_write(data->regmap,
 					   AF8133J_REG_RANGE, range);
+	}
 
 	pm_runtime_enable(dev);
 

