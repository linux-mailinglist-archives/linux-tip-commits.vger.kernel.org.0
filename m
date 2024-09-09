Return-Path: <linux-tip-commits+bounces-2235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AE9720A9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2221F24729
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126B189B9D;
	Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gi/3/y6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Re+uP0x1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57A187FEC;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902873; cv=none; b=jy46EOGlgBZmdKHg46wOeJBbyik2CJg4hhaqXqVZkwA8ZA9B67Lqie4nfwOSpj03OLx3OqzP7k55udq8eBEl7KaxvHxb23zRVivJQdWbPBWopD1IwqnKXm1aYQNAUbyVL4C+faUqo7ezhYqelnRlY8gvIXWrdTfVAo4T1LSv/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902873; c=relaxed/simple;
	bh=xO+gZ326F4qjI54yy6bQmK4e4iGBt2VX24vlzWN9msQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QmTL6Ms0cRGIzUU99y5EMes98p9aHmcZazRNN+mj3PDgpdv5uCJ58dHpXmXq2IPjZQxYXitxch1JFdEDThrX/R8NEXYaGEPFgRffQgQtl4oHJVR69sU2pBEzwY2BOvi9XdP8UbC9rrVfEPxo/E9lUQtzsTPPtCMpzQxXqyIabr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gi/3/y6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Re+uP0x1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdOsbUA9I6nOkCGbjsGmCZCFlC6ixrd9iStTILdBVk=;
	b=Gi/3/y6CLy/0q6ZOf/mrLs10hhk/hshpBzdKFchfOi229LXaHbeyJTlmCLZ5UXhUEyN7NO
	eY4YgkmMaBr2rYj/4NTanDb05ARFoaInQVsBxa4RckszQ674qFWxQNtLlyPMaKDSW0Wn3N
	Nb1d8WfyIlYHsDNbzZO/Yl9f9BcpNSGH9fV4aKCSiTcFNXu2mb8QHKsVGl6NSfy/05OmXA
	Kfih8/TJsNetkX4hUGuh6jROS5NhHfjRjq3wu9DGyInutkNX4BonlLJriz+GQcHKlM2o09
	AWVpqfOt2s3Skbbsbm8ZB1waj5eKZAcrolMKT9Hen0x6cA/KTGSkU1Ad82vqyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCdOsbUA9I6nOkCGbjsGmCZCFlC6ixrd9iStTILdBVk=;
	b=Re+uP0x1ug0g2vbfZTNlD+feJRDzvviZWFyoYo+eRgI2Yn5ukuQTjjYJOpe22E3LSZWb+Q
	3X5A7aTyfZ7/9eAg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Use the BITS_PER_LONG macro
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903035358.308482-1-ruanjinjie@huawei.com>
References: <20240903035358.308482-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286776.2215.12907503176662953840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     85a147a986e4feafb9286fabaf03a302a611cd85
Gitweb:        https://git.kernel.org/tip/85a147a986e4feafb9286fabaf03a302a611cd85
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Tue, 03 Sep 2024 11:53:58 +08:00
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 11:57:48 +02:00

printk: Use the BITS_PER_LONG macro

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make it simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240903035358.308482-1-ruanjinjie@huawei.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index bd2a892..8de6c49 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -4,6 +4,7 @@
 #define _KERNEL_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -122,7 +123,7 @@ enum desc_state {
 
 #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
-#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_SV_BITS		BITS_PER_LONG
 #define DESC_FLAGS_SHIFT	(DESC_SV_BITS - 2)
 #define DESC_FLAGS_MASK		(3UL << DESC_FLAGS_SHIFT)
 #define DESC_STATE(sv)		(3UL & (sv >> DESC_FLAGS_SHIFT))

