Return-Path: <linux-tip-commits+bounces-1484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BF91335F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Jun 2024 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902531F22DF8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Jun 2024 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AFF14A0AD;
	Sat, 22 Jun 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptY6yhoD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XufdKnxw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BE33F6;
	Sat, 22 Jun 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719055956; cv=none; b=LNA+0kFVsX0io+btbg/cyYfP7voID1c8DSmowa1w3MKyv8vOY3sdYeBxwI+uHxe70BuBNmgt8TiGjAJjSsbMFzgmjb603unhWsm0MxSQofkj6htQP8Mt7ub1m2gFj02JGYGqSXzmYj4O9aFDnmpgYbfLYKaX7nU0T7SN427zsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719055956; c=relaxed/simple;
	bh=8egAx2LUEkdu2B67LKI0vCze+VdfizJkL4L2Afkq7Cg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ez7z1MVQoplsiPJ+j6ymUeAqL/gRqq3HhrZZXiK4rjqRhabH03GMuUamJ1Xe7ft+HuDFVwWssYa+Tob0lbMWnfTSKMJfBh5Y3WHNe3YXcgbtk3uH4zLkqHo36qPBqv1wg3y1s7V5gVxYt2nbQpLBSA0vgQ7lyz1j+lzVZUTzZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptY6yhoD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XufdKnxw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Jun 2024 11:32:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719055951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bFCbK+vt1OFZmN1X5xe/2xoSttwFIlzcIYFQz94K8jE=;
	b=ptY6yhoDH1zJQKVWgJv9kF0H6OaGIodwJ1MBXPu5Prscjsjq5z/tTt70u8ctuyYAZGpRXe
	AoMqJMQ7r8/hmFIsPHIouALBWSLBL15uNMY02VvRRr6HbQaULEbuYZq5I063KTjVgchMlM
	P6i+cpSRXld70/eNNMLIQ9h+ST0aABVkklSjDcGfj9FfgOHi1z1GQO49qPiOexSaZYGPya
	YHt7Zv3ND8ci4Oks8fS2C5vuWurgeEcyM5RSKR32E85IwTYTT10TxaAoPE9OEGmGZICrRx
	/z73oen4hLVuT0nknBgyia6e/Q9AZlqeHcK6Rsv+M/7TOK4PhclbFd3/uMxB7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719055951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bFCbK+vt1OFZmN1X5xe/2xoSttwFIlzcIYFQz94K8jE=;
	b=XufdKnxw1UD81DgoNOgqT8rVfZyHtZKc27+1mcaxF0MPE/VRB/hhpIW3nqEyZ4hAGPbCkE
	rOnSMiL94G9K8zAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move the instrumentation exclusion bits too
Cc: kernel test robot <lkp@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171905595099.10875.18214578727695488234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a7e7185ccd2acc4360e2cde688027cd1ecf10d93
Gitweb:        https://git.kernel.org/tip/a7e7185ccd2acc4360e2cde688027cd1ecf10d93
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 22 Jun 2024 11:31:02 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Jun 2024 13:20:35 +02:00

x86/sev: Move the instrumentation exclusion bits too

Commit in fixes moved the sev*.c compilation units to coco/ - the guest
confidential computing location - where they belong but forgot the
instrumentation exclusion build directives.

Move them too.

Fixes: 06685975c209 ("x86/sev: Move SEV compilation units")
Closes: https://lore.kernel.org/oe-kbuild-all/202406220748.hG3qlmDx-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/sev/Makefile | 8 ++++++++
 arch/x86/kernel/Makefile   | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index b89ba3f..5f72e92 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,3 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += core.o
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_core.o = -pg
+endif
+
+KASAN_SANITIZE_core.o	:= n
+KMSAN_SANITIZE_core.o	:= n
+KCOV_INSTRUMENT_core.o	:= n
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b22ceb9..a847180 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -17,7 +17,6 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_head32.o = -pg
-CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
 
@@ -26,19 +25,16 @@ KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
-KASAN_SANITIZE_sev.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
-KMSAN_SANITIZE_sev.o					:= n
 
 # If instrumentation of the following files is enabled, boot hangs during
 # first second.
 KCOV_INSTRUMENT_head$(BITS).o				:= n
-KCOV_INSTRUMENT_sev.o					:= n
 
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 

