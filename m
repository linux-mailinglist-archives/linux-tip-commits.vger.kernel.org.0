Return-Path: <linux-tip-commits+bounces-2258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78E9720E4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4982E1F2486C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBDE18D649;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FsGHiwbW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bi9xyNHd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208718B492;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902881; cv=none; b=Xr6Ni8qIeMnARCRlOrLesoc2Z1XZGdy+wQVMEuLYr5Il4zo0PmaKFxYK4QOoY/7AC2zrhCtgTH656kDdWKUvi8VUU7YHbJB97VCkia7OyCowQ14Wy89vgb84bIkjPdUkAC8p0wFNYtvAc4ZzKqbTpfJ/EMO3M7T1yhj6Yt6XJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902881; c=relaxed/simple;
	bh=61f0KaebJmoa9W9mtxoi+Isr9bO2BXA0Pqtk+tTOG+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=irPM+tudwn0J4iyHQxmv6Ttebn2hNu/ZV9/hJ/EpBP3Kkqa7iJxfPA1peN5wzN+3Jy7C+4PM9Ju/sYkhY/XNIGZUT9L9j3Z4IZ3hGVisY/zXQDUtsZwgc3LpsPjaK9+HymZZHEaq2keq2I4Twq3COkJij7i1l/EYO/mGqDvWL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FsGHiwbW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bi9xyNHd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ0mLGw/QRoqSlfPKvDotK8w25bmfHWorAyujj+5wvE=;
	b=FsGHiwbWbRwZZ0i2ay7vMhGedpriNx23EBh0z1hpBI3SAq39B0WgA2Ch0wzOF3w5dSc30i
	rNnm6MB2rgfY1mBhDD2bhI5k2im7TKVJqRq1SNslOpT6L+Qk+mh7/qF00Lc+hfaXqY+QcK
	oPJ7q+8Vyguvo7Nfgr/uXW9Mh2wIGtv3MRUSeG8q5kIRsteQehykKt4nWnNO+TVA6jBTPI
	SzhTEvhcs7cCrzNFZLK7ijGai/43sVqlnd87C4p7TDzGxWL21gV085KjW1uaRBAWCtdGbn
	xCJLNMxe7wApz8qoh4HDxpOSvLyN9L+PNbgvJIod3813itP32nwX0zyurA1GNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ0mLGw/QRoqSlfPKvDotK8w25bmfHWorAyujj+5wvE=;
	b=Bi9xyNHdG3WsSlsUJQzcal6lDt3oupEoHBmyhn+fCm4MzpdD9x2CsomIWrplkM41QiEQRB
	EigL7WILtlCSbeAg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Do not rely on proxy headers
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-16-john.ogness@linutronix.de>
References: <20240820063001.36405-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287512.2215.552029869457302962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     1c17ebb7907a809a92f978995c27a53ead2526ee
Gitweb:        https://git.kernel.org/tip/1c17ebb7907a809a92f978995c27a53ead2526ee
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:41 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: nbcon: Do not rely on proxy headers

The headers kernel.h, serial_core.h, and console.h allow for the
definitions of many types and functions from other headers.
Rather than relying on these as proxy headers, explicitly
include all headers providing needed definitions. Also sort the
list alphabetically to be able to easily detect duplicates.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-16-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h          |  8 ++++++--
 kernel/printk/nbcon.c             | 13 ++++++++++++-
 kernel/printk/printk_ringbuffer.h |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index dc8bc08..ccb9166 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,11 +2,12 @@
 /*
  * internal.h - printk internal definitions
  */
-#include <linux/percpu.h>
 #include <linux/console.h>
-#include "printk_ringbuffer.h"
+#include <linux/percpu.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
@@ -43,6 +44,9 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+struct printk_ringbuffer;
+struct dev_printk_info;
+
 extern struct printk_ringbuffer *prb;
 
 __printf(4, 0)
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 61f0ae6..e8ddcb6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,13 +2,24 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include "internal.h"
+#include "printk_ringbuffer.h"
 /*
  * Printk console printing implementation for consoles which does not depend
  * on the legacy style console_lock mechanism.
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 52626d0..bd2a892 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,8 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 /*
  * Meta information about each stored message.

