Return-Path: <linux-tip-commits+bounces-5450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A845AAE401
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31654982E43
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9042128A3F3;
	Wed,  7 May 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovljoxEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OT+rnEc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0C28A1E6;
	Wed,  7 May 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630668; cv=none; b=qFnzEwpMjwIizvE+SkhXiMqWmKKQF+oJXilcSqGtSkwCi/QoTe0VChAWyFyo7DQod2dxtQ8VlcUU822IRVagkSOaSy9Pfeze85THfCW5TtWpKVchiSXrtyhf1nOpdoYJXw93LuVDcV6W30Nv6pfUwbB8rTX/GaTiQX78KqIZenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630668; c=relaxed/simple;
	bh=V3KR3TqgWBtodXihMEK9qwYj4FfY0/h45m1TZTfdOSQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kc5oJ8bSsHJnWHooqJeyV7i5YGoY0WDhX6k/AOjlBrbm88FzbqSAD0IXGBFwpaNwfINQqG0bhzIqdwwzO7dkPqgb3tzKqpGj87WMJYs+xFPL8O5X3gy1y64x94KlUZMWpv8rY/jJBliqcfzxPTHAuVfpQux2iXe0Mu9AXDXjUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovljoxEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OT+rnEc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 15:11:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746630664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1C6fzhvqrIckBVGLJqBwhvBDOLPDZ2Oky0FYZ4nItpo=;
	b=ovljoxEzwDiMGNvWgFf7K5W4zXEN81UUx+8m5E5cRRheD4FK2n47CGSAarLswx4H/CHCnT
	msPjVXJG/kKUfx031eGA49ItIcQfFlPApyb0tpJUTZlM6OAh0i1jys3heRAZ0gaaGXdR8Y
	lfvY5nEGEPzc8np0e9qo21SnN2/9LhryjkI7bB/zuX1je6NcASsb54bL3nbBouH6AgZ0QA
	sEGOwYyBy4sfi6n6luGKZI/KSC6LURzEv2W25KQJmvQC9adhCW2db7EIPkeT1RnCEzCObg
	hRSiFEEbWxtNa3hPnZhfkJZMGHW60fGJ2TH2H/56GDlY1OcIV/axSb4S4FG96w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746630664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1C6fzhvqrIckBVGLJqBwhvBDOLPDZ2Oky0FYZ4nItpo=;
	b=/OT+rnEcvK9MAMBGY8A+z0b9evn43FgJ8NA9EfNpbL/TjJgEvurj5WiuwUG4zeYwrte7Vn
	XgjCB8bmM7E7a4Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use scoped_guard() to shut clang up
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174663066368.406.8468526909340567854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     97f4b999e0c894d3e48e318aa1130132031815b3
Gitweb:        https://git.kernel.org/tip/97f4b999e0c894d3e48e318aa1130132031815b3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 07 May 2025 15:47:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:08:44 +02:00

genirq: Use scoped_guard() to shut clang up

This code pattern trips clang up:

     if (fail)
     	goto undo;

     guard(lock)(lock);
     do_stuff();
     return 0;

undo:
     ...

as it somehow extends the scope of the guard beyond the return statement.

Replace it with a scoped guard to help it to get its act together.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/oe-kbuild-all/202505071809.ajpPxfoZ-lkp@intel.com/
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e6c6c0a..2861e11 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2564,8 +2564,8 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 	if (retval)
 		goto err_irq_setup;
 
-	guard(raw_spinlock_irqsave)(&desc->lock);
-	desc->istate |= IRQS_NMI;
+	scoped_guard(raw_spinlock_irqsave, &desc->lock)
+		desc->istate |= IRQS_NMI;
 	return 0;
 
 err_irq_setup:

