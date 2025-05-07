Return-Path: <linux-tip-commits+bounces-5451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC448AAE923
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AD43AD071
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A508221730;
	Wed,  7 May 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnypQ84r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kAzmzAY1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303C14A4C7;
	Wed,  7 May 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643249; cv=none; b=FvTV1+3y66H4BA+zmOaNR5zhNyI/5SJIKXa/xDbZAEJM//26SADpe8jCIw3J90WnSb9iI5eY1IIAjhdIXuTIMVpwqkAaUiP3Vl3W2U5P7YM2wlXzX6H0PzSDExse/cqc+mOT5ZqqqROG4oUg7oO2WTvH4X26umnxezPV9ZKWUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643249; c=relaxed/simple;
	bh=QaXamWI6Ia1o3+1HNsgFHiV4uFT8N95itji57fGlEik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=skssL3n3ZFi9XvyPIKh+GVqCoglVZUp/+xaD7FYSmn8NRA3n6QcCMlIXuhGfjveMJznaUvBbP33Yp6WXP1kRSVa+ZDJHt5WIwEsV+z8BoLofBGs6C/b0PfjazKDcYdd6wfHhlUTotrh+AZwYpuU1QahvR7dSZX/b+rKcxAbUg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnypQ84r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kAzmzAY1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 18:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746643246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf9QUIfPySZA9aaxh0CXI9rc7+ZuDGEkYHRKU1UQ3hQ=;
	b=MnypQ84r5W2sPJOaB0OXwtqMByAWgWPWAUh5dxhCqQM2sqRNvGvgmXMfXQzMomUZoFqPr/
	VjP/yjR3+7hXpBGM4ohZ4zDNDk/Zi6qqwSpX+AvdI+7kwhr8xsJ3SI26nW/C41/3TTKhSK
	aT/rBiIPcuwyZDh7JeIzhikyfyFIiO+R5rCWSJ939BBXC0EXcjVQ/v+qgcqvRlFRsCdhKF
	cREER04DgOfd+yqDkDLbOGG6uCOuuJ5NGkHqWFZZMwdGAWIhUIM0kcMTwAnezEkPGOaVwy
	Gu+RIXdPARrpzRwdJl/fkwLNTZkfStar1iCFR2tmrPG1Ijyxu8MF2WL4wwFrNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746643246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf9QUIfPySZA9aaxh0CXI9rc7+ZuDGEkYHRKU1UQ3hQ=;
	b=kAzmzAY1DK+1LCG451KaOkbGOhQCbyVDH09UHHpF8tyIA6JU03XnzrMCzVvuxfvTjYNVNl
	8MOLaD7FM/aRCMDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] accel/habanalabs: Add explicit include of <asm/tsc.h>
 to pick up the rdtsc() definition
Cc: kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <202505080003.0t7ewxGp-lkp@intel.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174664324501.406.12440553986097050520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     b1d1720321a0fb90c918fcbb3aa15649c116130a
Gitweb:        https://git.kernel.org/tip/b1d1720321a0fb90c918fcbb3aa15649c116130a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 20:25:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 07 May 2025 20:30:53 +02:00

accel/habanalabs: Add explicit include of <asm/tsc.h> to pick up the rdtsc() definition

The following commit:

  288a4ff0ad29 ("x86/msr: Move rdtsc{,_ordered}() to <asm/tsc.h>")

removed the <asm/msr.h> include from the accel/habanalabs driver, which broke
the build on UML:

   drivers/accel/habanalabs/common/habanalabs_ioctl.c:326:23: error: call to undeclared function 'rdtsc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Add an explicit <asm/tsc.h> include, now that it works on UML too.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Oded Gabbay <ogabbay@kernel.org>
Link: https://lore.kernel.org/r/202505080003.0t7ewxGp-lkp@intel.com
---
 drivers/accel/habanalabs/common/habanalabs_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index dc80ca9..af23001 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -17,6 +17,8 @@
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 
+#include <asm/tsc.h>
+
 /* make sure there is space for all the signed info */
 static_assert(sizeof(struct cpucp_info) <= SEC_DEV_INFO_BUF_SZ);
 

